<?php
/*  
 * section BLOG
 */					 			
			
   	$wp_customize->add_section( 'tesseract_blog' , array(
    	'title'      		=> __('Blog Post Options', 'tesseract'),
    	'priority'   		=> 1,
		'panel' 			=> 'tesseract_layout'
	) );						
			
		$wp_customize->add_setting( 'tesseract_blog_content', array(
				'sanitize_callback' => 'tesseract_blog_sanitize_content',
				'default'			=> 'excerpt'				
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_content_control',
					array(
						'label'          => __( 'Choose the article content type', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_content',
						'type'           => 'radio',
						'choices'        => array(
							'excerpt'  	=> 'Excerpt',
							'content' 	=> 'Full Content',
							'titleonly' 	=> 'Title Only'
						),
						'priority' 		 => 1										
					)
				)
			);
			
	$wp_customize->add_setting( 'tesseract_blog_post_layout', array(
				'sanitize_callback' => 'tesseract_sanitize_select_blog_post_layout_types',
				'default' 			=> 'sidebar-left'
		) );

			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_post_layout_control',
					array(
						'label'         => __( 'Choose a layout type for the Blog Post page', 'tesseract' ),
						'section'       => 'tesseract_blog',
						'settings'      => 'tesseract_blog_post_layout',
						'type'          => 'select',
						'default'       => 'sidebar-left',
						'choices'		=> array(
							'sidebar-left'  	=> 	'Left Sidebar',
							'sidebar-right'  	=> 	'Right Sidebar',
							'fullwidth'			=>  'Full Width'
						),
						'priority' 		=> 2
					)
				)
			);
			
		$wp_customize->add_setting( 'tesseract_blog_display_featimg', array(
				'sanitize_callback' => 'tesseract_sanitize_checkbox',
				'default'			=> 0				
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_display_featimg_control',
					array(
						'label'          => __( 'Display posts\' featured image on the blog page', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_display_featimg',
						'type'           => 'checkbox',
						'priority' 		 => 3	
					)
				)
			);	
			
		$wp_customize->add_setting( 'tesseract_blog_featimg_pos', array(
			'sanitize_callback' => 'tesseract_blog_sanitize_featimg_pos',
			'default' 			=> 'above'
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_featimg_pos_control',
					array(
						'label'          => __( 'Choose the featured image position', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_featimg_pos',
						'type'           => 'radio',
						'choices'        => array(
							'above'  	=> 'Above the post title',
							'below' 	=> 'Below the post title',								
							'left'      =>  'left of the content',						
							'right'     =>  'right of the content'
						),
						'priority' 		 => 4,
						'active_callback' 	=> 'tesseract_blog_featimg_sizes_enable'										
					)
				)
			);				
	    
		$wp_customize->add_setting( 'tesseract_blog_date', array(
				'sanitize_callback' => 'tesseract_blog_sanitize_date',
				'default'			=> 'showdate'				
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_date_control',
					array(
						'label'          => __( 'Choose to Show or Hide Date', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_date',
						'type'           => 'radio',
						'choices'        => array(
							'showdate'  	=> 'Show Date',
							'hidedate' 	=> 'Hide Date'
						),
						'priority' 		 => 5										
					)
				)
			);
			
		$wp_customize->add_setting( 'tesseract_blog_author', array(
				'sanitize_callback' => 'tesseract_blog_sanitize_author',
				'default'			=> 'showauthor'				
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_author',
					array(
						'label'          => __( 'Choose to Show or Hide Author', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_author',
						'type'           => 'radio',
						'choices'        => array(
							'showauthor'  	=> 'Show Author',
							'hideauthor' 	=> 'Hide Author'
						),
						'priority' 		 => 6										
					)
				)
			);

		$wp_customize->add_setting( 'tesseract_blog_comments', array(
				'sanitize_callback' => 'tesseract_blog_sanitize_comments',
				'default'			=> 'showcomment'				
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_comments',
					array(
						'label'          => __( 'Choose to Show or Hide Comments', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_comments',
						'type'           => 'radio',
						'choices'        => array(
							'showcomment'  	=> 'Show Comments',
							'hidecomment' 	=> 'Hide Comments'
						),
						'priority' 		 => 7										
					)
				)
			);
		
		$wp_customize->add_setting( 'tesseract_blog_titlecolor', array(
				//'transport'         => 'postMessage',
				'sanitize_callback' => 'sanitize_hex_color',
				'default' 			=> '#ffffff'
		) );

		$wp_customize->add_control(
			new WP_Customize_Color_Control(
			$wp_customize,
			'tesseract_blog_titlecolor_control',
			array(
				'label'      => __( 'Post Title Color', 'tesseract' ),
				'section'    => 'tesseract_blog',
				'settings'   => 'tesseract_blog_titlecolor',
				'priority'   => 8
			) )
		);
		
		$wp_customize->add_setting( "tesseract_blog_button_txt", array(
				'transport'         => 'postMessage',
				'sanitize_callback' => 'esc_html'
		));

		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				"tesseract_blog_button_txt_control",
				array(
					'label'          => __( 'Read More Button text', 'tesseract' ),
					'section'        => 'tesseract_blog',
					'settings'       => 'tesseract_blog_button_txt',
					'type'           => 'text',
					'priority' 		 => 9
				)
			)
		);
		
		$wp_customize->add_setting( 'tesseract_blog_buttoncolor', array(
				'transport'         => 'postMessage',
				'sanitize_callback' => 'sanitize_hex_color',
				'default' 			=> '#ffffff'
		) );

		$wp_customize->add_control(
			new WP_Customize_Color_Control(
			$wp_customize,
			'tesseract_blog_buttoncolor_control',
			array(
				'label'      => __( 'Read More Button Text Color', 'tesseract' ),
				'section'    => 'tesseract_blog',
				'settings'   => 'tesseract_blog_buttoncolor',
				'priority'   => 10
			) )
		);
		
		$wp_customize->add_setting( 'tesseract_blog_buttonbgcolor', array(
				'transport'         => 'postMessage',
				'sanitize_callback' => 'tesseract_sanitize_rgba',
				'default' 			=> '#fffff'
		) );

		$wp_customize->add_control(
			new WP_Customize_Color_Control(
			$wp_customize,
			'tesseract_blog_buttonbgcolor_control',
			array(
				'label'      => __( 'Read More Button Color', 'tesseract' ),
				'section'    => 'tesseract_blog',
				'settings'   => 'tesseract_blog_buttonbgcolor',
				'priority'   => 11
			) )
		);
		
		$wp_customize->add_setting( 'tesseract_blog_button_size', array(
			'sanitize_callback' => 'tesseract_blog_sanitize_button_size',
			'default' 			=> 'medium'
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'tesseract_blog_button_size_control',
				array(
					'label'          => __( 'Choose the Read More Button size', 'tesseract' ),
					'section'        => 'tesseract_blog',
					'settings'       => 'tesseract_blog_button_size',
					'type'           => 'radio',
					'choices'        => array(							
						'small'      =>  'Small size Button',						
						'medium'     =>  'Medium size Button',
						'large'      =>  'Large size Button',
						'textonly'   =>  'Show Only Button Text',
					),
					'priority' 		 => 12,
					//'active_callback' 	=> 'tesseract_blog_featimg_sizes_enable'										
				)
			)
		);
		
		/*$wp_customize->add_setting( 'tesseract_blog_button_textonly', array(
			'sanitize_callback' => 'tesseract_blog_sanitize_button_textonly',
			'default' 			=> 'textbutton'
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'tesseract_blog_button_textonly_control',
				array(
					'label'          => __( 'Text Only Button', 'tesseract' ),
					'section'        => 'tesseract_blog',
					'settings'       => 'tesseract_blog_button_textonly',
					'type'           => 'radio',
					'choices'        => array(							
						'textonly'      =>  'Show Only Button Text',						
						'textbutton'     =>  'Show Text with Button'
					),
					'priority' 		 => 13,										
				)
			)
		);*/
		
		
		$wp_customize->add_setting( "tesseract_blog_button_radius", array(
				'transport'         => 'postMessage',
				'sanitize_callback' => 'esc_html'
		));

		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				"tesseract_blog_button_radius_control",
				array(
					'label'          => __( 'Read More Button radius for Rounded Corner', 'tesseract' ),
					'section'        => 'tesseract_blog',
					'settings'       => 'tesseract_blog_button_radius',
					'type'           => 'text',
					'priority' 		 => 14
				)
			)
		);
		
		
		
		$wp_customize->add_setting( 'tesseract_blog_button_pos', array(
			'sanitize_callback' => 'tesseract_blog_sanitize_button_pos',
			'default' 			=> 'left'
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'tesseract_blog_button_pos_control',
				array(
					'label'          => __( 'Choose the Read More Button position', 'tesseract' ),
					'section'        => 'tesseract_blog',
					'settings'       => 'tesseract_blog_button_pos',
					'type'           => 'radio',
					'choices'        => array(							
						'left'      =>  'left of the content',						
						'right'     =>  'right of the content',
						'center'     =>  'center of the content'
					),
					'priority' 		 => 15,
					//'active_callback' 	=> 'tesseract_blog_featimg_sizes_enable'										
				)
			)
		);
		
		
		
		/*$wp_customize->add_setting( 'tesseract_blog_featimg_size', array(
			'sanitize_callback' => 'tesseract_blog_sanitize_featimg_size',
			'default' 			=> 'default'
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_featimg_size_control',
					array(
						'label'          => __( 'Choose the featured image ratio', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_featimg_size',
						'type'           => 'radio',
						'choices'        => array(
							'default'  	=> '1:1 (Default width/height ratio)',
							'tv' 		=> '4:3',
							'hdtv' 		=> '16:9',
							'theater1' 	=> '1.85:1',
							'theater2' 	=> '2.35:1',
							'pixel' 	=> 'I use my own pixel value'
						),
						'priority' 		 => 5,
						'active_callback' 	=> 'tesseract_blog_featimg_sizes_enable'										
					)
				)
			);	
			
		$wp_customize->add_setting( 'tesseract_blog_featimg_px_size', array(
			'sanitize_callback' => 'absint'
		) );
		
			$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_blog_featimg_px_size_control',
					array(
						'label'          => __( 'Featured image height in pixels', 'tesseract' ),
						'section'        => 'tesseract_blog',
						'settings'       => 'tesseract_blog_featimg_px_size',
						'type'           => 'text',
						'priority' 		 => 6,
						'active_callback' 	=> 'tesseract_blog_featimg_px_size_enable'										
					)
				)
			);	*/					
				
