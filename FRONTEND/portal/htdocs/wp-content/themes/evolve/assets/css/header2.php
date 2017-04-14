<?php
global $evl_options;
$options = $evl_options;

$evolve_css_data = '

#search-text-box #search_label_top .srch-btn {
    width: 182px;
}

#search-text-box #search_label_top .srch-btn::before {
    color: #273039;
    content: "\f0d9";
    cursor: pointer;
    font-family: icomoon;
    font-size: 18px !important;
    font-weight: normal;
    position: absolute;
    right: 47px !important;
    text-align: center;
    top: -5px !important;
    width: 3px;
}

#search-text-box #search_label_top .srch-btn::after {
    background: #273039 none repeat scroll 0 0;
    border-radius: 3px;
    color: '. $evolve_top_menu_hover_font_color .';
    content: "\e91e";
    cursor: pointer;
    font-family: icomoon;
    font-size: 18px !important;
    font-weight: normal;
    line-height: 35px;
    position: absolute;
    right: 7px !important;
    text-align: center;
    top: -10px !important;
    width: 38px;
}

#search-text-top {
    background: #fff none repeat scroll 0 0 !important;
    border: 1px solid #273039 !important;
    border-radius: 4px !important;
    color: #757575 !important;
    float: right !important;
    font-family: Roboto !important;
    font-size: 14px;
    font-weight: 500;
    text-indent: 1px !important;
    height: 35px;
    padding: 0 0 0 10px !important;
    position: relative;
    transition: all 0.5s ease 0s;
    width: 170px !important;
}

#search_label_top {
    margin-top: 5px !important;
    color: #888;
}

div#search-text-box {
    margin-right: 0;
}

#social {
    float: right;
}

.sc_menu {
    float: none;
}

.sc_menu li a {
    padding: 8.7px 8px;
}

.sc_menu a.tipsytext:hover {
    color: '.$evolve_top_menu_hover_font_color.' !important;
}

.title-container #logo {
    float: none;
}

.searchform {
    float: right;
    clear: none;
}

.title-container #logo a {
    padding: 0px;
}

.menu-header .menu-item {
    text-transform: uppercase;
}

.top-menu-social {
    margin: 10px 0;
}

.header .woocommerce-menu li {
    margin-left: 20px;
}

@media (max-width: 768px) {
    ul.nav-menu ul.sub-menu .sf-with-ul:after {
        top: 12px;
    }
}


/*responsive*/

@media only screen and (max-width: 768px) {
    .searchform {
        clear: both;
        float: none;
    }
    .sc_menu {
        text-align: center;
    }
    .woocommerce-menu {
        float: none;
        margin-right: 0;
    }
    .woocommerce-menu li {
        background-image: none;
        margin-left: 0px;
    }
    .woocommerce-menu .dd-options li a {
        text-align: left;
    }
    .searchform {
        float: none;
    }
    #search-text-box {
        float: none;
    }
    #search_label_top::after {
        right: 15px !important;
    }
    .woocommerce-menu-holder {
        float: none;
    }
    .header .menu-container .col-md-3 {
        text-align: center;
        width: 100%;
        float: none !important;
    }
    .mobilemenu-icon span {
        display: block;
        background: #FFF none repeat scroll 0% 0%;
        height: 3px;
        width: 40px;
        margin-top: 6px;
    }
    .mobilemenu-icon {
        position: fixed;
        top: 54%;
        left: 45%;
    }
    #wrapper .dd-options li a {
        text-align: left;
    }
}

@media only screen and (min-width: 769px) and (max-width: 992px) {
    .header .title-container #tagline {
        padding: 20px 0px;
    }
}

ul.nav-menu {
    padding: 0px;
}

ul.nav-menu li:hover {
    background: none;
}

.woocommerce-menu .my-account a {
    font-size: 12px;
}

.woocommerce-menu .cart > a .t4p-icon-cart::before,
.woocommerce-menu .my-account > a .t4p-icon-user::before {
    margin-right: 10px;
}

.woocommerce-menu .cart > a:before {
    font-family: IcoMoon;
    content: "\e90c";
    margin-right: 10px;
}

#righttopcolumn,
#social,
.sc_menu,
.header a,
#tagline,
#logo {
    display: block;
}

ul.t4p-navbar-nav > li {
    display: inline-block;
    float: none;
}
';
