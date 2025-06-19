from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse, FileResponse, HttpResponseForbidden, HttpResponse, Http404
from django.contrib.auth import login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.hashers import make_password
from django.contrib.staticfiles import finders
from .models import Producto, datos, Folder, Document, TipoMadera, Product
from .forms import ProductoForm, RegistroForm, TipoMaderaForm, ProductForm
from django.core.mail import send_mail
from django.core.signing import TimestampSigner, BadSignature, SignatureExpired
from django.conf import settings
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST, require_http_methods
from django.template.loader import render_to_string
from django.db.models import Q, Sum
from django.db import models
import os, io, subprocess, datetime, shutil, json, re
from django.utils._os import safe_join
from django.utils.html import strip_tags
from django.core.mail import EmailMultiAlternatives
from datetime import datetime
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate
from reportlab.platypus import Table, TableStyle




# --------------------------
# Vistas para páginas estáticas
# --------------------------
def inicio(request):
    imagenes_publicadas = Producto.objects.filter(publicado=True).order_by('tipo_madera__nombre','id')
    return render(request, 'paginas/inicio.html', {'imagenes_publicadas': imagenes_publicadas})

@login_required(login_url="/libros/login/")
@never_cache
def calendar_view(request):
    return render(request, 'libros/calendario.html')

@login_required(login_url="/libros/login/")
@never_cache
def informes_view(request):
    # Conteo de productos publicados y no publicados
    published_count = Producto.objects.filter(publicado=True).count()
    unpublished_count = Producto.objects.filter(publicado=False).count()

    # Inventario por tipo de madera
    inventory_qs = TipoMadera.objects.annotate(
        total=models.Sum('productos__precio')  # o bien contar stock si usas otro modelo
    )
    # Si quisieras contar número de productos:
    inventory_by_type = [
        (tm.nombre, tm.productos.count())
        for tm in TipoMadera.objects.all()
    ]

    # Usuarios activos
    user_count = datos.objects.filter(is_active=True).count()

    context = {
        'published_count': published_count,
        'unpublished_count': unpublished_count,
        'inventory_by_type': inventory_by_type,
        'user_count': user_count,
    }
    return render(request, 'libros/informes.html', context)

@login_required(login_url="/libros/login/")
@never_cache
def manage_index(request):
    # 1. Conteos de cada módulo
    gallery_count   = Producto.objects.count()      # Galería de publicidad
    producto_publicado = Producto.objects.filter(publicado=True).count()     #Productos publicados
    producto_no_publicado = Producto.objects.filter(publicado=False).count()
    inventory_count = Product.objects.count()       # Lista de inventario
    usuarios_total      = datos.objects.count()                     # Total de usuarios
    cuentas_activas = datos.objects.filter(status='Activo').count()         # Listado de usuarios
    count_inactive  = datos.objects.filter(status='No Activo').count()  # Cuentas inactivas
    lista_folders   = Folder.objects.count()
    docs_count      = Document.objects.count()      # Documentos de contratación

    # Backups: contamos archivos .sql en la carpeta backups
    backup_dir = os.path.join(settings.BASE_DIR, 'backups')
    try:
        backups_count = len([f for f in os.listdir(backup_dir) if f.endswith('.sql')])
    except FileNotFoundError:
        backups_count = 0

    return render(request, 'libros/index.html', {
        'gallery_count':   gallery_count,
        'producto_publicado': producto_publicado,
        'producto_no_publicado': producto_no_publicado,
        'inventory_count': inventory_count,
        'usuarios_total': usuarios_total,
        'cuentas_activas':      cuentas_activas,
        'count_inactive': count_inactive,
        'lista_folders':    lista_folders,
        'docs_count':      docs_count,
        'backups_count':   backups_count,
    })


@login_required(login_url="/libros/login/")
@never_cache
def profile_view(request):
    user = request.user

    if request.method == 'POST':
        # 1) Subida de imagen de perfil
        if request.FILES.get('profile_image'):
            user.profile_image = request.FILES['profile_image']
            user.save()
            return JsonResponse({
                'status': 'success',
                'image_url': user.profile_image.url
            })

        # 2) Edición de datos vía AJAX
        editable_fields = [
            'nombres', 'apellidos', 'phone',
            'security_question', 'security_answer',
            'recovery_email'
        ]
        data = request.POST
        changed = False

        for f in editable_fields:
            if f in data:
                setattr(user, f, data[f])
                changed = True

        if changed:
            user.save()
            return JsonResponse({'status': 'success'})

        return JsonResponse({
            'status': 'error',
            'errors': 'No se enviaron campos válidos'
        }, status=400)

    # GET — renderiza la plantilla
    return render(request, 'libros/profile.html')

            
        
#---------------------------
# Vistas para login y redirección
# --------------------------
@login_required(login_url="/libros/login/")
@never_cache
def index(request):
    return render(request, "libros/index.html")

@never_cache
def login_view(request):
    context = {}
    if request.method == "POST":
        email = request.POST.get('email')
        password = request.POST.get('password')
        try:
            user = datos.objects.get(email=email)
        except datos.DoesNotExist:
            messages.error(request, "Correo o contraseña inválidos")
            context['show_login_modal'] = True
            return render(request, 'paginas/inicio.html', context)
        
        if user.status != "Activo":
            messages.error(request, "La cuenta no está activada. Por favor, contacta con el administrador.")
            context['show_login_modal'] = True
            return render(request, 'paginas/inicio.html', context)

        if user.check_password(password):
            messages.success(request, "Inicio de sesión exitoso")
            login(request, user)
            return redirect('index')
        else:
            messages.error(request, "Correo o contraseña inválidos")
            context['show_login_modal'] = True
            return render(request, 'paginas/inicio.html', context)
        
    return render(request, 'paginas/inicio.html')

@login_required(login_url="/libros/login/")
@never_cache
def logout_view(request):
    logout(request)
    return redirect('login')


# --------------------------
# Vistas para espacio de búsqueda de productos
# --------------------------
@login_required(login_url="/libros/login/")
@never_cache
def gestionar_productos_ajax(request):
    query = request.GET.get('query', '').strip()
    wood_filter = request.GET.get('wood_filter', '').strip()

    # Empieza obteniendo todos los productos
    productos = Producto.objects.select_related('tipo_madera')

    # Si se ha seleccionado un tipo de madera, filtra por ese campo
    if wood_filter:
        productos = productos.filter(tipo_madera_id=wood_filter)

    # Si se ingresó un término de búsqueda, se filtran por nombre o descripción
    if query:
        productos = productos.filter(nombre_producto__icontains=query)
        
    productos = productos.order_by('tipo_madera__nombre','id')
    html = render_to_string('libros/productos_partial.html', {'productos': productos})
    return JsonResponse({'html': html})


# --------------------------
# Vistas para gestión de productos
# --------------------------



from django.views.decorators.http import require_GET

@require_GET
@login_required(login_url="/libros/login/")
def validar_producto_existente(request):
    nombre = request.GET.get('nombre_producto') or request.GET.get('name')
    tipo_id = request.GET.get('tipo_madera') or request.GET.get('wood_type')
    existe = Producto.objects.filter(nombre_producto=nombre, tipo_madera_id=tipo_id).exists()
    return JsonResponse({'existe': existe})

 
@login_required(login_url="/libros/login/")
@never_cache
def gestionar_productos(request):
    if request.method == "POST":
        form = ProductoForm(request.POST, request.FILES)
        nombre = request.POST.get('nombre_producto') 
        tipo_id = request.POST.get('tipo_madera')
           # Verifica si ya existe un producto con ese nombre y tipo de madera
        if Producto.objects.filter(nombre_producto=nombre, tipo_madera_id=tipo_id).exists():
            messages.error(request, "El producto ya existe.")
            return redirect('gestionar_productos')
        if form.is_valid():
            form.save()
            return redirect('gestionar_productos')
    else:
        form = ProductoForm()
    
    # Obtener todos los productos
    productos = Producto.objects.select_related('tipo_madera').order_by('tipo_madera__nombre','id')
    tipos = TipoMadera.objects.all()
    
    # Agrupar productos por tipo de madera
    productos_por_tipo = {}
    for producto in productos:
        tm = producto.tipo_madera.nombre
        productos_por_tipo.setdefault(tm, []).append(producto)
        
    tipo_form = TipoMaderaForm()
    
    return render(request, 'libros/gestionar_productos.html', {
        'form': form, 
        'productos': productos,
        'productos_por_tipo': productos_por_tipo,
        'tipos_madera' : tipos,
        'tipo_form': tipo_form,
    })
    
    
@login_required(login_url="/libros/login/")
@never_cache
def editar_producto(request, producto_id):
    producto = get_object_or_404(Producto, pk=producto_id)
    tipos_madera = TipoMadera.objects.all()
    if request.method == "POST":
        form = ProductoForm(request.POST, request.FILES, instance=producto)
        if form.is_valid():
            imagen = form.cleaned_data.get('imagen')
            clear = form.cleaned_data.get('imagen_clear', False)
            if imagen and clear:
                form.cleaned_data['imagen_clear'] = False
            form.save()
            return redirect('gestionar_productos')
    else:
        form = ProductoForm(instance=producto)

    return render(request, 'libros/editar_producto_form.html', {
        'form': form, 
        'producto': producto, 
        'tipos_madera': tipos_madera })


@login_required(login_url="/libros/login/")
@never_cache
def eliminar_producto(request, producto_id):
    producto = get_object_or_404(Producto, id=producto_id)
    if request.method == "POST":
        producto.delete()
        return redirect('gestionar_productos')
    return render(request, 'libros/confirmar_eliminar.html', {'producto': producto})

@login_required(login_url="/libros/login/")
@never_cache
def subir_imagen(request):
    if request.method == "POST":
        form = ProductoForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('gestionar_productos')
    else:
        form = ProductoForm()
    return render(request, 'libros/subir_imagen.html', {'form': form})

@login_required(login_url="/libros/login/")
@never_cache
def publicar_producto(request, productoId):
    if request.method == 'POST':
        imagen = get_object_or_404(Producto, id=productoId)
        imagen.publicado = True
        imagen.save()
        return JsonResponse({'success': True})
    return JsonResponse({'success': False})

@login_required(login_url="/libros/login/")
@never_cache
def quitar_publicidad(request, productoId):
    if request.method == 'POST':
        imagen = get_object_or_404(Producto, id=productoId)
        imagen.publicado = False
        imagen.save()
        return JsonResponse({'success': True})
    return JsonResponse({'success': False})


@login_required(login_url="/libros/login/")
@never_cache
def crear_tipo_madera_ajax(request):
    if request.method == 'POST':
        form = TipoMaderaForm(request.POST)
        if form.is_valid():
            tipo = form.save()
            return JsonResponse({
                'id': tipo.id,
                'nombre': tipo.nombre
            })
        return JsonResponse({'errors': form.errors}, status=400)
    return JsonResponse({'error': 'Método no permitido'}, status=405)

# --------------------------
# Vistas para Registro y Gestión de Cuentas
# --------------------------

@login_required(login_url="/libros/login/")
@never_cache
def registro_login(request):
    if request.method == "POST":
        # Se instancia el formulario con los datos enviados (request.POST)
        form = RegistroForm(request.POST)
        if form.is_valid():
            # Si el formulario es válido, se guarda el usuario (incluye encriptar la contraseña y validar todos los campos)
            form.save()
            messages.success(request, "Cuenta creada exitosamente")
            return redirect('lista_login')
        else:
            messages.error(request, "Por favor corrija los errores en el formulario")
    else:
        # Si no es POST, se instancia un formulario vacío
        form = RegistroForm()
    # Se renderiza el template con el formulario en el contexto
    return render(request, 'libros/lista_login.html', {'form': form})


@login_required(login_url="/libros/login/")
@never_cache
def cuentas_list(request):
    cuentas = datos.objects.all()
    return render(request, 'libros/lista_login.html', {'cuentas': cuentas})


@login_required(login_url="/libros/login/")
@never_cache
def editar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    
    if request.method == "POST":
        
        cuenta.email = request.POST.get('email')
        cuenta.phone = request.POST.get('phone')
        cuenta.security_question = request.POST.get('security_question')
        cuenta.security_answer = request.POST.get('security_answer')
        cuenta.recovery_email = request.POST.get('recovery_email')
        
        new_password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')
        
        if new_password:
            if new_password == confirm_password:
                cuenta.set_password(new_password)
            else:
                messages.error(request, "Las contraseñas no coinciden")
                return redirect('editar_cuenta', cuenta_id=cuenta_id)
        cuenta.save()
        
        messages.success(request, "Cuenta actualizada exitosamente")
        return redirect('lista_login')
    return render(request, 'libros/editar_cuenta_form.html', {'cuenta': cuenta})


@login_required(login_url="/libros/login/")
@never_cache
def activar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    cuenta.status = "Activo"
    cuenta.is_active = True
    cuenta.save()
    messages.success(request, "Cuenta activada")
    return redirect('lista_login')


@login_required(login_url="/libros/login/")
@never_cache
def desactivar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    cuenta.status = "No Activo"
    cuenta.is_active = False
    cuenta.save()
    messages.success(request, "Cuenta desactivada")
    return redirect('lista_login')


@login_required(login_url="/libros/login/")
@never_cache
def eliminar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    cuenta.delete()
    messages.success(request, "Cuenta eliminada")
    return redirect('lista_login')


# --------------------------
# Vistas para gestión de documentos
# --------------------------

@login_required(login_url="/libros/login/")
@never_cache
def carpeta(request):
    return render(request, 'libros/carpeta.html')



# views.py
@login_required(login_url="/libros/login/")
@never_cache
def get_folders(request):
    folders = Folder.objects.all()
    data = []
    for folder in folders:
        data.append({
            'id': folder.id,
            'name': folder.name,
            'status': folder.status,
            'fecha_inicio': folder.fecha_inicio,
            'puesto_designado': folder.puesto_designado,
            'salario_actual': folder.salario_actual,
            'horas_trabajo': folder.horas_trabajo,
            'tiempo_contrato': folder.tiempo_contrato,
            'tipo_documento': folder.tipo_documento,
            'numero_identidad': folder.numero_identidad,
            'numero_seguro_social': folder.numero_seguro_social,
            'eps': folder.eps,
            'fondo_pensiones': folder.fondo_pensiones,
            'arl': folder.arl,
        })
    return JsonResponse(data, safe=False)
@login_required(login_url="/libros/login/")
@never_cache
def get_folder(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    data = {
        'id': folder.id,
        'name': folder.name,
        'status': folder.status,
        'fecha_inicio': folder.fecha_inicio,
        'puesto_designado': folder.puesto_designado,
        'salario_actual': folder.salario_actual,
        'horas_trabajo': folder.horas_trabajo,
        'tiempo_contrato': folder.tiempo_contrato,
        'tipo_documento': folder.tipo_documento,  # <-- ¡IMPORTANTE!
        'numero_identidad': folder.numero_identidad,
        'numero_seguro_social': folder.numero_seguro_social,
        'eps': folder.eps,
        'fondo_pensiones': folder.fondo_pensiones,
        'arl': folder.arl,
    }
    return JsonResponse(data)


@login_required(login_url="/libros/login/")
@never_cache
def create_folder(request):
    if request.method == "POST":
        folder_name = request.POST.get('folderName')
        if folder_name:
            folder = Folder.objects.create(name=folder_name)
            return JsonResponse({'message': 'Carpeta creada exitosamente', 'folder_id': folder.id}, status=201)
        return JsonResponse({'message': 'Por favor, ingrese un nombre para la carpeta.'}, status=400)


@login_required(login_url="/libros/login/")
@never_cache
def update_folder_status(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    status = request.POST.get('status')
    if status:
        folder.status = status
        folder.save()
        return JsonResponse({'message': 'Estado actualizado exitosamente'})
    return JsonResponse({'message': 'No se proporcionó un estado'}, status=400)


@login_required(login_url="/libros/login/")
@never_cache
def upload_documents(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    if request.method == 'POST' and request.FILES.getlist('documents'):
        for file in request.FILES.getlist('documents'):
            Document.objects.create(folder=folder, file=file)
        return JsonResponse({'message': 'Documentos subidos exitosamente'})
    return JsonResponse({'message': 'No se recibieron documentos'}, status=400)


@login_required(login_url="/libros/login/")
@never_cache
def update_benefits(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    if request.method == "POST":
        folder.fecha_inicio = request.POST.get('fecha_inicio', '')
        folder.puesto_designado = request.POST.get('puesto_designado', '')
        folder.salario_actual = request.POST.get('salario_actual', '')
        folder.horas_trabajo = request.POST.get('horas_trabajo', '')
        folder.tiempo_contrato = request.POST.get('tiempo_contrato', '')
        folder.numero_identidad = request.POST.get('numero_identidad', '')
        folder.numero_seguro_social = request.POST.get('numero_seguro_social', '')
        folder.eps = request.POST.get('eps', '')
        folder.fondo_pensiones = request.POST.get('fondo_pensiones', '')
        folder.arl = request.POST.get('arl', '')
        folder.save()
        return JsonResponse({'message': 'Prestaciones de servicio actualizadas exitosamente'})
    return JsonResponse({'message': 'No se recibieron prestaciones'}, status=400)


@login_required(login_url="/libros/login/")
@never_cache
def delete_folder(request, folder_id):
    if request.method == 'POST':
        folder = get_object_or_404(Folder, id=folder_id)
        folder.delete()
        return JsonResponse({'message': 'Carpeta eliminada exitosamente'})
    return JsonResponse({'message': 'Método no permitido'}, status=405)


@login_required(login_url="/libros/login/")
@never_cache
def delete_document(request, doc_id):
    if request.method == 'POST':
        document = get_object_or_404(Document, id=doc_id)
        document.delete()
        return JsonResponse({'message': 'Documento eliminado exitosamente'})
    return JsonResponse({'message': 'Método no permitido'}, status=405)


@login_required(login_url="/libros/login/")
@never_cache
def download_benefits_pdf(request, folder_id):
    # Recupera la carpeta y sus datos
    folder = get_object_or_404(Folder, pk=folder_id)

    buffer = io.BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter

    # Logo a la izquierda
    logo_path = finders.find('diseños/imagenes/logo.png')
    logo_width = 80
    logo_height = 80
    logo_x = 40
    logo_y = height - logo_height - 20

    if os.path.exists(logo_path):
        p.drawImage(logo_path, logo_x, logo_y, width=logo_width, height=logo_height, mask='auto')

    # Nombre de la empresa centrado
    p.setFont("Helvetica-Bold", 18)
    empresa = "Maderas Isabella AEI S.A.S"
    text_width = p.stringWidth(empresa, "Helvetica-Bold", 18)
    text_x = (width - text_width) / 2
    text_y = logo_y + (logo_height / 2) + 6
    p.drawString(text_x, text_y, empresa)

    # Título debajo del encabezado
    p.setFont("Helvetica-Bold", 16)
    titulo = f"Prestaciones del trabajador: {folder.name}"
    titulo_width = p.stringWidth(titulo, "Helvetica-Bold", 16)
    titulo_x = (width - titulo_width) / 2
    titulo_y = logo_y - 20
    p.drawString(titulo_x, titulo_y, titulo)

    # Tabla de prestaciones
    data = [
        ['Campo', 'Valor'],
        ['Fecha de inicio', folder.fecha_inicio],
        ['Puesto designado', folder.puesto_designado],
        ['Salario actual', folder.salario_actual],
        ['Horas de trabajo', folder.horas_trabajo],
        ['Tiempo de contrato', folder.tiempo_contrato],
        ['Número de identidad', folder.numero_identidad],
        ['Número de seguro social', folder.numero_seguro_social],
        ['EPS', folder.eps],
        ['AFP', folder.fondo_pensiones],
        ['ARL', folder.arl],
    ]

    table = Table(data, colWidths=[180, 250])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#307c0c')),
        ('TEXTCOLOR', (0,0), (-1,0), colors.white),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,0), 12),
        ('ALIGN', (0,0), (-1,-1), 'LEFT'),
        ('GRID', (0,0), (-1,-1), 1, colors.HexColor('#307c0c')),
        ('BACKGROUND', (0,1), (-1,-1), colors.whitesmoke),
        ('FONTNAME', (0,1), (0,-1), 'Helvetica'),
        ('FONTSIZE', (0,1), (-1,-1), 11),
    ]))

    # Calcula la posición de la tabla debajo del título
    espacio_encabezado = 100  # Ajusta si necesitas más/menos espacio
    table_height = 25 * len(data)
    table.wrapOn(p, width, height)
    table.drawOn(p, 90, height - espacio_encabezado - table_height)

    p.save()
    buffer.seek(0)
    return FileResponse(buffer, as_attachment=True, filename=f"prestaciones_{folder.name}.pdf")



# --------------------------
# Vistas para cambiar la contraseña
# --------------------------

def recu_contra(request):
    
    if request.method == 'POST':
        email = request.POST.get('email')
        security_question = request.POST.get('security_question')
        security_answer = request.POST.get('security_answer')
        
        try:
            user = datos.objects.get(email=email)
        except datos.DoesNotExist:
            messages.error(request, "El correo ingresado no está registrado.")
            return render(request, 'libros/recu_contra.html')
        
        
        # Validar la pregunta de seguridad
        if security_question:
            if not user.security_question or user.security_question.lower().strip() != security_question.lower().strip():
                messages.error(request, "La pregunta de seguridad no coincide con la registrada.")
                return render(request, 'libros/recu_contra.html')
        
        # Validar la respuesta de seguridad
        if security_answer:
            if not user.security_answer or user.security_answer.lower().strip() != security_answer.lower().strip():
                messages.error(request, "La respuesta de seguridad no es correcta.")
                return render(request, 'libros/recu_contra.html')
        
        recovery_email = user.recovery_email

        # Generamos un token único con un tiempo de expiración (por ejemplo, 1 hora)
        signer = TimestampSigner()
        token = signer.sign(str(user.pk))
        
        # Construir la URL absoluta para cambiar la contraseña
        reset_url = request.build_absolute_uri(f"/libros/cambia_con/{token}/")
        
         # Renderizar la plantilla para el correo
        html_message = render_to_string('libros/msg_correo.html', {
            'username': user.nombres,  # Ajusta esto según los campos de tu modelo
            'reset_url': reset_url,
            'site_name': 'Maderas Isabella SAS',  # Personaliza con el nombre de tu sitio
        })
        
        # Preparar y enviar el correo al 'recovery_email'
        subject = "Recuperación de contraseña"
        text_message = strip_tags(html_message)
        
        try:
            email = EmailMultiAlternatives(
                subject=subject,
                body=text_message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                to=[recovery_email]
            )
            email.encoding = 'utf-8'  
            email.send()
            messages.success(request, "Se ha enviado un enlace a tu correo de recuperación para cambiar la contraseña.")
            return redirect("login")
        except Exception as e:
            messages.error(request, f"Error al enviar el correo: {str(e)}")
            return render(request, 'libros/recu_contra.html')
        
    return render(request, 'libros/recu_contra.html')


def cambia_con(request, token):
    
    signer = TimestampSigner()
    try:
        user_id = signer.unsign(token, max_age=3600)
        usuario = get_object_or_404(datos, pk=user_id)
    except (BadSignature, SignatureExpired):
        messages.error(request, "El enlace de recuperación es inválido o ha expirado.")
        return redirect("recu_contra")
    
    if request.method == 'POST':
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')
        
        # Validar que las contraseñas coincidan
        if new_password and confirm_password and new_password != confirm_password:
            messages.error(request, "Las contraseñas no coinciden.")
            return render(request, 'libros/cambia_con.html')

        # Validación de la contraseña:
        # Mínimo 8 caracteres, 1 mayúscula y 1 carácter especial (@!|./&)
        if new_password and not re.fullmatch(r'^(?=.*[A-Z])(?=.*[@!|./&]).{8,}$', new_password):
            messages.error(request, "La contraseña debe tener mínimo 8 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).")
            return render(request, 'libros/cambia_con.html')
        
        # Se actualiza la contraseña en la base de datos
        usuario.password = make_password(new_password)
        usuario.save()
        
        messages.success(request, "La contraseña se ha cambiado correctamente.")
        return redirect("login")
    
    return render(request, 'libros/cambia_con.html')



# --------------------------
# Vistas para gestion de archivos
# --------------------------

@login_required(login_url="/libros/login/")
@never_cache
def vista_archivos(request, file_path):
    try:
        full_path = safe_join(settings.MEDIA_ROOT, "documentos", file_path)
    except ValueError:
        return HttpResponseForbidden("Acceso no permitido.")

    if not os.path.exists(full_path):
        return HttpResponseForbidden("Archivo no encontrado.")

    response = FileResponse(open(full_path, 'rb'))
    response['X-Frame-Options'] = 'ALLOWALL'  # Permitir visualización en iframe
    response['Content-Disposition'] = 'inline'  # Mostrar el archivo en el navegador
    return response


@login_required(login_url="/libros/login/")
@never_cache
def mi_vista(request):
    return render(request, 'mi_template.html', {
        'timestamp': datetime.now().timestamp()
    })


#---------------------------
# Vistas para gestión de restauracion backups
#---------------------------



@login_required(login_url="/libros/login/")
@never_cache
def manage_backups(request):
    backup_dir = os.path.join(settings.BASE_DIR, 'backups')
    os.makedirs(backup_dir, exist_ok=True)

    backups = []
    for fname in os.listdir(backup_dir):
        if fname.endswith('.sql'):
            full = os.path.join(backup_dir, fname)
            ts   = os.path.getmtime(full)
            backups.append({
                'filename': fname,
                'timestamp': datetime.fromtimestamp(ts)
            })

    backups.sort(key=lambda b: b['timestamp'], reverse=True)
    return render(request, 'manage_backups.html', {
        'backups': backups,
        'timestamp': datetime.now().timestamp()
    })


@login_required(login_url="/libros/login/")
@never_cache
def backup_database(request):
    # 1) Localiza mysqldump (en PATH o en settings)
    dump_cmd = shutil.which('mysqldump') or settings.MYSQLDUMP_PATH
    if not dump_cmd or not os.path.exists(dump_cmd):
        return HttpResponse(
            "❌ No se encontró mysqldump. Agrega su carpeta al PATH "
            "o define MYSQLDUMP_PATH en settings.py",
            status=500
        )

    # 2) Nombre y ruta del backup
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    db = settings.DATABASES['default']
    filename   = f"{db['NAME']}_{ts}.sql"
    backup_dir = os.path.join(settings.BASE_DIR, 'backups')
    full_path  = os.path.join(backup_dir, filename)

    # 3) Ejecuta mysqldump SIN petición interactiva de password
    cmd = [
        dump_cmd,
        '-u', db['USER'],
        f"--password={db['PASSWORD']}",
        db['NAME']
    ]
    with open(full_path, 'wb') as out:
        result = subprocess.run(cmd, stdout=out, stderr=subprocess.PIPE)

    if result.returncode != 0:
        err = result.stderr.decode(errors='ignore')
        return HttpResponse(f"❌ Error generando backup:<br><pre>{err}</pre>", status=500)

    return redirect('manage_backups')


@login_required(login_url="/libros/login/")
@never_cache
def restore_named(request):
    if request.method == 'POST':
        # 1) Localiza mysql.exe
        mysql_cmd = shutil.which('mysql') or settings.MYSQL_PATH
        if not mysql_cmd or not os.path.exists(mysql_cmd):
            return HttpResponse(
                "❌ No se encontró mysql. Agrega su carpeta al PATH "
                "o define MYSQL_PATH en settings.py",
                status=500
            )

        # 2) Ruta del .sql a restaurar
        fname     = request.POST.get('filename')
        full_path = os.path.join(settings.BASE_DIR, 'backups', fname)
        if not os.path.exists(full_path):
            return HttpResponse("❌ Archivo no encontrado.", status=404)

        # 3) Ejecuta restore SIN petición interactiva de password
        db = settings.DATABASES['default']
        cmd = [
            mysql_cmd,
            '-u', db['USER'],
            f"--password={db['PASSWORD']}",
            db['NAME']
        ]
        with open(full_path, 'rb') as inp:
            result = subprocess.run(cmd, stdin=inp, stderr=subprocess.PIPE)

        if result.returncode != 0:
            err = result.stderr.decode(errors='ignore')
            return HttpResponse(f"❌ Error restaurando backup:<br><pre>{err}</pre>", status=500)

    return redirect('manage_backups')


@login_required(login_url="/libros/login/")
@never_cache
@csrf_exempt
def delete_backup(request):
    if request.method == "POST":
        filename = request.POST.get("filename")
        path = os.path.join(settings.BASE_DIR, 'backups', filename)
        if os.path.exists(path):
            try:
                os.remove(path)
            except PermissionError:
                return HttpResponse(
                    "❌ No se pudo eliminar: archivo en uso.",
                    status=500
                )
    return redirect('manage_backups')



#-----------------------------------------
#Vistas para la gestion de lista de inventario
#-----------------------------------------

@login_required(login_url="/libros/login/")
@never_cache
def inventory_list(request):
    # AJAX POST para crear producto
    if request.method == 'POST' and request.headers.get('x-requested-with') == 'XMLHttpRequest':
        data = json.loads(request.body)
        
        tipo_id = data.get('wood_type')
        tipo_obj = get_object_or_404(TipoMadera, pk=tipo_id)
        data['wood_type'] = tipo_obj.nombre
        
        
        
        form = ProductForm(data)
        if form.is_valid():
            p = form.save()
            return JsonResponse({
                'success': True,
                'product': {
                    'id':           p.id,
                    'name':         p.name,
                    'wood_type':    p.wood_type,   # ojo con tu campo aquí
                    'price':        str(p.price),
                    'stock':        p.stock,
                }
            })
        else:
            return JsonResponse({'success': False, 'errors': form.errors}, status=400)

    # GET normal
    products = Product.objects.all().order_by('-created_at')
    tipos = TipoMadera.objects.all()     # <-- traemos todos los tipos de madera
    context = {
        'products': products,
        'tipos_madera': tipos,           # <-- los pasamos al template
    }
    return render(request, 'libros/inventory.html', context)


@login_required(login_url="/libros/login/")
@never_cache
@require_POST
def update_stock(request):
    # AJAX POST para actualizar stock
    data = json.loads(request.body)
    pid = data.get('id')
    new_stock = data.get('stock')
    try:
        prod = Product.objects.get(id=pid)
        prod.stock = new_stock
        prod.save()
        return JsonResponse({'success': True, 'stock': prod.stock})
    except Product.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Producto no encontrado'}, status=404)
    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)}, status=400)
    

@login_required(login_url="/libros/login/")
@never_cache
@require_http_methods(["PUT"])
def update_product(request, product_id):
    """Vista para actualizar un producto existente mediante AJAX"""
    try:
        product = Product.objects.get(id=product_id)
        data = json.loads(request.body)
        
        tipo_id = data.get('wood_type')
        tipo_obj = get_object_or_404(TipoMadera, pk=tipo_id)
        data['wood_type'] = tipo_obj.nombre
        
        form = ProductForm(data, instance=product)
        if form.is_valid():
            p = form.save()
            return JsonResponse({
                'success': True,
                'product': {
                    'id': p.id,
                    'name': p.name,
                    'wood_type': p.wood_type,
                    'price': str(p.price),
                    'stock': p.stock,
                }
            })
            
        return JsonResponse({'success': False, 'errors': form.errors}, status=400)
    
    except Product.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Producto no encontrado'}, status=404)
    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)}, status=500)


@login_required(login_url="/libros/login/")
@never_cache
@require_http_methods(["DELETE"])
def delete_product(request, product_id):
    """Vista para eliminar un producto mediante AJAX"""
    try:
        product = Product.objects.get(id=product_id)
        product.delete()
        return JsonResponse({'success': True})
    except Product.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Producto no encontrado'}, status=404)
    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)}, status=500)


@login_required(login_url="/libros/login/")
@never_cache
def download_inventory_pdf(request):
    buffer = io.BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter
    
    logo_path = finders.find('diseños/imagenes/logo.png')
    logo_width = 80
    logo_height = 80
    logo_x = 40  # margen derecho
    logo_y = height - logo_height - 20  # margen superior
    
    if os.path.exists(logo_path):
        p.drawImage(logo_path, logo_x, logo_y, width=logo_width, height=logo_height, mask='auto')
        
    p.setFont("Helvetica-Bold", 18)
    empresa = "Maderas Isabella AEI S.A.S"
    text_width = p.stringWidth(empresa, "Helvetica-Bold", 18)
    text_x = (width - text_width) / 2
    text_y = logo_y + (logo_height / 2) +6

    p.drawString(text_x, text_y, empresa)

    p.setFont("Helvetica", 12)
    # Título del inventario debajo del encabezado
    p.setFont("Helvetica-Bold", 16)
    titulo = "Inventario de Productos"
    titulo_width = p.stringWidth(titulo, "Helvetica-Bold", 16)
    titulo_x = (width - titulo_width) / 2
    titulo_y = logo_y - 20  # 20 px debajo del logo
    p.drawString(titulo_x, titulo_y, titulo)
    
    
    
        
    # --------- TABLA PRINCIPAL DE PRODUCTOS ---------
    # Construye los datos de la tabla
    data = [['Nombre', 'Tipo de Madera', 'Precio', 'Stock']]
    total_productos = 0
    total_stock = 0
    total_valor = 0

    for prod in Product.objects.all():
        data.append([
            str(prod.name),
            str(prod.wood_type),
            f"${prod.price}",
            str(prod.stock)
        ])
        total_productos += 1
        total_stock += prod.stock
        total_valor += float(prod.price) * prod.stock

    # Crea la tabla de productos
    table = Table(data, colWidths=[140, 140, 100, 80])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#000000')),
        ('TEXTCOLOR', (0,0), (-1,0), colors.white),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,0), 12),
        ('ALIGN', (0,0), (-1,-1), 'LEFT'),
        ('GRID', (0,0), (-1,-1), 1, colors.HexColor('#000000')),
        ('BACKGROUND', (0,1), (-1,-1), colors.whitesmoke),
        ('FONTNAME', (0,1), (-1,-1), 'Helvetica'),
        ('FONTSIZE', (0,1), (-1,-1), 11),
    ]))

    # Dibuja el título
    p.setFont("Helvetica-Bold", 16)

    # Dibuja la tabla de productos
    table.wrapOn(p, width, height)
    table_height = 25 * (len(data))  # Aproximado, puedes ajustar
    table.drawOn(p, 50, height - 140 - table_height)

    # Datos de la tabla resumen
    resumen_data = [
        ['Resumen del Inventario', ''],
        ['Total de productos:', str(total_productos)],
        ['Stock total:', str(total_stock)],
        ['Valor total del inventario:', f"${total_valor:,.2f}"],
    ]

    # Crea la tabla
    resumen_table = Table(resumen_data, colWidths=[180, 150])
    resumen_table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#307c0c')),
        ('TEXTCOLOR', (0,0), (-1,0), colors.white),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,0), 12),
        ('BOTTOMPADDING', (0,0), (-1,0), 10),
        ('BACKGROUND', (0,1), (-1,-1), colors.whitesmoke),
        ('GRID', (0,0), (-1,-1), 1, colors.HexColor('#307c0c')),
        ('FONTNAME', (0,1), (0,-1), 'Helvetica-Bold'),
        ('ALIGN', (0,0), (-1,-1), 'LEFT'),
    ]))

    # Dibuja la tabla en el canvas
    resumen_y = height - 140 - table_height - 120
    resumen_table.wrapOn(p, width, height)
    resumen_table.drawOn(p, 50, resumen_y) 

    p.save()
    buffer.seek(0)
    return FileResponse(buffer, as_attachment=True, filename="inventario.pdf")







