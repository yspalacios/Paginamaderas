# Usa una imagen oficial de Python como imagen base
FROM python:3.11-slim

# Establece variables de entorno para evitar que Python genere archivos .pyc y para que los logs salgan directamente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala dependencias del sistema
# AÑADIMOS pkg-config y libcairo2-dev para la compilación de PyCairo
RUN apt-get update && apt-get install -y default-libmysqlclient-dev gcc pkg-config libcairo2-dev

# Copia el archivo de requerimientos e instálalos
# Es importante separar este paso para aprovechar el caché de Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código de la aplicación al directorio de trabajo
COPY . .

# Expone el puerto 8000 para que el servidor de desarrollo de Django sea accesible
EXPOSE 8000

# Comando para ejecutar la aplicación (puedes cambiarlo por Gunicorn para producción)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]