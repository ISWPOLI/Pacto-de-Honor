<?php
/**
 *	Setup
 */
if( !function_exists( 'paraxis_lite_customizer' ) ) {
	add_action( 'customize_register', 'paraxis_lite_customizer', 50 );
	function paraxis_lite_customizer( $wp_customize ) {
		// Remove Setting & Control
		$wp_customize->remove_setting( 'branding_padding_1024' );
		$wp_customize->remove_control( 'branding_padding_1024' );
		$wp_customize->remove_setting( 'logo_style' );
		$wp_customize->remove_control( 'logo_style' );

		// Get Setting: Background Color
		$wp_customize->get_setting( 'background_color' )->default = '#ffffff';

		// Get Setting: Primary Color
		$wp_customize->get_setting( 'primary_color' )->default = '#9e005d';

		// Get Setting: Body Text Color
		$wp_customize->get_setting( 'body_text_color' )->default = '#333333';

		// Get Setting Entry Titles
		$wp_customize->get_setting( 'entry_titles' )->default = '#333333';

		// Get Setting: Entry Meta
		$wp_customize->get_setting( 'entry_meta' )->default = '#333333';

		// Get Setting: Footer Background
		$wp_customize->get_setting( 'footer_background' )->default = '#ffffff';

		// Get Setting: Social Color
		$wp_customize->get_setting( 'social_color' )->default = '#d0d0d0';

		// Get Setting: Site Logo
		$wp_customize->get_setting( 'site_logo' )->default = get_stylesheet_directory_uri() . '/assets/images/header-logo.png';

		// Get Setting: Logo Size
		$wp_customize->get_setting( 'logo_size' )->default = '450';

		// Get Setting: Branding Padding
		$wp_customize->get_setting( 'branding_padding' )->default = '232';

		// Headings Font Name
		$wp_customize->get_setting( 'headings_font_name' )->default = 'Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic';

		// Headings Font Family
		$wp_customize->get_setting( 'headings_font_family' )->default = '\'Open Sans\', sans-serif';
	}
}