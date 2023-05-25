
from django.urls import path
from .views import RegistrandoUsuario
urlpatterns = [
    path( 'registroUsuarios/' , RegistrandoUsuario.as_view() ),
]
