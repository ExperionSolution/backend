from SMTPEmail import SMTP


class SMTP_Services():
	
	account = ""
	password = ""
	obj_client = ""

	def __init__( self , account , password):
		self.account = account#"Cuenta"
		self.password = password #CodigoGmail
		self.obj_client = SMTP( SMTP_server="smtp.gmail.com" , SMTP_account=self.account , SMTP_password=self.password )
		
	def send_msg_text( self , titulo_msg , asunto_msg , text_msg , lista_remitente ):
		response_list = []
		for remitente in lista_remitente:
			self.obj_client.create_mime(
				recipient_email_addr= remitente ,
				sender_email_addr= self.account ,
				sender_display_name= titulo_msg ,
				subject= asunto_msg ,
				content_text=text_msg
			)
			response_list.append( {"correo":remitente,"estado":self.obj_client.send_msg()} )
		return response_list

	def send_msg_html( self , titulo_msg , asunto_msg , html_msg , lista_remitente ):
		response_list = []
		for remitente in lista_remitente:
			self.obj_client.create_mime(
				recipient_email_addr= remitente ,
				sender_email_addr= self.account ,
				sender_display_name=titulo_msg,
				subject=asunto_msg,
				content_html= str(html_msg),
			)
			response_list.append( {"correo":remitente,"estado":self.obj_client.send_msg()} )
		return response_list