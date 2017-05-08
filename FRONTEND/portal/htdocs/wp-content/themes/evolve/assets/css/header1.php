<?php
$evolve_css_data = '
.woocommerce-menu-holder {
    float: left;
}

.container-menu {
    z-index: auto;
}

#search-text-top {
    position: absolute;
    right: 0;
}

#search-text-top:focus {
    position: absolute;
    right: 0px;
    left: initial;
}

@media all and (-ms-high-contrast:none) {
    #search-text-box #search_label_top,
    #stickysearch_label {
        position: absolute;
        right: 0px;
    }
    #search-text-top,
    #search-stickyfix {
        margin-right: 0px;
        position: relative !important;
    }
    #search-text-box #search_label_top::after {
        right: 30px;
    }
    #stickysearch-text-box #stickysearch_label::after {
        right: 15px !important;
    }
    #search-text-top:focus,
    #search-stickyfix:focus {
        position: relative !important;
    }
}

.header .woocommerce-menu {
    margin-right: 20px;
    padding: 5px;
}

@media (max-width: 768px) {
    .header_v0 .title-container #logo a {
        padding: 0px;
    }
    #search-text-top {
        background: #fff;
        font-size: 12px;
        font-weight: normal;
        color: #888;
    }
    .sc_menu {
        float: none;
        text-align: center;
    }
    #search-text-top {
        border: 1px solid #fff;
        height: 36px;
        width: 170px;
    }
    .woocommerce-menu-holder {
        float: none;
    }
    .header .woocommerce-menu {
        float: none;
        margin-right: 0;
    }
    .title-container #logo {
        float: none;
    }
    #righttopcolumn,
    #social,
    .header a,
    #tagline,
    #logo {
        width: auto;
        display: block;
    }
    #wrapper .dd-container{
        text-align: center;
    }
}

@media screen and (min-width: 1200px) {
    .header_v0 div#search-text-box {
        margin-right: 0px
    }
}

.sticky-header ul.t4p-navbar-nav > li {
    display: inline-block;
    float: none;
}
';
