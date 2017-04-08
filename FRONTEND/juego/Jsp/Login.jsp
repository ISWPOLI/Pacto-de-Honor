<%-- 
    Document   : logon
    Created on : 24/03/2017, 06:00:23 PM
    Author     : JERR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Pacto de Honor</title>
        
        <script src="js/main.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
        <link rel="stylesheet" href="Decorator.css">
    </head>


    <body id="body" >
        <div id="fromtable">
            <form action="Iniciar" method="POST" id="formInicio" >
                <table align="center">
                    <img src="logo.png" id="image" >
                    <tr><td><input type="text" name="rusuario" placeholder="&#128272; Usuario" id="txtusuario"/></td></tr>
                    <tr><td><input type="password" name="rcontrasena" placeholder="&#128272; Password" id="txtpassword"/></td></tr><br>
                    <tr><td><a textaling="center" href="Forgot.jsp" id="txtfpassword">Forgot Password</a></td></tr>
                    <tr><td><a href="Registro.jsp"id="txtregistrarse" >Registrarse</a></td></tr><br>
                    <tr><td><input type="submit" value="Login" id="btnlogin"/></td></tr><br><br>
                    <td> 
                        <input  id="facebook"  type="submit" value="Facebook"/>
                        <input  id="google"    type="submit" value="Google"/> 
                        <input  id="Microsoft" type="submit" value="Microsoft"/>
                    </td>
                </table> 
            </form>
            <div 
                id="footer">Derechos Reservados &copy; Copyright HackDemons 2010-2017 
            </div>
            <!--/**<script>
                // Load the SDK asynchronously
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));
            </script>*/-->
        </div>
    </body>
</html>
