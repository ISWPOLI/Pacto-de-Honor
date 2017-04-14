<?php
function eleganto_advanced_sections_init_options() {
	if( class_exists( 'Kirki' ) ) {
  
  Kirki::add_config( 'eleganto_settings', array(
  	'capability'	 => 'edit_theme_options',
  	'option_type'	 => 'theme_mod',
  ) );
  
  Kirki::add_panel( 'homepage', array(
  	'priority'	 => 10,
  	'title'		 => __( 'Homepage Settings', 'eleganto-advanced-sections' ),
    'description'	 => __( 'Homepage options for Eleganto theme', 'eleganto-advanced-sections' ),
  ) );
  
  Kirki::add_section( 'homepage_layout', array(
  	'title'		 => __( 'Homepage Layout', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'slider_section', array(
  	'title'		 => __( 'Slider Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'blog_section', array(
  	'title'		 => __( 'Blog Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'carousel_section', array(
  	'title'		 => __( 'Carousel Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'portfolio_section', array(
  	'title'		 => __( 'Portfolio Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'testimonial_section', array(
  	'title'		 => __( 'Testimonial Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'image_section', array(
  	'title'		 => __( 'Image Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  Kirki::add_section( 'contact_section', array(
  	'title'		 => __( 'Contact Section Settings', 'eleganto-advanced-sections' ),
  	'panel'		 => 'homepage',
  	'priority'	 => 10,
  ) );
  
  /**
   * Homepage Layout
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'				 => 'custom',
  	'settings'			 => 'demo_page_intro',
  	'label'				 => __( 'Switch "Front page displays" to "A static page"', 'eleganto-advanced-sections' ),
  	'section'			 => 'homepage_layout',
  	'description'		 => sprintf( __( 'Your homepage is not static page. In order to set up the home page as shown in the official demo on our website (one page front page with sections), you will need to set up your front page to use a static page instead of showing your latest blog posts. Check the %s page for more informations.', 'eleganto' ), '<a href="' . admin_url( 'themes.php?page=eleganto-welcome' ) . '"><strong>' . __( 'Theme info', 'eleganto' ) . '</strong></a>' ),
  	'priority'			 => 10,
  	'active_callback'	 => array(
  		array(
  			'setting'	 => 'show_on_front',
  			'operator'	 => '!=',
  			'value'		 => 'page',
  		),
  	),
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'			 => 'switch',
  	'settings'		 => 'home_slider',
  	'label'			 => __( 'Slider', 'eleganto-advanced-sections' ),
  	'description'	 => __( 'Enable or Disable Slider on homepage', 'eleganto-advanced-sections' ),
  	'section'		 => 'homepage_layout',
  	'default'		 => '0',
  	'priority'		 => 10,
  ) );
  
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'sortable',
  	'settings'	 => 'home_layout',
  	'label'		 => esc_attr__( 'Homepage Blocks', 'eleganto-advanced-sections' ),
  	'section'	 => 'homepage_layout',
  	'help'		 => esc_attr__( 'Drag and Drop and enable the homepage blocks.', 'eleganto-advanced-sections' ),
  	'default'	 => array( 'blog_section' ),
  	'priority'	 => 10,
  	'choices'	 => array(
  		'blog_section'			 => esc_attr__( 'Blog', 'eleganto-advanced-sections' ),
  		'carousel_section'		 => esc_attr__( 'Carousel', 'eleganto-advanced-sections' ),
  		'portfolio_section'		 => esc_attr__( 'Portfolio', 'eleganto-advanced-sections' ),
  		'testimonial_section'	 => esc_attr__( 'Testimonial', 'eleganto-advanced-sections' ),
  		'contact_section'		 => esc_attr__( 'Contact', 'eleganto-advanced-sections' ),
  		'image_section'			 => esc_attr__( 'Image', 'eleganto-advanced-sections' ),
  	),
  ) );
  Kirki::add_field( 'eleganto_settings', array(
		'type'			 => 'custom',
		'settings'		 => 'pro-features',
		'label'			 => __( 'Eleganto PRO', 'eleganto-advanced-sections' ),
		'description'	 => __( 'Available in Eleganto PRO: My Team Section, Newsletter Section, WooCommerce Section, Brand Logos Section, Background Image Section, Custom Pages Sections, Google Map, Custom Colors, Google Fonts, Youtube Backgrounds, One Click Demo Import, Animations, Custom Footer Link and much more...', 'eleganto-advanced-sections' ),
		'section'		 => 'homepage_layout',
		'default'		 => '<a class="install-now button-primary button" href="' . esc_url( 'http://themes4wp.com/product/eleganto-pro/' ) . '" aria-label="Eleganto PRO" data-name="Eleganto PRO">' . __( 'Discover Eleganto PRO', 'eleganto-advanced-sections' ) . '</a>',
		'priority'		 => 10,
	) );
  
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'repeater',
  	'label'		 => __( 'Slider', 'eleganto-advanced-sections' ),
  	'section'	 => 'slider_section',
  	'priority'	 => 10,
  	'settings'	 => 'repeater_slider',
    'sanitize_callback' => 'esc_attr',
  	'default'	 => array(),
  	'fields'	 => array(
  		'slider_image'	 => array(
  			'type'		 => 'image',
  			'label'		 => __( 'Image', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'slider_title'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Title', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'slider_desc'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Description', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'slider_url'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'URL', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  	),
    'row_label'			 => array(
  		'type'	 => 'text',
  		'value'	 => __( 'Slide', 'eleganto-advanced-sections' ),
  	),
  ) );
  
  /**
   * Sections base settings
   */
  $sections = array(
  	'carousel'		 => array(
  		'color'		 => '#f90031',
  		'menu'		 => 'Carousel',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  	'blog'			 => array(
  		'color'		 => '#FF9100',
  		'menu'		 => 'Blog',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  	'portfolio'		 => array(
  		'color'		 => '#00ff33',
  		'menu'		 => 'Portfolio',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  	'testimonial'	 => array(
  		'color'		 => '#009BFF',
  		'menu'		 => 'Testimonial',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  	'contact'		 => array(
  		'color'		 => '#353535',
  		'menu'		 => 'Contact',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  	'image'			 => array(
  		'color'		 => '#ffd800',
  		'menu'		 => 'Image',
  		'intro-img'	 => '',
  		'intro-on'	 => 0,
  	),
  );
  
  foreach ( $sections as $keys => $values ) {
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'			 => 'toggle',
  		'settings'		 => $keys . '_intro_enable',
  		'label'			 => __( 'Section Intro', 'eleganto-advanced-sections' ),
  		'description'	 => __( 'Enable or disable section intro', 'eleganto-advanced-sections' ),
  		'section'		 => $keys . '_section',
  		'default'		 => $values[ 'intro-on' ],
  		'priority'		 => 10,
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'text',
  		'settings'	 => $keys . '_intro_title',
  		'label'		 => __( 'Intro Title', 'eleganto-advanced-sections' ),
      'sanitize_callback' => 'esc_attr',
  		'default'	 => '',
  		'section'	 => $keys . '_section',
  		'priority'	 => 10,
  		'required'	 => array(
  			array(
  				'setting'	 => $keys . '_intro_enable',
  				'operator'	 => '==',
  				'value'		 => 1,
  			),
  		)
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'text',
  		'settings'	 => $keys . '_intro_desc',
  		'label'		 => __( 'Intro Description', 'eleganto-advanced-sections' ),
      'sanitize_callback' => 'esc_attr',
  		'default'	 => '',
  		'section'	 => $keys . '_section',
  		'priority'	 => 10,
  		'required'	 => array(
  			array(
  				'setting'	 => $keys . '_intro_enable',
  				'operator'	 => '==',
  				'value'		 => 1,
  			),
  		)
  	) );
    Kirki::add_field( 'eleganto_settings', array(
    	'type'        => 'color',
    	'settings'    => $keys . '_intro_img_color',
    	'label'       => __( 'Intro Background Color', 'eleganto-advanced-sections' ),
    	'section'	 => $keys . '_section',
    	'default'     => '#FFFFFF',
    	'priority'    => 10,
      'output'	 => array(
  			array(
  				'element'	 => '#' . $keys . '_section .intro .prlx',
  				'property'	 => 'background-color',
  			),
  		),
      'required'	 => array(
  			array(
  				'setting'	 => $keys . '_intro_enable',
  				'operator'	 => '==',
  				'value'		 => 1,
  			),
  		)
    ) );
    Kirki::add_field( 'eleganto_settings', array(
    	'type'        => 'image',
    	'settings'    => $keys . '_intro_img_image',
    	'label'       => __( 'Intro Background Image', 'eleganto-advanced-sections' ),
    	'section'	 => $keys . '_section',
    	'default'     => $values[ 'intro-img' ],
    	'priority'    => 10,
      'required'	 => array(
  			array(
  				'setting'	 => $keys . '_intro_enable',
  				'operator'	 => '==',
  				'value'		 => 1,
  			),
  		)
    ) );

  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'color',
  		'settings'	 => $keys . '_section_color',
  		'label'		 => __( 'Section Background Color', 'eleganto-advanced-sections' ),
  		'section'	 => $keys . '_section',
  		'default'	 => $values[ 'color' ],
  		'priority'	 => 10,
  		'output'	 => array(
  			array(
  				'element'	 => '#' . $keys . '_section .section, #main-navigation .nav a.nav-' . $keys . '_section:after, #' . $keys . '_section .sub-title span',
  				'property'	 => 'background-color',
  			),
  			array(
  				'element'	 => '#' . $keys . '_section .border-top, #' . $keys . '_section .border-bottom',
  				'property'	 => 'border-color',
  			),
  		),
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'color',
  		'settings'	 => $keys . '_section_font_color',
  		'label'		 => __( 'Section Font Color', 'eleganto-advanced-sections' ),
  		'section'	 => $keys . '_section',
  		'default'	 => '#ffffff',
  		'priority'	 => 10,
  		'output'	 => array(
  			array(
  				'element'	 => '#' . $keys . '_section .section, #' . $keys . '_section .section a, #main-navigation .nav a.nav-' . $keys . '_section:hover, #main-navigation .nav a.nav-' . $keys . '_section.active',
  				'property'	 => 'color',
  			),
  			array(
  				'element'	 => '#' . $keys . '_section .sub-title:before',
  				'property'	 => 'background-color',
  			),
  		),
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'text',
  		'settings'	 => $keys . '_section_title',
  		'label'		 => __( 'Section Title', 'eleganto-advanced-sections' ),
      'sanitize_callback' => 'esc_attr',
  		'default'	 => '',
  		'section'	 => $keys . '_section',
  		'priority'	 => 10,
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'text',
  		'settings'	 => $keys . '_section_desc',
  		'label'		 => __( 'Section Description', 'eleganto-advanced-sections' ),
      'sanitize_callback' => 'esc_attr',
  		'default'	 => '',
  		'section'	 => $keys . '_section',
  		'priority'	 => 10,
  	) );
  	Kirki::add_field( 'eleganto_settings', array(
  		'type'		 => 'text',
  		'settings'	 => $keys . '_section_menu_title',
  		'label'		 => __( 'Main Menu Title', 'eleganto-advanced-sections' ),
  		'default'	 => $values[ 'menu' ],
  		'section'	 => $keys . '_section',
  		'priority'	 => 10,
  	) );
  }
  
  /**
   * Blog Section
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'slider',
  	'settings'	 => 'blog_section_number_posts',
  	'label'		 => __( 'Number of Posts', 'eleganto-advanced-sections' ),
  	'section'	 => 'blog_section',
  	'default'	 => 3,
  	'priority'	 => 10,
  	'choices'	 => array(
  		'min'	 => 1,
  		'max'	 => 20,
  		'step'	 => 1
  	),
  ) );
  
  /**
   * Carousel Section
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'repeater',
  	'label'		 => __( 'Carousel Items', 'eleganto-advanced-sections' ),
  	'section'	 => 'carousel_section',
  	'priority'	 => 10,
  	'settings'	 => 'repeater_carousel',
    'sanitize_callback' => 'esc_attr',
  	'default'	 => array(),
  	'fields'	 => array(
  		'carousel_image' => array(
  			'type'		 => 'image',
  			'label'		 => __( 'Image', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'carousel_title' => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Title', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'carousel_desc'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Description', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'carousel_url'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'URL', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  	),
    'row_label'			 => array(
  		'type'	 => 'text',
  		'value'	 => __( 'Carousel Item', 'eleganto-advanced-sections' ),
  	),
  ) );
  
  /**
   * Portfolio Section
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'slider',
  	'settings'	 => 'portfolio_section_number_posts',
  	'label'		 => __( 'Number of Posts', 'eleganto-advanced-sections' ),
  	'section'	 => 'portfolio_section',
  	'default'	 => 8,
  	'priority'	 => 10,
  	'choices'	 => array(
  		'min'	 => 1,
  		'max'	 => 40,
  		'step'	 => 1
  	),
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'radio-buttonset',
  	'settings'	 => 'portfolio_section_size',
  	'label'		 => __( 'Number of columns in row', 'eleganto-advanced-sections' ),
  	'section'	 => 'portfolio_section',
  	'default'	 => '3',
  	'priority'	 => 10,
  	'choices'	 => array(
  		'6'	 => '2',
  		'4'	 => '3',
  		'3'	 => '4',
  	),
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'radio-buttonset',
  	'settings'	 => 'portfolio_section_animation',
  	'label'		 => __( 'Portfolio Animation', 'eleganto-advanced-sections' ),
  	'section'	 => 'portfolio_section',
  	'default'	 => 'lily',
  	'priority'	 => 10,
  	'choices'	 => eas_portfolio_animation(),
  ) );
  
  /**
   * Testimonial Section
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'repeater',
  	'label'		 => __( 'Carousel Items', 'eleganto-advanced-sections' ),
  	'section'	 => 'testimonial_section',
  	'priority'	 => 10,
  	'settings'	 => 'repeater_testimonial',
  	'default'	 => array(),
  	'fields'	 => array(
  		'testimonial_image'	 => array(
  			'type'		 => 'image',
  			'label'		 => __( 'Photo', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'testimonial_name'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Name', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'testimonial_desc'	 => array(
  			'type'		 => 'textarea',
  			'label'		 => __( 'Testimonial', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  		'testimonial_url'	 => array(
  			'type'		 => 'text',
  			'label'		 => __( 'Link', 'eleganto-advanced-sections' ),
  			'default'	 => '',
  		),
  	),
    'row_label'			 => array(
  		'type'	 => 'text',
  		'value'	 => __( 'Testimonial', 'eleganto-advanced-sections' ),
  	),
  ) );
  
  /**
   * Contact Section
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'			 => 'select',
  	'settings'		 => 'conatact_form',
  	'label'			 => __( 'Contact Form', 'eleganto-advanced-sections' ),
  	'description'	 => __( 'Select form from Contact Form 7 plugin', 'eleganto-advanced-sections' ),
  	'section'		 => 'contact_section',
  	'default'		 => '',
  	'priority'		 => 10,
  	'choices'		 => eas_cf7_array_for_scg(),
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'textarea',
  	'settings'	 => 'conatact_company_text',
  	'label'		 => __( 'About Us', 'eleganto-advanced-sections' ),
  	'section'	 => 'contact_section',
  	'default'	 => '',
  	'priority'	 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'text',
  	'settings'	 => 'conatact_company_name',
  	'label'		 => __( 'Company Name', 'eleganto-advanced-sections' ),
  	'default'	 => __( 'Add a company name', 'eleganto-advanced-sections' ),
  	'section'	 => 'contact_section',
  	'default'	 => '',
  	'priority'	 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'			 => 'text',
  	'settings'		 => 'conatact_company_address',
  	'label'			 => __( 'Address', 'eleganto-advanced-sections' ),
  	'description'	 => __( 'Add your company address. Use &lt;br&gt; code to brake line.', 'eleganto-advanced-sections' ),
  	'section'		 => 'contact_section',
    'sanitize_callback' => 'wp_kses_post', 
  	'default'		 => '',
  	'priority'		 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'text',
  	'settings'	 => 'conatact_company_telephone',
  	'label'		 => __( 'Tel', 'eleganto-advanced-sections' ),
  	'default'	 => '',
  	'section'	 => 'contact_section',
  	'default'	 => '',
  	'priority'	 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'		 => 'text',
  	'settings'	 => 'conatact_company_email',
  	'label'		 => __( 'Email', 'eleganto-advanced-sections' ),
  	'default'	 => '',
  	'section'	 => 'contact_section',
  	'default'	 => '',
  	'priority'	 => 10,
  ) );
  
  /**
   * Image Settings
   */
  Kirki::add_field( 'eleganto_settings', array(
  	'type'			 => 'image',
  	'settings'		 => 'image_section_image',
  	'label'			 => __( 'Image', 'eleganto-advanced-sections' ),
  	'description'	 => __( 'Upload center image', 'eleganto-advanced-sections' ),
  	'section'		 => 'image_section',
  	'default'		 => '',
  	'priority'		 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'				 => 'textarea',
  	'settings'			 => 'image_section_text_left',
  	'label'				 => __( 'Text Left', 'eleganto-advanced-sections' ),
  	'section'			 => 'image_section',
  	'sanitize_callback'	 => 'wp_kses_post',
  	'default'			 => '',
  	'priority'			 => 10,
  ) );
  Kirki::add_field( 'eleganto_settings', array(
  	'type'				 => 'textarea',
  	'settings'			 => 'image_section_text_right',
  	'label'				 => __( 'Text Right', 'eleganto-advanced-sections' ),
  	'section'			 => 'image_section',
  	'sanitize_callback'	 => 'wp_kses_post',
  	'default'			 => '',
  	'priority'			 => 10,
  ) );
  }
}
add_action( 'plugins_loaded', 'eleganto_advanced_sections_init_options' );

// Portfolio hover animations
function eas_portfolio_animation() {

	$portfolio_animations = array(
		'lily'	 => 'Lily',
		'sadie'	 => 'Sadie',
		'roxy'	 => 'Roxy',
		'bubba'	 => 'Bubba',
		'romeo'	 => 'Romeo',
	);

	return $portfolio_animations;
}

// Portfolio hover animations
function eas_cf7_array_for_scg() {
	$args		 = array(
		'post_type'		 => 'wpcf7_contact_form',
		'posts_per_page' => -1
	);
	$forms		 = get_posts( $args );
	$output		 = array();
	$output[ 0 ] = '';
	if ( $forms && !is_wp_error( $forms ) ) {
		foreach ( $forms as $form ) {
			$output[ $form->ID ] = $form->post_title;
		}
	}
	return $output;
}
