from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse, FileResponse, HttpResponseForbidden
from django.contrib.auth import login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from .models import Producto, datos, Folder, Document
from .forms import ProductoForm, RegistroForm
from django.core.mail import send_mail
from django.core.signing import TimestampSigner, BadSignature, SignatureExpired
from django.conf import settings
from django.views.decorators.cache import never_cache
from django.template.loader import render_to_string
from django.db.models import Q
import os
from django.utils._os import safe_join
from django.utils.html import strip_tags
from django.core.mail import EmailMultiAlternatives
from datetime import datetime


# --------------------------
# Vistas para páginas estáticas
# --------------------------
def inicio(request):
    imagenes_publicadas = Producto.objects.filter(publicado=True).order_by('tipo_madera','id')
    return render(request, 'paginas/inicio.html', {'imagenes_publicadas': imagenes_publicadas})

def libros(request):
    return render(request, 'libros/index.html')

#---------------------------
# Vistas para login y redirección
# --------------------------
@login_required(login_url="/libros/login/")
@never_cache
def index_view(request):
    return render(request, "libros/index.html")

def login_view(request):
    if request.method == "POST":
        email = request.POST.get('email')
        password = request.POST.get('password')
        try:
            user = datos.objects.get(email=email)
        except datos.DoesNotExist:
            messages.error(request, "Correo o contraseña inválidos")
            return redirect('login')
        
        if user.status != "Activo":
            messages.error(request, "La cuenta no está activada. Por favor, contacta con el administrador.")
            return redirect('login')

        if user.check_password(password):
            messages.success(request, "Inicio de sesión exitoso")
            login(request, user)
            return redirect('index')
        else:
            messages.error(request, "Correo o contraseña inválidos")
            return redirect('login')
    return render(request, 'libros/login.html')

def logout_view(request):
    logout(request)
    return redirect('login')


# --------------------------
# Vistas para espacio de búsqueda de productos
# --------------------------
def gestionar_productos_ajax(request):
    query = request.GET.get('query', '').strip()
    wood_filter = request.GET.get('wood_filter', '').strip()

    # Empieza obteniendo todos los productos
    productos = Producto.objects.all().order_by('tipo_madera','id')

    # Si se ha seleccionado un tipo de madera, filtra por ese campo
    if wood_filter:
        productos = productos.filter(tipo_madera=wood_filter)

    # Si se ingresó un término de búsqueda, se filtran por nombre o descripción
    if query:
        productos = productos.filter(
            Q(nombre_producto__icontains=query)
        )
        
    productos = productos.order_by('tipo_madera','id')

    html = render_to_string('libros/productos_partial.html', {'productos': productos})
    return JsonResponse({'html': html})


# --------------------------
# Vistas para gestión de productos
# --------------------------

@login_required(login_url="/libros/login/")
@never_cache
def gestionar_productos(request):
    if request.method == "POST":
        form = ProductoForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('gestionar_productos')
    else:
        form = ProductoForm()
    
    # Obtener todos los productos
    productos = Producto.objects.all().order_by('tipo_madera','id')
    
    # Agrupar productos por tipo de madera
    productos_por_tipo = {}
    for producto in productos:
        tipo_madera = producto.tipo_madera
        if tipo_madera not in productos_por_tipo:
            productos_por_tipo[tipo_madera] = []
        productos_por_tipo[tipo_madera].append(producto)
    
    return render(request, 'libros/gestionar_productos.html', {
        'form': form, 
        'productos': productos,  # Mantenemos esta variable por compatibilidad
        'productos_por_tipo': productos_por_tipo
    })
    
    
@login_required(login_url="/libros/login/")
@never_cache
def editar_producto(request, producto_id):
    producto = get_object_or_404(Producto, pk=producto_id)
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

    return render(request, 'libros/editar_producto_form.html', {'form': form, 'producto': producto})


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


# --------------------------
# Vistas para Registro y Gestión de Cuentas
# --------------------------

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
    return render(request, 'libros/registro_form.html', {'form': form})

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
    return render(request, 'libros/editar_cuenta.html', {'cuenta': cuenta})

@login_required(login_url="/libros/login/")
@never_cache
def activar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    cuenta.status = "Activo"
    cuenta.save()
    messages.success(request, "Cuenta activada")
    return redirect('lista_login')

@login_required(login_url="/libros/login/")
@never_cache
def desactivar_cuenta(request, cuenta_id):
    cuenta = get_object_or_404(datos, id=cuenta_id)
    cuenta.status = "No Activo"
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
def carpeta(request):
    return render(request, 'libros/carpeta.html')

def get_folders(request):
    folders = Folder.objects.all()
    folders_list = []
    for folder in folders:
        docs_list = []
        for doc in folder.documents.all():
            docs_list.append({
                'id': doc.id,
                'name': doc.file.name,
                'url': doc.file.url,  # Asegúrate de que MEDIA_URL esté configurado correctamente
            })
        folders_list.append({
            'id': folder.id,
            'name': folder.name,
            'status': folder.status,
            'fecha_inicio': folder.fecha_inicio,
            'puesto_designado': folder.puesto_designado,
            'salario_actual': folder.salario_actual,
            'horas_trabajo': folder.horas_trabajo,
            'tiempo_contrato': folder.tiempo_contrato,
            'numero_identidad': folder.numero_identidad,
            'numero_seguro_social': folder.numero_seguro_social,
            'eps': folder.eps,
            'fondo_pensiones': folder.fondo_pensiones,
            'arl': folder.arl,
            'documents': docs_list
        })
    return JsonResponse(folders_list, safe=False)

def create_folder(request):
    if request.method == "POST":
        folder_name = request.POST.get('folderName')
        if folder_name:
            folder = Folder.objects.create(name=folder_name)
            return JsonResponse({'message': 'Carpeta creada exitosamente', 'folder_id': folder.id}, status=201)
        return JsonResponse({'message': 'Por favor, ingrese un nombre para la carpeta.'}, status=400)

def update_folder_status(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    status = request.POST.get('status')
    if status:
        folder.status = status
        folder.save()
        return JsonResponse({'message': 'Estado actualizado exitosamente'})
    return JsonResponse({'message': 'No se proporcionó un estado'}, status=400)

def upload_documents(request, folder_id):
    folder = get_object_or_404(Folder, id=folder_id)
    if request.method == 'POST' and request.FILES.getlist('documents'):
        for file in request.FILES.getlist('documents'):
            Document.objects.create(folder=folder, file=file)
        return JsonResponse({'message': 'Documentos subidos exitosamente'})
    return JsonResponse({'message': 'No se recibieron documentos'}, status=400)

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

def delete_folder(request, folder_id):
    if request.method == 'POST':
        folder = get_object_or_404(Folder, id=folder_id)
        folder.delete()
        return JsonResponse({'message': 'Carpeta eliminada exitosamente'})
    return JsonResponse({'message': 'Método no permitido'}, status=405)

def delete_document(request, doc_id):
    if request.method == 'POST':
        document = get_object_or_404(Document, id=doc_id)
        document.delete()
        return JsonResponse({'message': 'Documento eliminado exitosamente'})
    return JsonResponse({'message': 'Método no permitido'}, status=405)



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
        
        if new_password != confirm_password:
            messages.error(request, "Las contraseñas no coinciden.")
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

def vista_archivos(request, file_path):
    """ Sirve archivos desde media/documentos con los headers adecuados """
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


def mi_vista(request):
    return render(request, 'mi_template.html', {
        'timestamp': datetime.now().timestamp()
    })
