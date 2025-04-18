function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}
const csrftoken = getCookie('csrftoken');

document.addEventListener("DOMContentLoaded", function(){
  const searchInput = document.getElementById("search-input");
  const woodFilter = document.getElementById("wood-filter");
  const productosContainer = document.getElementById("productos-container");
  
  // Función que ejecuta la búsqueda combinando el texto y el filtro por tipo de madera
  function performSearch() {
      const query = searchInput.value;
      const wood = woodFilter.value;
      const url = "/busqueda_ajax/?query=" + encodeURIComponent(query) + "&wood_filter=" + encodeURIComponent(wood);
      fetch(url)
        .then(response => response.json())
        .then(data => {
          productosContainer.innerHTML = data.html;
        })
        .catch(error => console.log('Error en la búsqueda AJAX:', error));
  }
  
  // Se llama a la búsqueda al escribir en el input y al cambiar la selección del filtro
  searchInput.addEventListener("input", performSearch);
  woodFilter.addEventListener("change", performSearch);

});
// Función para cambiar el estado de un producto (publicar/quitar publicidad)
function cambiarEstado(productoId, accion, btn) {
  let url = '';
  if (accion === 'publicar') {
    url = `/libros/publicar_producto/${productoId}/`;
  } else if (accion === 'quitar') {
    url = `/libros/quitar_publicidad/${productoId}/`;
  }
  
  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRFToken': csrftoken
    },
    body: JSON.stringify({})
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      if (accion === 'publicar') {
        btn.innerText = 'No Publicar';
        btn.classList.remove('btn-info');
        btn.classList.add('btn-secondary');
        btn.setAttribute('onclick', `cambiarEstado(${productoId}, 'quitar', this)`);
      } else {
        btn.innerText = 'Publicar';
        btn.classList.remove('btn-secondary');
        btn.classList.add('btn-info');
        btn.setAttribute('onclick', `cambiarEstado(${productoId}, 'publicar', this)`);
      }
    } else {
      console.error('Error al cambiar el estado');
    }
  })
  .catch(error => console.error('Error en la petición AJAX:', error));
}

function abrirModal(id) {
  document.getElementById(id).classList.remove('hidden');
}

function cerrarModal(id) {
  document.getElementById(id).classList.add('hidden');
}

// Modal de Editar
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("btn-editar")) {
    const productoId = e.target.dataset.productoId;
    fetch(`/libros/editar_producto/${productoId}/`) // Usa tu URL real
      .then(response => response.text())
      .then(html => {
        document.getElementById("editar-form-container").innerHTML = html;
        abrirModal("modal-editar");
      });
  }
});

// Modal de Eliminar
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("btn-eliminar")) {
    const productoId = e.target.dataset.productoId;
    const productoNombre = e.target.dataset.productoNombre;
    const eliminarUrl = e.target.dataset.eliminarUrl;

    document.getElementById("producto-nombre").textContent = productoNombre;
    document.getElementById("form-eliminar").action = eliminarUrl;
    abrirModal("modal-eliminar");
  }
});


// ────────────────────────────────────────────────────────────────
// Código nuevo: sincronizar file input y “clear checkbox”
// ────────────────────────────────────────────────────────────────
document.addEventListener("DOMContentLoaded", function () {
  const editarContainer = document.getElementById("editar-form-container");

  const observer = new MutationObserver(function () {
    const fileInput   = editarContainer.querySelector('input[type="file"]');
    const clearCheckbox = editarContainer.querySelector('input[type="checkbox"]');

    if (fileInput && clearCheckbox) {
      // Si el usuario selecciona un archivo, desmarca clear
      fileInput.addEventListener('change', function () {
        if (this.files.length > 0) {
          clearCheckbox.checked = false;
        }
      });
      // Si marca clear, limpia el file input
      clearCheckbox.addEventListener('change', function () {
        if (this.checked) {
          fileInput.value = '';
        }
      });
    }
  });

  observer.observe(editarContainer, { childList: true, subtree: true });
});

// ────────────────────────────────────────────────────────────────
// bloquear reenvíos del formulario de subir archivos para evitar duplicados
// ────────────────────────────────────────────────────────────────

document.addEventListener("DOMContentLoaded", function(){
  const formSubir = document.querySelector('#modal-subir form');
  if (!formSubir) return;

  let enviado = false;
  formSubir.addEventListener('submit', function(e){
    if (enviado) {
      // Ya se estaba enviando: bloqueamos reenvíos
      e.preventDefault();
      return;
    }
    enviado = true;
    const btn = formSubir.querySelector('button[type="submit"]');
    if (btn) {
      btn.disabled = true;
      btn.innerText = 'Subiendo…';
    }
  });
});

// ────────────────────────────────────────────────────────────────
// Cerrar modales al hacer clic fuera del contenido (.modal-content)
// ────────────────────────────────────────────────────────────────
document.querySelectorAll('.modal').forEach(modal => {
  modal.addEventListener('click', function(e) {
    // Si clicaste directamente sobre el fondo del modal (no en .modal-content)
    if (e.target === modal) {
      cerrarModal(modal.id);
    }
  });
});