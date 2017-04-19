<?php

/**
 * Kirki Advanced Customizer
 * This is a sample configuration file to demonstrate all fields & capabilities.
 * @package eleganto
 */
// Early exit if Kirki is not installed
if ( !class_exists( 'Kirki' ) ) {
	return;
}
/* Register Kirki config */
Kirki::add_config( 'eleganto_settings', array(
	'capability'	 => 'edit_theme_options',
	'option_type'	 => 'theme_mod',
) );


/**
 * Add sections
 */
Kirki::add_section( 'sidebar_section', array(
	'title'			 => __( 'Sidebars', 'eleganto' ),
	'priority'		 => 10,
	'description'	 => __( 'Sidebar layouts.', 'eleganto' ),
) );

Kirki::add_section( 'layout_section', array(
	'title'			 => __( 'Main styling', 'eleganto' ),
	'priority'		 => 10,
	'description'	 => __( 'Define theme layout', 'eleganto' ),
) );

Kirki::add_section( 'social_icons_section', array(
	'title'		 => __( 'Social icons', 'eleganto' ),
	'priority'	 => 10,
) );

Kirki::add_section( 'post_section', array(
	'title'			 => __( 'Post settings', 'eleganto' ),
	'priority'		 => 10,
	'description'	 => __( 'Single post settings', 'eleganto' ),
) );

Kirki::add_section( 'site_bg_section', array(
	'title'		 => __( 'Site Background', 'eleganto' ),
	'priority'	 => 10,
) );

/**
 * Homepage Settings
 */
if ( !function_exists( 'eleganto_advanced_sections' ) ) {
	Kirki::add_section( 'plugin_deactivated', array(
		'title'		 => __( 'Homepage Settings', 'eleganto' ),
		'priority'	 => 1,
	) );
	Kirki::add_field( 'eleganto_settings', array(
		'type'			 => 'custom',
		'settings'		 => 'disabled-plugin',
		'label'			 => __( 'Eleganto Advanced Sections are Deactivated', 'eleganto' ),
		'description'	 => __( 'In order to use and setup the homepage sections, please install and activate the Eleganto Advanced Sections plugin.', 'eleganto' ),
		'section'		 => 'plugin_deactivated',
		'default'		 => '<a class="install-now button-primary button" href="' . esc_url( admin_url( 'themes.php?page=tgmpa-install-plugins' ) ) . '" aria-label="Install Eleganto Advanced Fields now" data-name="Eleganto Advanced Fields">' . __( 'Install Now', 'eleganto' ) . '</a>',
		'priority'		 => 10,
	) );
}
Kirki::add_field( 'eleganto_settings', array(
	'type'		 => 'radio-buttonset',
	'settings'	 => 'smooth_scroll',
	'label'		 => __( 'Website Smooth Scroll', 'eleganto' ),
	'section'	 => 'layout_section',
	'default'	 => 'smooth-scroll-on',
	'priority'	 => 10,
	'choices'	 => array(
		'smooth-scroll-on'	 => esc_attr__( 'Enabled', 'eleganto' ),
		'smooth-scroll-off'	 => esc_attr__( 'Disabled', 'eleganto' ),
	),
) );
/**
 * Siedebar Settings
 */
Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'switch',
	'settings'		 => 'rigth-sidebar-check',
	'label'			 => __( 'Right Sidebar', 'eleganto' ),
	'description'	 => __( 'Enable the Right Sidebar', 'eleganto' ),
	'section'		 => 'sidebar_section',
	'default'		 => 1,
	'priority'		 => 10,
) );

Kirki::add_field( 'eleganto_settings', array(
	'type'		 => 'radio-buttonset',
	'settings'	 => 'right-sidebar-size',
	'label'		 => __( 'Right Sidebar Size', 'eleganto' ),
	'section'	 => 'sidebar_section',
	'default'	 => '3',
	'priority'	 => 10,
	'choices'	 => array(
		'1'	 => '1',
		'2'	 => '2',
		'3'	 => '3',
		'4'	 => '4',
		'5'	 => '5'
	),
	'required'	 => array(
		array(
			'setting'	 => 'rigth-sidebar-check',
			'operator'	 => '==',
			'value'		 => 1,
		),
	)
) );

Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'switch',
	'settings'		 => 'left-sidebar-check',
	'label'			 => __( 'Left Sidebar', 'eleganto' ),
	'description'	 => __( 'Enable the Left Sidebar', 'eleganto' ),
	'section'		 => 'sidebar_section',
	'default'		 => 0,
	'priority'		 => 10,
) );

Kirki::add_field( 'eleganto_settings', array(
	'type'		 => 'radio-buttonset',
	'settings'	 => 'left-sidebar-size',
	'label'		 => __( 'Left Sidebar Size', 'eleganto' ),
	'section'	 => 'sidebar_section',
	'default'	 => '2',
	'priority'	 => 10,
	'choices'	 => array(
		'1'	 => '1',
		'2'	 => '2',
		'3'	 => '3',
		'4'	 => '4',
		'5'	 => '5'
	),
	'required'	 => array(
		array(
			'setting'	 => 'left-sidebar-check',
			'operator'	 => '==',
			'value'		 => 1,
		),
	)
) );

Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'toggle',
	'settings'		 => 'related-posts-check',
	'label'			 => __( 'Related posts', 'eleganto' ),
	'description'	 => __( 'Enable or disable related posts', 'eleganto' ),
	'section'		 => 'post_section',
	'default'		 => 1,
	'priority'		 => 10,
) );
Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'toggle',
	'settings'		 => 'author-check',
	'label'			 => __( 'Author box', 'eleganto' ),
	'description'	 => __( 'Enable or disable author box', 'eleganto' ),
	'section'		 => 'post_section',
	'default'		 => 1,
	'priority'		 => 10,
) );
Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'toggle',
	'settings'		 => 'post-nav-check',
	'label'			 => __( 'Post navigation', 'eleganto' ),
	'description'	 => __( 'Enable or disable navigation below post content', 'eleganto' ),
	'section'		 => 'post_section',
	'default'		 => 1,
	'priority'		 => 10,
) );
Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'toggle',
	'settings'		 => 'breadcrumbs-check',
	'label'			 => __( 'Breadcrumbs', 'eleganto' ),
	'description'	 => __( 'Enable or disable Breadcrumbs', 'eleganto' ),
	'section'		 => 'post_section',
	'default'		 => 1,
	'priority'		 => 10,
) );
Kirki::add_field( 'eleganto_settings', array(
	'type'		 => 'radio-buttonset',
	'settings'	 => 'breadcrumbs-align',
	'label'		 => __( 'Breadcrumbs align', 'eleganto' ),
	'section'	 => 'post_section',
	'default'	 => 'text-left',
	'priority'	 => 10,
	'choices'	 => array(
		'text-left'	 => __( 'Left', 'eleganto' ),
		'text-right' => __( 'Right', 'eleganto' ),
	),
	'required'	 => array(
		array(
			'setting'	 => 'breadcrumbs-check',
			'operator'	 => '==',
			'value'		 => 1,
		),
	)
) );

Kirki::add_field( 'eleganto_settings', array(
	'type'			 => 'toggle',
	'settings'		 => 'eleganto_socials',
	'label'			 => __( 'Social Icons', 'eleganto' ),
	'description'	 => __( 'Enable or Disable the social icons', 'eleganto' ),
	'section'		 => 'social_icons_section',
	'default'		 => 0,
	'priority'		 => 10,
) );
$s_social_links = array(
	'twp_social_facebook'	 => __( 'Facebook', 'eleganto' ),
	'twp_social_twitter'	 => __( 'Twitter', 'eleganto' ),
	'twp_social_google'		 => __( 'Google-Plus', 'eleganto' ),
	'twp_social_instagram'	 => __( 'Instagram', 'eleganto' ),
	'twp_social_pin'		 => __( 'Pinterest', 'eleganto' ),
	'twp_social_youtube'	 => __( 'YouTube', 'eleganto' ),
	'twp_social_reddit'		 => __( 'Reddit', 'eleganto' ),
);

foreach ( $s_social_links as $keys => $values ) {
	Kirki::add_field( 'eleganto_settings', array(
		'type'			 => 'text',
		'settings'		 => $keys,
		'label'			 => $values,
		'description'	 => sprintf( __( 'Insert your custom link to show the %s icon.', 'eleganto' ), $values ),
		'help'			 => __( 'Leave blank to hide icon.', 'eleganto' ),
		'section'		 => 'social_icons_section',
		'default'		 => '',
		'priority'		 => 10,
	) );
}

/**
 * Configuration sample for the eleganto Customizer.
 */
function eleganto_configuration_sample() {

	$config[ 'color_back' ]		 = '#192429';
	$config[ 'color_accent' ]	 = '#008ec2';
	$config[ 'width' ]			 = '25%';

	return $config;
}

add_filter( 'kirki/config', 'eleganto_configuration_sample' );
