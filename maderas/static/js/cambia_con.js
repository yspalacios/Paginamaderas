function validatePasswordChange() {
    // Obtiene los valores de los campos de contraseña
    var newPassword = document.getElementById('new_password').value;
    var confirmPassword = document.getElementById('confirm_password').value;
    
    // Validación de contraseña:
    // La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y 1 carácter especial (@!|./&)
    var regex = /^(?=.*[A-Z])(?=.*[@!|./&]).{12,}$/;
    
    if (!regex.test(newPassword)) {
      alert("La contraseña debe tener mínimo 12 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).");
      return false;
    }
    
    // Validar que las contraseñas coincidan
    if (newPassword !== confirmPassword) {
      alert("Las contraseñas no coinciden.");
      return false;
    }
    
    // Confirmación final para el cambio de contraseña
    return confirm("¿Estás seguro de cambiar tu contraseña?");
  }
  