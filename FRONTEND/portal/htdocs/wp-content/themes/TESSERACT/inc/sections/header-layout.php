<?php
/*
 * section HEADER LAYOUT
 */
if ( is_plugin_active( 'tesseractplus-plugin/fl-builder.php' ) ) {
   	$wp_customize->add_section( 'tesseract_header_layouts' , array(
    	'title'      => __('Header Layout', 'tesseract'),
    	'priority'   => 1,
		'panel'      => 'tesseract_header_options'
	) );


		$wp_customize->add_setting( 'tesseract_header_layout_setting', array(
				'sanitize_callback' => 'tesseract_sanitize_select_header_layout_types',
				'default' 			=> 'defaultlayout'
		) );

			$wp_customize->add_control(
				new WP_Customize_Control(
				$wp_customize,
				'tesseract_header_layout_setting_control',
				array(
					'label'      => __( 'Header Layout Option', 'tesseract' ),
					'section'    => 'tesseract_header_layouts',
					'settings'   => 'tesseract_header_layout_setting',
					'type'          => 'select',
					'default'       => 'defaultlayout',
					'choices'		=> array(
						'none'  	                => 	'None',
						'navbottom'        			=> 	'Nav Bottom',
						'navright'			    	=>  'Nav Right & Logo Left',
						'navleft'			    	=>  'Nav Left & Logo Right',
						'navcentered'				=>  'Nav Centered',
						'vertical-left'				=>  'Nav Vertical Left',
						'vertical-right'			=>  'Nav Vertical Right',
						'defaultlayout'			    =>  'Default'
						),
					'priority'   => 1
				) )
			);
		
		$wp_customize->add_setting( 'inline_logo_side', array(
				'sanitize_callback' => 'tesseract_sanitize_inline_logo_side',
				'default' 			=> 'inlineright'
		) );

		
		
		$wp_customize->add_setting( 'tesseract_vertical_header_width', array(
			'transport'         => 'postMessage',
			'sanitize_callback' => 'absint',
			'default' 			=> 230
		) );			
		
			$wp_customize->add_control( 'tesseract_vertical_header_width_control', array(
				'type'        		=> 'range',
				'priority'    		=> 1,
				'section'     		=> 'tesseract_header_layouts',
				'settings'     		=> 'tesseract_vertical_header_width',
				'label'       		=> 'Vertical Nav Width',
				'description' 		=> 'Use this range slider to set Vertical Nav Width',
				'input_attrs' 		=> array(
					'min'   => 200,
					'max'   => 400,
					'step'  => 1,
					'class' => 'tesseract-header-height',
					'style' => 'color: #0a0',
				),
				'priority' 			=> 1,
				'active_callback' 	=> 'tesseract_vertical_header_width_enable'
			) );
			
		
		$wp_customize->add_setting( 'tesseract_header_height', array(
			'transport'         => 'postMessage',
			'sanitize_callback' => 'absint',
			'default' 			=> 10
		) );			
		
			$wp_customize->add_control( 'tesseract_header_height_control', array(
				'type'        		=> 'range',
				'priority'    		=> 2,
				'section'     		=> 'tesseract_header_layouts',
				'settings'     		=> 'tesseract_header_height',
				'label'       		=> 'Header Padding',
				'description' 		=> 'Use this range slider to set header height',
				'input_attrs' 		=> array(
					'min'   => 0,
					'max'   => 50,
					'step'  => 5,
					'class' => 'tesseract-header-height',
					'style' => 'color: #0a0',
				),
				'priority' 			=> 2
			) );
};			