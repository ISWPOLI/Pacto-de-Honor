var cookies = {
    
    setCookie: function(cname, cvalue) {
        //var d = new Date();
        //d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        //var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + encodeURIComponent(cvalue) + ";"/* + expires + ";path=/"*/;
    },

    getCookie: function(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return decodeURIComponent(c.substring(name.length, c.length));
            }
        }
        return "";
    },

    checkCookie: function() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }
}