<?php

/**
 * Main builder admin class.
 *
 * @since 1.0
 */
final class FLBuilderAdmin {

	/**
	 * Initialize hooks.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function init()
	{
		$basename = plugin_basename( FL_BUILDER_FILE );
		
		// Activation
		register_activation_hook( FL_BUILDER_FILE,           __CLASS__ . '::activate' );
		
		// Actions
		add_action( 'admin_init',                            __CLASS__ . '::show_activate_notice' );

		// Filters
		add_filter( 'plugin_action_links_' . $basename,      __CLASS__ . '::render_plugin_action_links' );
	}

	/**
	 * Called on plugin activation and checks to see if the correct 
	 * WordPress version is installed and multisite is supported. If 
	 * all checks are passed the install method is called.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function activate()
	{
		global $wp_version;

		// Check for WordPress 3.5 and above.
		if(!version_compare($wp_version, '3.5', '>=')) {
			self::show_activate_error(__('The <strong>Page Builder</strong> plugin requires WordPress version 3.5 or greater. Please update WordPress before activating the plugin.', 'fl-builder'));
		}
		
		// Allow extensions to hook activation.
		$activate = apply_filters( 'fl_builder_activate', true );
		
		// Should we continue with activation? 
		if ( $activate ) {

			// Check for multisite.
			if(is_multisite()) {
				$url = FLBuilderModel::get_store_url( '', array( 'utm_medium' => 'bb-pro', 'utm_source' => 'plugins-admin-page', 'utm_campaign' => 'no-multisite-support' ) );
				self::show_activate_error( sprintf( __( 'This version of the <strong>Page Builder</strong> plugin is not compatible with WordPress Multisite. <a%s>Please upgrade</a> to the Multisite version of this plugin.', 'fl-builder' ), ' href="' . $url . '" target="_blank"' ) );
			}
			
			// Success! Run the install.
			self::install();
	
			// Trigger the activation notice.
			self::trigger_activate_notice();
		}
	}

	/**
	 * Show a message if there is an activation error and 
	 * deactivates the plugin.
	 *
	 * @since 1.0
	 * @param string $message The message to show.
	 * @return void
	 */
	static public function show_activate_error($message)
	{
		deactivate_plugins( FLBuilderModel::plugin_basename(), false, is_network_admin() );

		die( $message );
	}

	/**
	 * Sets the transient that triggers the activation notice
	 * or welcome page redirect.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function trigger_activate_notice()
	{
		if ( current_user_can( 'delete_users' ) ) {
			set_transient( '_fl_builder_activation_admin_notice', true, 30 );
		}
	}

	/**
	 * Shows the activation success message or redirects to the 
	 * welcome page.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function show_activate_notice()
	{
		// Bail if no activation transient is set.
		if ( ! get_transient( '_fl_builder_activation_admin_notice' ) ) {
			return;
		}

		// Delete the activation transient.
		delete_transient( '_fl_builder_activation_admin_notice' );

		if ( isset( $_GET['activate-multi'] ) || is_multisite() ) {
			// Show the notice if we are activating multiple plugins or on multisite.
			add_action('admin_notices', __CLASS__ . '::activate_notice');
			add_action('network_admin_notices', __CLASS__ . '::activate_notice');
		}
		else {
			// Redirect to the welcome page.
			wp_safe_redirect( add_query_arg( array( 'page' => 'fl-builder-settings' ), admin_url( 'options-general.php' ) ) );
		}
	}

	/**
	 * Shows the activation success message.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function activate_notice()
	{
		if ( FL_BUILDER_LITE !== true ) {
			$hash    = '#license';
			$message = __( 'Page Builder activated! <a%s>Click here</a> to enable remote updates.', 'fl-builder' );
		}
		else {
			$hash    = '#welcome';
			$message = __( 'Page Builder activated! <a%s>Click here</a> to get started.', 'fl-builder' );
		}
		
		$url = apply_filters( 'fl_builder_activate_redirect_url', admin_url( '/options-general.php?page=fl-builder-settings' . $hash ) );
		
		echo '<div class="updated" style="background: #d3ebc1;">';
		echo '<p><strong>' . sprintf( $message, ' href="' . esc_url( $url ) . '"' ) . '</strong></p>';
		echo '</div>';
	}

	/**
	 * Installs the builder upon successful activation. 
	 * Currently not used but may be in the future.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function install() {}

	/**
	 * Uninstalls the builder.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function uninstall()
	{
		FLBuilderModel::uninstall_database();
	}

	/**
	 * Renders the link for the row actions on the plugins page.
	 *
	 * @since 1.0
	 * @param array $actions An array of row action links.
	 * @return array
	 */
	static public function render_plugin_action_links($actions)
	{
		if(FL_BUILDER_LITE === true) {
			$url = FLBuilderModel::get_store_url( '', array( 'utm_medium' => 'bb-lite', 'utm_source' => 'plugins-admin-page', 'utm_campaign' => 'plugins-admin-upgrade' ) );
			$actions[] = '<a href="' . $url . '" style="color:#3db634;" target="_blank">' . _x( 'Upgrade', 'Plugin action link label.', 'fl-builder' ) . '</a>';
		}

		return $actions;
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function init_classes()
	{
		_deprecated_function( __METHOD__, '1.8' );
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function init_settings()
	{
		_deprecated_function( __METHOD__, '1.8' );
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function init_multisite()
	{
		_deprecated_function( __METHOD__, '1.8' );
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function init_templates()
	{
		_deprecated_function( __METHOD__, '1.8' );
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function white_label_plugins_page($plugins)
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderWhiteLabel::plugins_page()' );
		
		if ( class_exists( 'FLBuilderWhiteLabel' ) ) {
			return FLBuilderWhiteLabel::plugins_page( $plugins );
		}

		return $plugins;
	}

	/**
	 * @since 1.6.4.3
	 * @deprecated 1.8
	 */
	static public function white_label_themes_page( $themes )
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderWhiteLabel::themes_page()' );
		
		if ( class_exists( 'FLBuilderWhiteLabel' ) ) {
			return FLBuilderWhiteLabel::themes_page( $themes );
		}
		
		return $themes;
	}

	/**
	 * @since 1.6.4.4
	 * @deprecated 1.8
	 */
	static public function white_label_theme_gettext( $text )
	{
		if ( class_exists( 'FLBuilderWhiteLabel' ) ) {
			return FLBuilderWhiteLabel::theme_gettext( $text );
		}
		
		return $text;
	}
}

FLBuilderAdmin::init();
