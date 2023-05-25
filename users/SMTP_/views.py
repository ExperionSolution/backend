from .services.SMTP_service import SMTP_Services

from django.views import View
from django.http import JsonResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt


@method_decorator( csrf_exempt , name='dispatch' )
class Envio_Correo_Texto( View ):

	def post( self , request ):
		'''
		account , password , lista_correos_remitentes , titulo_msg , asunto_msg , texto_msg=""
		'''
		try:
			data_request = request.POST.dict()
			lista_correos_remitentes = dict( request.POST )["lista_correos_remitentes"]
			obj_client_SMTP = SMTP_Services( data_request['account'] , data_request['password'] )
			respuesta = obj_client_SMTP.send_msg_text( data_request['titulo_msg'] , data_request['asunto_msg'] , data_request["texto_msg"] , lista_correos_remitentes )
			return JsonResponse( {"response":"OK" , 'data':respuesta} )
		except:
			dataParametro = [ 'account' , 'password' , 'lista_correos_remitentes' , 'titulo_msg' , 'asunto_msg' , 'texto_msg']
			return JsonResponse( {"response":"error en el envio del correo","data":dataParametro} )


@method_decorator( csrf_exempt , name='dispatch' )
class Envio_Correo_HTML( View ):

	def post( self , request ):
		'''
		account , password , lista_correos_remitentes , titulo_msg , asunto_msg , string_htlm_msg=""
		'''
		try:
			data_request = request.POST.dict()
			lista_correos_remitentes = dict( request.POST )["lista_correos_remitentes"]
			obj_client_SMTP = SMTP_Services( data_request['account'] , data_request['password'] )
			respuesta = obj_client_SMTP.send_msg_html( data_request['titulo_msg'] , data_request['asunto_msg'] , data_request["string_htlm_msg"] , lista_correos_remitentes )
			return JsonResponse( {"response":"OK" , 'data':respuesta} )
		except:
			dataParametro = [ 'account' , 'password' , 'lista_correos_remitentes' , 'titulo_msg' , 'asunto_msg' , 'string_htlm_msg']
			return JsonResponse( {"response":"error en el envio del correo","parametrosNecesarios":dataParametro} )