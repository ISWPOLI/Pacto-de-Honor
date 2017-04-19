<?php

/**
 * Handles logic for the admin settings page. 
 *
 * @since 1.0
 */
final class FLBuilderAdminSettings {
	
	/**
	 * Holds any errors that may arise from
	 * saving admin settings.
	 *
	 * @since 1.0
	 * @var array $errors
	 */
	static public $errors = array();
	
	/** 
	 * Initializes the admin settings.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function init()
	{
		add_action( 'after_setup_theme', __CLASS__ . '::init_hooks' );
	}
	
	/** 
	 * Adds the admin menu and enqueues CSS/JS if we are on
	 * the builder admin settings page.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function init_hooks()
	{
		if ( ! is_admin() ) {
			return;
		}
		
		add_action( 'admin_menu', __CLASS__ . '::menu' );
			
		if ( isset( $_REQUEST['page'] ) && 'fl-builder-settings' == $_REQUEST['page'] ) {
			add_action( 'admin_enqueue_scripts', __CLASS__ . '::styles_scripts' );
			self::save();
		}
	}
	
	/** 
	 * Enqueues the needed CSS/JS for the builder's admin settings page.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function styles_scripts()
	{
		// Styles
		wp_enqueue_style( 'fl-builder-admin-settings', FL_BUILDER_URL . 'css/fl-builder-admin-settings.css', array(), FL_BUILDER_VERSION );

		// Scripts
		wp_enqueue_script( 'fl-builder-admin-settings', FL_BUILDER_URL . 'js/fl-builder-admin-settings.js', array(), FL_BUILDER_VERSION );
		
		// Media Uploader
		wp_enqueue_media();
	}
	
	/** 
	 * Renders the admin settings menu.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function menu() 
	{
		if ( current_user_can( 'delete_users' ) ) {
			
			$title = FLBuilderModel::get_branding();
			$cap   = 'delete_users';
			$slug  = 'fl-builder-settings';
			$func  = __CLASS__ . '::render';
			
			add_submenu_page( 'options-general.php', $title, $title, $cap, $slug, $func );
		}
	}
	
	/** 
	 * Renders the admin settings.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render()
	{
		include FL_BUILDER_DIR . 'includes/admin-settings-js-config.php';
		include FL_BUILDER_DIR . 'includes/admin-settings.php';
	}
	
	/** 
	 * Renders the page class for network installs and single site installs.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render_page_class()
	{
		if ( self::multisite_support() ) {
			echo 'fl-settings-network-admin';
		}
		else {
			echo 'fl-settings-single-install';
		}
	}
	
	/** 
	 * Renders the admin settings page heading.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render_page_heading()
	{
		$icon = FLBuilderModel::get_branding_icon();
		$name = FLBuilderModel::get_branding();
		
		if ( ! empty( $icon ) ) {
			echo '<img src="' . $icon . '" />';
		}
		
		echo '<span>' . sprintf( _x( '%s Settings', '%s stands for custom branded "Page Builder" name.', 'fl-builder' ), FLBuilderModel::get_branding() ) . '</span>';
	}
	
	/** 
	 * Renders the update message.
	 *
	 * @since 1.0
	 * @return void
	 */	 
	static public function render_update_message()
	{
		if ( ! empty( self::$errors ) ) {
			foreach ( self::$errors as $message ) {
				echo '<div class="error"><p>' . $message . '</p></div>';
			}
		}
		else if( ! empty( $_POST ) && ! isset( $_POST['email'] ) ) {
			echo '<div class="updated"><p>' . __( 'Settings updated!', 'fl-builder' ) . '</p></div>';
		}
	}
	
	/** 
	 * Renders the nav items for the admin settings menu.
	 *
	 * @since 1.0
	 * @return void
	 */	  
	static public function render_nav_items()
	{
		$item_data = apply_filters( 'fl_builder_admin_settings_nav_items', array(
			'welcome' => array(
				'title' 	=> __( 'Welcome', 'fl-builder' ),
				'show'		=> FLBuilderModel::get_branding() == __( 'Page Builder', 'fl-builder' ) && ( is_network_admin() || ! self::multisite_support() ),
				'priority'	=> 50
			),
			'license' => array(
				'title' 	=> __( 'License', 'fl-builder' ),
				'show'		=> FL_BUILDER_LITE !== true && ( is_network_admin() || ! self::multisite_support() ),
				'priority'	=> 100
			),
			'upgrade' => array(
				'title' 	=> __( 'Upgrade', 'fl-builder' ),
				'show'		=> FL_BUILDER_LITE === true,
				'priority'	=> 200
			),
			'modules' => array(
				'title' 	=> __( 'Modules', 'fl-builder' ),
				'show'		=> true,
				'priority'	=> 300
			),
			'post-types' => array(
				'title' 	=> __( 'Post Types', 'fl-builder' ),
				'show'		=> true,
				'priority'	=> 400
			),
			'icons' => array(
				'title' 	=> __( 'Icons', 'fl-builder' ),
				'show'		=> FL_BUILDER_LITE !== true,
				'priority'	=> 500
			),
			'editing' => array(
				'title' 	=> __( 'Editing', 'fl-builder' ),
				'show'		=> true,
				'priority'	=> 600
			),
			'cache' => array(
				'title' 	=> __( 'Cache', 'fl-builder' ),
				'show'		=> true,
				'priority'	=> 700
			),
			'uninstall' => array(
				'title' 	=> __( 'Uninstall', 'fl-builder' ),
				'show'		=> is_network_admin() || ! self::multisite_support(),
				'priority'	=> 800
			),
		) );
		
		$sorted_data = array();
		
		foreach ( $item_data as $key => $data ) {
			$data['key'] = $key;
			$sorted_data[ $data['priority'] ] = $data;
		}
		
		ksort( $sorted_data );
		
		foreach ( $sorted_data as $data ) {
			if ( $data['show'] ) {
				echo '<li><a href="#' . $data['key'] . '">' . $data['title'] . '</a></li>';
			}
		}
	}
	
	/** 
	 * Renders the admin settings forms.
	 *
	 * @since 1.0
	 * @return void
	 */	   
	static public function render_forms()
	{
		// Welcome
		if ( FLBuilderModel::get_branding() == __( 'Page Builder', 'fl-builder' ) && ( is_network_admin() || ! self::multisite_support() ) ) {
			self::render_form( 'welcome' );
		}
		
		// License
		if ( is_network_admin() || ! self::multisite_support() )  {
			self::render_form( 'license' );
		}
		
		// Upgrade
		if ( FL_BUILDER_LITE === true )	 {
			self::render_form( 'upgrade' );
		}
		
		// Modules
		self::render_form( 'modules' );
		
		// Post Types
		self::render_form( 'post-types' );
		
		// Icons
		self::render_form( 'icons' );
		
		// Editing
		self::render_form( 'editing' );
		
		// Cache
		self::render_form( 'cache' );
		
		// Uninstall
		self::render_form( 'uninstall' );
		
		// Let extensions hook into form rendering.
		do_action( 'fl_builder_admin_settings_render_forms' );
	}
	
	/** 
	 * Renders an admin settings form based on the type specified.
	 *
	 * @since 1.0
	 * @param string $type The type of form to render.
	 * @return void
	 */	   
	static public function render_form( $type )
	{
		if ( self::has_support( $type ) ) {
			include FL_BUILDER_DIR . 'includes/admin-settings-' . $type . '.php';
		}
	}
	
	/** 
	 * Renders the action for a form.
	 *
	 * @since 1.0
	 * @param string $type The type of form being rendered.
	 * @return void
	 */	  
	static public function render_form_action( $type = '' )
	{
		if ( is_network_admin() ) {
			echo network_admin_url( '/settings.php?page=fl-builder-multisite-settings#' . $type );
		}
		else {
			echo admin_url( '/options-general.php?page=fl-builder-settings#' . $type );
		}
	}
	
	/** 
	 * Returns the action for a form.
	 *
	 * @since 1.0
	 * @param string $type The type of form being rendered.
	 * @return string The URL for the form action.
	 */	 
	static public function get_form_action( $type = '' )
	{
		if ( is_network_admin() ) {
			return network_admin_url( '/settings.php?page=fl-builder-multisite-settings#' . $type );
		}
		else {
			return admin_url( '/options-general.php?page=fl-builder-settings#' . $type );
		}
	}
	
	/** 
	 * Checks to see if a settings form is supported.
	 *
	 * @since 1.0
	 * @param string $type The type of form to check.
	 * @return bool
	 */ 
	static public function has_support( $type )
	{
		return file_exists( FL_BUILDER_DIR . 'includes/admin-settings-' . $type . '.php' );
	}
	
	/** 
	 * Checks to see if multisite is supported.
	 *
	 * @since 1.0
	 * @return bool
	 */ 
	static public function multisite_support()
	{
		return is_multisite() && class_exists( 'FLBuilderMultisiteSettings' );
	}
	
	/** 
	 * Adds an error message to be rendered.
	 *
	 * @since 1.0
	 * @param string $message The error message to add.
	 * @return void
	 */	 
	static public function add_error( $message )
	{
		self::$errors[] = $message;
	}
	
	/** 
	 * Saves the admin settings.
	 *
	 * @since 1.0
	 * @return void
	 */	 
	static public function save()
	{
		// Only admins can save settings.
		if(!current_user_can('delete_users')) {
			return;
		}
		
		self::save_enabled_modules();
		self::save_enabled_post_types();
		self::save_enabled_icons();
		self::save_editing_capability();
		self::clear_cache();
		self::uninstall();
		
		// Let extensions hook into saving.
		do_action( 'fl_builder_admin_settings_save' );
	}
	
	/** 
	 * Saves the enabled modules.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */ 
	static private function save_enabled_modules()
	{
		if ( isset( $_POST['fl-modules-nonce'] ) && wp_verify_nonce( $_POST['fl-modules-nonce'], 'modules' ) ) {
			
			$modules = array();
			
			if ( is_array( $_POST['fl-modules'] ) ) {
				$modules = array_map( 'sanitize_text_field', $_POST['fl-modules'] );
			}
			
			FLBuilderModel::update_admin_settings_option( '_fl_builder_enabled_modules', $modules, true );
		}
	}
	
	/** 
	 * Saves the enabled post types.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */ 
	static private function save_enabled_post_types()
	{
		if ( isset( $_POST['fl-post-types-nonce'] ) && wp_verify_nonce( $_POST['fl-post-types-nonce'], 'post-types' ) ) {
		
			if ( is_network_admin() ) {
				$post_types = sanitize_text_field( $_POST['fl-post-types'] );
				$post_types = str_replace( ' ', '', $post_types );
				$post_types = explode( ',', $post_types );
			}
			else {
				
				$post_types = array();
				
				if ( isset( $_POST['fl-post-types'] ) && is_array( $_POST['fl-post-types'] ) ) {
					$post_types = array_map( 'sanitize_text_field', $_POST['fl-post-types'] );
				}
			}
			
			FLBuilderModel::update_admin_settings_option( '_fl_builder_post_types', $post_types, true );
		}
	}
	
	/** 
	 * Saves the enabled icons.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */		 
	static private function save_enabled_icons()
	{
		if ( isset( $_POST['fl-icons-nonce'] ) && wp_verify_nonce( $_POST['fl-icons-nonce'], 'icons' ) ) {
			
			// Make sure we have at least one enabled icon set. 
			if ( ! isset( $_POST['fl-enabled-icons'] ) && empty( $_POST['fl-new-icon-set'] ) ) {
				self::add_error( __( "Error! You must have at least one icon set enabled.", 'fl-builder' ) );
				return;
			}
			
			$filesystem	   = FLBuilderUtils::get_filesystem();
			$enabled_icons = array();
			
			// Sanitize the enabled icons.
			if ( isset( $_POST['fl-enabled-icons'] ) && is_array( $_POST['fl-enabled-icons'] ) ) {
				$enabled_icons = array_map( 'sanitize_text_field', $_POST['fl-enabled-icons'] );
			}
			
			// Update the enabled sets.
			self::update_enabled_icons( $enabled_icons );
			
			// Delete a set? 
			if ( ! empty( $_POST['fl-delete-icon-set'] ) ) {
				
				$sets  = FLBuilderIcons::get_sets();
				$key   = sanitize_text_field( $_POST['fl-delete-icon-set'] );
				$index = array_search( $key, $enabled_icons );
				
				if ( false !== $index ) {
					unset( $enabled_icons[ $index ] );
				}
				if ( isset( $sets[ $key ] ) ) {
					$filesystem->rmdir( $sets[ $key ]['path'], true );
					FLBuilderIcons::remove_set( $key );
				}
			}
			
			// Upload a new set?
			if ( ! empty( $_POST['fl-new-icon-set'] ) ) {

				$dir		 = FLBuilderModel::get_cache_dir( 'icons' );
				$id			 = (int) $_POST['fl-new-icon-set'];
				$path		 = get_attached_file( $id );
				$new_path	 = $dir['path'] . 'icon-' . time() . '/';
				$unzipped	 = unzip_file( $path, $new_path );
				
				// Unzip failed.
				if ( ! $unzipped ) {
					self::add_error( __( "Error! Could not unzip file.", 'fl-builder' ) );
					return;
				}
				
				// Move files if unzipped into a subfolder.
				$files = $filesystem->dirlist( $new_path );
				
				if ( 1 == count( $files ) ) {
					
					$values			= array_values( $files );
					$subfolder_info = array_shift( $values );
					$subfolder		= $new_path . $subfolder_info['name'] . '/';
					
					if ( file_exists( $subfolder ) && is_dir( $subfolder ) ) {
						
						$files = $filesystem->dirlist( $subfolder );
						
						if ( $files ) {
							foreach ( $files as $file ) {
								$filesystem->move( $subfolder . $file['name'], $new_path . $file['name'] );
							}
						}
						
						$filesystem->rmdir( $subfolder );
					}
				}
				
				// Check for supported sets.
				$is_icomoon	 = file_exists( $new_path . 'selection.json' );
				$is_fontello = file_exists( $new_path . 'config.json' );
				
				// Show an error if we don't have a supported icon set.
				if ( ! $is_icomoon && ! $is_fontello ) {
					$filesystem->rmdir( $new_path, true );
					self::add_error( __( "Error! Please upload an icon set from either Icomoon or Fontello.", 'fl-builder' ) );
					return;
				}
				
				// Enable the new set. 
				if ( is_array( $enabled_icons ) ) {
					$key = FLBuilderIcons::get_key_from_path( $new_path );
					$enabled_icons[] = $key;
				}
			}
			
			// Update the enabled sets again in case they have changed.
			self::update_enabled_icons( $enabled_icons );
		}
	}
	
	/** 
	 * Updates the enabled icons in the database.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */ 
	static private function update_enabled_icons( $enabled_icons = array() )
	{
		FLBuilderModel::update_admin_settings_option( '_fl_builder_enabled_icons', $enabled_icons, true );
	}
	
	/** 
	 * Saves the editing capability.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */ 
	static private function save_editing_capability()
	{
		if ( isset( $_POST['fl-editing-nonce'] ) && wp_verify_nonce( $_POST['fl-editing-nonce'], 'editing' ) ) {
			
			$capability = sanitize_text_field( $_POST['fl-editing-capability'] );
			
			FLBuilderModel::update_admin_settings_option( '_fl_builder_editing_capability', $capability, true );
		}
	}
	
	/** 
	 * Clears the builder cache.
	 *
	 * @since 1.5.3
	 * @access private
	 * @return void
	 */ 
	static private function clear_cache()
	{
		if ( ! current_user_can( 'delete_users' ) ) {
			return; 
		}
		else if ( isset( $_POST['fl-cache-nonce'] ) && wp_verify_nonce( $_POST['fl-cache-nonce'], 'cache' ) ) {
			if ( is_network_admin() ) {
				self::clear_cache_for_all_sites();
			}
			else {
				
				// Clear builder cache.
				FLBuilderModel::delete_asset_cache_for_all_posts();
				
				// Clear theme cache.
				if ( class_exists( 'FLCustomizer' ) && method_exists( 'FLCustomizer', 'clear_all_css_cache' ) ) {
					FLCustomizer::clear_all_css_cache();
				}
			}
		}
	}

	/** 
	 * Clears the builder cache for all sites on a network.
	 *
	 * @since 1.5.3
	 * @access private
	 * @return void
	 */ 
	static private function clear_cache_for_all_sites()
	{
		global $blog_id;
		global $wpdb;
		
		// Save the original blog id.
		$original_blog_id = $blog_id;
		
		// Get all blog ids.
		$blog_ids = $wpdb->get_col( "SELECT blog_id FROM $wpdb->blogs" );
		
		// Loop through the blog ids and clear the cache.
		foreach ( $blog_ids as $id ) {
			
			// Switch to the blog.
			switch_to_blog( $id );
			
			// Clear builder cache.
			FLBuilderModel::delete_asset_cache_for_all_posts();
			
			// Clear theme cache.
			if ( class_exists( 'FLCustomizer' ) && method_exists( 'FLCustomizer', 'clear_all_css_cache' ) ) {
				FLCustomizer::clear_all_css_cache();
			}
		}
		
		// Revert to the original blog.
		switch_to_blog( $original_blog_id );
	}

	/** 
	 * Uninstalls the builder and all of its data.
	 *
	 * @since 1.0
	 * @access private
	 * @return void
	 */ 
	static private function uninstall()
	{
		if ( ! current_user_can( 'delete_plugins' ) ) {
			return; 
		}
		else if ( isset( $_POST['fl-uninstall'] ) && wp_verify_nonce( $_POST['fl-uninstall'], 'uninstall' ) ) {
			
			$uninstall = apply_filters( 'fl_builder_uninstall', true );
			
			if ( $uninstall ) {
				FLBuilderAdmin::uninstall();	
			}
		}
	}
	
	/** 
	 * @since 1.0
	 * @deprecated 1.8
	 */ 
	static private function save_help_button()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderWhiteLabel::save_help_button_settings()' );
	}
	
	/** 
	 * @since 1.0
	 * @deprecated 1.8
	 */ 
	static private function save_branding()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderWhiteLabel::save_branding_settings()' );
	}
	
	/** 
	 * @since 1.0
	 * @deprecated 1.8
	 */ 
	static private function save_enabled_templates()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplatesAdmin::save_settings()' );
	}
}

FLBuilderAdminSettings::init();