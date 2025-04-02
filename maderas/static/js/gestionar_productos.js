function getCookie(name) {  // Función para obtener el valor de una cookie dado su nombre
    let cookieValue = null;  // Inicializa la variable que almacenará el valor de la cookie
    if (document.cookie && document.cookie !== '') {  // Verifica si existen cookies en el documento
      const cookies = document.cookie.split(';');  // Divide las cookies en un arreglo utilizando ";" como separador
      for (let i = 0; i < cookies.length; i++) {  // Itera sobre cada cookie en el arreglo
        const cookie = cookies[i].trim();  // Elimina espacios en blanco de la cookie actual
        if (cookie.substring(0, name.length + 1) === (name + '=')) {  // Comprueba si la cookie comienza con el nombre buscado seguido de "="
          cookieValue = decodeURIComponent(cookie.substring(name.length + 1));  // Decodifica y obtiene el valor de la cookie
          break;  // Sale del ciclo una vez encontrada la cookie
        }
      }
    }
    return cookieValue;  // Retorna el valor de la cookie o null si no se encontró
  }
  const csrftoken = getCookie('csrftoken');  // Almacena en "csrftoken" el valor de la cookie CSRF
  
  document.addEventListener("DOMContentLoaded", function(){  // Espera a que el contenido del documento se cargue completamente
    const searchInput = document.getElementById("search-input");  // Obtiene el elemento input de búsqueda por su ID
    const productosContainer = document.getElementById("productos-container");  // Obtiene el contenedor de productos por su ID
    
    searchInput.addEventListener("input", function(){  // Agrega un evento que se ejecuta cuando se detecta entrada en el input
      const query = searchInput.value;  // Guarda el valor actual del input en la variable "query"
      fetch("/busqueda_ajax/?query=" + encodeURIComponent(query))  // Realiza una petición AJAX a la URL de búsqueda, codificando el query
        .then(response => response.json())  // Convierte la respuesta a formato JSON
        .then(data => {  // Procesa los datos recibidos de la petición
           productosContainer.innerHTML = data.html;  // Actualiza el contenido HTML del contenedor de productos con el resultado
        })
        .catch(error => console.log('Error en la búsqueda AJAX:', error));  // Muestra un error en la consola en caso de fallo en la petición
    });
  });
  
  function cambiarEstado(productoId, accion, btn) {  // Función para cambiar el estado de un producto (publicar o quitar publicidad)
    let url = '';  // Inicializa la variable que contendrá la URL para la petición
    if (accion === 'publicar') {  // Si la acción es "publicar"
      url = `/libros/publicar_producto/${productoId}/`;  // Asigna la URL para publicar el producto
    } else if (accion === 'quitar') {  // Si la acción es "quitar"
      url = `/libros/quitar_publicidad/${productoId}/`;  // Asigna la URL para quitar la publicidad del producto
    }
    
    fetch(url, {  // Realiza una petición fetch a la URL especificada
      method: 'POST',  // Define el método HTTP POST para la petición
      headers: {  // Define los encabezados para la petición
        'Content-Type': 'application/json',  // Indica que el contenido se envía en formato JSON
        'X-CSRFToken': csrftoken  // Incluye el token CSRF para seguridad en la petición
      },
      body: JSON.stringify({})  // Envía un cuerpo de petición vacío en formato JSON
    })
    .then(response => response.json())  // Convierte la respuesta a formato JSON
    .then(data => {  // Procesa los datos recibidos de la petición
      if (data.success) {  // Si la respuesta indica éxito
        if (accion === 'publicar') {  // Si la acción era "publicar"
          btn.innerText = 'No Publicar';  // Cambia el texto del botón a "No Publicar"
          btn.classList.remove('btn-info');  // Remueve la clase "btn-info" del botón
          btn.classList.add('btn-secondary');  // Agrega la clase "btn-secondary" al botón
          btn.setAttribute('onclick', `cambiarEstado(${productoId}, 'quitar', this)`);  // Actualiza el atributo onclick para que la acción sea "quitar" al hacer clic
        } else {  // Si la acción era "quitar"
          btn.innerText = 'Publicar';  // Cambia el texto del botón a "Publicar"
          btn.classList.remove('btn-secondary');  // Remueve la clase "btn-secondary" del botón
          btn.classList.add('btn-info');  // Agrega la clase "btn-info" al botón
          btn.setAttribute('onclick', `cambiarEstado(${productoId}, 'publicar', this)`);  // Actualiza el atributo onclick para que la acción sea "publicar" al hacer clic
        }
      } else {  // Si no fue exitoso el cambio de estado
        console.error('Error al cambiar el estado');  // Muestra un mensaje de error en la consola
      }
    })
    .catch(error => console.error('Error en la petición AJAX:', error));  // Captura y muestra cualquier error durante la petición AJAX
  }