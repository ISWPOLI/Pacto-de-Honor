<?php

/**
 * Front-end AJAX handler for the builder interface. We use this 
 * instead of wp_ajax because that only works in the admin and 
 * certain things like some shortcodes won't render there. AJAX
 * requests handled through this method only run for logged in users
 * for extra security. Developers creating custom modules that need
 * AJAX should use wp_ajax instead.
 *
 * @since 1.7
 */
final class FLBuilderAJAX {

	/**
	 * An array of registered action data.
	 *
	 * @since 1.7
	 * @access private
	 * @var array $actions
	 */
	static private $actions = array();

	/**
	 * Initializes hooks.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function init()
	{
		add_action( 'wp', __CLASS__ . '::run' );
	}

	/**
	 * Runs builder's frontend AJAX.
	 *
	 * @since 1.7
	 * @return void
	 */
	static public function run()
	{
		self::add_actions();
		self::call_action();
	}

	/**
	 * Adds a callable AJAX action.
	 *
	 * @since 1.7
	 * @param string $action The action name.
	 * @param string $method The method to call.
	 * @param array $args An array of method arg names that are present in the post data.
	 * @return void
	 */
	static public function add_action( $action, $method, $args = array() )
	{
		self::$actions[ $action ] = array(
			'action' => $action,
			'method' => $method,
			'args'	 => $args
		);
	}

	/**
	 * Removes an AJAX action.
	 *
	 * @since 1.8
	 * @param string $action The action to remove.
	 * @return void
	 */
	static public function remove_action( $action )
	{
		if ( isset( self::$actions[ $action ] ) ) {
			unset( self::$actions[ $action ] );
		}
	}

	/**
	 * Adds all callable AJAX actions.
	 *
	 * @since 1.7
	 * @access private
	 * @return void
	 */
	static private function add_actions()
	{
		// FLBuilder
		self::add_action( 'render_settings_form', 'FLBuilder::render_settings_form', array( 'type', 'settings' ) );
		self::add_action( 'render_row_settings', 'FLBuilder::render_row_settings', array( 'node_id' ) );
		self::add_action( 'render_column_settings', 'FLBuilder::render_column_settings', array( 'node_id' ) );
		self::add_action( 'render_module_settings', 'FLBuilder::render_module_settings', array( 'node_id', 'type', 'parent_id' ) );
		self::add_action( 'render_layout_settings', 'FLBuilder::render_layout_settings' );
		self::add_action( 'render_global_settings', 'FLBuilder::render_global_settings' );
		self::add_action( 'render_template_selector', 'FLBuilder::render_template_selector' );
		self::add_action( 'render_icon_selector', 'FLBuilder::render_icon_selector' );
		
		// FLBuilderModel
		self::add_action( 'delete_node', 'FLBuilderModel::delete_node', array( 'node_id' ) );
		self::add_action( 'delete_col', 'FLBuilderModel::delete_col', array( 'node_id', 'new_width' ) );
		self::add_action( 'reorder_node', 'FLBuilderModel::reorder_node', array( 'node_id', 'position' ) );
		self::add_action( 'reorder_col', 'FLBuilderModel::reorder_col', array( 'node_id', 'position' ) );
		self::add_action( 'move_node', 'FLBuilderModel::move_node', array( 'node_id', 'new_parent', 'position' ) );
		self::add_action( 'move_col', 'FLBuilderModel::move_col', array( 'node_id', 'new_parent', 'position', 'resize' ) );
		self::add_action( 'resize_cols', 'FLBuilderModel::resize_cols', array( 'col_id', 'col_width', 'sibling_id', 'sibling_width' ) );
		self::add_action( 'reset_col_widths', 'FLBuilderModel::reset_col_widths', array( 'group_id' ) );
		self::add_action( 'save_settings', 'FLBuilderModel::save_settings', array( 'node_id', 'settings' ) );
		self::add_action( 'save_layout_settings', 'FLBuilderModel::save_layout_settings', array( 'settings' ) );
		self::add_action( 'save_global_settings', 'FLBuilderModel::save_global_settings', array( 'settings' ) );
		self::add_action( 'save_color_presets', 'FLBuilderModel::save_color_presets', array( 'presets' ) );
		self::add_action( 'duplicate_post', 'FLBuilderModel::duplicate_post' );
		self::add_action( 'duplicate_wpml_layout', 'FLBuilderModel::duplicate_wpml_layout', array( 'original_post_id', 'post_id' ) );
		self::add_action( 'apply_user_template', 'FLBuilderModel::apply_user_template', array( 'template_id', 'append' ) );
		self::add_action( 'apply_template', 'FLBuilderModel::apply_template', array( 'template_id', 'append' ) );
		self::add_action( 'save_layout', 'FLBuilderModel::save_layout' );
		self::add_action( 'save_draft', 'FLBuilderModel::save_draft' );
		self::add_action( 'clear_draft_layout', 'FLBuilderModel::clear_draft_layout' );
		self::add_action( 'disable_builder', 'FLBuilderModel::disable' );
		
		// FLBuilderAJAXLayout
		self::add_action( 'render_layout', 'FLBuilderAJAXLayout::render' );
		self::add_action( 'render_new_row', 'FLBuilderAJAXLayout::render_new_row', array( 'cols', 'position', 'template_id', 'template_type' ) );
		self::add_action( 'copy_row', 'FLBuilderAJAXLayout::copy_row', array( 'node_id' ) );
		self::add_action( 'render_new_column_group', 'FLBuilderAJAXLayout::render_new_column_group', array( 'node_id', 'cols', 'position' ) );
		self::add_action( 'render_new_columns', 'FLBuilderAJAXLayout::render_new_columns', array( 'node_id', 'insert', 'type', 'nested' ) );
		self::add_action( 'render_new_module', 'FLBuilderAJAXLayout::render_new_module', array( 'parent_id', 'position', 'type', 'template_id', 'template_type' ) );
		self::add_action( 'copy_module', 'FLBuilderAJAXLayout::copy_module', array( 'node_id' ) );
		
		// FLBuilderServices
		self::add_action( 'render_service_settings', 'FLBuilderServices::render_settings' );
		self::add_action( 'render_service_fields', 'FLBuilderServices::render_fields' );
		self::add_action( 'connect_service', 'FLBuilderServices::connect_service' );
		self::add_action( 'delete_service_account', 'FLBuilderServices::delete_account' );
		self::add_action( 'delete_service_account', 'FLBuilderServices::delete_account' );
		
		// FLBuilderAutoSuggest
		self::add_action( 'fl_builder_autosuggest', 'FLBuilderAutoSuggest::init' );
	}

	/**
	 * Runs the current AJAX action.
	 *
	 * @since 1.7
	 * @access private
	 * @return void
	 */
	static private function call_action()
	{
		// Only run for logged in users.
		if ( ! is_user_logged_in() ) {
			return;
		}
		
		// Verify the AJAX nonce.
		if ( ! self::verify_nonce() ) {
			return;	
		}

		// Get the $_POST data.
		$post_data = FLBuilderModel::get_post_data();
		
		// Get the post ID.
		$post_id = FLBuilderModel::get_post_id();
		
		// Make sure we have a post ID.
		if ( ! $post_id ) {
			return;
		}
		
		// Make sure the user can edit this post.
		if ( ! current_user_can( 'edit_post', $post_id ) ) {
			return;
		}

		// Get the action.
		if ( ! empty( $_REQUEST['fl_action'] ) ) {
			$action = $_REQUEST['fl_action'];
		}
		else if( ! empty( $post_data['fl_action'] ) ) {
			$action = $post_data['fl_action'];
		}
		else {
			return;
		}
		
		// Allow developers to modify actions before they are called.
		do_action( 'fl_ajax_before_call_action', $action );
		
		// Make sure the action exists.
		if ( ! isset( self::$actions[ $action ] ) ) {
			return;
		}
		
		// Get the action data.
		$action 	= self::$actions[ $action ];
		$args   	= array();
		$keys_args  = array();
		
		// Build the args array.
		foreach ( $action['args'] as $arg ) {
			$args[] = $keys_args[ $arg ] = isset( $post_data[ $arg ] ) ? $post_data[ $arg ] : null;
		}

		// Tell WordPress this is an AJAX request.
		if ( ! defined( 'DOING_AJAX' ) ) {
			define( 'DOING_AJAX', true );
		}
		
		// Allow developers to hook before the action runs.
		do_action( 'fl_ajax_before_' . $action['action'], $keys_args );

		// Call the action and allow developers to filter the result.
		$result = apply_filters( 'fl_ajax_' . $action['action'], call_user_func_array( $action['method'], $args ), $keys_args );
		
		// Allow developers to hook after the action runs.
		do_action( 'fl_ajax_after_' . $action['action'], $keys_args );
		
		// JSON encode the result.
		echo json_encode( $result );
		
		// Complete the request.
		die();
	}

	/**
	 * Checks to make sure the AJAX nonce is valid.
	 *
	 * @since 1.7.2
	 * @access private
	 * @return bool
	 */
	static private function verify_nonce()
	{
		$post_data 	= FLBuilderModel::get_post_data();
		$nonce 		= false;
		
		if ( isset( $post_data['_wpnonce'] ) ) {
			$nonce = $post_data['_wpnonce'];
		}
		else if ( isset( $_REQUEST['_wpnonce'] ) ) {
			$nonce = $_REQUEST['_wpnonce'];
		}
		
		if ( ! $nonce || ! wp_verify_nonce( $nonce, 'fl_ajax_update' ) ) {
			return false;	
		}
		
		return true;
	}
}

FLBuilderAJAX::init();