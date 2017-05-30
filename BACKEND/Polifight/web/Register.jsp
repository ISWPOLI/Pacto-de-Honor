<%-- 
    Document   : Register
    Created on : 21-may-2017, 19:29:19
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
        <title>Registrate</title>
    </head>

    <body id="body">
        <div class="StyleImage">
            <img src="Imagenes-y-Logos/LogoLogin.png"><br>
        </div>
        <br>
        <div id="fromtable">
            <form action="Registrar" method="POST"> 
                <table align="center">
                    <div class ="StyleText">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="rnombres" placeHolder="Names">
                            <label class="mdl-textfield__label" for="sample3">Nombres..</label>
                        </div>
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="rapellido" placeHolder="Last name">
                            <label class="mdl-textfield__label" for="sample3">Apellidos..</label>
                        </div>
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="ruser" placeHolder="User">
                            <label class="mdl-textfield__label" for="sample3">Usuario..</label>
                        </div>
                    </div>
                    <div class ="StyleText">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="remail"  placeHolder="Email">
                            <label class="mdl-textfield__label" for="sample3">Correo..</label>
                        </div>
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="rpais" placeHolder="Country">
                            <label class="mdl-textfield__label" for="sample3">Pais..</label>
                        </div>
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="text" name="rciudad" placeHolder="City">
                            <label class="mdl-textfield__label" for="sample3">Ciudad..</label>
                        </div>
                    </div>
                    <div class ="StyleText">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="password" name="rpass"  placeHolder="Password">
                            <label class="mdl-textfield__label" for="sample3">Contraseña..</label>
                        </div>
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                            <input class="mdl-textfield__input" type="password" name="repass"  placeHolder="Confirm Password">
                            <label class="mdl-textfield__label" for="sample3">Confirmar contraseña..</label>
                        </div>
                    </div>
                    <br><br>
                    <div class ="StyleText">
                        <input  id="EnviarCorreo" type="submit" value="Registrarse" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/> 
                        <input  id="EnviarCorreo" type="button" onClick="location='Login.jsp'" value="Cancelar"class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/>
                    </div>
                    <!--<input type="text" name="rnombres" placeholder="Nombre" required="required"/>
                    -<input type="text" name="rapellido" placeholder="Apellido" required="required"/>
                    -<input type="Email" name="remail" placeholder="&#128231; Email" required="required"/>
                    -<input type="text" name="rpais" placeholder="&#10687; Pais" required="required"/>
                    -<input type="text" name="rciudad" placeholder="&boxbox;Ciudad" required="required"/>
                    -<input type="text" name="ruser" placeholder="&#128272; Usuario" required="required"/>
                    -<input type="password" name="rpass" placeholder="&#128272 Password" required="required" /><br> <br>
                    -<input type="submit" id="btnlogin"  value="Registrate"/></td></tr>-->
                </table>
            </form>
        </div>
    </body>
</html>
