<?php
/**
 *	@link https://developer.wordpress.org/themes/functionality/custom-headers/
 *
 *	@package WordPress
 *	@subpackage paraxis-lite
 */
?>
<?php
remove_action( 'after_setup_theme', 'oblique_custom_header_setup' );

if( !function_exists( 'paraxis_lite_custom_header' ) ) {
	add_action( 'after_setup_theme', 'paraxis_lite_custom_header' );
	function paraxis_lite_custom_header() {
		$args = array(
			'default-text-color'	=> '444',
			'default-image'			=> get_stylesheet_directory_uri() . '/assets/images/image1.jpg',
			'height'				=> 650,
			'width'					=> 1920,
			'max-width'				=> 2000,
			'flex-height'			=> true,
			'wp-head-callback'       => 'oblique_header_style',
			'admin-head-callback'    => 'oblique_admin_header_style',
			'admin-preview-callback' => 'oblique_admin_header_image',
		);

		add_theme_support( 'custom-header', $args );
	}
}