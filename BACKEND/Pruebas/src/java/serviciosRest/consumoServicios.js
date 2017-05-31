

var surl="http://192.168.113.162:8080/Polifight/webresources/usuario/login?Estudiante&pass=demo123"; 
$(function callWebService() {
    try {
    $.ajax({
        url: surl,
        methood: "POST",
        async: true,
        contentType: "application/json; charset=utf-8",
        dataType: json,
        success: function(msg){ alert("consumido")},
        error:function(jqXmlHttpRequest, textStatus, errorThrown){alert("error lectura");} 
    });
    }catch(e){
        alert(e);
    }
}
//callWebService();
    
   
