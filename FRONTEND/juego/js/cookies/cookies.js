var cookies = {
    //Método para crear una cookie
    setCookie: function(cname, cvalue) { //Parámetro nombre y valor
        //document.cookie crea una cookie con la llave cname y el valor de cvalue
        document.cookie = cname + "=" + encodeURIComponent(cvalue) + ";";
    },
    //Método para obetener el valor de una cookie
    getCookie: function(cname) {
        var name = cname + "="; //Se guarda el valor de cname en una variable
        var ca = document.cookie.split(';'); //Se crea un arreglo con todas las cookies que hay dividiendolas por ";"
        for(var i = 0; i < ca.length; i++) { //Se recorre el arreglo
            var c = ca[i]; //Se asigna el elemento sub i del arreglo a una variable
            while (c.charAt(0) == ' ') { //Se recorre cada variable para encontrar la llave
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) { //Si encuentra la llave, retorna el valor de la cookie
                return decodeURIComponent(c.substring(name.length, c.length));
            }
        }
        return ""; //Retorna cadena vacia si no encuentra la cookie
    },
    //Método que revisa las cookies para ver si existe, si no, la crea
    checkCookie: function() {
        var user = cookies.getCookie("token");
        console.log("usuario:"+ user);
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                cookies.setCookie("token", user);
            }
        }
    }
}