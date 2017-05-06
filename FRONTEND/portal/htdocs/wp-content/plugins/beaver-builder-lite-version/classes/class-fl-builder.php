<?php

/**
 * Main builder class.
 *
 * @since 1.0
 */
final class FLBuilder {

	/**
	 * The ID of a post that is currently being rendered.
	 *
	 * @since 1.6.4.2
	 * @var int $post_rendering
	 */
	static public $post_rendering = null;
	
	/**
	 * Stores the default directory name to look for in a theme for BB templates.
	 *
	 * @since 1.5.9-cf
	 * @var string $template_dir
	 */
	static private $template_dir = 'fl-builder/includes';
	
	/**
	 * An array of which global assets have already been enqueued. This is
	 * used to ensure that only one copy of either the global CSS or JS is
	 * ever loaded on the page at one time.
	 * 
	 * For example, if a layout CSS file with the global CSS included in it 
	 * has already been enqueued, subsequent layout CSS files will not include 
	 * the global CSS.
	 *
	 * @since 1.8.2
	 * @var bool $enqueued_global_assets
	 */
	static private $enqueued_global_assets = array();

	/**
	 * Initializes hooks.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function init()
	{
		/* Actions */
		add_action('plugins_loaded',                               __CLASS__ . '::load_plugin_textdomain');
		add_action('send_headers',                                 __CLASS__ . '::no_cache_headers');
		add_action('wp',                                           __CLASS__ . '::init_ui', 11);
		add_action('wp_enqueue_scripts',                           __CLASS__ . '::register_layout_styles_scripts');
		add_action('wp_enqueue_scripts',                           __CLASS__ . '::enqueue_ui_styles_scripts');
		add_action('wp_enqueue_scripts',                           __CLASS__ . '::enqueue_all_layouts_styles_scripts');
		add_action('wp_head',         		                       __CLASS__ . '::render_custom_css_for_editing', 999);
		add_action('admin_bar_menu',                               __CLASS__ . '::admin_bar_menu', 999);
		add_action('wp_footer',                                    __CLASS__ . '::include_jquery');
		add_action('wp_footer',                                    __CLASS__ . '::render_ui');
		add_action('fl_builder_ui_panel_after_rows',               __CLASS__ . '::render_ui_panel_row_templates');
		add_action('fl_builder_ui_panel_after_modules',            __CLASS__ . '::render_ui_panel_modules_templates');
		
		/* Filters */
		add_filter('fl_builder_render_css',                        __CLASS__ . '::rewrite_css_cache_urls', 9999);
		add_filter('body_class',                                   __CLASS__ . '::body_class');
		add_filter('wp_default_editor',                            __CLASS__ . '::default_editor');
		add_filter('mce_css',                                      __CLASS__ . '::add_editor_css');
		add_filter('mce_buttons',                                  __CLASS__ . '::editor_buttons');
		add_filter('mce_buttons_2',                                __CLASS__ . '::editor_buttons_2');
		add_filter('mce_external_plugins',                         __CLASS__ . '::editor_external_plugins', 9999);
		add_filter('tiny_mce_before_init',                         __CLASS__ . '::editor_font_sizes');
		add_filter('the_content',                                  __CLASS__ . '::render_content');
	}

	/**
	 * Localization
	 *
	 * Load the translation file for current language. Checks the default WordPress
	 * languages folder first and then the languages folder inside the plugin.
	 *
	 * @since 1.4.4
	 * @return string|bool The translation file path or false if none is found.
	 */
	static public function load_plugin_textdomain()
	{
		// Traditional WordPress plugin locale filter
		// Uses get_user_locale() which was added in 4.7 so we need to check its available.
		if( function_exists( 'get_user_locale' ) ) {
			$locale = apply_filters( 'plugin_locale', get_user_locale(), 'fl-builder' );
		} else {
			$locale = apply_filters( 'plugin_locale', get_locale(), 'fl-builder' );
		}

		//Setup paths to current locale file
		$mofile_global = trailingslashit( WP_LANG_DIR ) . 'plugins/bb-plugin/' . $locale . '.mo';
		$mofile_local  = trailingslashit( FL_BUILDER_DIR ) . 'languages/' . $locale . '.mo';

		if ( file_exists( $mofile_global ) ) {
			//Look in global /wp-content/languages/plugins/bb-plugin/ folder
			return load_textdomain( 'fl-builder', $mofile_global );
		}
		else if ( file_exists( $mofile_local ) ) {
			//Look in local /wp-content/plugins/bb-plugin/languages/ folder
			return load_textdomain( 'fl-builder', $mofile_local );
		} 

		//Nothing found
		return false;
	}

	/**
	 * Alias method for registering a template data file with the builder.
	 *
	 * @since 1.8
	 * @param sting $path The directory path to the template data file.
	 * @return void
	 */
	static public function register_templates( $path )
	{
		FLBuilderModel::register_templates( $path );
	}

	/**
	 * Alias method for registering a module with the builder.
	 *
	 * @since 1.0
	 * @param string $class The module's PHP class name.
	 * @param array $form The module's settings form data.
	 * @return void
	 */
	static public function register_module($class, $form)
	{
		FLBuilderModel::register_module($class, $form);
	}

	/**
	 * Alias method for registering a settings form with the builder.
	 *
	 * @since 1.0
	 * @param string $id The form's ID.
	 * @param array $form The form data.
	 * @return void
	 */
	static public function register_settings_form($id, $form)
	{
		FLBuilderModel::register_settings_form($id, $form);
	}

	/**
	 * Send no cache headers when the builder interface is active.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function no_cache_headers()
	{
		if(isset($_GET['fl_builder'])) {
			header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
			header('Cache-Control: no-store, no-cache, must-revalidate');
			header('Cache-Control: post-check=0, pre-check=0', false);
			header('Pragma: no-cache');
			header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
		}
	}

	/**
	 * Set the default text editor to tinymce when the builder is active.
	 *
	 * @since 1.0
	 * @param string $type The current default editor type.
	 * @return string
	 */
	static public function default_editor($type)
	{
		return FLBuilderModel::is_builder_active() ? 'tinymce' : $type;
	}

	/**
	 * Add custom CSS for the builder to the text editor.
	 *
	 * @since 1.0
	 * @param string $mce_css
	 * @return string
	 */
	static public function add_editor_css($mce_css)
	{
		if(FLBuilderModel::is_builder_active()) {

			if(!empty($mce_css)) {
				$mce_css .= ',';
			}

			$mce_css .= FL_BUILDER_URL . 'css/editor.css';
		}

		return $mce_css;
	}

	/**
	 * Filter text editor buttons for the first row
	 *
	 * @since 1.0
	 * @param array $buttons The current buttons array.
	 * @return array
	 */
	static public function editor_buttons( $buttons )
	{
		if ( FLBuilderModel::is_builder_active() ) {
			if ( ( $key = array_search( 'wp_more', $buttons ) ) !== false ) {
				unset( $buttons[ $key ] );
			}
		}

		return $buttons;
	}

	/**
	 * Add additional buttons to the text editor.
	 *
	 * @since 1.0
	 * @param array $buttons The current buttons array.
	 * @return array
	 */
	static public function editor_buttons_2( $buttons )
	{
		global $wp_version;
		
		if ( FLBuilderModel::is_builder_active() ) {

			array_shift( $buttons );
			array_unshift( $buttons, 'fontsizeselect' );
			
			if ( version_compare( $wp_version, '4.6.9', '<=' ) ) {
				array_unshift( $buttons, 'formatselect' );
			}

			if ( ( $key = array_search( 'wp_help', $buttons ) ) !== false ) {
				unset( $buttons[ $key ] );
			}
		}

		return $buttons;
	}

	/**
	 * Custom font size options for the editor font size select.
	 *
	 * @since 1.6.3
	 * @param array $init The TinyMCE init array.
	 * @return array
	 */
	static public function editor_font_sizes( $init )
	{
		if ( FLBuilderModel::is_builder_active() ) {
			$init['fontsize_formats'] = implode( ' ', array(
				'10px',
				'12px',
				'14px',
				'16px',
				'18px',
				'20px',
				'22px',
				'24px',
				'26px',
				'28px',
				'30px',
				'32px',
				'34px',
				'36px',
				'38px',
				'40px',
				'42px',
				'44px',
				'46px',
				'48px',
			));
		}

		return $init;
	}

	/**
	 * Only allows certain text editor plugins to avoid conflicts
	 * with third party plugins.
	 *
	 * @since 1.0
	 * @param array $plugins The current editor plugins.
	 * @return array
	 */
	static public function editor_external_plugins($plugins)
	{
		if(FLBuilderModel::is_builder_active()) {

			$allowed = array(
				'anchor',
				'code',
				'insertdatetime',
				'nonbreaking',
				'print',
				'searchreplace',
				'table',
				'visualblocks',
				'visualchars',
				'emoticons',
				'advlist',
				'wptadv',
			);

			foreach($plugins as $key => $val) {
				if(!in_array($key, $allowed)) {
					unset($plugins[$key]);
				}
			}
		}

		return $plugins;
	}

	/**
	 * Register the styles and scripts for builder layouts.
	 *
	 * @since 1.7.4
	 * @return void
	 */
	static public function register_layout_styles_scripts()
	{
		$ver     = FL_BUILDER_VERSION;
		$css_url = plugins_url('/css/', FL_BUILDER_FILE);
		$js_url  = plugins_url('/js/', FL_BUILDER_FILE);
		$min     = defined( 'WP_DEBUG' ) && WP_DEBUG ? '' : '.min';

		// Register additional CSS
		wp_register_style('fl-slideshow',           $css_url . 'fl-slideshow.css', array('yui3'), $ver);
		wp_register_style('jquery-bxslider',        $css_url . 'jquery.bxslider.css', array(), $ver);
		wp_register_style('jquery-magnificpopup',   $css_url . 'jquery.magnificpopup.css', array(), $ver);
		wp_register_style('yui3',           		$css_url . 'yui3.css', array(), $ver);
		
		// Register icon CDN CSS
		wp_register_style('font-awesome',           'https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css', array(), $ver);
		wp_register_style('foundation-icons',       'https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css', array(), $ver);

		// Register additional JS
		wp_register_script('fl-slideshow',          $js_url . 'fl-slideshow' . $min . '.js', array('yui3'), $ver, true);
		wp_register_script('fl-gallery-grid',       $js_url . 'fl-gallery-grid.js', array('jquery'), $ver, true);
		wp_register_script('jquery-bxslider',       $js_url . 'jquery.bxslider.min.js', array('jquery-easing', 'jquery-fitvids'), $ver, true);
		wp_register_script('jquery-easing',         $js_url . 'jquery.easing.1.3.js', array('jquery'), '1.3', true);
		wp_register_script('jquery-fitvids',        $js_url . 'jquery.fitvids.js', array('jquery'), $ver, true);
		wp_register_script('jquery-imagesloaded', 	$js_url . 'jquery.imagesloaded.js', array('jquery'), $ver, true);
		wp_register_script('jquery-infinitescroll', $js_url . 'jquery.infinitescroll.js', array('jquery'), $ver, true);
		wp_register_script('jquery-magnificpopup',  $js_url . 'jquery.magnificpopup.min.js', array('jquery'), $ver, true);
		wp_register_script('jquery-mosaicflow',     $js_url . 'jquery.mosaicflow.min.js', array('jquery'), $ver, true);
		wp_register_script('jquery-waypoints',      $js_url . 'jquery.waypoints.min.js', array('jquery'), $ver, true);
		wp_register_script('jquery-wookmark',       $js_url . 'jquery.wookmark.min.js', array('jquery'), $ver, true);
		wp_register_script('yui3',       			$js_url . 'yui3.js', array(), $ver, true);

		wp_register_script('youtube-player', 		'https://www.youtube.com/iframe_api', array(), $ver, true);
		wp_register_script('vimeo-player', 			'https://player.vimeo.com/api/player.js', array(), $ver, true);		
	}

	/**
	 * Enqueue the styles and scripts for all builder layouts 
	 * in the main WordPress query.
	 *
	 * @since 1.7.4
	 * @return void
	 */
	static public function enqueue_all_layouts_styles_scripts()
	{
		global $wp_query;
		global $post;

		$original_post = $post;

		// Enqueue assets for posts in the main query.
		if ( isset( $wp_query->posts ) ) {
			foreach ( $wp_query->posts as $post ) {
				self::enqueue_layout_styles_scripts();
			}
		}

		// Enqueue assets for posts via the fl_builder_global_posts filter.
		$post_ids = FLBuilderModel::get_global_posts();

		if(count($post_ids) > 0) {

			$posts = get_posts(array(
				'post__in' 			=> $post_ids, 
				'post_type' 		=> get_post_types(),
				'posts_per_page'	=> -1
			));
			
			foreach($posts as $post) {
				self::enqueue_layout_styles_scripts();
			}
		}

		// Reset the global post variable.
		$post = $original_post;
	}

	/**
	 * Enqueue the styles and scripts for a single layout.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function enqueue_layout_styles_scripts()
	{
		if(FLBuilderModel::is_builder_enabled()) {

			$nodes = FLBuilderModel::get_categorized_nodes();

			// Enqueue required row CSS and JS
			foreach($nodes['rows'] as $row) {
				if($row->settings->bg_type == 'slideshow') {
					wp_enqueue_script('yui3');
					wp_enqueue_script('fl-slideshow');
					wp_enqueue_style('fl-slideshow');
				}
				else if($row->settings->bg_type == 'video') {
					wp_enqueue_script('jquery-imagesloaded');
					if ( $row->settings->bg_video_source == 'video_service' ) {
						
						$video_data = FLBuilderUtils::get_video_data($row->settings->bg_video_service_url);

						if( $video_data['type'] == 'youtube' ) {
							wp_enqueue_script('youtube-player');
						}
						else if($video_data['type'] == 'vimeo') {
							wp_enqueue_script('vimeo-player');
						}
					}
				}
			}

			// Enqueue required module CSS and JS
			foreach($nodes['modules'] as $module) {

				$module->enqueue_icon_styles();
				$module->enqueue_font_styles();
				$module->enqueue_scripts();

				foreach($module->css as $handle => $props) {
					wp_enqueue_style($handle, $props[0], $props[1], $props[2], $props[3]);
				}
				foreach($module->js as $handle => $props) {
					wp_enqueue_script($handle, $props[0], $props[1], $props[2], $props[3]);
				}
				if(!empty($module->settings->animation)) {
					wp_enqueue_script('jquery-waypoints');
				}
			}

			// Enqueue Google Fonts
			FLBuilderFonts::enqueue_styles();

			// Enqueue layout CSS
			self::enqueue_layout_cached_asset( 'css' );

			// Enqueue layout JS
			self::enqueue_layout_cached_asset( 'js' );
		}
	}

	/**
	 * Enqueues the cached CSS or JS asset for a layout.
	 *
	 * @since 1.8.2
	 * @access private
	 * @param string $type The type of asset. Either css or js.
	 * @return string
	 */
	static private function enqueue_layout_cached_asset( $type = 'css' )
	{
		$post_id    = FLBuilderModel::get_post_id();
		$asset_info = FLBuilderModel::get_asset_info();
		$asset_ver  = FLBuilderModel::get_asset_version();
		
		// Enqueue with the global code included?
		if ( in_array( $type, self::$enqueued_global_assets ) ) {
			$path = $asset_info[ $type . '_partial' ];
			$url = $asset_info[ $type . '_partial_url' ];
			$global = false;
		}
		else {
			$path = $asset_info[ $type ];
			$url = $asset_info[ $type . '_url' ];
			$global = true;
			self::$enqueued_global_assets[] = $type;
		}
		
		// Render if the file doesn't exist.
		if ( ! file_exists( $path ) || ( defined( 'WP_DEBUG' ) && WP_DEBUG ) ) {
			call_user_func_array( array( 'FLBuilder', 'render_' . $type ), array( $global ) );
		}
		
		// Don't enqueue if we don't have a file after trying to render.
		if ( ! file_exists( $path ) || 0 === filesize( $path ) ) {
			return;
		}
		
		// Enqueue.
		if ( 'css' == $type ) {
			$deps 	= apply_filters( 'fl_builder_layout_style_dependencies', array() );
			$media 	= apply_filters( 'fl_builder_layout_style_media', 'all' );
			wp_enqueue_style( 'fl-builder-layout-' . $post_id, $url, $deps, $asset_ver, $media );
		}
		else if ( 'js' == $type ) {
			wp_enqueue_script( 'fl-builder-layout-' . $post_id, $url, array( 'jquery' ), $asset_ver, true );
		}
	}

	/**
	 * Register and enqueue the styles and scripts for the builder UI.
	 *
	 * @since 1.7.4
	 * @return void
	 */
	static public function enqueue_ui_styles_scripts()
	{
		if(FLBuilderModel::is_builder_active()) {

			$ver     = FL_BUILDER_VERSION;
			$css_url = plugins_url('/css/', FL_BUILDER_FILE);
			$js_url  = plugins_url('/js/', FL_BUILDER_FILE);

			/* Frontend builder styles */
			wp_enqueue_style('dashicons');
			wp_enqueue_style('font-awesome');
			wp_enqueue_style('foundation-icons');
			wp_enqueue_style('jquery-nanoscroller',     $css_url . 'jquery.nanoscroller.css', array(), $ver);
			wp_enqueue_style('jquery-autosuggest',      $css_url . 'jquery.autoSuggest.min.css', array(), $ver);
			wp_enqueue_style('jquery-tiptip',           $css_url . 'jquery.tiptip.css', array(), $ver);
			wp_enqueue_style('bootstrap-tour',          $css_url . 'bootstrap-tour-standalone.min.css', array(), $ver);
			
			// Enqueue individual builder styles if WP_DEBUG is on.
			if ( defined( 'WP_DEBUG' ) && WP_DEBUG ) {
				wp_enqueue_style('fl-color-picker',         $css_url . 'fl-color-picker.css', array(), $ver);
				wp_enqueue_style('fl-lightbox',             $css_url . 'fl-lightbox.css', array(), $ver);
				wp_enqueue_style('fl-icon-selector',        $css_url . 'fl-icon-selector.css', array(), $ver);
				wp_enqueue_style('fl-builder',              $css_url . 'fl-builder.css', array(), $ver);
			}
			else {
				wp_enqueue_style('fl-builder-min',          $css_url . 'fl-builder.min.css', array(), $ver);
			}
			
			/* Custom Icons */
			FLBuilderIcons::enqueue_all_custom_icons_styles();

			/* RTL Support */
			if(is_rtl()) {
				wp_enqueue_style('fl-builder-rtl',      	$css_url . 'fl-builder-rtl.css', array(), $ver);
			}

			/* We have a custom version of sortable that fixes a bug. */
			wp_deregister_script('jquery-ui-sortable');

			/* Frontend builder scripts */
			wp_enqueue_media();
			wp_enqueue_script('heartbeat');
			wp_enqueue_script('wpdialogs');
			wp_enqueue_script('wpdialogs-popup');
			wp_enqueue_script('wplink');
			wp_enqueue_script('editor');
			wp_enqueue_script('quicktags');
			wp_enqueue_script('json2');
			wp_enqueue_script('jquery-ui-droppable');
			wp_enqueue_script('jquery-ui-draggable');
			wp_enqueue_script('jquery-ui-slider');
			wp_enqueue_script('jquery-ui-widget');
			wp_enqueue_script('jquery-ui-position');
			wp_enqueue_script('jquery-ui-sortable',     	$js_url . 'jquery.ui.sortable.js', array('jquery-ui-core', 'jquery-ui-widget', 'jquery-ui-mouse'), $ver, true);
			wp_enqueue_script('jquery-nanoscroller',    	$js_url . 'jquery.nanoscroller.min.js', array(), $ver, true);
			wp_enqueue_script('jquery-autosuggest',     	$js_url . 'jquery.autoSuggest.min.js', array(), $ver, true);
			wp_enqueue_script('jquery-tiptip',          	$js_url . 'jquery.tiptip.min.js', array(), $ver, true);
			wp_enqueue_script('jquery-simulate',        	$js_url . 'jquery.simulate.js', array(), $ver, true);
			wp_enqueue_script('jquery-validate',        	$js_url . 'jquery.validate.min.js', array(), $ver, true);
			wp_enqueue_script('bootstrap-tour',         	$js_url . 'bootstrap-tour-standalone.min.js', array(), $ver, true);
			wp_enqueue_script('ace', 						$js_url . 'ace/ace.js', array(), $ver, true);
			wp_enqueue_script('ace-language-tools', 		$js_url . 'ace/ext-language_tools.js', array(), $ver, true);
			
			// Enqueue individual builder scripts if WP_DEBUG is on.
			if ( defined( 'WP_DEBUG' ) && WP_DEBUG ) {
				wp_enqueue_script('fl-color-picker',        			$js_url . 'fl-color-picker.js', array(), $ver, true);
				wp_enqueue_script('fl-lightbox',            			$js_url . 'fl-lightbox.js', array(), $ver, true);
				wp_enqueue_script('fl-icon-selector',       			$js_url . 'fl-icon-selector.js', array(), $ver, true);
				wp_enqueue_script('fl-stylesheet',          			$js_url . 'fl-stylesheet.js', array(), $ver, true);
				wp_enqueue_script('fl-builder',             			$js_url . 'fl-builder.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-ajax-layout',   			$js_url . 'fl-builder-ajax-layout.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-forced-media-queries', 	$js_url . 'fl-builder-forced-media-queries.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-preview',     			$js_url . 'fl-builder-preview.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-responsive-editing', 		$js_url . 'fl-builder-responsive-editing.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-services',    			$js_url . 'fl-builder-services.js', array(), $ver, true);
				wp_enqueue_script('fl-builder-tour',        			$js_url . 'fl-builder-tour.js', array(), $ver, true);
			}
			else {
				wp_enqueue_script('fl-builder-min',             		$js_url . 'fl-builder.min.js', array(), $ver, true);
			}

			/* Additional module styles and scripts */
			foreach(FLBuilderModel::$modules as $module) {

				$module->enqueue_scripts();

				foreach($module->css as $handle => $props) {
					wp_enqueue_style($handle, $props[0], $props[1], $props[2], $props[3]);
				}
				foreach($module->js as $handle => $props) {
					wp_enqueue_script($handle, $props[0], $props[1], $props[2], $props[3]);
				}
			}
		}
	}

	/**
	 * Include a jQuery fallback script when the builder is
	 * enabled for a page.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function include_jquery()
	{
		if(FLBuilderModel::is_builder_enabled()) {
			include FL_BUILDER_DIR . 'includes/jquery.php';
		}
	}

	/**
	 * Adds builder classes to the body class.
	 *
	 * @since 1.0
	 * @param array $classes An array of existing classes.
	 * @return array
	 */
	static public function body_class($classes)
	{
		$do_render = apply_filters( 'fl_builder_do_render_content', true, FLBuilderModel::get_post_id() );
		
		if($do_render && FLBuilderModel::is_builder_enabled() && !is_archive()) {
			$classes[] = 'fl-builder';
		}
		if(FLBuilderModel::is_builder_active() && !FLBuilderModel::current_user_has_editing_capability()) {
			$classes[] = 'fl-builder-simple';
		}

		return $classes;
	}

	/**
	 * Adds the page builder button to the WordPress admin bar.
	 *
	 * @since 1.0
	 * @param object $wp_admin_bar An instance of the WordPress admin bar.
	 * @return void
	 */
	static public function admin_bar_menu($wp_admin_bar)
	{
		global $wp_the_query;

		if ( FLBuilderModel::is_post_editable() ) {

			$wp_admin_bar->add_node( array(
				'id'    => 'fl-builder-frontend-edit-link',
				'title' => '<style> #wp-admin-bar-fl-builder-frontend-edit-link .ab-icon:before { content: "\f116" !important; top: 2px; margin-right: 3px; } </style><span class="ab-icon"></span>' . FLBuilderModel::get_branding(),
				'href'  => FLBuilderModel::get_edit_url( $wp_the_query->post->ID )
			));
		}
	}
	
	static public function locate_template_file( $template_base, $slug )
	{
		$specific_template = $template_base . '-' . $slug . '.php';
		$general_template = $template_base . '.php';
		$default_dir = trailingslashit( FL_BUILDER_DIR ) . 'includes/';
		
		// Try to find the specific template, then repeat the same process for general.
		
		$locate_template_order = apply_filters( 'fl_builder_locate_template_order', array(
			self::$template_dir . $specific_template,
			self::$template_dir . $general_template
		), self::$template_dir, $template_base, $slug );
		
		$template_path = locate_template( $locate_template_order );
		
		if ( ! $template_path ) {
			if ( file_exists( $default_dir . $specific_template ) ) {
				$template_path = $default_dir . $specific_template;
			}
			else if ( file_exists( $default_dir . $general_template ) ) {
				$template_path = $default_dir . $general_template;
			}
		}
		
		return apply_filters( 'fl_builder_template_path', $template_path, $template_base, $slug );
	}

	/**
	 * Initializes the builder interface.
	 *
	 * @since 1.0
	 * @since 1.8 Method name changed from init to init_ui.
	 * @return void
	 */
	static public function init_ui()
	{
		// Enable editing if the builder is active.
		if ( FLBuilderModel::is_builder_active() && ! defined( 'DOING_AJAX' ) ) {
			
			// Tell W3TC not to minify while the builder is active.
			define( 'DONOTMINIFY', true );
			
			// Tell Autoptimize not to minify while the builder is active.
			add_filter( 'autoptimize_filter_noptimize', '__return_true' );

			// Remove 3rd party editor buttons.
			remove_all_actions('media_buttons', 999999);
			remove_all_actions('media_buttons_context', 999999);

			// Get the post.
			require_once ABSPATH . 'wp-admin/includes/post.php';
			$post_id = FLBuilderModel::get_post_id();

			// Check to see if the post is locked.
			if(wp_check_post_lock($post_id) !== false) {
				header('Location: ' . admin_url('/post.php?post=' . $post_id . '&action=edit'));
			}
			else {
				FLBuilderModel::enable_editing();
			}
		}
	}

	/**
	 * Renders the markup for the builder interface.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render_ui()
	{
		global $wp_the_query;

		if ( FLBuilderModel::is_builder_active() ) {

			$post_id            = $wp_the_query->post->ID;
			$global_settings	= FLBuilderModel::get_global_settings();
			$simple_ui			= ! FLBuilderModel::current_user_has_editing_capability();
			$categories         = FLBuilderModel::get_categorized_modules();
			$render_panel       = apply_filters( 'fl_builder_render_ui_panel', FLBuilderModel::current_user_has_editing_capability() );
			
			if ( $render_panel ) {
				include FL_BUILDER_DIR . 'includes/ui-panel.php';	
			}
			
			include FL_BUILDER_DIR . 'includes/ui-bar.php';
			include FL_BUILDER_DIR . 'includes/ui-fields.php';
			include FL_BUILDER_DIR . 'includes/ui-js-templates.php';
			include FL_BUILDER_DIR . 'includes/ui-js-config.php';
		}
	}

	/**
	 * Renders the markup for the title in the builder's bar.
	 *
	 * @since 1.6.3
	 * @return void
	 */
	static public function render_ui_bar_title()
	{
		// Get the bar title.
		$title = apply_filters( 'fl_builder_ui_bar_title', FLBuilderModel::get_branding() );
		
		// Render the bar title.
		if ( '' == FLBuilderModel::get_branding_icon() ) {
			echo '<span class="fl-builder-bar-title fl-builder-bar-title-no-icon">' . $title . '</span>';
		}
		else {
			echo '<span class="fl-builder-bar-title">';
			echo '<img src="' . FLBuilderModel::get_branding_icon() . '" /> ';
			echo '<span>' . $title . '</span></span>';
		}
	}

	/**
	 * Renders the markup for the buttons in the builder's bar.
	 *
	 * @since 1.6.3
	 * @return void
	 */
	static public function render_ui_bar_buttons()
	{
		$help_button 	= FLBuilderModel::get_help_button_settings();
		$simple_ui		= ! FLBuilderModel::current_user_has_editing_capability();
		
		$buttons = apply_filters( 'fl_builder_ui_bar_buttons', array(
			'help' => array(
				'label' => '<i class="fa fa-question-circle"></i>',
				'show'	=> $help_button['enabled'] && ! $simple_ui
			),
			'upgrade' => array(
				'label' => __( 'Upgrade Today <i class="fa fa-external-link-square"></i>', 'fl-builder' ),
				'show'	=> true === FL_BUILDER_LITE
			),
			'buy' => array(
				'label' => __( 'Buy Now <i class="fa fa-external-link-square"></i>', 'fl-builder' ),
				'show'	=> stristr( home_url(), 'demo.wpbeaverbuilder.com' )
			),
			'done' => array(
				'label' => __( 'Done', 'fl-builder' ),
				'class' => 'fl-builder-button-primary'
			),
			'tools' => array(
				'label' => __( 'Tools', 'fl-builder' ),
				'show'	=> ! $simple_ui
			),
			'templates' => array(
				'label' => __( 'Templates', 'fl-builder' ),
				'show'	=> ! $simple_ui
			),
			'add-content' => array(
				'label' => __( 'Add Content', 'fl-builder' ),
				'show'	=> ! $simple_ui
			)	
		) );
		
		echo '<div class="fl-builder-bar-actions">';
		
		foreach ( $buttons as $slug => $button ) {
			
			if ( isset( $button['show'] ) && ! $button['show'] ) {
				continue;
			}
			
			echo '<span class="fl-builder-' . $slug . '-button fl-builder-button';
			
			if ( isset( $button['class'] ) ) {
				echo ' ' . $button['class'];
			}
			
			echo '">' . $button['label'] . '</span>';
		}
		
		echo '<div class="fl-clear"></div></div>';
	}

	/** 
	 * Renders categorized row templates in the UI panel.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function render_ui_panel_row_templates()
	{
		$is_row_template    = FLBuilderModel::is_post_user_template( 'row' );
		$is_module_template = FLBuilderModel::is_post_user_template( 'module' );
		$has_editing_cap    = FLBuilderModel::current_user_has_editing_capability();
		$row_templates      = FLBuilderModel::get_row_templates_data();
		
		if ( ! $is_row_template && ! $is_module_template && $has_editing_cap ) {
			include FL_BUILDER_DIR . 'includes/ui-panel-row-templates.php';
		}
	}

	/** 
	 * Renders categorized module templates in the UI panel.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function render_ui_panel_modules_templates()
	{
		$is_module_template = FLBuilderModel::is_post_user_template( 'module' );
		$has_editing_cap    = FLBuilderModel::current_user_has_editing_capability();
		$module_templates   = FLBuilderModel::get_module_templates_data();
		
		if ( ! $is_module_template && $has_editing_cap ) {
			include FL_BUILDER_DIR . 'includes/ui-panel-module-templates.php';
		}
	}

	/**
	 * Renders layouts using a new instance of WP_Query with the provided 
	 * args and enqueues the necessary styles and scripts. We set the global 
	 * $wp_query variable so the builder thinks we are in the loop when content 
	 * is rendered without having to call query_posts.
	 *
	 * @link https://codex.wordpress.org/Class_Reference/WP_Query See for a complete list of args.
	 *
	 * @since 1.7
	 * @param array|string $args An array or string of args to be passed to a new instance of WP_Query.
	 * @param int $site_id The ID of a site on a network to pull the query from.
	 * @return void
	 */
	static public function render_query( $args, $site_id = null )
	{
		global $blog_id;
		global $post;
		global $wp_query;
		
		// Pull from a site on the network?
		if ( $site_id && is_multisite() ) {
			$original_blog_id = $blog_id;
			switch_to_blog( $site_id );
		}
		
		// Get the post and query.
		$original_post 	= $post;
		$wp_query  		= new WP_Query( $args );
		$post_data 		= FLBuilderModel::get_post_data();
		
		// Make sure the builder's render content filter is present.
		add_filter( 'the_content', 'FLBuilder::render_content' );
		
		// Unset the builder's post_data post ID so the global $post is used.
		FLBuilderModel::update_post_data( 'post_id', null );
		
		// Loop through the posts.
		while ( $wp_query->have_posts() ) {
			
			// Set the global post.
			$wp_query->the_post();
			
			// Make sure this isn't the same post as the original post to prevent infinite loops.
			if ( is_object( $original_post ) && $original_post->ID === $post->ID ) {
				continue;
			}
			
			// Enqueue styles and scripts for this post.
			self::enqueue_layout_styles_scripts();
			
			// Print the styles since we are outside of the head tag.
			ob_start();
			wp_print_styles();
			echo ob_get_clean();
			
			// Backup the main query in case it is overwritten in the_content().
			$backup_query = $wp_query;
			
			// Render the content.
			the_content();
			
			// Restore the main query in case it was overwritten.
			$wp_query = $backup_query;
		}
		
		// Reset the post_id if we have one in $post_data.
		if ( isset( $post_data['post_id'] ) ) {
			FLBuilderModel::update_post_data( 'post_id', $post_data['post_id'] );
		}
		
		// Reset the global query.
		wp_reset_query();
		
		// Reset the site data?
		if ( $site_id && is_multisite() ) {
			switch_to_blog( $original_blog_id );
		}
	}

	/**
	 * Renders the content for a builder layout while in the loop. 
	 * This method should only be called by the_content filter as 
	 * defined in fl-builder.php. To output builder content, use 
	 * the_content function while in a WordPress loop. 
	 *
	 * @since 1.0
	 * @param string $content The existing content.
	 * @return string
	 */
	static public function render_content( $content )
	{
		$post_id        = FLBuilderModel::get_post_id();
		$enabled        = FLBuilderModel::is_builder_enabled();
		$rendering      = $post_id === self::$post_rendering;
		$do_render      = apply_filters( 'fl_builder_do_render_content', true, $post_id );
		$in_loop        = in_the_loop();
		$is_global      = in_array( $post_id, FLBuilderModel::get_global_posts() );

		if( $enabled && ! $rendering && $do_render && ( $in_loop || $is_global ) ) {
			
			// Set the post rendering ID.
			self::$post_rendering = $post_id;

			// Remove the builder's render_content filter so it's not called again.
			remove_filter( 'the_content', 'FLBuilder::render_content' );
			
			// Render the content.
			
			ob_start();

			do_action( 'fl_builder_before_render_content', $content );

			echo '<div class="' . self::render_content_classes() . '" data-post-id="' . $post_id . '">';
			self::render_nodes();
			echo '</div>';
			
			do_action( 'fl_builder_after_render_content', $content );
			
			$content = apply_filters( 'fl_builder_rendered_content', ob_get_clean() );
			
			// Reapply the builder's render_content filter.
			add_filter( 'the_content', 'FLBuilder::render_content' );
			
			// Do shortcodes here since letting the WP filter run can cause an infinite loop.
			if ( apply_filters( 'fl_builder_render_shortcodes', true ) ) {
				$content = apply_filters( 'fl_builder_before_render_shortcodes', $content );
				$pattern = get_shortcode_regex();
				$content = preg_replace_callback( "/$pattern/s", 'FLBuilder::double_escape_shortcodes', $content );
				$content = do_shortcode( $content );
			}
			
			// Add srcset attrs to images with the class wp-image-<ID>.
			if ( function_exists( 'wp_make_content_images_responsive' ) ) {
				$content = wp_make_content_images_responsive( $content );
			}
			
			// Clear the post rendering ID.
			self::$post_rendering = null;
		}

		return $content;
	}

	/**
	 * Escaped shortcodes need to be double escaped or they will
	 * be parsed by WP's shortcodes filter.
	 *
	 * @since 1.6.4.1
	 * @param array $matches The existing content.
	 * @return string
	 */
	static public function double_escape_shortcodes( $matches )
	{
		if ( $matches[1] == '[' && $matches[6] == ']' ) {
			return '[' . $matches[0] . ']';
		}
		
		return $matches[0];
	}

	/**
	 * Renders the CSS classes for the main content div tag.
	 *
	 * @since 1.6.4
	 * @return string
	 */
	static public function render_content_classes()
	{
		global $wp_the_query;
		
		$post_id = FLBuilderModel::get_post_id();
		
		// Build the content class.
		$classes = 'fl-builder-content fl-builder-content-' . $post_id;
		
		// Add the primary content class.
		if ( isset( $wp_the_query->post ) && $wp_the_query->post->ID == $post_id ) {
			$classes .= ' fl-builder-content-primary';
		}
		
		// Add browser specific classes.
		if ( isset( $_SERVER[ 'HTTP_USER_AGENT' ] ) ) {
			if ( stristr( $_SERVER[ 'HTTP_USER_AGENT' ], 'Trident/7.0' ) && stristr( $_SERVER[ 'HTTP_USER_AGENT' ], 'rv:11.0' ) ) {
				$classes .= ' fl-builder-ie-11';
			}
		}
		
		return apply_filters( 'fl_builder_content_classes', $classes );
	}

	/**
	 * Renders the markup for all nodes in a layout.
	 *
	 * @since 1.6.3
	 * @return void
	 */
	static public function render_nodes()
	{
		do_action( 'fl_builder_before_render_nodes' );
		
		if ( apply_filters( 'fl_builder_render_nodes', true ) ) {
			self::render_rows();
		}
		
		do_action( 'fl_builder_after_render_nodes' );
	}

	/**
	 * Renders the markup for a node's attributes.
	 *
	 * @since 1.8
	 * @param array $attrs
	 * @return void
	 */
	static public function render_node_attributes( $attrs )
	{
		foreach( $attrs as $attr_key => $attr_value ) {
			
			if ( empty( $attr_value ) ) {
				continue;
			}
			else if ( is_string( $attr_value ) ) {
				echo ' ' . $attr_key . '="' . $attr_value . '"';
			}
			else if ( is_array( $attr_value ) ) {
				
				echo ' ' . $attr_key . '="';
				
				for( $i = 0; $i < count( $attr_value ); $i++ ) {
					
					echo $attr_value[ $i ];
					
					if ( $i < count( $attr_value ) - 1  ) {
						echo ' ';
					}
				}
				
				echo '"';
			}
		}
	}

	/**
	 * Renders the stripped down content for a layout
	 * that is saved to the WordPress editor.
	 *
	 * @since 1.0
	 * @param string $content The existing content.
	 * @return string
	 */
	static public function render_editor_content()
	{
		$rows = FLBuilderModel::get_nodes('row');

		ob_start();

		// Render the modules.
		foreach($rows as $row) {

			$groups = FLBuilderModel::get_nodes('column-group', $row);

			foreach($groups as $group) {

				$cols = FLBuilderModel::get_nodes('column', $group);

				foreach($cols as $col) {

					$col_children = FLBuilderModel::get_nodes( null, $col );

					foreach ( $col_children as $col_child ) {

						if ( 'module' == $col_child->type ) {
								
							$module = FLBuilderModel::get_module( $col_child );
							
							if ( $module && $module->editor_export ) {

								// Don't crop photos to ensure media library photos are rendered.
								if($module->settings->type == 'photo') {
									$module->settings->crop = false;
								}

								FLBuilder::render_module_html($module->settings->type, $module->settings, $module);
							}
						}
						else if ( 'column-group' == $col_child->type ) {
							
							$group_cols = FLBuilderModel::get_nodes( 'column', $col_child );
							
							foreach ( $group_cols as $group_col ) {
			
								$modules = FLBuilderModel::get_modules( $group_col );
								
								foreach ( $modules as $module ) {
									
									if($module->editor_export) {

										// Don't crop photos to ensure media library photos are rendered.
										if($module->settings->type == 'photo') {
											$module->settings->crop = false;
										}

										FLBuilder::render_module_html($module->settings->type, $module->settings, $module);
									}						
								}
							}
						}
					}
				}
			}
		}

		// Get the content.
		$content = ob_get_clean();

		// Remove unnecessary tags.
		$content = preg_replace('/<\/?div[^>]*\>/i',                '', $content);
		$content = preg_replace('/<\/?span[^>]*\>/i',               '', $content);
		$content = preg_replace('#<script(.*?)>(.*?)</script>#is',  '', $content);
		$content = preg_replace('/<i [^>]*><\\/i[^>]*>/',           '', $content);
		$content = preg_replace('/ class=".*?"/',                   '', $content);

		// Remove empty lines.
		$content = preg_replace('/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/', "\n", $content);

		return $content;
	}

	/**
	 * Renders a settings form.
	 *
	 * @since 1.0
	 * @param array $form The form data.
	 * @param object $settings The settings data.
	 * @return array
	 */
	static public function render_settings($form = array(), $settings)
	{
		$defaults = array(
			'class'     => '',
			'attrs'     => '',
			'title'     => '',
			'badges'	=> array(),
			'tabs'      => array(),
			'buttons'	=> array(),
			'resizable' => false
		);

		$form = apply_filters( 'fl_builder_settings_form_config', array_merge( $defaults, $form ) );

		ob_start();
		include FL_BUILDER_DIR . 'includes/settings.php';
		$html = ob_get_clean();

		return array( 'html' => $html );
	}

	/**
	 * Renders a settings form field.
	 *
	 * @since 1.0
	 * @param string $name The field name.
	 * @param array $field An array of setup data for the field.
	 * @param object $settings Form settings data object.
	 * @return void
	 */
	static public function render_settings_field($name, $field, $settings = null)
	{
		$field              = apply_filters( 'fl_builder_render_settings_field', $field, $name, $settings ); // Allow field settings filtering first
		$i                  = null;
		$is_multiple        = isset($field['multiple']) && $field['multiple'] === true;
		$supports_multiple  = $field['type'] != 'editor' && $field['type'] != 'photo' && $field['type'] != 'service';
		$settings           = ! $settings ? new stdClass() : $settings;
		$preview            = isset($field['preview']) ? json_encode($field['preview']) : json_encode(array('type' => 'refresh'));
		$row_class          = isset($field['row_class']) ? ' ' . $field['row_class'] : '';
		$responsive         = false;
		$root_name          = $name;
		$global_settings    = FLBuilderModel::get_global_settings();
		$value              = isset($settings->$name) ? $settings->$name : '';
		
		// Use a default value if not set in the settings.
		if ( ! isset( $settings->$name ) && isset( $field['default'] ) ) {
			$value = $field['default'];
		}

		// Check to see if responsive is enabled for this field (unit field only for now).
		if ( $global_settings->responsive_enabled && isset( $field['responsive'] ) && ! $is_multiple && 'unit' == $field['type'] ) {
			$responsive = $field['responsive'];
		}

		// Render the field.
		if($is_multiple && $supports_multiple) {

			$values     = $value;
			$arr_name   = $name;
			$name      .= '[]';

			echo '<tbody class="fl-field fl-builder-field-multiples" data-type="form" data-preview=\'' . $preview . '\'>';

			for($i = 0; $i < count($values); $i++) {
				$value = $values[$i];
				echo '<tr class="fl-builder-field-multiple" data-field="'. $arr_name .'">';
				include FL_BUILDER_DIR . 'includes/field.php';
				echo '<td class="fl-builder-field-actions">';
				echo '<i class="fl-builder-field-move fa fa-arrows"></i>';
				echo '<i class="fl-builder-field-copy fa fa-copy"></i>';
				echo '<i class="fl-builder-field-delete fa fa-times"></i>';
				echo '</td>';
				echo '</tr>';
			}

			echo '<tr>';

			if(empty($field['label'])) {
				echo '<td colspan="2">';
			}
			else {
				echo '<td>&nbsp;</td><td>';
			}

			echo '<a href="javascript:void(0);" onclick="return false;" class="fl-builder-field-add fl-builder-button" data-field="'. $arr_name .'">'. sprintf( _x( 'Add %s', 'Field name to add.', 'fl-builder' ), $field['label'] ) .'</a>';
			echo '</td>';
			echo '</tr>';
			echo '</tbody>';
		}
		else {
			echo '<tr id="fl-field-'. $name .'" class="fl-field' . $row_class . '" data-type="' . $field['type'] . '" data-preview=\'' . $preview . '\'>';
			include FL_BUILDER_DIR . 'includes/field.php';
			echo '</tr>';
		}
	}

	/**
	 * Renders a settings form.
	 *
	 * @since 1.0
	 * @param string $type The type of form to render.
	 * @param object $settings The settings data.
	 * @return array
	 */
	static public function render_settings_form($type = null, $settings = null)
	{
		$form = FLBuilderModel::get_settings_form( $type );

		if(isset($settings) && !empty($settings)) {
			$defaults = FLBuilderModel::get_settings_form_defaults( $type );
			$settings = (object)array_merge((array)$defaults, (array)$settings);
		}
		else {
			$settings = FLBuilderModel::get_settings_form_defaults( $type );
		}

		return self::render_settings(array(
			'title' 	=> $form['title'],
			'tabs'  	=> $form['tabs'],
			'resizable' => true
		), $settings);
	}

	/**
	 * Renders the markup for the layout settings form.
	 *
	 * @since 1.8
	 * @return array
	 */
	static public function render_layout_settings()
	{
		$settings 	= FLBuilderModel::get_layout_settings();
		$form 		= FLBuilderModel::$settings_forms['layout'];

		return self::render_settings( array(
			'class'   	=> 'fl-builder-layout-settings',
			'title'   	=> $form['title'],
			'tabs'    	=> $form['tabs'],
			'resizable' => true
		), $settings );
	}

	/**
	 * Renders the markup for the global settings form.
	 *
	 * @since 1.0
	 * @return array
	 */
	static public function render_global_settings()
	{
		$settings 	= FLBuilderModel::get_global_settings();
		$form 		= FLBuilderModel::$settings_forms['global'];

		return self::render_settings(array(
			'class'   	=> 'fl-builder-global-settings',
			'title'   	=> $form['title'],
			'tabs'    	=> $form['tabs'],
			'resizable' => true
		), $settings);
	}

	/**
	 * Renders the markup for the template selector.
	 *
	 * @since 1.0
	 * @return array
	 */
	static public function render_template_selector()
	{
		$filter_data = FLBuilderModel::get_template_selector_filter_data();
		$templates   = FLBuilderModel::get_template_selector_data();

		ob_start();
		include FL_BUILDER_DIR . 'includes/template-selector.php';
		$html = ob_get_clean();

		return array( 'html' => $html );
	}

	/**
	 * Renders the markup for the icon selector.
	 *
	 * @since 1.0
	 * @return array
	 */
	static public function render_icon_selector()
	{
		$icon_sets = FLBuilderIcons::get_sets();

		ob_start();
		include FL_BUILDER_DIR . 'includes/icon-selector.php';
		$html = ob_get_clean();
		
		return array( 'html' => $html );
	}

	/**
	 * Renders the markup for all of the rows in a layout.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render_rows()
	{
		$rows = FLBuilderModel::get_nodes('row');
		
		do_action( 'fl_builder_before_render_rows', $rows );

		foreach($rows as $row) {
			self::render_row($row);
		}
		
		do_action( 'fl_builder_after_render_rows', $rows );
	}

	/**
	 * Renders the markup for a single row.
	 *
	 * @since 1.0
	 * @param object $row The row to render.
	 * @return void
	 */
	static public function render_row($row)
	{
		$groups = FLBuilderModel::get_nodes('column-group', $row);
		
		do_action( 'fl_builder_before_render_row', $row, $groups );
		
		$template_file = self::locate_template_file(
			apply_filters( 'fl_builder_row_template_base', 'row', $row ),
			apply_filters( 'fl_builder_row_template_slug', '', $row )
		);
		
		if ( $template_file && FLBuilderModel::is_node_visible( $row ) ) {
			include $template_file;
		}
		
		do_action( 'fl_builder_after_render_row', $row, $groups );
	}

	/**
	 * Renders the HTML attributes for a single row.
	 *
	 * @since 1.0
	 * @param object $row A row node object.
	 * @return void
	 */
	static public function render_row_attributes( $row )
	{
		$custom_class = apply_filters( 'fl_builder_row_custom_class', $row->settings->class, $row );
		$overlay_bgs  = array( 'photo', 'parallax', 'slideshow', 'video' );
		$attrs        = array(
			'id'          => $row->settings->id,
			'class'       => array(
				'fl-row',
				'fl-row-' . $row->settings->width . '-width',
				'fl-row-bg-' . $row->settings->bg_type,
				'fl-node-' . $row->node
			),
			'data-node'   => $row->node
		);

		// Classes
		if ( ! empty( $row->settings->full_height ) && $row->settings->full_height == 'full' ) {
			
			$attrs['class'][] = 'fl-row-full-height';
			
			if ( isset( $row->settings->content_alignment ) ) {
				$attrs['class'][] = 'fl-row-align-' . $row->settings->content_alignment;
			}
		}
		if ( in_array( $row->settings->bg_type, $overlay_bgs ) && ! empty( $row->settings->bg_overlay_color ) ) {
			$attrs['class'][] = 'fl-row-bg-overlay';
		}
		if ( ! empty( $row->settings->responsive_display ) ) {
			$attrs['class'][] = 'fl-visible-' . $row->settings->responsive_display;
		}
		if ( ! empty( $custom_class ) ) {
			$attrs['class'][] = trim( esc_attr( $custom_class ) );
		}
		
		// Data
		if ( $row->settings->bg_type == 'parallax' && ! empty( $row->settings->bg_parallax_image_src ) ) {
			$attrs['data-parallax-speed'] = $row->settings->bg_parallax_speed;
			$attrs['data-parallax-image'] = $row->settings->bg_parallax_image_src;
		}
		
		self::render_node_attributes( apply_filters( 'fl_builder_row_attributes', $attrs, $row ) );
	}

	/**
	 * Renders the markup for a row's background.
	 *
	 * @since 1.0
	 * @param object $row A row node object.
	 * @return void
	 */
	static public function render_row_bg($row)
	{
		do_action( 'fl_builder_before_render_row_bg', $row );
		
		if($row->settings->bg_type == 'video') {

			$vid_data = FLBuilderModel::get_row_bg_data($row);

			if($vid_data || in_array($row->settings->bg_video_source, array('video_url', 'video_service'))) {
				$template_file = self::locate_template_file(
					apply_filters( 'fl_builder_row_video_bg_template_base', 'row-video', $row ),
					apply_filters( 'fl_builder_row_video_bg_template_slug', '', $row )
				);
				
				if ( $template_file ) {
					include $template_file;
				}
			}
		}
		else if($row->settings->bg_type == 'slideshow') {
			echo '<div class="fl-bg-slideshow"></div>';
		}
		
		do_action( 'fl_builder_after_render_row_bg', $row );
	}

	/**
	 * Renders the HTML class for a row's content wrapper.
	 *
	 * @since 1.0
	 * @param object $row A row node object.
	 * @return void
	 */
	static public function render_row_content_class($row)
	{
		echo 'fl-row-content';
		echo ' fl-row-' . $row->settings->content_width . '-width';
		echo ' fl-node-content';
	}

	/**
	 * Renders the settings lightbox for a row.
	 *
	 * @since 1.0
	 * @param string $node_id A row node ID.
	 * @return array
	 */
	static public function render_row_settings($node_id = null)
	{
		$node       = FLBuilderModel::get_node($node_id);
		$settings   = $node->settings;
		$form       = FLBuilderModel::$settings_forms['row'];
		
		$rendered_settings = self::render_settings(array(
			'class'     => 'fl-builder-row-settings',
			'attrs'     => 'data-node="'. $node->node .'"',
			'title'     => $form['title'],
			'tabs'      => $form['tabs'],
			'resizable' => true
		), $settings);

		return array(
			'settings' => $rendered_settings['html'],
			'state'    => FLBuilderAJAXLayout::render( $node_id )
		);
	}

	/**
	 * Renders the markup for a column group.
	 *
	 * @since 1.0
	 * @param object $group A column group node object.
	 * @return void
	 */
	static public function render_column_group($group)
	{
		$cols = FLBuilderModel::get_nodes('column', $group);

		do_action( 'fl_builder_before_render_column_group', $group, $cols );

		$template_file = self::locate_template_file(
			apply_filters( 'fl_builder_column_group_template_base', 'column-group', $group ),
			apply_filters( 'fl_builder_column_group_template_slug', '', $group )
		);
		
		if ( $template_file ) {
			include $template_file;
		}
		
		do_action( 'fl_builder_after_render_column_group', $group, $cols );
	}

	/**
	 * Renders the attrs for a column group.
	 *
	 * @since 1.0
	 * @param object $group
	 * @return void
	 */
	static public function render_column_group_attributes( $group )
	{
		$cols   = FLBuilderModel::get_nodes( 'column', $group );
		$parent = FLBuilderModel::get_node_parent( $group );
		$attrs  = array(
			'class' => array(
				'fl-col-group',
				'fl-node-' . $group->node
			),
			'data-node' => $group->node
		);
		
		if ( 'column' == $parent->type ) {
			$attrs['class'][] = 'fl-col-group-nested';
		}
		
		foreach( $cols as $col ) {
			
			if( isset( $col->settings->equal_height ) && $col->settings->equal_height == 'yes' ) {
				if ( ! in_array( 'fl-col-group-equal-height', $attrs['class'] ) ) {
					$attrs['class'][] = 'fl-col-group-equal-height';
				}
				if( isset( $col->settings->content_alignment ) ) {
					if ( ! in_array( 'fl-col-group-align-' . $col->settings->content_alignment, $attrs['class'] ) ) {
						$attrs['class'][] = 'fl-col-group-align-' . $col->settings->content_alignment;
					}
				}	
			}
			if( isset( $col->settings->responsive_size ) && $col->settings->responsive_size == 'custom' ) {
				if ( ! in_array( 'fl-col-group-custom-width', $attrs['class'] ) ) {
					$attrs['class'][] = 'fl-col-group-custom-width';
				}
			}
			if( isset( $col->settings->responsive_order ) && $col->settings->responsive_order == 'reversed' ) {
				if ( ! in_array( 'fl-col-group-responsive-reversed', $attrs['class'] ) ) {
					$attrs['class'][] = 'fl-col-group-responsive-reversed';
				}
			}
		}
		
		self::render_node_attributes( apply_filters( 'fl_builder_column_group_attributes', $attrs, $group ) );
	}

	/**
	 * Renders the markup for a single column.
	 *
	 * @since 1.7
	 * @param string|object $col_id A column ID or object.
	 * @return void
	 */
	static public function render_column( $col_id = null )
	{
		$col = is_object( $col_id ) ? $col_id : FLBuilderModel::get_node( $col_id );
		
		if ( FLBuilderModel::is_node_visible( $col ) ) {
			include FL_BUILDER_DIR . 'includes/column.php';	
		}		
	}

	/**
	 * Renders the markup for the column settings lightbox.
	 *
	 * @since 1.0
	 * @param string $node_id A column node ID.
	 * @return array
	 */
	static public function render_column_settings($node_id = null)
	{
		$node       = FLBuilderModel::get_node($node_id);
		$settings   = $node->settings;
		$form       = FLBuilderModel::$settings_forms['col'];

		$rendered_settings = self::render_settings(array(
			'class'     => 'fl-builder-col-settings',
			'attrs'     => 'data-node="'. $node->node .'"',
			'title'     => $form['title'],
			'tabs'      => $form['tabs'],
			'resizable' => true
		), $settings);

		return array(
			'settings' => $rendered_settings['html'],
			'state'    => FLBuilderAJAXLayout::render( $node->parent )
		);
	}

	/**
	 * Renders the HTML attributes for a single column.
	 *
	 * @since 1.0
	 * @param object $col A column node object.
	 * @return void
	 */
	static public function render_column_attributes( $col )
	{
		$custom_class = apply_filters( 'fl_builder_column_custom_class', $col->settings->class, $col );
		$overlay_bgs  = array( 'photo' );
		$nested       = FLBuilderModel::get_nodes( 'column-group', $col );
		$attrs        = array(
			'id'          => $col->settings->id,
			'class'       => array(
				'fl-col',
				'fl-node-' . $col->node
			),
			'data-node'   => $col->node,
			'style'       => 'width: ' . $col->settings->size . '%;'
		);
		
		// Classes
		if ( $col->settings->size <= 50 ) {
			$attrs['class'][] = 'fl-col-small';
		}
		if ( count( $nested ) > 0 ) {
			$attrs['class'][] = 'fl-col-has-cols';
		}
		if ( in_array( $col->settings->bg_type, $overlay_bgs ) && ! empty( $col->settings->bg_overlay_color ) ) {
			$attrs['class'][] = 'fl-col-bg-overlay';
		}
		if ( ! empty( $col->settings->responsive_display ) ) {
			$attrs['class'][] = 'fl-visible-' . $col->settings->responsive_display;
		}
		if ( ! empty( $custom_class ) ) {
			$attrs['class'][] = trim( esc_attr( $custom_class ) );
		}
		
		// Render the attrs
		self::render_node_attributes( apply_filters( 'fl_builder_column_attributes', $attrs, $col ) );
	}

	/**
	 * Renders the markup for all modules in a column.
	 *
	 * @since 1.0
	 * @param string|object $col_id A column ID or object.
	 * @return void
	 */
	static public function render_modules( $col_id = null )
	{
		$nodes = FLBuilderModel::get_nodes( null, $col_id );
		
		do_action( 'fl_builder_before_render_modules', $nodes, $col_id );

		foreach ( $nodes as $node ) {
			
			if ( 'module' == $node->type && FLBuilderModel::is_module_registered( $node->settings->type ) ) {
				self::render_module( $node );
			}
			else if ( 'column-group' == $node->type ) {
				self::render_column_group( $node );
			}
		}
		
		do_action( 'fl_builder_after_render_modules', $nodes, $col_id );
	}

	/**
	 * Renders the markup for a single module.
	 *
	 * @since 1.7
	 * @param string|object $module_id A module ID or object.
	 * @return void
	 */
	static public function render_module( $module_id = null )
	{
		$module 	= FLBuilderModel::get_module( $module_id );
		$settings 	= $module->settings;
		$id 		= $module->node;

		do_action( 'fl_builder_before_render_module', $module );

		$template_file = self::locate_template_file(
			apply_filters( 'fl_builder_module_template_base', 'module', $module ),
			apply_filters( 'fl_builder_module_template_slug', '',  $module )
		);
		
		if ( $template_file && FLBuilderModel::is_node_visible( $module ) ) {
			include $template_file;
		}

		do_action( 'fl_builder_after_render_module', $module );
	}

	/**
	 * Renders the settings lightbox for a module.
	 *
	 * @since 1.0
	 * @param string $node_id The module node ID.
	 * @param string $type The type of module.
	 * @param string $parent_id The parent column node ID.
	 * @param bool $render_state Whether to render the preview state or not.
	 * @return array
	 */
	static public function render_module_settings($node_id = null, $type = null, $parent_id = null, $render_state = true)
	{
		$assets  = '';
		
		// Get the module and settings.
		if($node_id) {
			$module     = FLBuilderModel::get_module($node_id);
			$settings   = $module->settings;
		}
		else {
			$module     = FLBuilderModel::$modules[$type];
			$settings   = FLBuilderModel::get_module_defaults($type);
		}

		// Render the settings CSS/JS assets.
		if(file_exists($module->dir .'css/settings.css')) {
			$assets .= '<link class="fl-builder-settings-css" rel="stylesheet" href="'. $module->url .'css/settings.css" />';
		}
		if(file_exists($module->dir .'js/settings.js')) {
			$assets .= '<script class="fl-builder-settings-js" src="'. $module->url .'js/settings.js"></script>';
		}

		// Render the form.
		$rendered_settings = self::render_settings(array(
			'class' 	=> 'fl-builder-module-settings fl-builder-'. $type .'-settings',
			'attrs' 	=> 'data-node="'. $node_id .'" data-parent="'. $parent_id .'" data-type="'. $type .'"',
			'title' 	=> sprintf( '%s ' . __( 'Settings', 'fl-builder' ), $module->name ),
			'tabs'  	=> apply_filters( 'fl_builder_render_module_settings', $module->form, $module ),
			'resizable' => true
		), $settings);
		
		// Return the HTML.
		return array( 
			'settings' => $assets . $rendered_settings['html'],
			'state'    => $render_state ? FLBuilderAJAXLayout::render( $node_id ) : null
		);
	}

	/**
	 * Renders the markup for a single module. This can be used to render
	 * the markup of a module within another module by passing the type 
	 * and settings params and leaving the module param null.
	 *
	 * @since 1.0
	 * @param string $type The type of module.
	 * @param object $settings A module settings object.
	 * @param object $module Optional. An existing module object to use.
	 * @return void
	 */
	static public function render_module_html($type, $settings, $module = null)
	{
		// Settings
		$defaults = FLBuilderModel::get_module_defaults($type);
		$settings = (object)array_merge((array)$defaults, (array)$settings);

		// Module
		$class = get_class(FLBuilderModel::$modules[$type]);
		$module = new $class();
		$module->settings = $settings;

		// Shorthand reference to the module's id.
		$id = $module->node;

		include $module->dir .'includes/frontend.php';
	}

	/**
	 * Renders the HTML attributes for a single module.
	 *
	 * @since 1.0
	 * @param object $module A module node object.
	 * @return void
	 */
	static public function render_module_attributes( $module )
	{
		$custom_class = apply_filters( 'fl_builder_module_custom_class', $module->settings->class, $module );
		$attrs        = array(
			'id'          => esc_attr( $module->settings->id ),
			'class'       => array(
				'fl-module',
				'fl-module-' . $module->settings->type,
				'fl-node-' . $module->node
			),
			'data-node'   => $module->node,
			'data-animation-delay' => $module->settings->animation_delay
		);
		
		// Classes
		if ( ! empty( $module->settings->responsive_display ) ) {
			$attrs['class'][] = 'fl-visible-' . $module->settings->responsive_display;
		}
		if ( ! empty( $module->settings->animation ) ) {
			$attrs['class'][] = 'fl-animation fl-' . $module->settings->animation;
		}
		if ( ! empty( $custom_class ) ) {
			$attrs['class'][] = trim( esc_attr( $custom_class ) );
		}
		
		// Data
		if ( FLBuilderModel::is_builder_active() ) {
			$attrs['data-parent'] = $module->parent;
			$attrs['data-type'] = $module->settings->type;
			$attrs['data-name'] = $module->name;
		}
		
		// Render the attrs
		self::render_node_attributes( apply_filters( 'fl_builder_module_attributes', $attrs, $module ) );
	}

	/**
	 * Renders the CSS for a single module.
	 *
	 * @since 1.0
	 * @param string $type The type of module.
	 * @param object $id A module node ID.
	 * @param object $settings A module settings object.
	 * @return void
	 */
	static public function render_module_css($type, $id, $settings)
	{
		// Settings
		$global_settings = FLBuilderModel::get_global_settings();
		$defaults = FLBuilderModel::get_module_defaults($type);
		$settings = (object)array_merge((array)$defaults, (array)$settings);

		// Module
		$class = get_class(FLBuilderModel::$modules[$type]);
		$module = new $class();
		$module->settings = $settings;

		include $module->dir .'includes/frontend.css.php';
	}

	/**
	 * Renders the CSS and JS assets.
	 *
	 * @since 1.7
	 * @return void
	 */
	static public function render_assets()
	{
		self::render_css();
		self::render_js();
	}

	/**
	 * Renders custom CSS in a style tag so it can be edited 
	 * using the builder interface.
	 *
	 * @since 1.7
	 * @return void
	 */
	static public function render_custom_css_for_editing()
	{
		if ( ! FLBuilderModel::is_builder_active() ) {
			return;
		}
		
		$global_settings = FLBuilderModel::get_global_settings();
		$layout_settings = FLBuilderModel::get_layout_settings();
		
		echo '<style id="fl-builder-global-css">' . $global_settings->css . '</style>';
		echo '<style id="fl-builder-layout-css">' . $layout_settings->css . '</style>';
	}

	/**
	 * Renders and caches the CSS for a builder layout.
	 *
	 * @since 1.0
	 * @param bool $include_global
	 * @return void
	 */
	static public function render_css( $include_global = true )
	{
		// Delete the old file.
		FLBuilderModel::delete_asset_cache( $include_global ? 'css' : 'css_partial' );

		// Get info on the new file.
		$nodes 				= FLBuilderModel::get_categorized_nodes();
		$node_status		= FLBuilderModel::get_node_status();
		$global_settings    = FLBuilderModel::get_global_settings();
		$asset_info         = FLBuilderModel::get_asset_info();
		$post_id            = FLBuilderModel::get_post_id();
		$post               = get_post($post_id);
		$compiled           = array();
		$css 				= '';
		$path               = $include_global ? $asset_info['css'] : $asset_info['css_partial'];
		
		// Render the global css.
		if ( $include_global ) {
			$css .= self::render_global_css();
		}
		
		// Loop through rows
		foreach($nodes['rows'] as $row) {

			// Instance row css
			ob_start();
			include FL_BUILDER_DIR . 'includes/row-css.php';
			$css .= ob_get_clean();

			// Instance row margins
			$css .= self::render_row_margins($row);

			// Instance row padding
			$css .= self::render_row_padding($row);

			// Instance row border
			$css .= self::render_row_border($row);
		}
		
		// Loop through the columns.
		foreach($nodes['columns'] as $col) {
			
			// Instance column css
			ob_start();
			include FL_BUILDER_DIR . 'includes/column-css.php';
			$css .= ob_get_clean();

			// Instance column margins
			$css .= self::render_column_margins($col);

			// Instance column padding
			$css .= self::render_column_padding($col);

			// Instance column border
			$css .= self::render_column_border($col);

			// Get the modules in this column.
			$modules = FLBuilderModel::get_modules($col);
		}
		
		// Loop through the modules.
		foreach($nodes['modules'] as $module) {

			// Global module css
			$file = $module->dir . 'css/frontend.css';
			$file_responsive = $module->dir . 'css/frontend.responsive.css';

			// Only include global module css that hasn't been included yet.
			if(!in_array($module->settings->type, $compiled)) {

				// Add to the compiled array so we don't include it again.
				$compiled[] = $module->settings->type;

				// Get the standard module css.
				if(file_exists($file)) {
					$css .= file_get_contents($file);
				}

				// Get the responsive module css.
				if($global_settings->responsive_enabled && file_exists($file_responsive)) {
					$css .= '@media (max-width: '. $global_settings->responsive_breakpoint .'px) { ';
					$css .= file_get_contents($file_responsive);
					$css .= ' }';
				}
			}

			// Instance module css
			$file       = $module->dir . 'includes/frontend.css.php';
			$settings   = $module->settings;
			$id         = $module->node;

			if(file_exists($file)) {
				ob_start();
				include $file;
				$css .= ob_get_clean();
			}

			// Instance module margins
			$css .= self::render_module_margins($module);
			
			if ( ! isset( $global_settings->auto_spacing ) || $global_settings->auto_spacing ) {
				$css .= self::render_responsive_module_margins($module);
			}
		}
		
		// Custom Global CSS (included here for proper specificity)
		if ( 'published' == $node_status && $include_global ) {
			$css .= $global_settings->css;
		}
		
		// Custom Global Nodes CSS
		$css .= self::render_global_nodes_custom_code( 'css' );
		
		// Custom Layout CSS
		if ( 'published' == $node_status ) {
			$css .= FLBuilderModel::get_layout_settings()->css;
		}

		// Save the css
		$css = apply_filters( 'fl_builder_render_css', $css, $nodes, $global_settings );
		
		if ( ! defined( 'WP_DEBUG' ) || ! WP_DEBUG ) {
			$css = preg_replace('!/\*[^*]*\*+([^/][^*]*\*+)*/!', '', $css);
			$css = str_replace(array("\r\n", "\r", "\n", "\t", '  ', '    ', '    '), '', $css);
		}
		
		file_put_contents( $path, $css );
	
		@chmod( $path, 0644 );
		
		do_action( 'fl_builder_after_render_css' );
	}

	/**
	 * Renders the CSS used for all builder layouts.
	 *
	 * @since 1.8.2
	 * @return string
	 */
	static public function render_global_css()
	{
		// Get info on the new file.
		$global_settings = FLBuilderModel::get_global_settings();
		
		// Core layout css
		$css = file_get_contents(FL_BUILDER_DIR . '/css/fl-builder-layout.css');
		
		// Core button defaults
		if ( ! defined( 'FL_THEME_VERSION' ) ) {
			$css .= file_get_contents( FL_BUILDER_DIR . '/css/fl-builder-layout-button-defaults.css' );
		}
		
		// Core layout RTL css
		if(is_rtl()) {
			$css .= file_get_contents(FL_BUILDER_DIR . '/css/fl-builder-layout-rtl.css');
		}
		
		// Global node css
		foreach ( array(
			array( 'row_margins',    '.fl-row-content-wrap { margin: ' ),
			array( 'row_padding',    '.fl-row-content-wrap { padding: ' ),
			array( 'row_width',      '.fl-row-fixed-width { max-width: ' ),
			array( 'module_margins', '.fl-module-content { margin: ' )
		) as $data ) {
			if ( '' !== $global_settings->{ $data[0] } ) {
				$value = preg_replace( self::regex( 'css_unit' ), '', strtolower( $global_settings->{ $data[0] } ) );
				$css .= $data[1] . esc_attr( $value );
				$css .= ( is_numeric( $value ) ) ? ( 'px; }' ) : ( '; }' );
			}
		}

		// Responsive layout css
		if ( $global_settings->responsive_enabled ) {

			// Medium devices			
			$css .= '@media (max-width: '. $global_settings->medium_breakpoint .'px) { ';

				// Core medium layout css
				$css .= file_get_contents(FL_BUILDER_DIR . '/css/fl-builder-layout-medium.css');
				
				// Global node medium css
				foreach ( array(
					array( 'row_margins_medium',    '.fl-row[data-node] > .fl-row-content-wrap { margin: ' ),
					array( 'row_padding_medium',    '.fl-row[data-node] > .fl-row-content-wrap { padding: ' ),
					array( 'module_margins_medium', '.fl-module[data-node] > .fl-module-content { margin: ' )
				) as $data ) {
					if ( '' !== $global_settings->{ $data[0] } ) {
						$value = preg_replace( self::regex( 'css_unit' ), '', strtolower( $global_settings->{ $data[0] } ) );
						$css .= $data[1] . esc_attr( $value );
						$css .= ( is_numeric( $value ) ) ? ( 'px; }' ) : ( '; }' );
					}
				}

			$css .= ' }';

			// Responsive devices
			$css .= '@media (max-width: '. $global_settings->responsive_breakpoint .'px) { ';
			
				// Core responsive layout css
				$css .= file_get_contents(FL_BUILDER_DIR . '/css/fl-builder-layout-responsive.css');
				
				// Auto spacing
				if ( ! isset( $global_settings->auto_spacing ) || $global_settings->auto_spacing ) {
					$css .= file_get_contents(FL_BUILDER_DIR . '/css/fl-builder-layout-auto-spacing.css');
				}
				
				// Global node responsive css
				foreach ( array(
					array( 'row_margins_responsive',    '.fl-row[data-node] > .fl-row-content-wrap { margin: ' ),
					array( 'row_padding_responsive',    '.fl-row[data-node] > .fl-row-content-wrap { padding: ' ),
					array( 'module_margins_responsive', '.fl-module[data-node] > .fl-module-content { margin: ' )
				) as $data ) {
					if ( '' !== $global_settings->{ $data[0] } ) {
						$value = preg_replace( self::regex( 'css_unit' ), '', strtolower( $global_settings->{ $data[0] } ) );
						$css .= $data[1] . esc_attr( $value );
						$css .= ( is_numeric( $value ) ) ? ( 'px; }' ) : ( '; }' );
					}
				}
			
			$css .= ' }';
		}
		
		// Default page heading
		if ( ! $global_settings->show_default_heading && ! empty( $global_settings->default_heading_selector ) ) {
			$heading_selector = esc_attr( $global_settings->default_heading_selector );

			// If the value starts with `body` or `.fl-builder` selector, we use custom selectors
			if ( 0 === strpos( $heading_selector, 'body' ) || 0 === strpos( $heading_selector, '.fl-builder' ) ) {
				$css .= $heading_selector;
			} else {
				$css .= '.page ' . $heading_selector . ', .single-fl-builder-template ' . $heading_selector;
			}

			$css .= ' { display:none; }';
		}

		return $css;
	}

	/**
	 * Forcing HTTPS in URLs when `FLBuilderModel::is_ssl()` returns TRUE
	 *
	 * @since 1.7.6
	 * @param string $content A string where the URLs will be modified.
	 * @return string String with SSL ready URLs.
	 */
	static public function rewrite_css_cache_urls( $content )
	{
		if ( FLBuilderModel::is_ssl() ) {
			$content = str_ireplace( 'http:', 'https:', $content );
		}
		
		return $content;
	}

	/**
	 * Regular expressions.
	 *
	 * @since 1.9
	 * @param string $scope What regular expression to return?
	 * @return string Regular expression.
	 */
	static public function regex( $scope )
	{
		$regex = array(
			'css_unit' => '/[^a-z0-9%.\-]/',
		);

		return ( isset( $regex[ $scope ] ) ) ? $regex[ $scope ] : null;
	}

	/**
	 * Renders the CSS spacing and border properties for a node.
	 *
	 * @param object $node A generic node object.
	 * @param string $prop_type One of [ 'padding', 'margin', 'border' ].
	 * @param string $selector_prefix Optional CSS selector prefix for better overrides.
	 * @return string A CSS string.
	 */
	static public function render_node_spacing( $node = null, $prop_type = '', $selector_prefix = '' )
	{
		// Exit early if incorrect parameters		
		if ( ! is_object( $node ) || empty( $prop_type ) ) {
			return;
		}

		$prop_type = strtolower( $prop_type );

		// Ensure type is valid
		if ( ! in_array( $prop_type, array( 'margin', 'padding', 'border' ), true ) ) {
			return;
		}

		$global_settings  = FLBuilderModel::get_global_settings();
		$settings         = $node->settings;
		$css              = '';
		$selector_prefix .= ' .fl-node-' . $node->node;

		// Determine selector suffix to apply spacing to
		switch ( $node->type ) {
			case 'row':
				$selector_suffix = ' > .fl-row-content-wrap';
				break;
			case 'column':
				$selector_suffix = ' > .fl-col-content';
				break;
			case 'module':
				$selector_suffix = ' > .fl-module-content';
				break;
		}

		// Create rules for each breakpoint
		foreach ( array( 'default', 'medium', 'responsive' ) as $breakpoint ) {
			$breakpoint_css = '';
			$setting_suffix = ( 'default' !== $breakpoint ) ? '_' . $breakpoint : '';

			// Iterate over each direction
			foreach ( array( 'top', 'right', 'bottom', 'left' ) as $dir ) {
				$setting = $prop_type . '_' . $dir . $setting_suffix;

				if ( ! isset( $settings->{ $setting } ) ) {
					continue;
				}

				$prop  = $prop_type . '-' . $dir;
				$value = preg_replace( self::regex( 'css_unit' ), '', strtolower( $settings->{ $setting } ) );

				if ( 'border' === $prop_type ) {
					
					if ( empty( $settings->border_type ) ) {
						continue;
					}
					else {
						$prop .= '-width';
					}
				}

				if ( '' !== $value ) {
					$breakpoint_css .= "\t";
					$breakpoint_css .= $prop . ':' . esc_attr( $value );
					$breakpoint_css .= ( is_numeric( trim( $value ) ) ) ? ( 'px;' ) : ( ';' );
					$breakpoint_css .= "\r\n";
				}
			}

			if ( ! empty( $breakpoint_css ) ) {
				
				// Build the selector
				if ( 'default' !== $breakpoint ) {
					$selector = $selector_prefix . '.fl-' . str_replace( 'column', 'col', $node->type ) . $selector_suffix;
				}
				else {
					$selector = $selector_prefix . $selector_suffix;
				}
				
				// Wrap css in selector
				$breakpoint_css = $selector . ' {' . "\r\n" . $breakpoint_css . '}' . "\r\n";

				// Wrap css in media query
				if ( 'default' !== $breakpoint ) {
					$breakpoint_css = '@media ( max-width: ' . $global_settings->{ $breakpoint . '_breakpoint' } . 'px ) {' . "\r\n" . $breakpoint_css . '}' . "\r\n";
				}

				$css .= $breakpoint_css;
			}
		}

		return $css;
	}

	/**
	 * Renders the CSS margins for a row.
	 *
	 * @since 1.0
	 * @param object $row A row node object.
	 * @return string The row CSS margins string.
	 */
	static public function render_row_margins($row)
	{
		return self::render_node_spacing( $row, 'margin' );
	}

	/**
	 * Renders the CSS padding for a row.
	 *
	 * @since 1.0
	 * @param object $row A row node object.
	 * @return string The row CSS padding string.
	 */
	static public function render_row_padding($row)
	{
		return self::render_node_spacing( $row, 'padding' );
	}

	/**
	 * Renders the CSS border widths for a row.
	 *
	 * @since 1.9
	 * @param object $row A row node object.
	 * @return string The row CSS border-width string.
	 */
	static public function render_row_border($row)
	{
		return self::render_node_spacing( $row, 'border' );
	}

	/**
	 * Renders the CSS margins for a column.
	 *
	 * @since 1.0
	 * @param object $col A column node object.
	 * @return string The column CSS margins string.
	 */
	static public function render_column_margins($col)
	{
		return self::render_node_spacing( $col, 'margin' );
	}

	/**
	 * Renders the CSS padding for a column.
	 *
	 * @since 1.0
	 * @param object $col A column node object.
	 * @return string The column CSS padding string.
	 */
	static public function render_column_padding($col)
	{
		return self::render_node_spacing( $col, 'padding' );
	}

	/**
	 * Renders the CSS border widths for a column.
	 *
	 * @since 1.9
	 * @param object $col A column node object.
	 * @return string The column CSS border-width string.
	 */
	static public function render_column_border($col)
	{
		return self::render_node_spacing( $col, 'border', '.fl-builder-content' );
	}

	/**
	 * Renders the CSS margins for a module.
	 *
	 * @since 1.0
	 * @param object $module A module node object.
	 * @return string The module CSS margins string.
	 */
	static public function render_module_margins($module)
	{
		return self::render_node_spacing( $module, 'margin' );
	}

	/**
	 * Renders the (auto) responsive CSS margins for a module.
	 *
	 * @since 1.0
	 * @param object $module A module node object.
	 * @return string The module CSS margins string.
	 */
	static public function render_responsive_module_margins($module)
	{
		$global_settings = FLBuilderModel::get_global_settings();
		$settings        = $module->settings;
		$margins         = '';
		$css             = '';
		
		// Bail early if we have global responsive margins.
		if ( '' != $global_settings->module_margins_responsive ) {
			return $css;	
		}
		
		// Get the global default margin value to use.
		if ( '' != $global_settings->module_margins_medium ) {
			$default = trim( $global_settings->module_margins_medium );
		}
		else {
			$default = trim( $global_settings->module_margins );
		}
		
		// Set the responsive margin CSS if necessary.
		foreach ( array( 'top', 'bottom', 'left', 'right' ) as $dimension ) {
			
			$responsive = 'margin_' . $dimension . '_responsive';
			$medium     = 'margin_' . $dimension . '_responsive';
			$desktop    = 'margin_' . $dimension;
		
			if ( '' == $settings->$responsive ) {
			
				$value = '' == $settings->$medium ? $settings->$desktop : $settings->$medium;
				
				if ( '' != $value && ( $value > $default || $value < 0 ) ) {
					$margins .= 'margin-' . $dimension . ':' . esc_attr( $default ) . 'px;';
				}
			}
		}
		
		// Set the media query if we have margins.
		if ( '' !== $margins ) {
			$css .= '@media (max-width: ' . esc_attr( $global_settings->responsive_breakpoint ) . 'px) { ';
			$css .= '.fl-node-' . $module->node . ' > .fl-module-content { ' . $margins . ' }';
			$css .= ' }';
		}

		return $css;
	}

	/**
	 * Renders and caches the JavaScript for a builder layout.
	 *
	 * @since 1.0
	 * @param bool $include_global
	 * @return void
	 */
	static public function render_js( $include_global = true )
	{
		// Delete the old file.
		FLBuilderModel::delete_asset_cache( $include_global ? 'js' : 'js_partial' );

		// Get info on the new file.
		$nodes 		   		= FLBuilderModel::get_categorized_nodes();
		$global_settings    = FLBuilderModel::get_global_settings();
		$layout_settings 	= FLBuilderModel::get_layout_settings();
		$rows          		= FLBuilderModel::get_nodes('row');
		$asset_info    		= FLBuilderModel::get_asset_info();
		$compiled      		= array();
		$js            		= '';
		$path               = $include_global ? $asset_info['js'] : $asset_info['js_partial'];
		
		// Render the global js.
		if ( $include_global ) {
			$js .= self::render_global_js();
		}

		// Loop through the rows.
		foreach($nodes['rows'] as $row) {
			$js .= self::render_row_js( $row );
		}
		
		// Loop through the modules.
		foreach($nodes['modules'] as $module) {
			$js .= self::render_module_js( $module, $compiled );
		}
		
		// Add the layout settings JS.
		$js .= self::render_global_nodes_custom_code( 'js' );
		$js .= $layout_settings->js;

		// Call the FLBuilder._renderLayoutComplete method if we're currently editing.
		if(stristr($asset_info['js'], '-draft.js') || stristr($asset_info['js'], '-preview.js')) {
			$js .= "; if(typeof FLBuilder !== 'undefined' && typeof FLBuilder._renderLayoutComplete !== 'undefined') FLBuilder._renderLayoutComplete();";
		}

		// Include FLJSMin
		if(!class_exists('FLJSMin')) {
			include FL_BUILDER_DIR . 'classes/class-fl-jsmin.php';
		}

		// Save the js
		if(!empty($js)) {
			
			$js = apply_filters( 'fl_builder_render_js', $js, $nodes, $global_settings );
			
			if ( ! defined( 'WP_DEBUG' ) || ! WP_DEBUG ) {
				try {
				    $min = FLJSMin::minify( $js );
				} catch (Exception $e) {}

				if ( $min ) {
				    $js = $min;
				}
			}
			
			file_put_contents( $path, $js );
			
			@chmod( $path, 0644 );
			
			do_action( 'fl_builder_after_render_js' );
		}
	}

	/**
	 * Renders the JS used for all builder layouts.
	 *
	 * @since 1.8.2
	 * @return string
	 */
	static public function render_global_js()
	{
		$global_settings = FLBuilderModel::get_global_settings();
		$js = '';

		// Add the path legacy vars (FLBuilderLayoutConfig.paths should be used instead).
		$js .= "var wpAjaxUrl = '" . admin_url('admin-ajax.php') . "';";
		$js .= "var flBuilderUrl = '" . FL_BUILDER_URL . "';";
		
		// Layout config object.
		ob_start();
		include FL_BUILDER_DIR . 'includes/layout-js-config.php';
		$js .= ob_get_clean();

		// Core layout JS.
		$js .= file_get_contents(FL_BUILDER_DIR . 'js/fl-builder-layout.js');
				
		// Add the global settings JS.
		$js .= $global_settings->js;
		
		return $js;
	}

	/**
	 * Renders the JavaScript for a single row.
	 *
	 * @since 1.7
	 * @param string|object $row_id A row ID or object.
	 * @return string
	 */
	static public function render_row_js( $row_id )
	{
		$row 		= is_object( $row_id ) ? $row_id : FLBuilderModel::get_node( $row_id );
		$settings   = $row->settings;
		$id         = $row->node;

		ob_start();
		include FL_BUILDER_DIR . 'includes/row-js.php';
		return ob_get_clean();
	}

	/**
	 * Renders the JavaScript for all modules in a single row.
	 *
	 * @since 1.7
	 * @param string|object $row_id A row ID or object.
	 * @return string
	 */
	static public function render_row_modules_js( $row_id )
	{
		$row 				= is_object( $row_id ) ? $row_id : FLBuilderModel::get_node( $row_id );
		$nodes 				= FLBuilderModel::get_categorized_nodes();
		$template_post_id 	= FLBuilderModel::is_node_global( $row );
		$compiled 			= array();
		$js					= '';

		// Render the JS.
		foreach( $nodes['groups'] as $group ) {
			if ( $row->node == $group->parent || ( $template_post_id && $row->template_node_id == $group->parent ) ) {
				foreach( $nodes['columns'] as $column ) {
					if ( $group->node == $column->parent ) {
						foreach( $nodes['modules'] as $module ) {
							if ( $column->node == $module->parent ) {
								$js .= self::render_module_js( $module, $compiled );
							}
						}
					}
				}
			}
		}
		
		// Return the JS.
		return $js;
	}

	/**
	 * Renders the JavaScript for all modules in a single column.
	 *
	 * @since 1.7
	 * @param string|object $col_id A column ID or object.
	 * @return string
	 */
	static public function render_column_modules_js( $col_id )
	{
		$col 		= is_object( $col_id ) ? $col_id : FLBuilderModel::get_node( $col_id );
		$nodes 		= FLBuilderModel::get_categorized_nodes();
		$compiled 	= array();
		$js			= '';
		
		// Render the JS.
		foreach( $nodes['modules'] as $module ) {
			if ( $col->node == $module->parent ) {
				$js .= self::render_module_js( $module, $compiled );
			}
		}
		
		// Return the JS.
		return $js;
	}

	/**
	 * Renders the JavaScript for a single module.
	 *
	 * @since 1.7
	 * @param string|object $module_id A module ID or object.
	 * @param array $compiled An array of module types that have already has frontend.js compiled.
	 * @return string
	 */
	static public function render_module_js( $module_id, &$compiled = array() )
	{
		$module 			= is_object( $module_id ) ? $module_id : FLBuilderModel::get_module( $module_id );
		$global_settings    = FLBuilderModel::get_global_settings();
		$js     			= '';
		
		// Global module JS
		$file = $module->dir . 'js/frontend.js';

		if ( file_exists( $file ) && ! in_array( $module->settings->type, $compiled ) ) {
			$js .= "\n" . file_get_contents( $file );
			$compiled[] = $module->settings->type;
		}

		// Instance module JS
		$file       = $module->dir . 'includes/frontend.js.php';
		$settings   = $module->settings;
		$id         = $module->node;

		if ( file_exists( $file ) ) {
			ob_start();
			include $file;
			$js .= ob_get_clean();
		}
		
		// Return the JS.
		return $js;
	}

	/**
	 * Renders the custom CSS or JS for all global nodes in a layout. 
	 *
	 * @since 1.7
	 */
	static public function render_global_nodes_custom_code( $type = 'css' )
	{
		$code 		 = '';
		$rendered 	 = array();
		
		if ( ! FLBuilderModel::is_post_node_template() ) {
			
			$nodes 		 = FLBuilderModel::get_layout_data();
			$node_status = FLBuilderModel::get_node_status();
			
			foreach( $nodes as $node_id => $node ) {
				
				$template_post_id = FLBuilderModel::is_node_global( $node );
				
				if ( $template_post_id && ! in_array( $template_post_id, $rendered ) ) {
					
					$rendered[] = $template_post_id;
					$code .= FLBuilderModel::get_layout_settings( $node_status, $template_post_id )->{ $type };
				}
			}
		}
		
		return $code;
	}

	/**
	 * Custom logging function that handles objects and arrays.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function log()
	{
		foreach ( func_get_args() as $arg ) {
			ob_start();
			print_r( $arg );
			error_log( ob_get_clean() );
		}
	}

	/**
	 * @since 1.0
	 * @deprecated 1.7.4
	 */
	static public function layout_styles_scripts( $post_id )
	{
		_deprecated_function( __METHOD__, '1.7.4', __CLASS__ . '::enqueue_layout_styles_scripts()' );
		
		self::enqueue_layout_styles_scripts( $post_id );
	}

	/**
	 * @since 1.0
	 * @deprecated 1.7.4
	 */
	static public function styles_scripts()
	{
		_deprecated_function( __METHOD__, '1.7.4', __CLASS__ . '::enqueue_ui_styles_scripts()' );
		
		self::enqueue_ui_styles_scripts();
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function register_templates_post_type()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplates::register_post_type()' );
		
		if ( class_exists( 'FLBuilderUserTemplates' ) ) {
			FLBuilderUserTemplates::register_post_type();
		}
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function render_template( $template )
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplates::template_include()' );
		
		if ( class_exists( 'FLBuilderUserTemplates' ) ) {
			FLBuilderUserTemplates::template_include();
		}
	}

	/**
	 * @since 1.6.3
	 * @deprecated 1.8
	 */
	static public function render_ui_panel_node_templates()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplates::render_ui_panel_node_templates()' );
		
		if ( class_exists( 'FLBuilderUserTemplates' ) ) {
			FLBuilderUserTemplates::render_ui_panel_node_templates();
		}
	}

	/**
	 * @since 1.0
	 * @deprecated 1.8
	 */
	static public function render_user_template_settings()
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplates::render_settings()' );
		
		if ( class_exists( 'FLBuilderUserTemplates' ) ) {
			FLBuilderUserTemplates::render_settings();
		}
	}

	/**
	 * @since 1.6.3
	 * @deprecated 1.8
	 */
	static public function render_node_template_settings( $node_id = null )
	{
		_deprecated_function( __METHOD__, '1.8', 'FLBuilderUserTemplates::render_node_settings()' );
		
		if ( class_exists( 'FLBuilderUserTemplates' ) ) {
			FLBuilderUserTemplates::render_node_settings( $node_id );
		}
	}
}

FLBuilder::init();
