Aplicativos
Tener todos los aplicativos descargados e instalados
	1 sublime: editor texto multiple opcional
	2 PhP la ultima version para compilar composer preferible 5.2.0
	3 Xampp instalar solo en disco c
	3 Composer versionador: poner pach de PHP

Login PHP facebook.
Se codifica lo Requerido párrafo de inicio de sesión con facebook, Tener en Cuenta por direction seguridad
sin indico mi Identificación NI EL SECRETO de la Aplicación Creada en facebook, para la ejecucion se 
Deben switch to Do SEGÚN Proyecto, en La Ruta Login_PHP_facebook-config-facebook.php

Previos

Tener o crear de Cuenta en Facebook.
Tener o crear de Cuenta en Facebook Desarrolladores https://developers.facebook.com/
Crea Una Aplicación PARA USO de Identificación y secreto. https://developers.facebook.com/apps
Consultas CREAR Y Habilitar API, Pruebas Hacer.
Leer la Información y verificar casas de cambio.
Clases 
Nota: Se USO Un Árbol de Carpetas para embeber de composser un SDK4 de facebook.

Login_PHP_facebook: 
index.php: 
Tiene el Código párrafo Generar El Botón y logo de facebook para el inicio de sesión "tener en Cuenta Que El css FUE traido de bootstrapcdn"

* aplicación: 
stat.php: 
Llama y carga clases index.php, facebook.php, y autoload.php. 
autoload.php usamos algunos adj Parámetros de logueo del sdk4 php desarrolladores de Facebook. 
facebook.php usamos Parámetros de Inicio de Sesión y Trabajamos con facebookSession.

logout.php:
Terminar la sesión y redirigir al index.php para poder cerrar sesión.
* config: 
facebook.php: 
Hace col La Consulta de la API con El ID Y SECRETOS Y REALIZAMOS Scopes teniendo en Cuenta Lo Que el SDK 
permite Traer ojetos con la USO correcto del conseguir, "tener en Cuenta Que Datos de Como Lista de amigos sin 
por direction seguridad permite de facebook ".

* proveedor: 
* composser: Recopilar las Versiones y Tener el sdk4 php de facebook pecado Tener que Hacer el reqiure de 
Cada Una de Sus clases.

*facebook: 
       *PHP-sdk-v4: Almacena el SDK4 php de developerFacebook que da licenciamiento para usar el API.