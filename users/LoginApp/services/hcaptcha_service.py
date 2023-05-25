import requests

# Informacion ---------------------->>>>>>>>>>>>>>>>
# https://docs.hcaptcha.com/
'''
Una vez obtenido el Secret Key de la cuenta
Generamos una key publica para una pagina
insertamos la key publica en el formulario del frontend
al mandar el paquete al backen se enviara el codigo de verificasion de hcaptchat del catcha resuelto
validamos que el captcha sea valido, accediendo a la url de la pagina y pasando la keyprivada y key generada en el frontend
si la api retorna true entonces continuamos, en otro caso retornamos false
'''
# ---------------------------------->>>>>>>>>>>>>>>>

#SECRET_KEY = "0x4B6f1fBd0A82D5a14565D3850Ceb6cCb1124d6CC"

request_dicc['h-captcha-response']

def validando_hcaptcha( hcaptcha_response , secret_key ):
    response = requests.post( "https://hcaptcha.com/siteverify" , data={'secret':secret_key, 'response':hcaptcha_response })
    data_response_hcaptcha = json.loads(response.content)
    return data_response_hcaptcha['success'] #Return True o False