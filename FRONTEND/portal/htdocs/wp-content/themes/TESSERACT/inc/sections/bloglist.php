<?php
/*  
 * section BLOGLIST
 */					 			
			
   	$wp_customize->add_section( 'tesseract_bloglist' , array(
    	'title'      		=> __('Blog List Options', 'tesseract'),
    	'priority'   		=> 3,
		'panel' 			=> 'tesseract_layout'
	) );
$wp_customize->add_setting( 'tesseract_bloglist_content', array(
				'sanitize_callback' => 'tesseract_blog_sanitize_content',
				'default'			=> 'excerpt'				
		) );
$wp_customize->add_control(
				new WP_Customize_Control(
					$wp_customize,
					'tesseract_bloglist_content_control',
					array(
						'label'          => __( 'Choose the article content type', 'tesseract' ),
						'section'        => 'tesseract_bloglist',
						'settings'       => 'tesseract_bloglist_content',
						'type'           => 'radio',
						'choices'        => array(
							'excerpt'  	=> 'Excerpt',
							'content' 	=> 'Full Content'
						),
						'priority' 		 => 1										
					)
				)
			);	
?>