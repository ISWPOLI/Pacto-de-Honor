<?php

/**
 * Manages remote updates for all Beaver Builder products.
 *
 * @since 1.0
 */
final class FLUpdater {

	/**
	 * The API URL for the Beaver Builder update server.
	 *
	 * @since 1.0
	 * @access private
	 * @var string $_updates_api_url
	 */
	static private $_updates_api_url = 'http://updates.wpbeaverbuilder.com/';

	/**
	 * An internal array of data for each product.
	 *
	 * @since 1.0
	 * @access private
	 * @var array $_products
	 */
	static private $_products = array();

	/**
	 * An internal array of remote responses with
	 * update data for each product.
	 *
	 * @since 1.8.4
	 * @access private
	 * @var array $_responses
	 */
	static private $_responses = array();

	/**
	 * An internal array of settings for the updater instance.
	 *
	 * @since 1.0
	 * @access private
	 * @var array $settings
	 */
	private $settings = array();

	/**
	 * Updater constructor method.
	 *
	 * @since 1.0
	 * @param array $settings An array of settings for this instance.
	 * @return void
	 */
	public function __construct( $settings = array() )
	{
		$this->settings = $settings;

		if ( 'plugin' == $settings['type'] ) {
			add_filter( 'pre_set_site_transient_update_plugins', array( $this, 'update_check' ) );
			add_filter( 'plugins_api', array( $this, 'plugin_info' ), 10, 3 );
			add_action( 'in_plugin_update_message-' . self::get_plugin_file( $settings['slug'] ), array( $this, 'update_message' ), 1, 2 );
		}
		else if ( $settings['type'] == 'theme' ) {
			add_filter( 'pre_set_site_transient_update_themes', array( $this, 'update_check' ) );
		}
	}

	/**
	 * Get the update data response from the API.
	 *
	 * @since 1.7.7
	 * @return object
	 */
	public function get_response()
	{
		$slug = $this->settings['slug'];

		if ( isset( FLUpdater::$_responses[ $slug ] ) ) {
			return FLUpdater::$_responses[ $slug ];
		}

		FLUpdater::$_responses[ $slug ] = FLUpdater::api_request( FLUpdater::$_updates_api_url, array(
			'fl-api-method' => 'update_info',
			'license'       => FLUpdater::get_subscription_license(),
			'domain'        => network_home_url(),
			'product'       => $this->settings['name'],
			'slug'          => $this->settings['slug'],
			'version'       => $this->settings['version'],
			'php'           => phpversion()
		) );

		return FLUpdater::$_responses[ $slug ];
	}

	/**
	 * Checks to see if an update is available for the current product.
	 *
	 * @since 1.0
	 * @param object $transient A WordPress transient object with update data.
	 * @return object
	 */
	public function update_check( $transient )
	{
		global $pagenow;

		if( 'plugins.php' == $pagenow && is_multisite() ) {
			return $transient;
		}
		if ( ! is_object( $transient ) ) {
			$transient = new stdClass();
		}
		if ( ! isset( $transient->checked ) ) {
			$transient->checked = array();
		}

		$response = $this->get_response();

		if( ! isset( $response->error ) ) {

			$transient->last_checked = time();
			$transient->checked[ $this->settings['slug'] ] = $this->settings['version'];

			if($this->settings['type'] == 'plugin') {

				$plugin = self::get_plugin_file($this->settings['slug']);

				if ( version_compare( $response->new_version, $this->settings['version'], '>' ) ) {

					$transient->response[ $plugin ] 				= new stdClass();
					$transient->response[ $plugin ]->slug 			= $response->slug;
					$transient->response[ $plugin ]->new_version 	= $response->new_version;
					$transient->response[ $plugin ]->url 			= $response->homepage;
					$transient->response[ $plugin ]->package 		= $response->package;

					if ( empty( $response->package ) ) {
						$transient->response[ $plugin ]->upgrade_notice = FLUpdater::get_update_error_message();
					}
				}
			}
			else if($this->settings['type'] == 'theme') {

				if(version_compare($response->new_version, $this->settings['version'], '>')) {

					$transient->response[$this->settings['slug']] = array(
						'new_version'   => $response->new_version,
						'url'           => $response->homepage,
						'package'       => $response->package
					);
				}
			}
		}

		return $transient;
	}

	/**
	 * Retrives the data for the plugin info lightbox.
	 *
	 * @since 1.0
	 * @param bool $false
	 * @param string $action
	 * @param object $args
	 * @return object|bool
	 */
	public function plugin_info($false, $action, $args)
	{
		if ( 'plugin_information' != $action ) {
			return $false;
		}
		if(!isset($args->slug) || $args->slug != $this->settings['slug']) {
			return $false;
		}

		$response = $this->get_response();

		if( ! isset( $response->error ) ) {

			$info 					= new stdClass();
			$info->name     		= $this->settings['name'];
			$info->version			= $response->new_version;
			$info->slug				= $response->slug;
			$info->plugin_name		= $response->plugin_name;
			$info->author			= $response->author;
			$info->homepage			= $response->homepage;
			$info->requires			= $response->requires;
			$info->tested			= $response->tested;
			$info->last_updated		= $response->last_updated;
			$info->download_link	= $response->package;
			$info->sections 		= (array)$response->sections;

			return $info;
		}

		return $false;
	}

	/**
	 * Shows an update message on the plugins page if an update
	 * is available but there is no active subscription.
	 *
	 * @since 1.0
	 * @param array $plugin_data An array of data for this plugin.
	 * @param object $response An object with update data for this plugin.
	 * @return void
	 */
	public function update_message( $plugin_data, $response )
	{
		if ( empty( $response->package ) ) {
			echo FLUpdater::get_update_error_message( $plugin_data );
		}
	}

	/**
	 * Static method for initializing an instance of the updater
	 * for each active product.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function init()
	{
		include FL_UPDATER_DIR . 'includes/config.php';

		foreach($config as $path) {
			if(file_exists($path)) {
				require_once $path;
			}
		}
	}

	/**
	 * Static method for adding a product to the updater and
	 * creating the new instance.
	 *
	 * @since 1.0
	 * @param array $args An array of settings for the product.
	 * @return void
	 */
	static public function add_product($args = array())
	{
		if(is_array($args) && isset($args['slug'])) {

			if($args['type'] == 'plugin') {
				if(file_exists(WP_CONTENT_DIR . '/plugins/' . $args['slug'])) {
					self::$_products[$args['name']] = $args;
					new FLUpdater(self::$_products[$args['name']]);
				}
			}
			if($args['type'] == 'theme') {
				if(file_exists(WP_CONTENT_DIR . '/themes/' . $args['slug'])) {
					self::$_products[$args['name']] = $args;
					new FLUpdater(self::$_products[$args['name']]);
				}
			}
		}
	}

	/**
	 * Static method for rendering the license form.
	 *
	 * @since 1.0
	 * @return void
	 */
	static public function render_form()
	{
		// Activate a subscription?
		if(isset($_POST['fl-updater-nonce'])) {
			if(wp_verify_nonce($_POST['fl-updater-nonce'], 'updater-nonce')) {
				self::save_subscription_license($_POST['license']);
			}
		}

		$license 	  = self::get_subscription_license();
		$subscription = self::get_subscription_info();

		// Include the form ui.
		include FL_UPDATER_DIR . 'includes/form.php';
	}

	/**
	 * Renders available subscriptions and downloads.
	 *
	 * @since 1.10
	 * @param object $subscription
	 * @return void
	 */
	static public function render_subscriptions( $subscription )
	{
		if ( ! $subscription->active || ! $subscription->domain->active || ! isset( $subscription->downloads ) || isset( $subscription->error ) ) {
			return;
		}
		
		include FL_UPDATER_DIR . 'includes/subscriptions.php';
	}

	/**
	 * Static method for getting the subscription license key.
	 *
	 * @since 1.0
	 * @return string
	 */
	static public function get_subscription_license()
	{
		$value = get_site_option('fl_themes_subscription_email');

		return $value ? $value : '';
	}

	/**
	 * Static method for updating the subscription license.
	 *
	 * @since 1.0
	 * @param string $license The new license key.
	 * @return void
	 */
	static public function save_subscription_license($license)
	{
		FLUpdater::api_request(self::$_updates_api_url, array(
			'fl-api-method' => 'activate_domain',
			'license'       => $license,
			'domain'        => network_home_url(),
			'products'		=> json_encode( self::$_products )
		));

		update_site_option('fl_themes_subscription_email', $license);
	}

	/**
	 * Static method for retrieving the subscription info.
	 *
	 * @since 1.0
	 * @return bool
	 */
	static public function get_subscription_info()
	{
		return self::api_request(self::$_updates_api_url, array(
			'fl-api-method' => 'subscription_info',
			'domain'        => network_home_url(),
			'license'       => FLUpdater::get_subscription_license()
		));
	}

	/**
	 * Returns an update message for if an update
	 * is available but there is no active subscription.
	 *
	 * @since 1.6.4.3
	 * @param array $plugin_data An array of data for this plugin.
	 * @return string
	 */
	static private function get_update_error_message( $plugin_data = null )
	{
		$message  = '';
		$message .= '<p style="padding:10px 20px; margin-top: 10px; background: #d54e21; color: #fff;">';
		$message .= __( '<strong>UPDATE UNAVAILABLE!</strong>', 'fl-builder' );
		$message .= '&nbsp;&nbsp;&nbsp;';
		$message .= __('Please subscribe to enable automatic updates for this plugin.', 'fl-builder');

		if ( $plugin_data && isset( $plugin_data['PluginURI'] ) ) {
			$message .= ' <a href="' . $plugin_data['PluginURI'] . '" target="_blank" style="color: #fff; text-decoration: underline;">';
			$message .= __('Subscribe Now', 'fl-builder');
			$message .= ' &raquo;</a>';
		}

		$message .= '</p>';

		return $message;
	}

	/**
	 * Static method for retrieving the plugin file path for a
	 * product relative to the plugins directory.
	 *
	 * @since 1.0
	 * @access private
	 * @param string $slug The product slug.
	 * @return string
	 */
	static private function get_plugin_file( $slug )
	{
		if ( 'bb-plugin' == $slug ) {
			$file = $slug . '/fl-builder.php';
		}
		else {
			$file = $slug . '/' . $slug . '.php';
		}

		return $file;
	}

	/**
	 * Static method for sending a request to the store
	 * or update API.
	 *
	 * @since 1.0
	 * @access private
	 * @param string $api_url The API URL to use.
	 * @param array $args An array of args to send along with the request.
	 * @return mixed The response or false if there is an error.
	 */
	static private function api_request($api_url = false, $args = array())
	{
		if($api_url) {

			$params = array();

			foreach($args as $key => $val) {
				$params[] = $key . '=' . urlencode($val);
			}

			return self::remote_get($api_url . '?' . implode('&', $params));
		}

		return false;
	}

	/**
	 * Get a remote response.
	 *
	 * @since 1.0
	 * @access private
	 * @param string $url The URL to get.
	 * @return mixed The response or false if there is an error.
	 */
	static private function remote_get($url)
	{
		$request      = wp_remote_get($url);
		$error        = new stdClass();
		$error->error = 'connection';

		if(is_wp_error($request)) {
			return $error;
		}
		if(wp_remote_retrieve_response_code($request) != 200) {
			return $error;
		}

		$body = wp_remote_retrieve_body($request);

		if(is_wp_error($body)) {
			return $error;
		}

		$body_decoded = json_decode($body);

		if(!is_object($body_decoded)) {
			return $error;
		}

		return $body_decoded;
	}
}
