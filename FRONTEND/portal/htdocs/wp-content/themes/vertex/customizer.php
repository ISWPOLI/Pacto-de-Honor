<?php

function vertex_customize_register($wp_customize){

    $wp_customize->add_section(
	'header_section',
		array( 
			'title' => __('Logo','vertex'), 
			'capability' => 'edit_theme_options', 
			'description' =>  __('Allows you to edit your theme\'s layout.','vertex')
			)
	);

	$wp_customize->add_section(
		'sm_section', 
		array( 
			'title' =>  __('Social Media','vertex'), 
			'capability' => 'edit_theme_options', 
			'description' =>  __('Allows you to set your social media URLs','vertex')
			)
	);

	$socials = array('twitter','facebook','google-plus','instagram','pinterest','linkedin','vimeo','youtube');

	for($i=0;$i<count($socials);$i++) {
		$name = str_replace('-',' ',ucfirst($socials[$i]));
		$wp_customize->add_setting('vertex_'.$socials[$i], array(
	    'capability' => 'edit_theme_options',
	    'type'       => 'theme_mod',
	    'sanitize_callback' => 'vertex_sanitize_customizer_val',
		));
		$wp_customize->add_control( new WP_Customize_Control(
			$wp_customize,
			'vertex_'.$socials[$i],
			array(
			    'settings' => 'vertex_'.$socials[$i],
			    'label'    => sprintf( __( '%s URL' ,'vertex' ), $name ),
			    'section'  => 'sm_section',
			    'type'     => 'text',
			)
		));
	}

	$wp_customize->add_section(
		'featured_text_section', 
		array( 
			'title' =>  __('Featured Text','vertex'), 
			'capability' => 'edit_theme_options', 
			'description' =>  __('Allows you to set your footer settings','vertex')
		)
	);

	$wp_customize->add_setting(
		'vertex_hometext',
		array(
		    'capability' => 'edit_theme_options',
		    'type'       => 'theme_mod',
		    'sanitize_callback' => 'vertex_sanitize_customizer_val',
		)
	);

	$wp_customize->add_control( new WP_Customize_Control(
		$wp_customize,
		'vertex_hometext',
		array(
		    'settings' => 'vertex_hometext',
		    'label'    => __('Featured Text','vertex'),
		    'section'  => 'featured_text_section',
		    'type'     => 'textarea', 
		)
	));

	$wp_customize->add_section(
		'copyright_section', 
		array( 
			'title' =>  __('Copyright Text','vertex'), 
			'capability' => 'edit_theme_options', 
			'description' =>  __('Allows you to set your footer settings','vertex')
		)
	);

	$wp_customize->add_setting(
		'vertex_copyright',
		array(
    		'capability' => 'edit_theme_options',
    		'type' => 'theme_mod',
    		'sanitize_callback' => 'vertex_sanitize_customizer_val',
		)
	);

	$wp_customize->add_control( new WP_Customize_Control(
		$wp_customize,
		'vertex_copyright',
		array(
		    'settings' => 'vertex_copyright',
		    'label'    => __('Copyright Text','vertex'),
		    'section'  => 'copyright_section',
		    'type'     => 'textarea',
		)
	));

}
add_action('customize_register', 'vertex_customize_register');

function vertex_setting($name, $default = false) {
	return get_theme_mod( $name, $default );
}

function vertex_sanitize_customizer_val($value){
	if (!filter_var($value, FILTER_VALIDATE_URL) === false) //check if URL
		return esc_url_raw($value);
	else
		return sanitize_text_field($value);
}