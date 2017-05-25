<%-- 
    Document   : Forgot
    Created on : 24/03/2017, 09:33:19 PM
    Author     : CPE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Olvido Clave Pacto de Honor</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
        <link rel="stylesheet" href="Decorator.css">
    </head>

    <body id="body">
        <div id="fromtable">    
            
    
            <form action="RecuperaClave" method="POST" >
                <img src="logo.png" id="image">
                <h1>Recupera tu clave</h1>
                <br>
                <input type="Email" name="remail" placeholder="&#128231; Email de Registro" required="required"/> <br> </br> 
                <input type="submit" value="Enviar" id="btnlogin"/>
                <input type="submit" value="Cancelar" id="btnlogin"/>
                
            </form>
            <br>
            <div align="center" >Derechos Reservados &copy; Copyright HackDemons 2010-2017 </div>            
        </div>
    </body >
</html>
