
let deleteAccountId = null;


function showFloatingAlert(message, type = 'success') {
  // Elimina cualquier alerta previa
  const oldAlert = document.getElementById('alerta-flotante');
  if (oldAlert) oldAlert.remove();

  // Crea el div de la alerta
  const alertDiv = document.createElement('div');
  alertDiv.id = 'alerta-flotante';
  alertDiv.className = 'fixed top-6 left-1/2 transform -translate-x-1/2 z-50 px-6 py-4 rounded shadow-lg transition-all';
  alertDiv.style.background = 'white';
  alertDiv.style.borderLeft = type === 'success' ? '6px solid #22c55e' : '6px solid #ef4444';
  alertDiv.style.color = type === 'success' ? '#15803d' : '#b91c1c';
  alertDiv.textContent = message;

  document.body.appendChild(alertDiv);

  setTimeout(() => {
    alertDiv.remove();
  }, 1500); 
}


// -------------------------------------
// ELIMINAR CUENTA
// -------------------------------------

function openDeleteModal(id) {
  deleteAccountId = id;
  document.getElementById('deleteModal').style.display = 'flex';
}

function closeDeleteModal() {
  deleteAccountId = null;
  document.getElementById('deleteModal').style.display = 'none';
}

function confirmDelete() {
  if (deleteAccountId) {
    window.location.href = `/libros/eliminar_cuenta/${deleteAccountId}/`;
  }
}

// -------------------------------------
// CREAR CUENTA (modal)
// -------------------------------------
function openCreateAccountModal() {
  document.getElementById('createAccountModal').style.display = 'flex';
}

function closeCreateAccountModal() {
  document.getElementById('createAccountModal').style.display = 'none';
}

// Validación del formulario de creación 
function validarCrearFormulario() {
  const nombres = document.getElementById('nombres').value;
  const apellidos = document.getElementById('apellidos').value;
  const email = document.getElementById('email').value;
  const phone = document.getElementById('phone').value;
  const password = document.getElementById('password').value;
  const confirmPassword = document.getElementById('confirm_password').value;
  const terminos = document.getElementById('terminos').checked;
  
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const nameRegex = /^[A-Za-zÀ-ÿ\s]+$/;
  const phoneRegex = /^\d{0,10}$/;
  
  if (!nameRegex.test(nombres)) {
      showFloatingAlert("El campo de Nombres solo debe contener letras.");
      return false;
  }
  
  if (!nameRegex.test(apellidos)) {
      showFloatingAlert("El campo de Apellidos solo debe contener letras.");
      return false;
  }
  
  if (!emailRegex.test(email)) {
      showFloatingAlert("Ingrese un correo válido.");
      return false;
  }
  
  if (phone && !phoneRegex.test(phone)) {
      showFloatingAlert("El Teléfono debe contener solo números y máximo 10 dígitos.");
      return false;
  }
  
  if (password.length < 6) {
      showFloatingAlert("La contraseña debe tener al menos 6 caracteres.");
      return false;
  }
  
  if (password !== confirmPassword) {
      showFloatingAlert("Las contraseñas no coinciden.");
      return false;
  }
  
  if (!terminos) {
      showFloatingAlert("Debe aceptar los Términos y Condiciones.");
      return false;
  }
  
  return true;
}

// Asignar el handler al formulario de creación (añade id="createForm" en tu registro_form.html)
document.getElementById('createForm').onsubmit = validarCrearFormulario;

// -------------------------------------
// EDITAR CUENTA (modal)
// -------------------------------------
function openEditModal(id, email, phone, question, answer, recovery_email) {
  const modal = document.getElementById('editModal');
  modal.style.display = 'flex';

  const form = document.getElementById('editForm');
  //estas lineas son para que el formulario sepa a que cuenta pertenece
  form.action = "/libros/editar_cuenta/" + id + "/";

  
  document.getElementById('email').value = email;
  document.getElementById('phone').value = phone;
  document.getElementById('security_question').value = question;
  document.getElementById('security_answer').value = answer;
  document.getElementById('recovery_email').value = recovery_email;
  document.getElementById('password').value = '';
  document.getElementById('confirm_password').value = '';
}

function closeEditModal() {
  document.getElementById('editModal').style.display = 'none';
}

window.addEventListener('click', function(e) {
  const modal = document.getElementById('editModal');
  if (e.target === modal) closeEditModal();
});

// Validación del formulario de edición (originsal)
function validarEditarFormulario() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm_password').value;
    
    if (password) {
        // La contraseña debe tener mínimo 8 caracteres, 1 letra mayúscula y 1 carácter especial (@!|./&)
        const regex = /^(?=.*[A-Z])(?=.*[@!|./&]).{8,}$/;
        if (!regex.test(password)) {
            showFloatingAlert("La contraseña debe tener mínimo 8 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).");
            return false;
        }
        
        if (password !== confirmPassword) {
            showFloatingAlert("Las contraseñas no coinciden");
            return false;
        }
    }
    return true;
}

// Asignar el handler al formulario de edición
document.getElementById('editForm').onsubmit = validarEditarFormulario;




// --------------------------------------------
// Función genérica para cerrar cualquier modal
// --------------------------------------------
function cerrarModal(id) {
  const modal = document.getElementById(id);
  if (modal) {
    modal.style.display = 'none';
  }

  // También puedes llamar a tus funciones específicas si quieres
  if (id === 'editModal') closeEditModal();
  else if (id === 'deleteModal') closeDeleteModal();
  else if (id === 'createAccountModal') closeCreateAccountModal();
}

