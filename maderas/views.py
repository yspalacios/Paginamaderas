from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse, FileResponse, HttpResponseForbidden, HttpResponse
from django.contrib.auth import login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.hashers import make_password
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
import os, subprocess, datetime, shutil, json
from django.utils._os import safe_join
from django.utils.html import strip_tags
from django.core.mail import EmailMultiAlternatives
from datetime import datetime



# --------------------------
# Vistas para páginas estáticas
# --------------------------
def inicio(request):
    imagenes_publicadas = Producto.objects.filter(publicado=True).order_by('tipo_madera__nombre','id')
    return render(request, 'paginas/inicio.html', {'imagenes_publicadas': imagenes_publicadas})


# myapp/views.py
from django.shortcuts import render

def calendar_view(request):
    return render(request, 'libros/calendario.html')

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
def manage_index(request):
    # 1. Conteos de cada módulo
    gallery_count   = Producto.objects.count()      # Galería de publicidad
    producto_publicado = Producto.objects.filter(publicado=True).count()     #Productos publicados
    producto_no_publicado = Producto.objects.filter(publicado=False).count()    #Productos publicados
    inventory_count = Product.objects.count()       # Lista de inventario
    user_count      = datos.objects.count()         # Listado de usuarios
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
        'user_count':      user_count,
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


@login_required
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

def inventory_list(request):
    # AJAX POST para crear producto
    if request.method=='POST' and request.headers.get('x-requested-with')=='XMLHttpRequest':
        data = json.loads(request.body)
        form = ProductForm(data)
        if form.is_valid():
            p = form.save()
            return JsonResponse({
                'success': True,
                'product': {
                    'id':        p.id,
                    'name':      p.name,
                    'wood_type': p.wood_type,
                    'price':     str(p.price),
                    'stock':     p.stock,
                }
            })
        else:
            return JsonResponse({'success':False,'errors':form.errors}, status=400)

    # GET normal
    products = Product.objects.all().order_by('-created_at')
    return render(request,'libros/inventory.html',{'products':products})


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
    
    
    

@require_http_methods(["PUT"])
def update_product(request, product_id):
    """Vista para actualizar un producto existente mediante AJAX"""
    try:
        product = Product.objects.get(id=product_id)
        data = json.loads(request.body)
        
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
        else:
            return JsonResponse({'success': False, 'errors': form.errors}, status=400)
    except Product.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Producto no encontrado'}, status=404)
    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)}, status=500)


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


