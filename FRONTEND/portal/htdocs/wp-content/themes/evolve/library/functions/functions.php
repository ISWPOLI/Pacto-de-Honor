<?php

/**
 * Functions - general template functions that are used throughout EvoLve
 *
 * @package evolve
 * @subpackage Functions
 */
function evolve_media() {
    global $evl_options;
    $evolve_template_url = get_template_directory_uri();

    $evolve_css_data = '';

    $evolve_pagination_type = evolve_get_option('evl_pagination_type', 'pagination');
    $evolve_pos_button = evolve_get_option('evl_pos_button', 'right');
    $evolve_carousel_slider = evolve_get_option('evl_carousel_slider', '1');
    $evolve_parallax_slider = evolve_get_option('evl_parallax_slider_support', '1');
    $evolve_status_gmap = evolve_get_option('evl_status_gmap', '1');
    $evolve_recaptcha_public = evolve_get_option('evl_recaptcha_public', '');
    $evolve_recaptcha_private = evolve_get_option('evl_recaptcha_private', '');
    $evolve_fontawesome = evolve_get_option('evl_fontawesome', '0');
    $evolve_responsive_menu = evolve_get_option('evl_responsive_menu', 'icon');
    $evolve_responsive_menu_layout = evolve_get_option('evl_responsive_menu_layout', 'basic');
    $evolve_google_map_api = evolve_get_option('evl_google_map_api', '');

    if (is_admin())
        return;

    wp_enqueue_script('jquery');
    
    if ($evolve_parallax_slider == "1") {
        wp_enqueue_script('parallax', EVOLVEJS . '/parallax/parallax.js');
        wp_enqueue_style('parallaxcss', EVOLVEJS . '/parallax/parallax.css');
        wp_enqueue_script('modernizr', EVOLVEJS . '/parallax/modernizr.js');
    }

    if ($evolve_carousel_slider == "1") {
        wp_enqueue_script('carousel', EVOLVEJS . '/carousel.js');
    }
    wp_enqueue_script('tipsy', EVOLVEJS . '/tipsy.js', array('jquery'));
    wp_enqueue_script('fields', EVOLVEJS . '/fields.js', array('jquery'));
    wp_enqueue_script('tabs', EVOLVEJS . '/tabs.js', array('jquery'), '', true);

    //if ($evolve_pagination_type == "infinite") {
    wp_enqueue_script('jscroll', EVOLVEJS . '/jquery.infinite-scroll.min.js', array('jquery'));
    //}

    if ($evolve_pos_button == "disable" || $evolve_pos_button == "") {
        
    } else {
        wp_enqueue_script('jquery_scroll', EVOLVEJS . '/jquery.scroll.pack.js', array('jquery'));
    }
    wp_enqueue_script('supersubs', EVOLVEJS . '/supersubs.js', array('jquery'));
    wp_enqueue_script('superfish', EVOLVEJS . '/superfish.js', array('jquery'));
    wp_enqueue_script('buttons', EVOLVEJS . '/buttons.js', array('jquery'));
    wp_enqueue_script('ddslick', EVOLVEJS . '/ddslick.js', array('jquery'));
    wp_enqueue_script('meanmenu', EVOLVEJS . '/jquery.meanmenu.js', array('jquery'));
    wp_enqueue_script('main', EVOLVEJS . '/main.js', array('jquery'), '', true);

    if ($evolve_status_gmap == "1") {
        wp_enqueue_script('googlemaps', '//maps.googleapis.com/maps/api/js?key=' . $evolve_google_map_api . '&amp;language=' . mb_substr(get_locale(), 0, 2));
        wp_enqueue_script('gmap', EVOLVEJS . '/gmap.js', array('jquery'), '', true);
    }

    if ($evolve_recaptcha_public && $evolve_recaptcha_private) {
        wp_enqueue_script('googlerecaptcha', 'https://www.google.com/recaptcha/api.js');
    }

    if ($evolve_fontawesome != "1") {
        // FontAwesome 
        wp_enqueue_style('fontawesomecss', get_template_directory_uri() . '/assets/fonts/fontawesome/css/font-awesome.css', false);
    }
    
    // Main Stylesheet
    function evolve_styles() {

        wp_enqueue_style('maincss', get_stylesheet_uri(), false);

        require_once( get_template_directory() . '/custom-css.php' );
        wp_add_inline_style('bootstrapcsstheme', $evolve_css_data);

        $evolve_header_type = evolve_get_option('evl_header_type', 'none');
        switch ($evolve_header_type) {
            case "none":
                require_once( get_template_directory() . '/assets/css/header1.php' );
                break;
            case "h1":
                require_once( get_template_directory() . '/assets/css/header2.php' );
                break;
        }
        wp_add_inline_style('bootstrapcsstheme', $evolve_css_data);
	wp_enqueue_style('meanmenu', get_template_directory_uri() . '/assets/css/shortcode/meanmenu.css');
    }

    add_action('wp_enqueue_scripts', 'evolve_styles');


    if (defined('ICL_LANGUAGE_CODE')) {
        $language_code = ICL_LANGUAGE_CODE;
    } else {
        $language_code = '';
    }

    if ($evolve_responsive_menu == 'icon') {
        $evolve_responsive_menu = '<span class="t4p-icon-menu"></span>';
    } elseif ($evolve_responsive_menu == 'text') {
        $evolve_responsive_menu = evolve_get_option('evl_responsive_menu_text', 'Menu');
    } else {
        $evolve_responsive_menu = '';
    }

    //$evl_portfolio_pagination_type = isset($evl_options['evl_portfolio_pagination_type']) ? $evl_options['evl_portfolio_pagination_type'] : '';
    $local_variables = array(
        'language_flag' => $language_code,
        'infinite_blog_finished_msg' => '<em>' . __('All posts displayed', 'evolve') . '</em>',
        'infinite_blog_text' => '<em>' . __('Loading the next set of posts...', 'evolve') . '</em>',
        'theme_url' => get_template_directory_uri(),
    );

    wp_localize_script('main', 'js_local_vars', $local_variables);

    $responsive_menu_vars = array(
        'responsive_menu' => $evolve_responsive_menu,
        'responsive_menu_layout' => $evolve_responsive_menu_layout,
    );

    wp_localize_script('main', 'js_responsive_menu', $responsive_menu_vars);
}

/**
 * evolve_menu - adds css class to the <ul> tag in wp_page_menu.
 *
 * @since 0.3
 * @filter evolve_menu_ulclass
 * @needsdoc
 */
function evolve_menu_ulclass($ulclass) {
    $classes = apply_filters('evolve_menu_ulclass', (string) 'nav-menu'); // Available filter: evolve_menu_ulclass
    return preg_replace('/<ul>/', '<ul class="' . $classes . '">', $ulclass, 1);
}

/**
 * evolve_get_terms() Returns other terms except the current one (redundant)
 *
 * @since 0.2.3
 * @usedby evolve_entry_footer()
 */
function evolve_get_terms($term = NULL, $glue = ', ') {
    if (!$term)
        return;

    $separator = "\n";
    switch ($term):
        case 'cats':
            $current = single_cat_title('', false);
            $terms = get_the_category_list($separator);
            break;
        case 'tags':
            $current = single_tag_title('', '', false);
            $terms = get_the_tag_list('', "$separator", '');
            break;
    endswitch;
    if (empty($terms))
        return;

    $thing = explode($separator, $terms);
    foreach ($thing as $i => $str) {
        if (strstr($str, ">$current<")) {
            unset($thing[$i]);
            break;
        }
    }
    if (empty($thing))
        return false;

    return trim(join($glue, $thing));
}

/**
 * evolve_get Gets template files
 *
 * @since 0.2.3
 * @needsdoc
 * @action evolve_get
 * @todo test this on child themes
 */
function evolve_get($file = NULL) {
    do_action('evolve_get'); // Available action: evolve_get
    $error = "Sorry, but <code>{$file}</code> does <em>not</em> seem to exist. Please make sure this file exist in <strong>" . get_stylesheet_directory() . "</strong>\n";
    $error = apply_filters('evolve_get_error', (string) $error); // Available filter: evolve_get_error
    if (isset($file) && file_exists(get_stylesheet_directory() . "/{$file}.php"))
        locate_template(get_stylesheet_directory() . "/{$file}.php");
    else
        echo $error;
}

/**
 * evolve_include_all() A function to include all files from a directory path
 *
 * @since 0.2.3
 * @credits k2
 */
function evolve_include_all($path, $ignore = false) {

    /* Open the directory */
    $dir = @dir($path) or die('Could not open required directory ' . $path);

    /* Get all the files from the directory */
    while (( $file = $dir->read() ) !== false) {
        /* Check the file is a file, and is a PHP file */
        if (is_file($path . $file) and ( !$ignore or ! in_array($file, $ignore) ) and preg_match('/\.php$/i', $file)) {
            require_once( $path . $file );
        }
    }
    $dir->close(); // Close the directory, we're done.
}

/**
 * Remove title attribute from menu
 * 
 */
function evolve_my_menu_notitle($menu) {
    return $menu = preg_replace('/ title=\"(.*?)\"/', '', $menu);
}

add_filter('wp_nav_menu', 'evolve_my_menu_notitle');

/**
 * reCaptcha Class
 *
 * @recaptcha 2
 * @since 3.2.5
 */
class evolve_GoogleRecaptcha {
    /* Google recaptcha API url */

    public function VerifyCaptcha($response) {

        $response = isset($_POST['g-recaptcha-response']) ? esc_attr($_POST['g-recaptcha-response']) : '';
        $remote_ip = $_SERVER["REMOTE_ADDR"];
        $secret = evolve_get_option('evl_recaptcha_private', '');
        $request = wp_remote_get('https://www.google.com/recaptcha/api/siteverify?secret=' . $secret . '&response=' . $response . '&remoteip=' . $remote_ip);
        $response_body = wp_remote_retrieve_body($request);
        $res = json_decode($response_body, TRUE);
        if ($res['success'] == 'true')
            return TRUE;
        else
            return FALSE;
    }

}
