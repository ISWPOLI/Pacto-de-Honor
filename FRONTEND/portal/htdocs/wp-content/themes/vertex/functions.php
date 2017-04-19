<?php

/**
 * Theme support features.
 *
 * @since 1.0.0
 */
function vertex_setup() {

	global $content_width;

	load_theme_textdomain('vertex', get_template_directory() . '/languages');
	add_theme_support( 'custom-logo', array( 'height' => 149, 'width' => 149, 'flex-height' => true, 'flex-width' => true ) );
	register_nav_menu( 'header-menu', __( 'Header Menu', 'vertex' ) );
	add_theme_support( 'post-thumbnails' );
	add_theme_support( 'automatic-feed-links' );
	add_theme_support( "title-tag" );
	add_theme_support( 'post-formats', array( 'video' ) );
	add_theme_support( 'custom-background', array('default-color' => 'FFFFFF') );

	if ( ! isset( $content_width ) ) $content_width = 900;

}
add_action( 'after_setup_theme', 'vertex_setup' );

/**
 * Editor custom style
 *
 * @since 1.0.0
 */
function vertex_add_editor_styles() {
    add_editor_style( 'css/editor-style.css' );
}
add_action( 'admin_init', 'vertex_add_editor_styles' );


/**
 * Enqueue of theme styles and scripts.
 *
 * @since 1.0.0
 */
function vertex_theme_imports(){


    wp_enqueue_style( 'vertex-google-lato-font', 'https://fonts.googleapis.com/css?family=Lato:300,400,500,700,900' );
    wp_enqueue_style( 'slicknav', get_stylesheet_directory_uri().'/css/slicknav.min.css' );
    wp_enqueue_style( 'slitslider', get_stylesheet_directory_uri().'/css/slitslider.css' );
	wp_enqueue_style( 'vertex', get_stylesheet_uri(),999 );
	
	wp_enqueue_script( 'slicknav', get_stylesheet_directory_uri() . '/js/jquery.slicknav.min.js', array('jquery') );
	wp_enqueue_script( 'vertex-modernizr', get_stylesheet_directory_uri() . '/js/modernizr.custom.79639.min.js', array('jquery') );
	wp_enqueue_script( 'cond', get_stylesheet_directory_uri() . '/js/jquery.ba-cond.min.js', array('jquery') );
	wp_enqueue_script( 'slitslider', get_stylesheet_directory_uri() . '/js/jquery.slitslider.js', array('jquery') );
	wp_enqueue_script( 'vertex', get_stylesheet_directory_uri() . '/js/scripts.js', array('jquery') );
	if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
		wp_enqueue_script( 'comment-reply' );
	}
}
add_action('wp_enqueue_scripts', 'vertex_theme_imports');

/**
 * Theme widgets. 
 *
 * @since 1.0.0
 */
function vertex_widgets_init() {
	register_sidebar( array(
		'name' => __('No Sidebar','vertex'),
		'id' => 'sidebar-1',
		'before_widget' => '<div id="%1$s" class="widget_box %2$s">',
		'after_widget' => '</div>',
		'before_title' => '<h3 class="side_title">',
		'after_title' => '</h3>',	
		) );
	register_sidebar( array(
		'name' => __('Footer Col 1','vertex'),
		'id' => 'footer-1',
		'before_widget' => '<div id="%1$s" class="widget_box footer_box %2$s">',
		'after_widget' => '</div>',
		'before_title' => '<h3 class="footer_title">',
		'after_title' => '</h3>',
		) );
	register_sidebar( array(
		'name' => __('Footer Col 2','vertex'),
		'id' => 'footer-2',
		'before_widget' => '<div id="%1$s" class="widget_box footer_box %2$s">',
		'after_widget' => '</div>',
		'before_title' => '<h3 class="footer_title">',
		'after_title' => '</h3>',
	) );
	register_sidebar( array(
		'name' => __('Footer Col 3','vertex'),
		'id' => 'footer-3',
		'before_widget' => '<div id="%1$s" class="widget_box footer_box %2$s">',
		'after_widget' => '</div>',
		'before_title' => '<h3 class="footer_title">',
		'after_title' => '</h3>',
		'ignore_sticky_posts' => true
	) );
	register_sidebar( array(
		'name' => __('Footer Col 4','vertex'),
		'id' => 'footer-4',
		'before_widget' => '<div id="%1$s" class="widget_box footer_box %2$s">',
		'after_widget' => '</div>',
		'before_title' => '<h3 class="footer_title">',
		'after_title' => '</h3>',
		'ignore_sticky_posts' => true
	) );
}
add_action( 'widgets_init', 'vertex_widgets_init' );


/**
 * Default copyright text.
 *
 * @since 1.0.0
 * @return string The copyrigh text.
 */
function vertex_footer_copyright() {

	return '&copy; ' . date_i18n( __( 'Y', 'vertex' ) ) .'. '. __('Powered by <a href="https://wordpress.org" target="_blank">WordPress</a>. Vertex created by <a href="http://dessign.net/" target="_blank">Dessign</a>','vertex');

}

require_once get_template_directory().'/customizer.php';

/**
 * Video iframe.
 * This is used to parse content to find video URLs from youtube or vimeo.
 *
 * @since 1.0.0
 * @param int $post_id the post ID
 * @return string The embed code of the video.
 */
function vertex_get_video( $post_id ) {

	$post = get_post($post_id);
	$content = do_shortcode( apply_filters( 'the_content', $post->post_content ) );
	$embeds = get_media_embedded_in_content( $content );
	if( !empty($embeds) ) {
		//check what is the first embed containg video tag, youtube or vimeo
		foreach( $embeds as $embed ) {
			if( strpos( $embed, 'video' ) || strpos( $embed, 'youtube' ) || strpos( $embed, 'vimeo' ) ) {
				return $embed;
			}
		}
	} else {
		//No video embedded found
		return false;
	}
	 
}

/**
 * Filter for the_category function
 * Filter for the_category function
 *
 * @since 1.0.0
 * @param string the return string
 * @return string the string that separates each category
 */

function vertex_the_category_filter($return,$separator=' ') {

    if( is_home() || is_front_page() ) {

        //list the category names to exclude
        $exclude = array('featured','slide');

        $cats = explode($separator,$return);
        $newlist = array();
        foreach($cats as $cat) {
            $catname = trim(strip_tags($cat));
            if(!in_array($catname,$exclude))
                $newlist[] = $cat;
        }
        return implode($separator,$newlist);
    } else
        return $return;
}

add_filter('the_category','vertex_the_category_filter',10,2);