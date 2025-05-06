// -------------------------------------
// ELIMINAR CUENTA
// -------------------------------------
let deleteAccountId = null;

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
            alert("La contraseña debe tener mínimo 8 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).");
            return false;
        }
        
        if (password !== confirmPassword) {
            alert("Las contraseñas no coinciden");
            return false;
        }
    }
    return true;
}

// Asignar el handler al formulario de edición
document.getElementById('editForm').onsubmit = validarEditarFormulario;


// --------------------------------------------
// Cierre automático de modales al hacer clic fuera del contenido
// --------------------------------------------
document.querySelectorAll('.modal').forEach(modal => {
  modal.addEventListener('click', function (e) {
    if (e.target === modal) {
      cerrarModal(modal.id);
    }
  });
});

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
