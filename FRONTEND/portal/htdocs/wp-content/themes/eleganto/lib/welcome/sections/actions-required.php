<?php
/**
 * Actions required
 */
?>
<?php 
  $counter = 0; 
  $theme = wp_get_theme(); 
?>
<div id="actions_required" class="eleganto-tab-pane">
  <h1><?php printf( esc_html__( 'Keep up with %s\'s recommended actions' ,'eleganto' ), $theme->get( 'Name' ) ); ?></h1>
  <!-- NEWS -->
  <hr />
  <!-- Kirki -->
  <?php if ( !is_plugin_active( 'kirki/kirki.php' ) ) { ?>
		<h3><?php esc_html_e( 'Kirki Toolkit is not installed', 'eleganto' ); ?></h3>
		<p><?php esc_html_e( 'This theme uses Kirki toolkit plugin to customize theme. This plugin adds advanced features to the WordPress customizer. Install the plugin before you go to the customizer.', 'eleganto' ); ?></p>
		<p><a href="<?php echo esc_url( wp_nonce_url( self_admin_url( 'update.php?action=install-plugin&plugin=kirki' ), 'install-plugin_kirki' ) ); ?>" class="button button-primary"><?php esc_html_e( 'Install Kirki Toolkit', 'eleganto' ); ?></a></p>
    <hr />
  <?php 
    $counter++; 
  } ?>
  <!-- Front page -->
  <?php if ( get_option( 'show_on_front' ) != 'page' ) { ?>
    <h3><?php esc_html_e( 'Switch "Front page displays" to "A static page" ', 'eleganto' ); ?></h3>
		<div class="two-three"><?php esc_html_e( 'If you want to create unique homepage, create the new page first, set the template "Homepage" and save the page. Then please go to Settings -> Reading and switch "Front page displays" to "A static page" and select the page you created before.', 'eleganto' ); ?>
      <p><a href="<?php echo wp_customize_url(); ?>" class="button button-primary"><?php esc_html_e( 'Go to Customizer', 'eleganto' ); ?></a></p>
    </div>
    <div class="one-three">
      <a href="<?php echo get_template_directory_uri(); ?>/lib/welcome/img/eleganto-front-page.jpg" target="_blank">
  			<img src="<?php echo get_template_directory_uri(); ?>/lib/welcome/img/eleganto-front-page.jpg" width="225" height="152" />
  		</a>
    </div>
  <?php 
    $counter++; 
  } else { ?>
  <?php } ?>
  <?php	if( $counter == '0' ) { ?>
		<p><?php esc_html_e( 'Hooray! There are no recommended actions for you right now.', 'eleganto' ); ?></p>
	<?php }	?>
  <div id="counter-count" data-counter="<?php echo absint($counter) ?>"></div>
</div>
