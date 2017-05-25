<%-- 
    Document   : index
    Created on : 14/04/2017, 11:50:33 PM
    Author     : JERR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Facebook</title>
   <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="main.js"></script>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

	<link rel="stylesheet" href="main.css">
</head>
<body>
	<h1>Facebook SDK login con Javascript</h1>

	<a href="#" id="login" class="btn btn-primary">Iniciar sesión</a>
	
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

	  (function(d, s, id) {
	    var js, fjs = d.getElementsByTagName(s)[0];
	    if (d.getElementById(id)) return;
	    js = d.createElement(s); js.id = id;
	    js.src = "//connect.facebook.net/en_US/sdk.js";
	    fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
	 </script>
</body>
</html>
