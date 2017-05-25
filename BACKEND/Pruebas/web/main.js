$(function () {

    var app_id = '713189185529900';
    var scopes = 'email, public_profile, user_friends';

    var btn_login = '<input href="#" id="facebook"  type="submit" value="Facebook"/>';

    var div_session = "<div id='facebook-session'>" +
            "<strong></strong>" +
            "<img>" +
            "<a href='#' id='logout' class='btn btn-danger'>Cerrar sesión</a>" +
            "</div>";

    window.fbAsyncInit = function () {
        FB.init({
            appId: app_id,
            status: true,
            cookie: true,
            xfbml: true,
            version: 'v2.9'
        });


        FB.getLoginStatus(function (response) {
            statusChangeCallback(response, function () {});
        });
    };

    var statusChangeCallback = function (response, callback) {
        console.log(response);
        if (response.status === 'connected') {
            getFacebookData();
        } else {
            callback(false);
        }
    }

    var checkLoginState = function (callback) {
        FB.getLoginStatus(function (response) {
            callback(response);
        });
    }

    var getFacebookData = function () {
        FB.api('/me', function (response) {
            $('#facebook').after(div_session);
            $('#facebook').remove();
            $('#facebook-session strong').text("Bienvenido: " + response.name);
            $('#facebook-session img').attr('src', 'http://graph.facebook.com/' + response.id + '/picture?type=large');
        });
    }

    var facebookLogin = function () {
        checkLoginState(function (data) {
            if (data.status !== 'connected') {
                FB.login(function (response) {
                    if (response.status === 'connected')
                        getFacebookData();
                }, {scope: scopes});
            }
        })
    }

    var facebookLogout = function () {
        checkLoginState(function (data) {
            if (data.status === 'connected') {
                FB.logout(function (response) {
                    $('#facebook-session').before(btn_login);
                    $('#facebook-session').remove();
                })
            }
        })

    }



    $(document).on('click', '#facebook', function (e) {
        e.preventDefault();
                
        facebookLogin();
    })

    $(document).on('click', '#logout', function (e) {
        e.preventDefault();

        if (confirm("¿Está seguro?"))
            facebookLogout();
        else
            return false;
    })

})
