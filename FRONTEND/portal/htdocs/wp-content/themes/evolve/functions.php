<?php

if (get_stylesheet_directory() == get_template_directory()) {
    define('EVOLVE_URL', get_template_directory() . '/library/functions/');
    define('EVOLVE_DIRECTORY', get_template_directory_uri() . '/library/functions/');
} else {
    define('EVOLVE_URL', get_template_directory() . '/library/functions/');
    define('EVOLVE_DIRECTORY', get_template_directory_uri() . '/library/functions/');
}

/**
 * Get Option.
 * Helper function to return the theme option value.
 * If no value has been saved, it returns $default.
 * Needed because options are
 * as serialized strings.
 */
function evolve_get_option($name, $default = false) {
    $config = get_option('evolve');

    if (!isset($config['id'])) {
        //return $default;
    }
    global $evl_options;

    $options = $evl_options;
    if (isset($GLOBALS['redux_compiler_options'])) {
        $options = $GLOBALS['redux_compiler_options'];
    }

    if (isset($options[$name])) {
        $mediaKeys = array(
            'evl_bootstrap_slide1_img',
            'evl_bootstrap_slide2_img',
            'evl_bootstrap_slide3_img',
            'evl_bootstrap_slide4_img',
            'evl_bootstrap_slide5_img',
            'evl_content_background_image',
            'evl_favicon',
            'evl_footer_background_image',
            'evl_header_logo',
            'evl_scheme_background',
            'evl_slide1_img',
            'evl_slide2_img',
            'evl_slide3_img',
            'evl_slide4_img',
            'evl_slide5_img',
        );
        // Media SHIM
        if (in_array($name, $mediaKeys)) {
            if (is_array($options[$name])) {
                return isset($options[$name]['url']) ? $options[$name]['url'] : false;
            } else {
                return $options[$name];
            }
        }

        return $options[$name];
    }

    return $default;
}

get_template_part('library/functions/basic-functions');
get_template_part('library/admin/admin-init');

// Metaboxes
get_template_part('library/views/metaboxes/metaboxes');

// Register Navigation
register_nav_menu('sticky_navigation', 'Sticky Header Navigation');

function evolve_script() {
    wp_enqueue_style('reset', get_template_directory_uri() . '/assets/css/reset.css');
    // Bootstrap Elements  
    wp_enqueue_style('bootstrapcss', get_template_directory_uri() . '/assets/css/bootstrap.css', array('maincss'));
    wp_enqueue_style('bootstrapcsstheme', get_template_directory_uri() . '/assets/css/bootstrap-theme.css', array('bootstrapcss'));
    wp_enqueue_script('bootstrap', get_template_directory_uri() . '/assets/js/bootstrap.min.js');
}

add_action('wp_enqueue_scripts', 'evolve_script');
