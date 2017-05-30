<%-- 
    Document   : Login
    Created on : 20-may-2017, 17:12:03
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        <script src="js/main.js">
        <title>Poli Fights</title>
    </head>
    <body>
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
            <script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else {
      // The person is not logged into your app or we are unable to tell.
      
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '713189185529900',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.8' // use graph api version 2.8
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

        
        <div class="StyleImage">
            <img src="Imagenes-y-Logos/LogoLogin.png"><br>
        </div>
        
        <div class ="StyleText">
            <form action="Iniciar" method="POST" if="formInicio">
                <div class ="StyleText">
                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <input class="mdl-textfield__input" type="text" name="rusuario" id="txtusuario" placeHolder="User">
                        <label class="mdl-textfield__label" for="sample3">Usuario..</label>
                    </div>
                </div>
                <div class ="StyleText">
                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <input class="mdl-textfield__input" type="password" name="rcontrasena" id="txtpassword" placeHolder="Password">
                        <!--placeHolder="Poli123*"-->
                        <label class="mdl-textfield__label" for="sample4">Contraseña..</label>
                    </div>
                </div>
                <br>
                <div class ="StyleMenu">
                    <button type="submit" value="Iniciar Sesión" id="btnlogin" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">Iniciar Sesión</button>
                    <button type="button" id="demo-menu-lower-left" class="mdl-button mdl-js-button mdl-js-ripple-effect">M<font style="text-transform: lowercase;">as opciones</font></button>
                </div>
                <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect" for="demo-menu-lower-left">
                    <li class="mdl-menu__item"><a href="Register.jsp" id="txtfpassword">Registrate</a></li>
                    <li class="mdl-menu__item"><a href="Forgot.jsp" id="txtregistrarse" >Olvidaste tu contraseña</a></li>
                </ul>
                <br><br>
                <div class ="StyleText">
                    <fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
                    <input  id="google"    type="submit" value="Google" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/> 
                    <input  id="Microsoft" type="submit" value="Microsoft"class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/>
                </div>
                <!--
                    <input href="#" id="facebook"  type="submit" value="Facebook" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/>
                    <input  id="google"    type="submit" value="Google" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/> 
                    <input  id="Microsoft" type="submit" value="Microsoft"class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"/>
                -->
            </form>
        </div>
    </body>
</html>
