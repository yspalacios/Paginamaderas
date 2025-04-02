// Función para validar el formulario antes de enviar
function validarFormulario() {
    // Se obtienen los valores de cada campo
    const nombres = document.getElementById('nombres').value;
    const apellidos = document.getElementById('apellidos').value;
    const email = document.getElementById('email').value;
    const phone = document.getElementById('phone').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm_password').value;
    const terminos = document.getElementById('terminos').checked;
    
    // Expresiones regulares para validaciones
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const nameRegex = /^[A-Za-zÀ-ÿ\s]+$/;
    const phoneRegex = /^\d{0,10}$/;
    
    if (!nameRegex.test(nombres)) {
        alert("El campo de Nombres solo debe contener letras.");
        return false;
    }
    
    if (!nameRegex.test(apellidos)) {
        alert("El campo de Apellidos solo debe contener letras.");
        return false;
    }
    
    if (!emailRegex.test(email)) {
        alert("Ingrese un correo válido.");
        return false;
    }
    
    if (phone && !phoneRegex.test(phone)) {
        alert("El Teléfono debe contener solo números y máximo 10 dígitos.");
        return false;
    }
    
    if (password.length < 6) {
        alert("La contraseña debe tener al menos 6 caracteres.");
        return false;
    }
    
    if (password !== confirmPassword) {
        alert("Las contraseñas no coinciden.");
        return false;
    }
    
    if (!terminos) {
        alert("Debe aceptar los Términos y Condiciones.");
        return false;
    }
    
    return true;
}