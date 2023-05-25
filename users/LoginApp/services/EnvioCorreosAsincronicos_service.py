import threading , requests


account = ""
password = ""


def envio_correo_texto( endPoint_ServicioCorreo , account , password , titulo_msg , asunto_msg , texto_msg , lista_correos_remitentes ):
	data = { "account": account ,
		"password": password ,
		"titulo_msg":titulo_msg,
		"asunto_msg":asunto_msg,
		"texto_msg":texto_msg,
		"lista_correos_remitentes":lista_correos_remitentes }
	response_data = requests.post( endPoint_ServicioCorreo , data=data )


def envio_correo_texto_asincrono( titulo_msg , asunto_msg , texto_msg , lista_correos_remitentes ):
	
	endPoint_ServicioCorreo = 'http://127.0.0.1:8000/CorreoET/envio_correo_texto/'
	
	thread = threading.Thread(target=envio_correo_texto , args=[ endPoint_ServicioCorreo , account , password , titulo_msg , asunto_msg , texto_msg , lista_correos_remitentes ])
	thread.start()


def envio_correo_html( endPoint_ServicioCorreo , account , password , titulo_msg , asunto_msg , html_msg , lista_correos_remitentes ):
	data = { "account": account ,
		"password": password ,
		"titulo_msg":titulo_msg,
		"asunto_msg":asunto_msg,
		"string_htlm_msg":str(html_msg),
		"lista_correos_remitentes":lista_correos_remitentes } 
	response_data = requests.post( endPoint_ServicioCorreo , data=data )


def envio_correo_html_asincrono( titulo_msg , asunto_msg , html_msg , lista_correos_remitentes ):
	
	endPoint_ServicioCorreo = 'http://127.0.0.1:8000/CorreoET/envio_correo_html/'

	thread = threading.Thread(target=envio_correo_html , args=[ endPoint_ServicioCorreo , account , password , titulo_msg , asunto_msg , html_msg , lista_correos_remitentes ])
	thread.start()