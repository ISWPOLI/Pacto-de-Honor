<?php

class WPevolve {

    /**
     * init() Initialisation method which calls all other methods in turn.
     *
     * @since 0.1
     */
    public static function init() {
        $theme = new WPevolve;

        $theme->enviroment();
        $theme->evolve();
        $theme->extentions();
        $theme->defaults();
        $theme->ready();

        do_action('evolve_init');
    }

    /**
     * enviroment() defines WP evolve directory constants
     *
     * @since 0.2.3
     */
    public static function enviroment() {
        define('EVOLVETHEMELIB', get_template_directory() . '/library'); // Shortcut to point to the /library/ dir
        define('EVOLVETHEMECORE', EVOLVETHEMELIB . '/functions/'); // Shortcut to point to the /functions/ dir
        define('EVOLVETHEMEMORE', EVOLVETHEMELIB . '/extensions/'); // Shortcut to point to the /extensions/ dir
        define('EVOLVETHEMEMEDIA', EVOLVETHEMELIB . '/media'); // Shortcut to point to the /media/ URI
        define('EVOLVETHEMECSS', EVOLVETHEMEMEDIA . '/css');
        define('EVOLVETHEMEIMAGES', EVOLVETHEMEMEDIA . '/images');
        define('EVOLVETHEMEJS', EVOLVETHEMEMEDIA . '/js');

        // URI shortcuts
        define('EVOLVETHEME', get_template_directory_uri(), true);
        define('EVOLVELIBRARY', EVOLVETHEME . '/library', true); // Shortcut to point to the /library/ URI
        define('EVOLVEMEDIA', EVOLVELIBRARY . '/media', true); // Shortcut to point to the /media/ URI
        define('EVOLVECSS', EVOLVEMEDIA . '/css', true);
        define('EVOLVEIMAGES', EVOLVEMEDIA . '/images', true);
        define('EVOLVEJS', EVOLVEMEDIA . '/js', true);

        do_action('enviroment'); // Available action: load_enviroment
    }

    /**
     * evolve() includes all the core functions for WP evolve
     *
     * @since 0.2.3
     */
    public static function evolve() {
        get_template_part('library/functions/hooks'); // load the WP evolve Hook System
        get_template_part('library/functions/functions'); // load evolve functions
        get_template_part('library/functions/comments'); // load comment functions
        get_template_part('library/functions/widgets'); // load Widget functions
    }

    /**
     * extensions() includes all extensions if they exist
     *
     * @since 0.2.3
     */
    public static function extentions() {
        evolve_include_all(EVOLVETHEMEMORE);
    }

    /**
     * defaults() connects WP evolve default behavior to their respective action
     *
     * @since 0.2.3
     */
    public static function defaults() {
        add_filter('wp_page_menu', 'evolve_menu_ulclass'); // adds a .nav class to the ul wp_page_menu generates
        add_action('init', 'evolve_media'); // evolve_media() loads scripts and styles
    }

    /**
     * ready() includes user's theme.php if it exists, calls the evolve_init action, includes all pluggable functions and registers widgets
     *
     * @since 0.2.3
     */
    public static function ready() {
        if (file_exists(EVOLVETHEMEMEDIA . '/custom-functions.php'))
            get_template_part('library/functions/custom-functions'); // include custom-functions.php if that file exist
        get_template_part('library/functions/pluggable'); // load pluggable functions
        do_action('evolve_init'); // Available action: evolve_init
    }

}

// end of WPevolve;
