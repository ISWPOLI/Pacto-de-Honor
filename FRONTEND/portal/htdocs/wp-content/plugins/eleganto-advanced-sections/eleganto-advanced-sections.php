<?php
/*
Plugin Name: Eleganto Advanced Sections
Plugin URI: https://themes4wp.com
Description: Add Services, Testimonials, Slider, Image, Blog and Contact sections to Eleganto theme.
Version: 1.1.8
Author: Themes4WP
Author URI: http://themes4wp.com
Text Domain: eleganto-advanced-sections
Domain Path: /languages
License: GPLv2
License URI: https://www.gnu.org/licenses/gpl-2.0.html
*/

if ( ! function_exists( 'add_action' ) ) {
	die( 'Nothing to do...' );
}

/* Required helper functions */
include_once( dirname( __FILE__ ) . '/inc/settings.php' );


if ( ! function_exists( 'eleganto_advanced_sections' ) ) {
	function eleganto_advanced_sections() {
	}
}

/**
 * Load plugin textdomain.
 *
 * @since 1.0.0
 */

add_action( 'plugins_loaded', 'eleganto_advanced_sections_load_textdomain' );

function eleganto_advanced_sections_load_textdomain() {
	load_plugin_textdomain( 'eleganto-advanced-sections', false, dirname( plugin_basename( __FILE__ ) ) . '/languages' );

}

/* Check if Eleganto theme is activated */

if ( ! empty ( $GLOBALS['pagenow'] ) && 'plugins.php' === $GLOBALS['pagenow'] ) {	
    add_action( 'admin_notices', 'eleganto_advanced_sections_admin_notices', 0 );
}	

function eleganto_advanced_sections_requirements() {
	
	$eleganto_advanced_sections_errors = array();
	$theme = wp_get_theme();
	
	if ( 'Eleganto PRO' == $theme->name ) {
		$eleganto_advanced_sections_errors[] = __( 'There is no need for activating Eleganto Advanced Sections plugin. You already have the PRO version of Eleganto which includes this plugin.','eleganto-advanced-sections');
	
  } elseif ( ( 'Eleganto' != $theme->name ) && ( 'Eleganto' != $theme->parent_theme ) ) {

		$eleganto_advanced_sections_errors[] = __( 'You need to have <a href="https://wordpress.org/themes/eleganto/" target="_blank">Eleganto</a> theme in order to use Eleganto Advanced Sections plugin.','eleganto-advanced-sections' );
	
  }
	
	return $eleganto_advanced_sections_errors;

}

function eleganto_advanced_sections_admin_notices()
{

    $eleganto_advanced_sections_errors = eleganto_advanced_sections_requirements();

    if ( empty ( $eleganto_advanced_sections_errors ) )
        return;

    /* Suppress "Plugin activated" notice. */
    unset( $_GET['activate'] );
	
	echo '<div class="notice error my-acf-notice is-dismissible">';
		echo '<p>'.join($eleganto_advanced_sections_errors).'</p>';
        echo '<p>'.__( '<i>Eleganto Advanced Sections</i> has been deactivated.', 'eleganto-advanced-sections' ).'</p>';
    echo '</div>';

    deactivate_plugins( plugin_basename( __FILE__ ) );
}
