<%-- 
    Document   : logon
    Created on : 24/03/2017, 06:00:23 PM
    Author     : JERR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Pacto de Honor</title>
        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script src="main.js"></script>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
        <link rel="stylesheet" href="Decorator.css">
    </head>

    <body id="body" >
        <script> 
      // Load the SDK asynchronously
        window.fbAsyncInit = function() {
    FB.init({
      appId      : '713189185529900',
      xfbml      : true,
      version    : 'v2.9'
    });
    FB.AppEvents.logPageView();
  };  
    
  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
        </script>

        <div id="fromtable">
            <form action="Iniciar" method="POST" id="formInicio" >
                <table align="center">
                    <img src="logo.png" id="image" >
                    <tr><td><input type="text" name="rusuario" placeholder="&#128272; Usuario" id="txtusuario" required="required"/></td></tr>
                    <tr><td><input type="password" name="rcontrasena" placeholder="&#128272; Password" id="txtpassword" required="required"/></td></tr><br>
                    <tr><td><a textaling="center" href="Forgot.jsp" id="txtfpassword">Forgot Password</a></td></tr>
                    <tr><td><a href="Registro.jsp"id="txtregistrarse" >Registrarse</a></td></tr><br>
                    <tr><td><input type="submit" value="Login" id="btnlogin"/></td></tr><br><br>
                    <td> 
                        <input href="#" id="facebook"  type="submit" value="Facebook"/>
                        <input  id="google"    type="submit" value="Google"/> 
                        <input  id="Microsoft" type="submit" value="Microsoft"/>
                    </td>
                </table> 
            </form>
            <div 
                id="footer">Derechos Reservados &copy; Copyright HackDemons 2010-2017 
            </div>
        </div>
    </body>
</html>
