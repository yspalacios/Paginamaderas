// Variable global para almacenar el id de la carpeta en edición
let currentFolderId = null;
  
// Función para obtener el token CSRF (seguridad en Django)
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

// Actualizar el estado de una carpeta
function updateFolderStatus(folderId, newStatus) {
  fetch(`/update-status/${folderId}/`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-CSRFToken': getCookie('csrftoken')
    },
    body: `status=${encodeURIComponent(newStatus)}`
  })
  .then(response => response.json())
  .then(data => {
    if (data.message === 'Estado actualizado exitosamente') {
      const folderDiv = document.querySelector(`.folder[data-id="${folderId}"]`);
      if (folderDiv) {
        const statusText = folderDiv.querySelector('.folder-status');
        if (statusText) {
          statusText.textContent = `Estado: ${newStatus}`;
        }
      }
      renderFolders();
    } else {
      alert(data.message);
    }
  })
  .catch(error => console.error('Error al actualizar estado:', error));
}

// Subir documentos a una carpeta
function uploadDocuments(folderId) {
  const input = document.getElementById(`uploadInput-${folderId}`);
  if (input.files.length === 0) {
    alert("Seleccione al menos un documento para subir.");
    return;
  }
  const formData = new FormData();
  for (let i = 0; i < input.files.length; i++) {
    formData.append('documents', input.files[i]);
  }
  fetch(`/upload-documents/${folderId}/`, {
    method: 'POST',
    headers: {
      'X-CSRFToken': getCookie('csrftoken')
    },
    body: formData
  })
  .then(response => response.json())
  .then(data => {
    if (data.message === 'Documentos subidos exitosamente') {
      alert("Documentos subidos exitosamente");
      renderFolders();
    } else {
      alert(data.message);
    }
  })
  .catch(error => console.error('Error al subir documentos:', error));
}

// Crear carpeta
document.getElementById('createFolderBtn').addEventListener('click', () => {
  const folderName = document.getElementById('folderName').value.trim();
  if (folderName === "") {
    alert("Por favor, ingrese un nombre para la carpeta.");
    return;
  }
  fetch('/create-folder/', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-CSRFToken': getCookie('csrftoken')
    },
    body: `folderName=${encodeURIComponent(folderName)}`
  })
  .then(response => response.json())
  .then(data => {
    if (data.message === 'Carpeta creada exitosamente') {
      renderFolders();
    } else {
      alert(data.message);
    }
  })
  .catch(error => console.error('Error:', error));
});

// Renderizar las carpetas y sus documentos
function renderFolders() {
  fetch('/get-folders/')
  .then(response => response.json())
  .then(folders => {
    const container = document.getElementById('foldersContainer');
    container.innerHTML = "";
    folders.forEach(folder => {
      // Contenedor principal de la carpeta
      const folderDiv = document.createElement('div');
      folderDiv.classList.add('folder');
      folderDiv.setAttribute('data-id', folder.id);

      // Encabezado de la carpeta
      const headerDiv = document.createElement('div');
      headerDiv.classList.add('folder-header');
      // Flecha para expandir/colapsar
      const toggleArrow = document.createElement('span');
      toggleArrow.classList.add('folder-toggle');
      toggleArrow.innerHTML = '▶'; // Flecha a la derecha (cerrado)
      toggleArrow.addEventListener('click', () => toggleFolder(folderDiv));
      
      const title = document.createElement('div');
      title.classList.add('folder-title');
      title.textContent = folder.name;
      // También permitimos hacer clic en el título para expandir/colapsar
      title.addEventListener('click', () => toggleFolder(folderDiv));

      // Botón para editar prestaciones
      const editBenefitsBtn = document.createElement('button');
      editBenefitsBtn.textContent = "Editar Prestaciones";
      editBenefitsBtn.classList.add('btn');
      editBenefitsBtn.addEventListener('click', (e) => {
        e.stopPropagation(); 
        currentFolderId = folder.id;
        document.getElementById('fecha_inicio').value = folder.fecha_inicio || "";
        document.getElementById('puesto_designado').value = folder.puesto_designado || "";
        document.getElementById('salario_actual').value = folder.salario_actual || "";
        document.getElementById('horas_trabajo').value = folder.horas_trabajo || "";
        document.getElementById('tiempo_contrato').value = folder.tiempo_contrato || "";
        document.getElementById('numero_identidad').value = folder.numero_identidad || "";
        document.getElementById('numero_seguro_social').value = folder.numero_seguro_social || "";
        document.getElementById('eps').value = folder.eps || "";
        document.getElementById('fondo_pensiones').value = folder.fondo_pensiones || "";
        document.getElementById('arl').value = folder.arl || "";
        openEditModal();
      });

      // Botón para mostrar prestaciones guardadas
      const showBenefitsBtn = document.createElement('button');
      showBenefitsBtn.textContent = "Mostrar Prestaciones";
      showBenefitsBtn.classList.add('btn');
      showBenefitsBtn.addEventListener('click', (e) => {
        e.stopPropagation(); // Evitar que se propague al título/header
        openShowModal(folder);
      });

      // Botón de opciones (cambiar estado y eliminar carpeta)
      const optionsBtn = document.createElement('button');
      optionsBtn.innerHTML = "⚙️";
      optionsBtn.classList.add('btn');
      optionsBtn.addEventListener("click", (event) => {
        event.stopPropagation(); // Evitar que se propague al título/header
        toggleOptions(event, folder.id);
      });

      headerDiv.appendChild(toggleArrow);
      headerDiv.appendChild(title);
      headerDiv.appendChild(editBenefitsBtn);
      headerDiv.appendChild(showBenefitsBtn);
      headerDiv.appendChild(optionsBtn);
      folderDiv.appendChild(headerDiv);

      // Menú de opciones para estado y eliminar carpeta
      const optionsMenu = document.createElement("div");
      optionsMenu.classList.add("options-menu");
      const statusLabel = document.createElement("label");
      statusLabel.textContent = "Estado:";
      const statusSelect = document.createElement("select");
      const statuses = ["Contratado", "No contratado", "Incapacitado", "En revisión", "No admitido", "Despedido"];
      statuses.forEach(status => {
        const option = document.createElement("option");
        option.value = status;
        option.textContent = status;
        if (folder.status === status) { 
          option.selected = true; 
        }
        statusSelect.appendChild(option);
      });
      statusSelect.addEventListener("change", () => {
        updateFolderStatus(folder.id, statusSelect.value);
      });
      optionsMenu.appendChild(statusLabel);
      optionsMenu.appendChild(statusSelect);

      const deleteBtn = document.createElement("button");
      deleteBtn.textContent = "Eliminar Carpeta";
      deleteBtn.classList.add("btn");
      deleteBtn.style.background = "red";
      deleteBtn.style.color = "white";
      deleteBtn.style.marginTop = "10px";
      deleteBtn.addEventListener("click", () => confirmDelete(folder.id));
      optionsMenu.appendChild(deleteBtn);

      folderDiv.appendChild(optionsMenu);

      // Mostrar estado actual
      const statusText = document.createElement('p');
      statusText.classList.add('folder-status');
      statusText.textContent = `Estado: ${folder.status || "No definido"}`;
      folderDiv.appendChild(statusText);

      // Contenedor para el contenido desplegable (todo lo que no es el header)
      const contentDiv = document.createElement('div');
      contentDiv.classList.add('folder-content');
      // Por defecto, contenido oculto
      contentDiv.style.display = 'none';

      // Sección para documentos
      const documentsDiv = document.createElement('div');
      documentsDiv.classList.add('documents');
      if (folder.documents && folder.documents.length > 0) {
        const docsTitle = document.createElement('p');
        docsTitle.textContent = "Documentos:";
        documentsDiv.appendChild(docsTitle);

        // Iteramos cada documento
        folder.documents.forEach(doc => {
          // Contenedor para el documento
          const docContainer = document.createElement('div');
          docContainer.classList.add('doc-container');
          
          // Contenedor para el nombre (a la izquierda)
          const nameDiv = document.createElement('div');
          nameDiv.classList.add('doc-name');
          const docLink = document.createElement('a');
          docLink.href = doc.url;     // Enlace de descarga
          docLink.textContent = doc.name;
          docLink.setAttribute('download', '');
          nameDiv.appendChild(docLink);
          
          // Contenedor para los botones (a la derecha)
          const buttonsDiv = document.createElement('div');
          buttonsDiv.classList.add('doc-buttons');
          
          // Botón para ver archivo en el modal
          const viewFileBtn = document.createElement('button');
          viewFileBtn.innerHTML = "👁️";
          viewFileBtn.title = "Ver Archivo";
          viewFileBtn.classList.add('icon-btn', 'view-btn');
          viewFileBtn.addEventListener('click', () => {
            console.log("Botón Ver Archivo presionado, URL:", doc.url);
            openFileModal(doc.url);
          });
          
          const separator = document.createElement('span');
          separator.classList.add('separator');
          separator.textContent = " | ";
          
          // Botón para eliminar documento (equis)
          const deleteDocBtn = document.createElement('button');
          deleteDocBtn.innerHTML = "❌";
          deleteDocBtn.title = "Eliminar Documento";
          deleteDocBtn.classList.add('icon-btn', 'delete-btn');
          deleteDocBtn.addEventListener('click', () => deleteDocument(doc.id));
          
          buttonsDiv.appendChild(viewFileBtn);
          buttonsDiv.appendChild(deleteDocBtn);
          
          // Agregar contenedores al docContainer
          docContainer.appendChild(nameDiv);
          docContainer.appendChild(buttonsDiv);
          
          documentsDiv.appendChild(docContainer);
        });
      }

      // Input para subir nuevos documentos
      const fileInput = document.createElement('input');
      fileInput.type = "file";
      fileInput.multiple = true;
      // Para limitar a PDF, descomenta la siguiente línea:
      // fileInput.accept = "application/pdf";
      fileInput.id = `uploadInput-${folder.id}`;
      const uploadBtn = document.createElement('button');
      uploadBtn.textContent = "Subir Documentos";
      uploadBtn.classList.add('btn');
      uploadBtn.addEventListener('click', () => uploadDocuments(folder.id));
      documentsDiv.appendChild(fileInput);
      documentsDiv.appendChild(uploadBtn);

      // Agregar documentos al contenido desplegable
      contentDiv.appendChild(documentsDiv);
      
      // Añadir el contenido desplegable a la carpeta
      folderDiv.appendChild(contentDiv);

      container.appendChild(folderDiv);
    });

    // Cada vez que renderizamos, volvemos a aplicar el filtro de búsqueda
    filterFolders();
  })
  .catch(error => console.error('Error:', error));
}

// Nueva función para alternar el despliegue de una carpeta
function toggleFolder(folderDiv) {
  const content = folderDiv.querySelector('.folder-content');
  const arrow = folderDiv.querySelector('.folder-toggle');
  
  if (content.style.display === 'none' || !content.style.display) {
    // Expandir carpeta
    content.style.display = 'block';
    arrow.innerHTML = '▼'; // Flecha abajo (abierto)
    folderDiv.classList.add('expanded');
  } else {
    // Colapsar carpeta
    content.style.display = 'none';
    arrow.innerHTML = '▶'; // Flecha a la derecha (cerrado)
    folderDiv.classList.remove('expanded');
  }
}

// Filtrar carpetas según búsqueda (por título y estado)
document.getElementById('searchInput').addEventListener('keyup', filterFolders);
function filterFolders() {
  const searchValue = document.getElementById('searchInput').value.toLowerCase();
  const folderDivs = document.querySelectorAll('.folder');
  folderDivs.forEach(div => {
    const title = div.querySelector('.folder-title').textContent.toLowerCase();
    let status = div.querySelector('.folder-status').textContent.toLowerCase();
    // Si empieza con "estado:", removemos esa parte para comparar sólo el valor
    if (status.startsWith('estado:')) {
      status = status.substring(7).trim();
    }
    // Se muestra la carpeta si el título o el estado incluyen el valor buscado
    div.style.display = (title.includes(searchValue) || status.includes(searchValue)) ? "" : "none";
  });
}

// Abrir modal de edición
function openEditModal() {
  const modal = document.getElementById('modal-editar');
  console.log("Modal de edición encontrado:", !!modal);
  if (modal) {
    modal.style.display = 'block';
    console.log("Modal de edición mostrado");
  } else {
    console.error("No se encontró el elemento con id 'modal-editar'");
  }
}

function openShowModal(folder) {
  // Tu código actual...
  const modal = document.getElementById('modal-mostrar');
  console.log("Modal para mostrar prestaciones encontrado:", !!modal);
  if (modal) {
    modal.style.display = 'block';
    console.log("Modal para mostrar prestaciones mostrado");
  } else {
    console.error("No se encontró el elemento con id 'modal-mostrar'");
  }
}

// Guardar prestaciones
document.getElementById('saveBenefitsBtn').addEventListener('click', () => {
  const data = {
    fecha_inicio: document.getElementById('fecha_inicio').value,
    puesto_designado: document.getElementById('puesto_designado').value,
    salario_actual: document.getElementById('salario_actual').value,
    horas_trabajo: document.getElementById('horas_trabajo').value,
    tiempo_contrato: document.getElementById('tiempo_contrato').value,
    numero_identidad: document.getElementById('numero_identidad').value,
    numero_seguro_social: document.getElementById('numero_seguro_social').value,
    eps: document.getElementById('eps').value,
    fondo_pensiones: document.getElementById('fondo_pensiones').value,
    arl: document.getElementById('arl').value
  };
  const formBody = Object.keys(data)
    .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(data[key]))
    .join('&');
  fetch(`/update-benefits/${currentFolderId}/`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-CSRFToken': getCookie('csrftoken')
    },
    body: formBody
  })
  .then(response => response.json())
  .then(resp => {
    if (resp.message === 'Prestaciones de servicio actualizadas exitosamente') {
      alert('Prestaciones guardadas correctamente');
      document.getElementById('modal-editar').style.display = 'none';
      renderFolders();
    } else {
      alert(resp.message);
    }
  })
  .catch(error => console.error('Error:', error));
});

// Abrir modal para mostrar prestaciones
function openShowModal(folder) {
  const labels = [
    "Fecha de inicio", "Puesto designado", "Salario actual", "Horas de trabajo",
    "Tiempo de contrato", "Número de identidad", "Número de seguro social",
    "EPS", "Fondo de pensiones (AFP)", "ARL"
  ];
  let content = "";
  content += `<div class="benefit-row"><span class="benefit-label">${labels[0]}:</span><span class="benefit-value">${folder.fecha_inicio || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[1]}:</span><span class="benefit-value">${folder.puesto_designado || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[2]}:</span><span class="benefit-value">${folder.salario_actual || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[3]}:</span><span class="benefit-value">${folder.horas_trabajo || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[4]}:</span><span class="benefit-value">${folder.tiempo_contrato || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[5]}:</span><span class="benefit-value">${folder.numero_identidad || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[6]}:</span><span class="benefit-value">${folder.numero_seguro_social || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[7]}:</span><span class="benefit-value">${folder.eps || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[8]}:</span><span class="benefit-value">${folder.fondo_pensiones || "--"}</span></div>`;
  content += `<div class="benefit-row"><span class="benefit-label">${labels[9]}:</span><span class="benefit-value">${folder.arl || "--"}</span></div>`;
  document.getElementById('benefitsDisplayContent').innerHTML = content;
  document.getElementById('modal-mostrar').style.display = 'block';
}
document.getElementById('closeShowBenefitsBtn').addEventListener('click', () => {
  document.getElementById('modal-mostrar').style.display = 'none';
});

// Función que abre el modal para ver un archivo (PDF, imagen, etc.)
function openFileModal(fileUrl) {
  console.log("Abriendo archivo en URL:", fileUrl);
  const iframe = document.getElementById('fileIframe');
  if (iframe) {
    iframe.src = fileUrl;
  } else {
    console.error("No se encontró el elemento con id 'fileIframe'");
  }
  const modal = document.getElementById('modal-ver');
  if (modal) {
    modal.style.display = 'block';
    console.log("Modal mostrado");
  } else {
    console.error("No se encontró el elemento con id 'modal-ver'");
  }
}

// Cerrar el modal de visualización de archivo
document.getElementById('closeFileModalBtn').addEventListener('click', () => {
  document.getElementById('modal-ver').style.display = 'none';
  document.getElementById('fileIframe').src = "";
});

// Mostrar/ocultar menú de opciones (estado, eliminar)
function toggleOptions(event, folderId) {
  const folderDiv = event.target.closest('.folder');
  const menu = folderDiv.querySelector('.options-menu');
  if (menu) {
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
  }
  event.stopPropagation();
}

// Eliminar documento
function deleteDocument(docId) {
  if (confirm('¿Está seguro de que desea eliminar este documento?')) {
    fetch(`/delete-document/${docId}/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRFToken': getCookie('csrftoken')
      },
      body: `docId=${docId}`
    })
    .then(response => response.json())
    .then(data => {
      if (data.message === 'Documento eliminado exitosamente') {
        renderFolders();
      } else {
        alert(data.message);
      }
    })
    .catch(error => console.error('Error al eliminar documento:', error));
  }
}

// Eliminar carpeta
function confirmDelete(folderId) {
  if (confirm('¿Está seguro de que desea eliminar esta carpeta?')) {
    fetch(`/delete-folder/${folderId}/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRFToken': getCookie('csrftoken')
      },
      body: `folderId=${folderId}`
    })
    .then(response => response.json())
    .then(data => {
      if (data.message === 'Carpeta eliminada exitosamente') {
        renderFolders();
      } else {
        alert(data.message);
      }
    })
    .catch(error => console.error('Error al eliminar carpeta:', error));
  }
}

// Inicializar renderizado de carpetas
renderFolders();