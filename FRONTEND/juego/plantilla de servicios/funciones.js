var surl = "http://192.168.101.22:8080/Polifight/webresources/usuario/login?user=Estudiante&pass=demo123";
function callWebService(){
    try{ 
        $.ajax({
            url: surl,
            method: "POST",
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

callWebService();