class AccessibilityWidget {
  constructor() {
    this.isPanelOpen = false;
    this.currentFontSize = 100;
    this.readingGuideActive = false;
    this.mouseMoveHandler = null;
    this.initStyles();
    this.createButton();
    this.createPanel();

    window.addEventListener('resize', () => {
      if (this.isPanelOpen) {
        this.positionPanel();
      }
    });
  }

  initStyles() {
    const style = document.createElement('style');
    document.head.appendChild(style);
  }

  createButton() {
    this.button = document.createElement('button');
    this.button.classList.add('acc-widget-button');
    this.button.innerHTML = '<img src="/static/diseños/imagenes/hacker.ico" alt="Accesibilidad" style="width: 40px; height: 40px;">';
    this.button.addEventListener('click', () => this.togglePanel());
    document.body.parentNode.insertBefore(this.button, document.body);
  }

  createPanel() {
    this.panel = document.createElement('div');
    this.panel.classList.add('acc-widget-panel');

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

    const contentSection = document.createElement('div');
    contentSection.classList.add('acc-widget-section');
    const contentTitle = document.createElement('h4');
    contentTitle.textContent = 'Ajustes de contenido';

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

    this.panel.appendChild(header);
    this.panel.appendChild(contentSection);
    this.panel.appendChild(colorSection);
    this.panel.appendChild(toolsSection);

    document.body.parentNode.insertBefore(this.panel, document.body);
  }

  togglePanel() {
    this.isPanelOpen = !this.isPanelOpen;
    if (this.isPanelOpen) {
      this.panel.classList.add('open');
      this.positionPanel();
    } else {
      this.panel.classList.remove('open');
    }
  }

  positionPanel() {
    const btnRect = this.button.getBoundingClientRect();
    const panelRect = this.panel.getBoundingClientRect();
    const panelHeight = this.panel.offsetHeight;
    const panelWidth = panelRect.width;
    const windowWidth = window.innerWidth;

    let left = btnRect.left;

    // Detectar si se saldría por el lado derecho
    if (btnRect.left + panelWidth > windowWidth) {
      left = windowWidth - panelWidth - 10; // 10px de margen
    }

    // Detectar si está muy a la izquierda
    if (left < 10) {
      left = 10;
    }

    this.panel.style.left = `${left}px`;
    this.panel.style.top = `${btnRect.top - panelHeight - 10}px`; // Justo arriba del botón
  }

  // ... el resto de tus métodos como createOption, changeFontSize, toggleX se mantienen igual ...


  createOption(label, onClick) {
    const option = document.createElement('div');
    option.classList.add('acc-widget-option');
    option.textContent = label;
    option.addEventListener('click', () => {
      onClick();
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
          'Cursor grande': 'big-cursor',
          'Guía de lectura': 'acc-reading-guide',
        };

        const className = classMap[label];

        if (label === 'Cursor grande') {
          const isActive = document.body.style.cursor.includes("big-cursor");
          option.classList.toggle('active', isActive);
        } else if (label === 'Guía de lectura') {
          const guideExists = !!document.querySelector('.acc-reading-guide');
          option.classList.toggle('active', guideExists);
        } else if (className) {
          const isActive = document.body.classList.contains(className);
          option.classList.toggle('active', isActive);
        }
      }, 50);
    });

    return option;
  }

  changeFontSize(delta) {
    this.currentFontSize += delta;
    if (this.currentFontSize < 50) this.currentFontSize = 50;
    if (this.currentFontSize > 200) this.currentFontSize = 200;
    this.fontSizeValue.textContent = `${this.currentFontSize}%`;
    document.documentElement.style.fontSize = this.currentFontSize + '%';
  }

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

  toggleBigCursor() {
    if (document.body.style.cursor.includes("big-cursor")) {
      document.body.style.cursor = "";
    } else {
      document.body.style.cursor = 'url("static/diseños/imagenes/big-cursor.png") 16 16, auto';
    }
  }

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

window.addEventListener('DOMContentLoaded', () => {
  new AccessibilityWidget();
});
