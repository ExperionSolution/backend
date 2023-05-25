from pathlib import Path
import string , random , requests


from .services.EnvioCorreosAsincronicos_service import envio_correo_html_asincrono
from .services.Template_Verificasion_service import generar_template_codigo_verificasion


from django.shortcuts import render , redirect
from django.views import View
from django.http import JsonResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt


from DB.models import Usuarios_tentativos


CURRENT_DIR = Path(__file__).resolve().parent


@method_decorator( csrf_exempt , name='dispatch' )
class RegistrandoUsuario( View ):
	
	def post( self , request ):
		dicc_request = request.POST.dict()
		
		if dicc_request["proceso"] == "Registrando_User_Tentativo":
			
			# If Correo no existe en tabla Usuarios ------->>>
			# --------------------------------------------->>>
			
			if Usuarios_tentativos.objects.filter( correo=dicc_request["correo"] ).exists() :
				for userObj in Usuarios_tentativos.objects.filter( correo=dicc_request["correo"] ):
					userObj.delete()

			codigo_verificasion = ''.join( random.choice(string.ascii_lowercase+"123456789") for i in range(6)) #Generamos la clave random
			Usuarios_tentativos(
				correo = dicc_request["correo"] ,
				codigo_validacion = codigo_verificasion ).save()
			
			path_template_verificasion = CURRENT_DIR/"templates/cod_verif.html"
			hmtl_code = generar_template_codigo_verificasion( path_template_verificasion , dicc_request["correo"] , codigo_verificasion )
			envio_correo_html_asincrono( 'Enzo Team' , f'Codigo Verificasion para {dicc_request["correo"]}' , hmtl_code , [dicc_request["correo"]] )

			return JsonResponse( {"response":"OK"} ) #Se puede retornar codigos
		
		elif dicc_request["proceso"] == "Validando_Codigo_User_Tentativo":
			if Usuarios_tentativos.objects.filter(correo=dicc_request["correo"],codigo_validacion=dicc_request["codigo_validacion"]).exists():
				for userObj in Usuarios_tentativos.objects.filter( correo=dicc_request["correo"] ):
					userObj.delete()

				# Registramos Usuario---->>>>>>>>>>>>>>>>>>
				#------------------------->>>>>>>>>>>>>>>>>
				return JsonResponse( {"response":"OK"} ) #Se puede retornar codigos
			else:
				return JsonResponse( {"response":"Correo o Codigo Invalidos"} )	#Se puede retornar codigos

		return JsonResponse({"response":"Error en datos Enviados"})