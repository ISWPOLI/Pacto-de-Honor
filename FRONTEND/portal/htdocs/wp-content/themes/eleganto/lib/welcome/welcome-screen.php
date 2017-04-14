<?php

/**
 * Welcome Screen Class
 */
class eleganto_Welcome {

	/**
	 * Constructor for the welcome screen
	 */
	public function __construct() {
		/* create dashbord page */
		add_action( 'admin_menu', array( $this, 'eleganto_welcome_register_menu' ) );
		/* activation notice */
		add_action( 'admin_enqueue_scripts', array( $this, 'eleganto_welcome_style_and_scripts' ) );

		/* load welcome screen */
		add_action( 'eleganto_welcome', array( $this, 'eleganto_welcome_getting_started' ), 10 );
		add_action( 'eleganto_welcome', array( $this, 'eleganto_welcome_actions_required' ), 20 );
		add_action( 'eleganto_welcome', array( $this, 'eleganto_welcome_contribute' ), 30 );
		add_action( 'eleganto_welcome', array( $this, 'eleganto_welcome_support' ), 40 );

		/* activation notice */
		add_action( 'load-themes.php', array( $this, 'eleganto_activation_admin_notice' ) );
	}

	/**
	 * Adds an admin notice upon successful activation.
	 */
	public function eleganto_activation_admin_notice() {
		global $pagenow;

		if ( is_admin() && ('themes.php' == $pagenow) && isset( $_GET[ 'activated' ] ) ) {
			add_action( 'admin_notices', array( $this, 'eleganto_welcome_admin_notice' ), 99 );
		}
	}

	/**
	 * Display an admin notice linking to the welcome screen
	 */
	public function eleganto_welcome_admin_notice() {
		// Get Theme Details from style.css
		$theme = wp_get_theme();
		?>
		<div class="updated notice is-dismissible">
			<p><?php printf( esc_html( 'Welcome! Thank you for choosing %1s! To fully take advantage of the best our theme can offer please make sure you visit our %2s.', 'eleganto' ), $theme->get( 'Name' ), '<a href="' . esc_url( admin_url( 'themes.php?page=eleganto-welcome' ) ) . '">' . esc_html( 'welcome page', 'eleganto' ) . '</a>' ); ?></p>
			<p><a href="<?php echo esc_url( admin_url( 'themes.php?page=eleganto-welcome' ) ); ?>" class="button" style="text-decoration: none;"><?php printf( esc_html( 'Get started with %1s', 'eleganto' ), $theme->get( 'Name' ) ); ?></a></p>
		</div>
		<?php
	}

	/**
	 * Creates the dashboard page
	 * @see  add_theme_page()
	 */
	public function eleganto_welcome_register_menu() {
		// Get Theme Details from style.css
		$theme = wp_get_theme();
		add_theme_page( 'About Eleganto', sprintf( __( 'About %s', 'eleganto' ), $theme->get( 'Name' ) ), 'activate_plugins', 'eleganto-welcome', array( $this, 'eleganto_welcome_screen' ) );
	}

	/**
	 * Load welcome screen css and javascript
	 */
	public function eleganto_welcome_style_and_scripts( $hook_suffix ) {
		if ( 'appearance_page_eleganto-welcome' == $hook_suffix ) {
			wp_enqueue_style( 'eleganto-welcome-screen-css', get_template_directory_uri() . '/lib/welcome/css/welcome.css' );
			wp_enqueue_script( 'eleganto-welcome-screen-js', get_template_directory_uri() . '/lib/welcome/js/welcome.js', array( 'jquery' ) );
		}
	}

	/**
	 * Welcome screen content
	 */
	public function eleganto_welcome_screen() {
		?>

		<ul class="eleganto-nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#getting_started" aria-controls="getting_started" role="tab" data-toggle="tab"><?php esc_html_e( 'Getting started', 'eleganto' ); ?></a></li>
			<li role="presentation" class="eleganto-tab eleganto-w-red-tab"><a href="#actions_required" aria-controls="actions_required" role="tab" data-toggle="tab"><?php esc_html_e( 'Actions recommended', 'eleganto' ); ?></a></li>
			<li role="presentation"><a href="#contribute" aria-controls="contribute" role="tab" data-toggle="tab"><?php esc_html_e( 'Contribute', 'eleganto' ); ?></a></li>
			<li role="presentation"><a href="#support" aria-controls="support" role="tab" data-toggle="tab"><?php esc_html_e( 'Support', 'eleganto' ); ?></a></li>
		</ul>

		<div class="eleganto-tab-content">

		<?php do_action( 'eleganto_welcome' ); ?>

		</div>
		<?php
	}

	/**
	 * Getting started
	 */
	public function eleganto_welcome_getting_started() {
		require_once( get_template_directory() . '/lib/welcome/sections/getting-started.php' );
	}

	/**
	 * Actions required
	 */
	public function eleganto_welcome_actions_required() {
		require_once( get_template_directory() . '/lib/welcome/sections/actions-required.php' );
	}

	/**
	 * Contribute
	 */
	public function eleganto_welcome_contribute() {
		require_once( get_template_directory() . '/lib/welcome/sections/contribute.php' );
	}

	/**
	 * Support
	 */
	public function eleganto_welcome_support() {
		require_once( get_template_directory() . '/lib/welcome/sections/support.php' );
	}

}

$GLOBALS[ 'eleganto_Welcome' ] = new eleganto_Welcome();
