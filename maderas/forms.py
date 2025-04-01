from django import forms  # Importa el módulo de formularios de Django
from .models import Producto, Folder, datos  # Importa los modelos necesarios, incluyendo el modelo personalizado Cuenta
import re

# ====================== ProductoForm ====================
class ProductoForm(forms.ModelForm):
    class Meta:
        model = Producto  # Se utiliza el modelo Producto
        fields = ['tipo_madera', 'nombre_producto', 'descripcion', 'imagen']  # Campos que se incluirán en el formulario

    def __init__(self, *args, **kwargs):
        # Constructor del formulario que llama al constructor del padre
        super().__init__(*args, **kwargs)
        # Si la instancia ya existe (se está editando), se marca el campo 'imagen' como no obligatorio
        if self.instance and self.instance.pk:
            self.fields['imagen'].required = False

    def clean_imagen(self):
        # Método para validar el campo 'imagen'
        imagen = self.cleaned_data.get('imagen')  # Se obtiene el valor del campo 'imagen'
        if imagen is False:
            return None  # Si el valor es False, se retorna None
        # Si no se sube una imagen y la instancia actual no tiene imagen, se genera un error de validación
        if not imagen and not self.instance.imagen:
            raise forms.ValidationError("Debes subir una imagen.")
        return imagen  # Se retorna la imagen validada

    def save(self, commit=True):
        # Método para guardar la instancia del modelo
        instance = super().save(commit=False)  # Se guarda sin confirmar en la base de datos
        # Si en los datos limpiados la imagen es None, se asigna None a la imagen de la instancia
        if self.cleaned_data.get('imagen') is None:
            instance.imagen = None
        if commit:
            instance.save()  # Se guarda en la base de datos si commit es True
        return instance  # Se retorna la instancia guardada

# ========================= FolderForm ===================
class FolderForm(forms.ModelForm):
    class Meta:
        model = Folder  # Se utiliza el modelo Folder
        fields = [
            'name',
            'status',
            'fecha_inicio',
            'puesto_designado',
            'salario_actual',
            'horas_trabajo',
            'tiempo_contrato',
            'numero_identidad',
            'numero_seguro_social',
            'eps',
            'fondo_pensiones',
            'arl'
        ]  # Campos incluidos en el formulario

    def clean_numero_identidad(self):
        # Método para validar que 'numero_identidad' contenga solo dígitos
        numero_identidad = self.cleaned_data.get('numero_identidad')  # Obtiene el valor ingresado
        if numero_identidad and not numero_identidad.isdigit():
            # Si existe un valor y no está compuesto únicamente de dígitos, se lanza un error
            raise forms.ValidationError("El número de identidad debe contener solo dígitos.")
        return numero_identidad  # Se retorna el valor validado

    def clean_numero_seguro_social(self):
        # Método para validar que 'numero_seguro_social' contenga solo dígitos
        numero_seguro_social = self.cleaned_data.get('numero_seguro_social')  # Obtiene el valor ingresado
        if numero_seguro_social and not numero_seguro_social.isdigit():
            # Si existe un valor y no está compuesto únicamente de dígitos, se lanza un error
            raise forms.ValidationError("El número de seguro social debe contener solo dígitos.")
        return numero_seguro_social  # Se retorna el valor validado

    def clean_salario_actual(self):
        # Método para validar que 'salario_actual' sea un valor numérico
        salario_actual = self.cleaned_data.get('salario_actual')  # Obtiene el valor ingresado
        if salario_actual:
            try:
                # Intenta convertir el valor a float (acepta números decimales)
                float(salario_actual)
            except ValueError:
                # Si ocurre un error, el valor no es numérico y se lanza un error de validación
                raise forms.ValidationError("El salario actual debe ser un número.")
        return salario_actual  # Se retorna el valor validado

# ======================= RegistroForm =====================
class RegistroForm(forms.ModelForm):
    # Campo para la contraseña con widget de password
    password = forms.CharField(widget=forms.PasswordInput, help_text="Ingrese su contraseña.")
    # Campo para la confirmación de la contraseña
    confirm_password = forms.CharField(widget=forms.PasswordInput, help_text="Confirme su contraseña.")

    class Meta:
        model = datos  # Se utiliza el modelo personalizado de Cuenta
        fields = [
            'nombres',           # Campo para los nombres
            'apellidos',         # Campo para los apellidos
            'email',             # Campo para el correo electrónico
            'phone',             # Campo para el teléfono
            'security_question', # Campo para la pregunta de seguridad
            'security_answer',   # Campo para la respuesta de seguridad
            'recovery_email',    # Campo para el correo de recuperación
            'password'           # Campo para la contraseña
        ]


    def __init__(self, *args, **kwargs):
        # Constructor del formulario que añade el atributo "required" a todos los campos
        super().__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['required'] = 'required'  # Línea para forzar que el campo sea obligatorio


    def clean(self):
        # Obtiene los datos limpios del formulario
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")
        
        # Validar que las contraseñas coincidan
        if password and confirm_password and password != confirm_password:
            self.add_error('confirm_password', "Las contraseñas no coinciden.")
        
        # Validación de la contraseña:
        # La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y 1 carácter especial (@!|./&)
        if password and not re.fullmatch(r'^(?=.*[A-Z])(?=.*[@!|./&]).{12,}$', password):
            self.add_error('password', "La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).")
        
        return cleaned_data

    def save(self, commit=True):
        # Sobrescribe el método save para encriptar la contraseña antes de guardar
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password"])  # Encripta la contraseña
        if commit:
            user.save()  # Guarda la instancia en la base de datos
        return user