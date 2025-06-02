function showFloatingAlert(message) {
  var alertDiv = document.getElementById('floating-alert');
  alertDiv.textContent = message;
  alertDiv.style.display = 'block';
  setTimeout(function() {
    alertDiv.style.display = 'none';
  }, 3000);
}

function showConfirmModal() {
  var modal = document.getElementById('confirm-modal');
  modal.classList.remove('hidden');

  return new Promise(function(resolve) {
    document.getElementById('confirm-yes').onclick = function() {
      modal.classList.add('hidden');
      resolve(true);
    };
    document.getElementById('confirm-no').onclick = function() {
      modal.classList.add('hidden');
      resolve(false);
    };
  });
}

async function validatePasswordChange() {
  var newPassword = document.getElementById('new_password').value;
  var confirmPassword = document.getElementById('confirm_password').value;

  var regex = /^(?=.*[A-Z])(?=.*[@!|./&]).{8,}$/;

  if (!regex.test(newPassword)) {
    showFloatingAlert("La contraseña debe tener mínimo 8 caracteres, 1 letra mayúscula y un carácter especial (@!|./&).");
    return false;
  }

  if (newPassword !== confirmPassword) {
    showFloatingAlert("Las contraseñas no coinciden.");
    return false;
  }

  var confirmed = await showConfirmModal();
  return confirmed;
}

document.addEventListener('DOMContentLoaded', function() {
  var form = document.getElementById('cambia-con-form');
  if (form) {
    form.onsubmit = async function(e) {
      e.preventDefault();
      if (await validatePasswordChange()) {
        form.submit();
      }
    };
  }
});