from django.urls import path
from . import views
from .views import  vista_archivos
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.inicio, name='inicio'),
    
    #===================================================================
    # Rutas para la gestión de productos
    #===================================================================
    path('libros/subir_imagen/', views.subir_imagen, name='subir_imagen'),
    path('libros/gestionar_productos/', views.gestionar_productos, name='gestionar_productos'),
    path('libros/editar_producto/<int:producto_id>/', views.editar_producto, name='editar_producto'),
    path('libros/eliminar/<int:producto_id>/', views.eliminar_producto, name='confirmar_eliminar'),
    path('libros/publicar_producto/<int:productoId>/', views.publicar_producto, name='publicar_producto'),
    path('libros/quitar_publicidad/<int:productoId>/', views.quitar_publicidad, name='quitar_publicidad'),
    path('productos/', views.inicio, name='inicio_publicados'),
    
    #===================================================================
    # Rutas para la gestión de usuarios
    #===================================================================
    path('libros/login/', views.login_view, name="login"),
    path('libros/index/', views.index_view, name="index"),
    path('libros/cambia_con/<str:token>/', views.cambia_con, name='cambia_con'),
    path('libros/recu_contra/', views.recu_contra, name="recu_contra"),
    path('libros/registro/', views.registro_login, name='registro_login'),
    path('logout/', views.logout_view, name='logout'),


    #===================================================================
    # Rutas para la gestión de cuentas
    #===================================================================
    path('libros/cuentas/', views.cuentas_list, name='lista_login'),
    path('libros/editar_cuenta/<int:cuenta_id>/', views.editar_cuenta, name='editar_cuenta'),
    path('libros/activar_cuenta/<int:cuenta_id>/', views.activar_cuenta, name='activar_cuenta'),
    path('libros/desactivar_cuenta/<int:cuenta_id>/', views.desactivar_cuenta, name='desactivar_cuenta'),
    path('libros/eliminar_cuenta/<int:cuenta_id>/', views.eliminar_cuenta, name='eliminar_cuenta'),
   
    
    #===================================================================
    # Rutas para la gestión de carpetas y documentos
    #===================================================================
    path('libros/carpeta', views.carpeta, name='carpeta'),
    path('get-folders/', views.get_folders, name='get_folders'),
    path('create-folder/', views.create_folder, name='create_folder'),
    path('update-status/<int:folder_id>/', views.update_folder_status, name='update_folder_status'),
    path('upload-documents/<int:folder_id>/', views.upload_documents, name='upload_documents'),
    path('update-benefits/<int:folder_id>/', views.update_benefits, name='update_benefits'),
    path('delete-folder/<int:folder_id>/', views.delete_folder, name='delete_folder'),
    path('delete-document/<int:doc_id>/', views.delete_document, name='delete_document'),
    path('busqueda_ajax/', views.gestionar_productos_ajax, name='busqueda_ajax'),    
    path('media/documentos/<path:file_path>/', vista_archivos, name='vista_archivos'),
    
    
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
