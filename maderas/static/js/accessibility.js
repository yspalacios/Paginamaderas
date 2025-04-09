class AccessibilityWidget {
    constructor() {
      this.isPanelOpen = false;
      this.currentFontSize = 100; // tamaño de fuente inicial en %
      this.readingGuideActive = false;
      this.mouseMoveHandler = null;
      this.initStyles();
      this.createButton();
      this.createPanel();
    }
  
    // Inyecta estilos CSS para el widget y sus funcionalidades
    initStyles() {
      const style = document.createElement('style');
      
      document.head.appendChild(style);
    }
  
    createButton() {
      this.button = document.createElement('button');
      this.button.classList.add('acc-widget-button');
      this.button.innerHTML = '<img src="static/diseños/imagenes/11212.png" alt="Accesibilidad" style="width: 40px; height: 40px;">';
      this.button.addEventListener('click', () => this.togglePanel());
      // Inserta el botón fuera del body para evitar que se vea afectado por filtros
      document.body.parentNode.insertBefore(this.button, document.body);
      this.makeButtonDraggable();
    }
  
    // Hace el botón arrastrable
    makeButtonDraggable() {
      let offsetX = 0;
      let offsetY = 0;
      let isDragging = false;
  
      this.button.addEventListener('mousedown', (e) => {
        isDragging = true;
        offsetX = e.clientX - this.button.getBoundingClientRect().left;
        offsetY = e.clientY - this.button.getBoundingClientRect().top;
      });
  
      document.addEventListener('mousemove', (e) => {
        if (isDragging) {
          const x = e.clientX - offsetX;
          const y = e.clientY - offsetY;
          this.button.style.left = `${x}px`;
          this.button.style.top = `${y}px`;
          this.button.style.bottom = 'auto';
          this.button.style.right = 'auto';
        }
      });
  
      document.addEventListener('mouseup', () => {
        isDragging = false;
      });
    }
  
    createPanel() {
      this.panel = document.createElement('div');
      this.panel.classList.add('acc-widget-panel');
  
      // Encabezado del panel
      const header = document.createElement('div');
      header.classList.add('acc-widget-header');
      const title = document.createElement('h3');
      title.textContent = 'Menú de accesibilidad';
      const closeBtn = document.createElement('button');
      closeBtn.classList.add('acc-widget-close');
      closeBtn.innerHTML = '✕';
      closeBtn.addEventListener('click', () => this.togglePanel());
      header.appendChild(title);
      header.appendChild(closeBtn);
  
      // Sección: Ajustes de contenido
      const contentSection = document.createElement('div');
      contentSection.classList.add('acc-widget-section');
      const contentTitle = document.createElement('h4');
      contentTitle.textContent = 'Ajustes de contenido';
  
      // Controles para cambiar el tamaño de fuente
      const fontSizeLabel = document.createElement('label');
      fontSizeLabel.textContent = 'Ajustar tamaño de fuente';
      const fontSizeControls = document.createElement('div');
      fontSizeControls.classList.add('acc-font-size-controls');
      const decreaseFontBtn = document.createElement('button');
      decreaseFontBtn.textContent = '-';
      decreaseFontBtn.addEventListener('click', () => this.changeFontSize(-10));
      this.fontSizeValue = document.createElement('span');
      this.fontSizeValue.classList.add('acc-font-size-value');
      this.fontSizeValue.textContent = `${this.currentFontSize}%`;
      const increaseFontBtn = document.createElement('button');
      increaseFontBtn.textContent = '+';
      increaseFontBtn.addEventListener('click', () => this.changeFontSize(10));
  
      fontSizeControls.appendChild(decreaseFontBtn);
      fontSizeControls.appendChild(this.fontSizeValue);
      fontSizeControls.appendChild(increaseFontBtn);
  
      // Opciones de ajustes de contenido en cuadrícula
      const contentGrid = document.createElement('div');
      contentGrid.classList.add('acc-widget-grid');
      contentGrid.appendChild(this.createOption('Resaltar títulos', () => this.toggleHighlightTitle()));
      contentGrid.appendChild(this.createOption('Resaltar enlaces', () => this.toggleHighlightLinks()));
      contentGrid.appendChild(this.createOption('Fuente para dislexia', () => this.toggleDyslexiaFont()));
      contentGrid.appendChild(this.createOption('Espaciado de letras', () => this.toggleLetterSpacing()));
      contentGrid.appendChild(this.createOption('Interlineado', () => this.toggleLineHeight()));
      contentGrid.appendChild(this.createOption('Grosor de fuente', () => this.toggleFontWeight()));
  
      contentSection.appendChild(contentTitle);
      contentSection.appendChild(fontSizeLabel);
      contentSection.appendChild(fontSizeControls);
      contentSection.appendChild(contentGrid);
  
      // Sección: Ajustes de color
      const colorSection = document.createElement('div');
      colorSection.classList.add('acc-widget-section');
      const colorTitle = document.createElement('h4');
      colorTitle.textContent = 'Ajustes de color';
      const colorGrid = document.createElement('div');
      colorGrid.classList.add('acc-widget-grid');
      colorGrid.appendChild(this.createOption('Contraste oscuro', () => this.toggleDarkContrast()));
      colorGrid.appendChild(this.createOption('Contraste claro', () => this.toggleLightContrast()));
      colorGrid.appendChild(this.createOption('Alto contraste', () => this.toggleHighContrast()));
      colorGrid.appendChild(this.createOption('Alta saturación', () => this.toggleHighSaturation()));
      colorGrid.appendChild(this.createOption('Baja saturación', () => this.toggleLowSaturation()));
      colorGrid.appendChild(this.createOption('Monocromo', () => this.toggleMonochrome()));
      colorSection.appendChild(colorTitle);
      colorSection.appendChild(colorGrid);
  
      // Sección: Herramientas
      const toolsSection = document.createElement('div');
      toolsSection.classList.add('acc-widget-section');
      const toolsTitle = document.createElement('h4');
      toolsTitle.textContent = 'Herramientas';
      const toolsGrid = document.createElement('div');
      toolsGrid.classList.add('acc-widget-grid');
      toolsGrid.appendChild(this.createOption('Guía de lectura', () => this.toggleReadingGuide()));
      toolsGrid.appendChild(this.createOption('Detener animaciones', () => this.toggleStopAnimations()));
      toolsGrid.appendChild(this.createOption('Cursor grande', () => this.toggleBigCursor()));
      toolsSection.appendChild(toolsTitle);
      toolsSection.appendChild(toolsGrid);
  
      // Armamos el panel
      this.panel.appendChild(header);
      this.panel.appendChild(contentSection);
      this.panel.appendChild(colorSection);
      this.panel.appendChild(toolsSection);
  
      // Inserta el panel fuera del body para que no se vea afectado
      document.body.parentNode.insertBefore(this.panel, document.body);
    }
  
    // Método auxiliar para crear cada opción del menú
    createOption(label, onClick) {
      const option = document.createElement('div');
      option.classList.add('acc-widget-option');
      option.textContent = label;
      option.addEventListener('click', () => {
        onClick(); // Ejecuta la función original (no la modificamos)
        
        // Espera un poco para que los cambios en el body surtan efecto y actualiza visualmente
        setTimeout(() => {
          const classMap = {
            'Resaltar títulos': 'acc-highlight-titles',
            'Resaltar enlaces': 'acc-highlight-links',
            'Fuente para dislexia': 'acc-dyslexia-font',
            'Espaciado de letras': 'acc-letter-spacing',
            'Interlineado': 'acc-line-height',
            'Grosor de fuente': 'acc-font-weight',
            'Contraste oscuro': 'acc-dark-contrast',
            'Contraste claro': 'acc-light-contrast',
            'Alto contraste': 'acc-high-contrast',
            'Alta saturación': 'acc-high-saturation',
            'Baja saturación': 'acc-low-saturation',
            'Monocromo': 'acc-monochrome',
            'Detener animaciones': 'acc-stop-animations',
            'Cursor grande': 'big-cursor', // Esto se trata distinto, ver más abajo
            'Guía de lectura': 'acc-reading-guide', // Lo manejamos por nodo agregado
          };
    
          const className = classMap[label];
    
          // Control especial para el cursor
          if (label === 'Cursor grande') {
            const isActive = document.body.style.cursor.includes("big-cursor");
            option.classList.toggle('active', isActive);
          }
          // Control especial para la guía de lectura
          else if (label === 'Guía de lectura') {
            const guideExists = !!document.querySelector('.acc-reading-guide');
            option.classList.toggle('active', guideExists);
          }
          // Para los demás que son clases en el body
          else if (className) {
            const isActive = document.body.classList.contains(className);
            option.classList.toggle('active', isActive);
          }
        }, 50); // Un pequeño retardo para que se refleje el cambio
      });
    
      return option;
    }
  
    // Alterna la visibilidad del panel
    togglePanel() {
      this.isPanelOpen = !this.isPanelOpen;
      if (this.isPanelOpen) {
        this.panel.classList.add('open');
      } else {
        this.panel.classList.remove('open');
      }
    }
  
    // Cambia el tamaño de fuente del documento
    changeFontSize(delta) {
      this.currentFontSize += delta;
      if (this.currentFontSize < 50) this.currentFontSize = 50;
      if (this.currentFontSize > 200) this.currentFontSize = 200;
      this.fontSizeValue.textContent = `${this.currentFontSize}%`;
      document.documentElement.style.fontSize = this.currentFontSize + '%';
    }
  
    // Funciones de accesibilidad que alternan clases en el body
  
    toggleHighlightTitle() {
      document.body.classList.toggle('acc-highlight-titles');
    }
  
    toggleHighlightLinks() {
      document.body.classList.toggle('acc-highlight-links');
    }
  
    toggleDyslexiaFont() {
      document.body.classList.toggle('acc-dyslexia-font');
    }
  
    toggleLetterSpacing() {
      document.body.classList.toggle('acc-letter-spacing');
    }
  
    toggleLineHeight() {
      document.body.classList.toggle('acc-line-height');
    }
  
    toggleFontWeight() {
      document.body.classList.toggle('acc-font-weight');
    }
  
    toggleDarkContrast() {
      document.body.classList.toggle('acc-dark-contrast');
    }
  
    toggleLightContrast() {
      document.body.classList.toggle('acc-light-contrast');
    }
  
    toggleHighContrast() {
      document.body.classList.toggle('acc-high-contrast');
    }
  
    toggleHighSaturation() {
      document.body.classList.toggle('acc-high-saturation');
    }
  
    toggleLowSaturation() {
      document.body.classList.toggle('acc-low-saturation');
    }
  
    toggleMonochrome() {
      document.body.classList.toggle('acc-monochrome');
    }
  
    toggleStopAnimations() {
      document.body.classList.toggle('acc-stop-animations');
    }
  
    // Lógica para alternar el cursor grande
    toggleBigCursor() {
      // Si ya está activo un cursor personalizado, se revierte al cursor por defecto
      if (document.body.style.cursor.includes("big-cursor")) {
        document.body.style.cursor = "";
      } else {
        // Define la imagen y las coordenadas de "hotspot"
        document.body.style.cursor = 'url("static/diseños/imagenes/big-cursor.png") 16 16, auto';
      }
    }
  
    // La Guía de lectura: barra horizontal que sigue el cursor vertical
    toggleReadingGuide() {
      if (!this.readingGuideActive) {
        this.readingGuide = document.createElement('div');
        this.readingGuide.classList.add('acc-reading-guide');
        document.body.appendChild(this.readingGuide);
        this.mouseMoveHandler = (e) => {
          this.readingGuide.style.top = e.clientY + 'px';
        };
        document.addEventListener('mousemove', this.mouseMoveHandler);
        this.readingGuideActive = true;
      } else {
        document.removeEventListener('mousemove', this.mouseMoveHandler);
        if (this.readingGuide) {
          document.body.removeChild(this.readingGuide);
        }
        this.readingGuideActive = false;
      }
    }
  }
  
  // Inicializa el widget al cargar el DOM
  window.addEventListener('DOMContentLoaded', () => {
    new AccessibilityWidget();
  });
  