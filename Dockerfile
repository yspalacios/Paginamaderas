# -----------------------------------------------------------------
# Dockerfile para una aplicación Django
# -----------------------------------------------------------------

# Etapa 1: Imagen Base
# Usamos una imagen oficial de Python. 'slim' es una versión ligera, ideal para desarrollo.
FROM python:3.11-slim

# Etapa 2: Variables de Entorno
# PYTHONDONTWRITEBYTECODE: Evita que Python cree archivos .pyc.
# PYTHONUNBUFFERED: Asegura que los logs se muestren en la consola de Docker en tiempo real.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Etapa 3: Instalar Dependencias del Sistema
# Actualizamos la lista de paquetes e instalamos las dependencias que necesitan
# algunas librerías de Python para compilarse.
# - default-libmysqlclient-dev: Para conectar con MySQL.
# - gcc: Compilador de C.
# - pkg-config & libcairo2-dev: Para librerías que generan gráficos o PDFs como PyCairo.
RUN apt-get update && apt-get install -y default-libmysqlclient-dev gcc pkg-config libcairo2-dev

# Etapa 4: Configurar el Directorio de Trabajo
# Creamos y nos movemos al directorio /app dentro del contenedor.
WORKDIR /app

# Etapa 5: Instalar Dependencias de Python
# Copiamos solo el archivo de requerimientos primero.
# Esto aprovecha el sistema de caché de Docker: si este archivo no cambia,
# Docker no volverá a ejecutar este paso, acelerando las reconstrucciones.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 6: Copiar el Código de la Aplicación
# Copiamos todo el código de nuestro proyecto al directorio de trabajo /app.
COPY . .

# Etapa 7: Exponer el Puerto
# Informamos a Docker que nuestra aplicación escuchará en el puerto 8000.
EXPOSE 8000

# Etapa 8: Comando de Ejecución
# El comando por defecto que se ejecutará al iniciar el contenedor.
# Inicia el servidor de desarrollo de Django, haciéndolo accesible desde cualquier IP (0.0.0.0).
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
