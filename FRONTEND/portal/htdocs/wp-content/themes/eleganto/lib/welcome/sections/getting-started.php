<?php
/**
 * Getting started template
 */

?>
<?php $theme = wp_get_theme(); ?>

<div id="getting_started" class="eleganto-tab-pane active">

	<div class="eleganto-tab-pane-center">

		<h1 class="eleganto-welcome-title"><?php printf( esc_html__( 'Welcome to %s!', 'eleganto' ), $theme->get( 'Name' ) ); ?></h1>
    
    <?php if ( is_child_theme() ) { ?>
      <h3 class="eleganto-welcome-title-child"><?php printf( esc_html__( 'A child theme of %s.', 'eleganto' ), 'Eleganto' ); ?></h3>
    <?php } ?>

		<p><?php esc_html_e( 'Our elegant and professional Business theme, which turns your Wordpress to awesome corporate site.','eleganto'); ?></p>
		<p><?php printf( esc_html__( 'We want to make sure you have the best experience using %1s and that is why we gathered here all the necessary informations for you. We hope you will enjoy using %2s, as much as we enjoy creating great products.', 'eleganto' ), $theme->get( 'Name' ), $theme->get( 'Name' ) ); ?>

	</div>

	<hr />

	<div class="eleganto-tab-pane-center">

		<h1><?php esc_html_e( 'Getting started', 'eleganto' ); ?></h1>

		<h4><?php esc_html_e( 'Customize everything in a single place.' ,'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'Using the WordPress Customizer you can easily customize every aspect of the theme.', 'eleganto' ); ?></p>
    <p><?php esc_html_e( 'This theme uses Kirki toolkit plugin to customize theme. This plugin adds advanced features to the WordPress customizer. Install the plugin before you go to the customizer.', 'eleganto' ); ?></p>
		<p>
      <?php if ( is_plugin_active( 'kirki/kirki.php' ) ) { ?>
				<span class="eleganto-w-activated button"><?php esc_html_e( 'Kirki is already activated', 'eleganto' ); ?></span>
			<?php	} else { ?>
				<a href="<?php echo esc_url( wp_nonce_url( self_admin_url( 'update.php?action=install-plugin&plugin=kirki' ), 'install-plugin_kirki' ) ); ?>" class="button button-primary"><?php esc_html_e( 'Install Kirki Toolkit', 'eleganto' ); ?></a>
		  <?php	} ?>
      <a href="<?php echo wp_customize_url(); ?>" class="button button-primary"><?php esc_html_e( 'Go to Customizer', 'eleganto' ); ?></a>
    </p>

	</div>

	<hr />

	<div class="eleganto-tab-pane-center">

		<h1><?php esc_html_e( 'FAQ', 'eleganto' ); ?></h1>

	</div>
  <div class="eleganto-video-tutorial">
    <div class="eleganto-tab-pane-half eleganto-tab-pane-first-half">
  		<h4><?php esc_html_e( 'Set a Static Home Page (Front Page)', 'eleganto' ); ?></h4>
      <p><?php esc_html_e( 'By default the front page of your site will display blog posts. We recommended to set static home page as front page. Create the new page first, set the template "Homepage" and save the page. Then please go to Customize -> Static Front Page and switch "Front page displays" to "A static page" and select the page you created before.', 'eleganto' ); ?></p>
  	  <p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/create-a-homepage/' ); ?>" class="button"><?php esc_html_e( 'View how to do this', 'eleganto' ); ?></a></p>
    </div>
    <div class="eleganto-tab-pane-half video">
      <p class="youtube">
  			<a href="<?php echo get_template_directory_uri(); ?>/lib/welcome/img/eleganto-front-page.jpg" target="_blank">
    			<img src="<?php echo get_template_directory_uri(); ?>/lib/welcome/img/eleganto-front-page.jpg" width="350" height="200" />
    		</a>
  		</p>
    </div>
  </div>
  
	<div class="eleganto-tab-pane-half eleganto-tab-pane-first-half">

		<h4><?php esc_html_e( 'Install Eleganto Advanced Sections plugin', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'To setup the homepage you need to install and activate Eleganto Advanced Sections plugin. This plugin allows you completely setup the homepage layout.', 'eleganto' ); ?></p>
		<p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/homepage-setup-eleganto/' ); ?>" class="button"><?php esc_html_e( 'View how to do this', 'eleganto' ); ?></a></p>

		<hr />
		
		<h4><?php esc_html_e( 'Homepage Setup', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'In the below documentation you will find an easy way to build an unique homepage design', 'eleganto' ); ?></p>
		<p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/homepage-setup-eleganto/' ); ?>" class="button"><?php esc_html_e( 'View how to do this', 'eleganto' ); ?></a></p>
    
	</div>

	<div class="eleganto-tab-pane-half">

		<h4><?php esc_html_e( 'Install Contact Form 7 plugin', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'This plugin allows you put the contact form inside homepage contact section', 'eleganto' ); ?></p>
		<p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/homepage-setup-eleganto/#contact%c2%a0section-setup' ); ?>" class="button"><?php esc_html_e( 'View how to do this', 'eleganto' ); ?></a></p>
    
    <?php if ( !is_child_theme() ) { ?>
  		<hr />
      
      <h4><?php esc_html_e( 'Create a child theme', 'eleganto' ); ?></h4>
  		<p><?php esc_html_e( 'If you want to make changes to the theme\'s files, those changes are likely to be overwritten when you next update the theme. In order to prevent that from happening, you need to create a child theme. For this, please follow the documentation below.', 'eleganto' ); ?></p>
  		<p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/how-to-create-a-child-theme/' ); ?>" class="button"><?php esc_html_e( 'View how to do this', 'eleganto' ); ?></a></p>
		<?php } ?>
    
	</div>

	<div class="eleganto-clear"></div>

	<hr />

	<div class="eleganto-tab-pane-center">

		<h1><?php esc_html_e( 'View full documentation', 'eleganto' ); ?></h1>
		<p><?php printf( esc_html__( 'Need more details? Please check our full documentation for detailed information on how to use %s.', 'eleganto' ), 'Eleganto' ); ?></p>
		<p><a href="<?php echo esc_url( 'http://demo.themes4wp.com/documentation/category/eleganto/' ); ?>" class="button button-primary"><?php esc_html_e( 'Read full documentation', 'eleganto' ); ?></a></p>

	</div>

	<hr />

	<div class="eleganto-tab-pane-center">
		<h1><?php esc_html_e( 'Recommended plugins', 'eleganto' ); ?></h1>
	</div>

	<div class="eleganto-tab-pane-half eleganto-tab-pane-first-half">
		<!-- Kirki Toolkit -->
		<h4><?php esc_html_e( 'Kirki Toolkit', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'This theme uses Kirki toolkit plugin to customize theme. This plugin adds advanced features to the WordPress customizer. Install the plugin before you go to the customizer.', 'eleganto' ); ?></p>
		<?php if ( is_plugin_active( 'kirki/kirki.php' ) ) { ?>
			<p><span class="eleganto-w-activated button"><?php esc_html_e( 'Already activated', 'eleganto' ); ?></span></p>
		<?php }	else { ?>
			<p><a href="<?php echo esc_url( wp_nonce_url( self_admin_url( 'update.php?action=install-plugin&plugin=kirki' ), 'install-plugin_kirki' ) ); ?>" class="button button-primary"><?php esc_html_e( 'Install Kirki Toolkit', 'eleganto' ); ?></a></p>
		<?php }	?>
    
		<hr />
    
		<!-- Eleganto Advanced Sections -->
		<h4><?php esc_html_e( 'Eleganto Advanced Sections', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'Eleganto Advanced Sections allows you setup homepage layout.. ', 'eleganto' ); ?></p>
		<?php if ( is_plugin_active( 'eleganto-advanced-sections/eleganto-advanced-sections.php' ) ) { ?>
			<p><span class="eleganto-w-activated button"><?php esc_html_e( 'Already activated', 'eleganto' ); ?></span></p>
		<?php }	else { ?>
			<p><a href="<?php echo esc_url('themes.php?page=tgmpa-install-plugins' ); ?>" class="button button-primary"><?php esc_html_e( 'Install Eleganto Advanced Sections', 'eleganto' ); ?></a></p>
		<?php } ?>
 
    
	</div>

	<div class="eleganto-tab-pane-half">
  
    <!-- Contact Form 7 -->
		<h4><?php esc_html_e( 'Contact Form 7', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'This plugin allows you put the contact form inside homepage contact section', 'eleganto' ); ?></p>
		<?php if ( is_plugin_active( 'contact-form-7/wp-contact-form-7.php' ) ) { ?>
				<p><span class="eleganto-w-activated button"><?php esc_html_e( 'Already activated', 'eleganto' ); ?></span></p>
		<?php } else { ?>
      <p><a href="<?php echo esc_url( wp_nonce_url( self_admin_url( 'update.php?action=install-plugin&plugin=contact-form-7' ), 'install-plugin_contact-form-7' ) ); ?>" class="button button-primary"><?php esc_html_e( 'Install Contact Form 7', 'eleganto' ); ?></a></p>
  	<?php } ?>
    
		<hr />
    
		<!-- Portfolio Post Type -->
		<h4><?php esc_html_e( 'Portfolio Post Type', 'eleganto' ); ?></h4>
		<p><?php esc_html_e( 'This plugin enable a portfolio post type and taxonomies..', 'eleganto' ); ?></p>
		<?php if ( is_plugin_active( 'portfolio-post-type/portfolio-post-type.php' ) ) { ?>
			<p><span class="eleganto-w-activated button"><?php esc_html_e( 'Already activated', 'eleganto' ); ?></span></p>
		<?php	}	else { ?>
			<p><a href="<?php echo esc_url( wp_nonce_url( self_admin_url( 'update.php?action=install-plugin&plugin=portfolio-post-type' ), 'install-plugin_portfolio-post-type' ) ); ?>" class="button button-primary"><?php esc_html_e( 'Install Portfolio Post Type', 'eleganto' ); ?></a></p>
		<?php	} ?>

	</div>

	<div class="eleganto-clear"></div>

</div>
