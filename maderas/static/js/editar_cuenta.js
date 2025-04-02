function validarFormulario() {
    // Se obtiene el valor de la contraseña y su confirmación
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm_password').value;
    
    // Si se ingresó una nueva contraseña, se valida el formato
    if (password) {
        // La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y 1 carácter especial (@!|./&)
        const regex = /^(?=.*[A-Z])(?=.*[@!|./&]).{12,}$/;
        if (!regex.test(password)) {
            alert("La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).");
            return false;
        }
        
        // Validar que las contraseñas coincidan
        if (password !== confirmPassword) {
            alert("Las contraseñas no coinciden");
            return false;
        }
    }
    return true;
}