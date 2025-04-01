from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse, HttpResponseNotAllowed, FileResponse, HttpResponseForbidden
from django.contrib.auth import authenticate, login, logout, get_user_model
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from .models import Producto, datos, Folder, Document
from .forms import ProductoForm, RegistroForm
from django.core.mail import send_mail
from django.conf import settings
from django.urls import reverse
from django.views.decorators.cache import never_cache
from django.contrib.admin.views.decorators import staff_member_required
from django.template.loader import render_to_string
from django.db.models import Q
import os
from django.utils._os import safe_join

# --------------------------
# Vistas para páginas estáticas
# --------------------------
def inicio(request):
    imagenes_publicadas = Producto.objects.filter(publicado=True)
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
    productos = Producto.objects.all()
    return render(request, 'libros/gestionar_productos.html', {'form': form, 'productos': productos})

@login_required(login_url="/libros/login/")
@never_cache
def editar_producto(request, producto_id):
    producto = get_object_or_404(Producto, id=producto_id)
    if request.method == "POST":
        form = ProductoForm(request.POST, request.FILES, instance=producto)
        if form.is_valid():
            form.save()
            return redirect('gestionar_productos')
    else:
        form = ProductoForm(instance=producto)
    return render(request, 'libros/editar_producto.html', {'form': form})

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
            return redirect('login')
        else:
            messages.error(request, "Por favor corrija los errores en el formulario")
    else:
        # Si no es POST, se instancia un formulario vacío
        form = RegistroForm()
    # Se renderiza el template con el formulario en el contexto
    return render(request, 'libros/registro_login.html', {'form': form})

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
# Vistas para espacio de búsqueda de productos
# --------------------------
def gestionar_productos_ajax(request):
    query = request.GET.get('query', '')
    if query:
        productos = Producto.objects.filter(
            Q(nombre_producto__icontains=query) | Q(descripcion__icontains=query)
        )
    else:
        productos = Producto.objects.all()
    html = render_to_string('libros/productos_partial.html', {'productos': productos})
    return JsonResponse({'html': html})


# --------------------------
# Vistas para cambiar la contraseña
# --------------------------

def recu_contra(request):
    """
    Vista para validar los datos ingresados (correo, nombres, apellidos, 
    pregunta y respuesta de seguridad, teléfono) y guardar el correo en la sesión
    para posteriormente cambiar la contraseña.
    """
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
        
        # Guardamos el email en la sesión para usarlo en la vista de cambio de contraseña
        request.session['reset_email'] = email
        return redirect('cambia_con')  # Asegúrate de que en urls.py esta URL se llame 'cambia_con'
    
    return render(request, 'libros/recu_contra.html')


def cambia_con(request):
    """
    Vista para cambiar la contraseña una vez que se ha validado el usuario.
    Se comprueba que ambas contraseñas ingresadas sean iguales y se actualiza el password.
    """
    if request.method == 'POST':
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')
        
        if new_password != confirm_password:
            messages.error(request, "Las contraseñas no coinciden.")
            return render(request, 'libros/cambia_con.html')
        
        email = request.session.get('reset_email')
        if not email:
            messages.error(request, "La sesión ha expirado. Por favor, vuelve a solicitar la recuperación de contraseña.")
            return redirect('recu_contra')
        
        try:
            user = datos.objects.get(email=email)
            user.set_password(new_password)
            user.save()
            messages.success(request, "Contraseña cambiada exitosamente.")
            # Limpiamos la variable de sesión
            del request.session['reset_email']
            return redirect('login')  # Redirige a la página de inicio de sesión (asegúrate de tener definida la URL 'login')
        except datos.DoesNotExist:
            messages.error(request, "No se encontró un usuario con ese correo.")
    
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

    