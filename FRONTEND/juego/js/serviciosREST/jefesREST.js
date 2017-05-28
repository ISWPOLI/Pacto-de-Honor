/*
cambiar el local host por endPoint
pasar el token el usuario logeado
*/

var surl = "http://localhost:80:80/Polifight/websources/personaje/badCharacter?token=962C7B2EBEB246ACB132C4BAA90E52E6170417155119";
function callWebService(){
    try{ 
        $.ajax({
            url: surl+"/login?user=Estudiante&pass=demo123",
            method: "GET",
            async: true,
            contentType: "application/json; charset=utf-8",
            dataType: "json",        
            success: function(msg) { alert("funciono") },
            error: function(jqXmlHttpRequest, textStatus, errorThrown) { alert("Error leyendo datos."); }
        });
    } 
    catch (err) {
        alert(err);
    }
}