<?php

$global_settings = FLBuilderModel::get_global_settings();

FLBuilder::register_settings_form('module_advanced', array(
	'title'         => __('Advanced', 'fl-builder'),
	'sections'      => array(
		'margins'       => array(
			'title'         => __('Margins', 'fl-builder'),
			'fields'        => array(
				'margin_top' => array(
					'type'        => 'unit',
					'label'       => __( 'Top', 'fl-builder' ),
					'description' => 'px',
					'preview'     => array(
						'type' => 'none',
					),
					'responsive'  => array(
						'placeholder' => array(
							'default'    => ( isset( $global_settings->module_margins ) ) ? $global_settings->module_margins : '',
							'medium'     => ( isset( $global_settings->module_margins_medium ) ) ? $global_settings->module_margins_medium : '',
							'responsive' => ( isset( $global_settings->module_margins_responsive ) ) ? $global_settings->module_margins_responsive : '',
						)
					)
				),
				'margin_bottom' => array(
					'type'        => 'unit',
					'label'       => __( 'Bottom', 'fl-builder' ),
					'description' => 'px',
					'preview'     => array(
						'type' => 'none',
					),
					'responsive'  => array(
						'placeholder' => array(
							'default'    => ( isset( $global_settings->module_margins ) ) ? $global_settings->module_margins : '',
							'medium'     => ( isset( $global_settings->module_margins_medium ) ) ? $global_settings->module_margins_medium : '',
							'responsive' => ( isset( $global_settings->module_margins_responsive ) ) ? $global_settings->module_margins_responsive : '',
						)
					)
				),
				'margin_left' => array(
					'type'        => 'unit',
					'label'       => __( 'Left', 'fl-builder' ),
					'description' => 'px',
					'preview'     => array(
						'type' => 'none',
					),
					'responsive'  => array(
						'placeholder' => array(
							'default'    => ( isset( $global_settings->module_margins ) ) ? $global_settings->module_margins : '',
							'medium'     => ( isset( $global_settings->module_margins_medium ) ) ? $global_settings->module_margins_medium : '',
							'responsive' => ( isset( $global_settings->module_margins_responsive ) ) ? $global_settings->module_margins_responsive : '',
						)
					)
				),
				'margin_right' => array(
					'type'        => 'unit',
					'label'       => __( 'Right', 'fl-builder' ),
					'description' => 'px',
					'preview'     => array(
						'type' => 'none',
					),
					'responsive'  => array(
						'placeholder' => array(
							'default'    => ( isset( $global_settings->module_margins ) ) ? $global_settings->module_margins : '',
							'medium'     => ( isset( $global_settings->module_margins_medium ) ) ? $global_settings->module_margins_medium : '',
							'responsive' => ( isset( $global_settings->module_margins_responsive ) ) ? $global_settings->module_margins_responsive : '',
						)
					)
				),
			)
		),
		'responsive'   => array(
			'title'         => __('Responsive Layout', 'fl-builder'),
			'fields'        => array(
				'responsive_display' => array(
					'type'          => 'select',
					'label'         => __('Display', 'fl-builder'),
					'options'       => array(
						''                  => __('Always', 'fl-builder'),
						'desktop'           => __('Large Devices Only', 'fl-builder'),
						'desktop-medium'    => __('Large &amp; Medium Devices Only', 'fl-builder'),
						'medium'            => __('Medium Devices Only', 'fl-builder'),
						'medium-mobile'     => __('Medium &amp; Small Devices Only', 'fl-builder'),
						'mobile'            => __('Small Devices Only', 'fl-builder'),
					),
					'help'          => __( 'Choose whether to show or hide this module at different device sizes.', 'fl-builder' ),
					'preview'         => array(
						'type'            => 'none'
					)
				),
			)
		),
		'visibility'   => array(
			'title'         => __('Visibility', 'fl-builder'),
			'fields'        => array(
				'visibility_display' => array(
					'type'          => 'select',
					'label'         => __('Display', 'fl-builder'),
					'options'       => array(
						''				=> __('Always', 'fl-builder'),
						'logged_out'    => __('Logged Out User', 'fl-builder'),
						'logged_in'     => __('Logged In User', 'fl-builder'),
						'0'             => __('Never', 'fl-builder'),
					),
					'toggle' 		=> array(
						'logged_in'		=> array(
							'fields' 		=> array('visibility_user_capability')
						)
					),
					'preview'         => array(
						'type'            => 'none'
					)
				),
				'visibility_user_capability' => array(
					'type' 						=> 'text',
					'label'						=> __('User Capability', 'fl-builder'),
					'description'  	 			=> sprintf( __( 'Optional. Set the <a%s>capability</a> required for users to view this module.', 'fl-builder' ), ' href="http://codex.wordpress.org/Roles_and_Capabilities#Capability_vs._Role_Table" target="_blank"' ),
					'preview'         			=> array(
						'type'            			=> 'none'
					),
				)
			)
		),
		'animation'    => array(
			'title'         => __('Animation', 'fl-builder'),
			'fields'        => array(
				'animation'     => array(
					'type'          => 'select',
					'label'         => __('Style', 'fl-builder'),
					'options'       => array(
						''              => _x( 'None', 'Animation style.', 'fl-builder' ),
						'fade-in'       => _x( 'Fade In', 'Animation style.', 'fl-builder' ),
						'slide-left'    => _x( 'Slide Left', 'Animation style.', 'fl-builder' ),
						'slide-right'   => _x( 'Slide Right', 'Animation style.', 'fl-builder' ),
						'slide-up'      => _x( 'Slide Up', 'Animation style.', 'fl-builder' ),
						'slide-down'    => _x( 'Slide Down', 'Animation style.', 'fl-builder' ),
					),
					'preview'         => array(
						'type'            => 'none'
					)
				),
				'animation_delay' => array(
					'type'          => 'text',
					'label'         => __('Delay', 'fl-builder'),
					'default'       => '0.0',
					'maxlength'     => '4',
					'size'          => '5',
					'description'   => _x( 'seconds', 'Value unit for form field of time in seconds. Such as: "5 seconds"', 'fl-builder' ),
					'help'          => __('The amount of time in seconds before this animation starts.', 'fl-builder'),
					'preview'         => array(
						'type'            => 'none'
					)
				)
			)
		),
		'css_selectors' => array(
			'title'         => __('CSS Selectors', 'fl-builder'),
			'fields'        => array(
				'id'            => array(
					'type'          => 'text',
					'label'         => __('ID', 'fl-builder'),
					'help'          => __( "A unique ID that will be applied to this module's HTML. Must start with a letter and only contain dashes, underscores, letters or numbers. No spaces.", 'fl-builder' ),
					'preview'         => array(
						'type'            => 'none'
					)
				),
				'class'         => array(
					'type'          => 'text',
					'label'         => __('Class', 'fl-builder'),
					'help'          => __( "A class that will be applied to this module's HTML. Must start with a letter and only contain dashes, underscores, letters or numbers. Separate multiple classes with spaces.", 'fl-builder' ),
					'preview'         => array(
						'type'            => 'none'
					)
				)
			)
		)
	)
));
