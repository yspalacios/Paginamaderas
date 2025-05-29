document.getElementById("back-to-top").addEventListener("click", function(e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // Funcionalidad sencilla para el carrusel
  (function() {
    const carousel = document.getElementById('productosCarousel');
    const items = carousel.querySelectorAll('.carousel-item');
    let currentIndex = 0;

    const showItem = index => {
      items.forEach((item, i) => {
        item.style.display = i === index ? 'block' : 'none';
      });
    };

    carousel.querySelector('.prev').addEventListener('click', function() {
      currentIndex = (currentIndex === 0) ? items.length - 1 : currentIndex - 1;
      showItem(currentIndex);
    });

    carousel.querySelector('.next').addEventListener('click', function() {
      currentIndex = (currentIndex === items.length - 1) ? 0 : currentIndex + 1;
      showItem(currentIndex);
    });

    // Inicializa el carrusel
    showItem(currentIndex);
  })();

