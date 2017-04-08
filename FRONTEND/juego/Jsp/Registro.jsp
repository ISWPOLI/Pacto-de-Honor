<%-- 
    Document   : Registro
    Created on : 24/03/2017, 09:39:46 PM
    Author     : CPE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro Pacto de Honor</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
        <link rel="stylesheet" href="Decorator.css">
    </head>

    <body id="body">
        <div id="fromtable">
            <form action="" method="POST"  > 
                <table align="center">
                    <img src="logo.png" id="image" > 
                    <tr><td><input type="text" name="rnombres" placeholder="Nombre"/>
                            <input type="text" name="rapellido" placeholder="Apellido"/>
                            <input type="Email" name="remail" placeholder="&#128231; Email"/>
                            <input type="text" name="rpais" placeholder="&#10687; Pais"/>
                            <input type="text" name="rciudad" placeholder="&boxbox;Ciudad"/>
                            <input type="text" name="rusuario" placeholder="&#128272; Usuario"/>
                            <input type="password" name="rcontraseña" placeholder="&#128272 Password" /><br> <br>
                            <input type="submit" id="btnlogin"  value="Registrate"/></td></tr>
                </table>
            </form>
            <br>
            <div align="center">Derechos Reservados &copy; Copyright HackDemons 2010-2017 </div>
        </div>
    </body>
</html>
