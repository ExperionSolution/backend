from django.db import models

class Usuarios_tentativos( models.Model ):
	id = models.AutoField( primary_key=True )
	correo = models.CharField( max_length=100 )
	codigo_validacion = models.CharField( max_length=100 )
	fecha_creacion = models.DateTimeField( auto_now_add=True )