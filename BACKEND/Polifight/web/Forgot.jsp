<%-- 
    Document   : Forgot
    Created on : 22-may-2017, 18:04:06
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="shortcut icon" href="Imagenes-y-Logos/Escudo.ico">
        <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
        <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
        <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="css/StyleLoginRegister.css" rel="stylesheet" type="text/css" media="screen" />
        <title>Recuerda tu contraseña</title>
    </head>

    <body id="body">
        <div class="StyleImage">
            <img src="Imagenes-y-Logos/LogoLogin.png"><br>
        </div>
        <div style="styleText">
            <div id="fromtable" >    
                <form action="RecuperarClave" method="POST" >
                
                    <!--<h1>Recupera tu clave</h1>-->
                
                    <div class ="StyleText">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="remail" id="remail" placeHolder="Mail" required="required">
                            <label class="mdl-textfield__label" for="sample3">Correo..</label>
                        </div>
                    </div>
                    <div class ="StyleText">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="rusuario" id="remail" placeHolder="User" required="required">
                            <label class="mdl-textfield__label" for="sample3">Usuario..</label>
                        </div>
                    </div>
                    <br>
                    <div class ="StyleText">
                        <input  id="EnviarCorreo" type="submit" value="Enviar" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/> 
                        <input  id="EnviarCorreo" type="button" onClick="location='Login.jsp'" value="Cancelar"class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/>
                    </div>
                    
                        <!--<input type="submit" value="Enviar" id="btnlogin"/>
                        <input type="submit" value="Cancelar" id="btnlogin"/>-->
                    
                    
                    <!--<input type="Email" name="remail" placeholder="&#128231; Email de Registro" required="required"/> <br> </br> -->
                    
                </form>
                <br>
            </div>
        </div>
    </body >
</html>
