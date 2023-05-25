from bs4 import BeautifulSoup


def generar_template_codigo_verificasion( path_template , correo_usuario , codigo_verificasion ):
	with open( path_template ) as fp:
		soup = BeautifulSoup( fp , "html.parser")
	p_correo_usuario = soup.find( "p" ,id="correo_usuario")
	p_cod_verificasion = soup.find( "p" ,id="codigo_de_verificasion")
	p_correo_usuario.string.replace_with(correo_usuario)
	p_cod_verificasion.string.replace_with(codigo_verificasion)
	return soup

if __name__ == "__main__":
	path_template = "C:\\Users\\diego\\OneDrive\\Escritorio\\LoginProyect\\config\\LoginApp\\templates\\cod_verif.html"
	print( generar_template_codigo_verificasion( path_template , "correo_usuario@gmail.com" , "5465464688" ) )