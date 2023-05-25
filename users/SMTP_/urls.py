
from django.urls import path
from .views import Envio_Correo_Texto , Envio_Correo_HTML
urlpatterns = [
    path( 'envio_correo_texto/' , Envio_Correo_Texto.as_view() ),
    path( 'envio_correo_html/' , Envio_Correo_HTML.as_view() ),
]
