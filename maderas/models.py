from django.db import models  # Importa el módulo de modelos de Django
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin  # Importa clases para crear usuarios personalizados
from django.core.validators import RegexValidator  # Importa el validador para expresiones regulares
from django.core.validators import MinValueValidator


class TipoMadera(models.Model):
    nombre = models.CharField(max_length=200, unique=True)

    def __str__(self):
        return self.nombre


# Modelo para el producto
class Producto(models.Model):
    tipo_madera = models.ForeignKey(
        TipoMadera,
        on_delete=models.PROTECT,
        related_name='productos'
    )  # ahora FK    
    nombre_producto = models.CharField(max_length=200)  # Nombre del producto
    descripcion = models.TextField()  # Descripción detallada del producto
    imagen = models.ImageField(upload_to='productos/', null=True, blank=True)  # Imagen del producto 
    publicado = models.BooleanField(default=False)  # Indica si el producto está publicado
    precio = models.DecimalField(max_digits=10, decimal_places=2, default=0.00, validators=[MinValueValidator(0)])  # Precio del producto (máximo 10 dígitos, 2 decimales)

    def __str__(self):
        return self.nombre_producto  # Representación en cadena del objeto Producto

#-------------------------------------------------
# Modelo para la creación de cuentas de usuario
#-------------------------------------------------

#modelo para crear eñ super usuario
class CuentaManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("El correo electrónico es obligatorio")

        # Solo validar nombres y apellidos si no es superusuario
        if not extra_fields.get('is_superuser', False):
            if 'nombres' not in extra_fields or not extra_fields['nombres']:
                raise ValueError("El campo 'nombres' es obligatorio")
            if 'apellidos' not in extra_fields or not extra_fields['apellidos']:
                raise ValueError("El campo 'apellidos' es obligatorio")

        # Asignar estado por defecto si no es superusuario
        if not extra_fields.get('is_superuser', False):
            extra_fields.setdefault('is_active', False)
            extra_fields.setdefault('status', 'No Activo')

        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields["is_active"] = True
        extra_fields["status"] = "Activo"
        return self.create_user(email, password, **extra_fields)

# Modelo personalizado de Cuenta que hereda de AbstractBaseUser y PermissionsMixin
class datos(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)  # Campo de correo, debe ser único

    nombres = models.CharField(
        max_length=100,      # Máximo 100 caracteres
        blank=False,         # Campo obligatorio
        null=False,          # No permite valor nulo
        default=""
    )  

    apellidos = models.CharField(
        max_length=100,      # Máximo 100 caracteres
        blank=False,         # Campo obligatorio
        null=False,           # No permite valor nulo
        default=""
    )  
    
    
    # Validador para el campo phone: solo permite 10 dígitos numéricos
    phone_validator = RegexValidator(
        regex=r'^\d{10}$',  # Expresión regular que valida 10 dígitos
        message='El teléfono debe contener 10 dígitos numéricos.'
    )
    phone = models.CharField(
        max_length=10,       # Máximo 10 caracteres
        blank=True,          # Puede quedar vacío
        null=True,           # Puede ser nulo
        validators=[phone_validator]  # Se aplica el validador al campo
    )
    
    security_question = models.CharField(max_length=255, blank=True, null=True)  # Pregunta de seguridad (opcional)
    security_answer = models.CharField(max_length=255, blank=True, null=True)    # Respuesta a la pregunta de seguridad (opcional)
    recovery_email = models.EmailField(blank=True, null=True)  # Correo de recuperación (opcional)
    profile_image = models.ImageField(upload_to='profile_images/', blank=True, null=True)  # nuevo campo para la imagen de perfil (opcional)
    status = models.CharField(max_length=20, default="No Activo")  # Estado de la cuenta
    is_active = models.BooleanField(default=True)   # Indica si la cuenta está activa
    is_staff = models.BooleanField(default=False)     # Indica si el usuario tiene permisos de staff

    USERNAME_FIELD = 'email'  # Campo que se utilizará para el inicio de sesión
    REQUIRED_FIELDS = []      # Campos requeridos adicionales (en este caso, ninguno)

    objects = CuentaManager()  # Asigna el manager personalizado a la clase

    def __str__(self):
        return self.email  # Representación en cadena del objeto Cuenta

#-------------------------------------------------
# Modelo para las carpetas
#-------------------------------------------------

class Folder(models.Model):
    name = models.CharField(max_length=255)  # Nombre de la carpeta
    status = models.CharField(max_length=50, default='No definido')  # Estado de la carpeta
    fecha_inicio = models.CharField(max_length=100, blank=True, null=True)  # Fecha de inicio (opcional)
    puesto_designado = models.CharField(max_length=255, blank=True, null=True)  # Puesto designado (opcional)
    salario_actual = models.CharField(max_length=100, blank=True, null=True)  # Salario actual (opcional)
    horas_trabajo = models.CharField(max_length=50, blank=True, null=True)  # Horas de trabajo (opcional)
    tiempo_contrato = models.CharField(max_length=100, blank=True, null=True)  # Tiempo de contrato (opcional)
    numero_identidad = models.CharField(max_length=100, blank=True, null=True)  # Número de identidad (opcional)
    numero_seguro_social = models.CharField(max_length=100, blank=True, null=True)  # Número de seguro social (opcional)
    eps = models.CharField(max_length=100, blank=True, null=True)  # EPS (opcional)
    fondo_pensiones = models.CharField(max_length=100, blank=True, null=True)  # Fondo de pensiones (opcional)
    arl = models.CharField(max_length=100, blank=True, null=True)  # ARL (opcional)

    def __str__(self):
        return self.name  # Representación en cadena del objeto Folder

# Modelo para los documentos asociados a una carpeta
class Document(models.Model):
    folder = models.ForeignKey(Folder, related_name='documents', on_delete=models.CASCADE)  # Relación con el modelo Folder
    file = models.FileField(upload_to='documents/', null=True, blank=True)  # Archivo subido (opcional)
    uploaded_at = models.DateTimeField(auto_now_add=True)  # Fecha y hora de subida (se asigna automáticamente)

    def __str__(self):
        return self.file.name if self.file else ""  # Representación en cadena del objeto Document

#--------------------------------------------------
# Modelo para la lista de inventario
#--------------------------------------------------

class Product(models.Model):
    name            =models.CharField("Nombre", max_length=255)
    wood_type       =models.CharField("Tipo de madera", max_length=100, blank=True)
    price           =models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0)])
    stock           =models.PositiveIntegerField(default=0, validators=[MinValueValidator(0)])
    created_at      =models.DateTimeField(auto_now_add=True)
    updated_at      =models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
    