<?php
/**
 *	Setup
 */
if( !function_exists( 'paraxis_lite_setup' ) ) {
	add_action( 'after_setup_theme', 'paraxis_lite_setup' );
	function paraxis_lite_setup() {
		
		// Customizer
		require_once( trailingslashit( get_stylesheet_directory() ) .'includes/customizer.php' );

		// Styles
 		require_once( trailingslashit( get_stylesheet_directory() ) . 'includes/styles.php' );
	}
}

// Custom Header
require_once(  trailingslashit( get_stylesheet_directory() ) . 'includes/custom-header.php' );

/**
 *	Enqueue Styles
 */
if( !function_exists( 'paraxis_lite_enqueue_styles' ) ) {
	add_action( 'wp_enqueue_scripts', 'paraxis_lite_enqueue_styles' );
	function paraxis_lite_enqueue_styles() {
	    wp_enqueue_style( 'oblique-style', get_template_directory_uri() . '/style.css' );
	    wp_enqueue_style( 'paraxis-lite-style', get_stylesheet_directory_uri() . '/style.css', array( 'oblique-style' ) );
	}
}

/**
 *	Customize Controls Enqueue Scripts
 */
if( !function_exists( 'paraxis_lite_customize_controls_enqueue_scripts' ) ) {
	add_action( 'customize_controls_enqueue_scripts', 'paraxis_lite_customize_controls_enqueue_scripts' );
	function paraxis_lite_customize_controls_enqueue_scripts() {
		wp_enqueue_script( 'paraxis-lite-customizer', get_stylesheet_directory_uri() . '/assets/js/paraxis-lite-customizer.js', array( 'jquery' ), '20120206', true  );
	}
}