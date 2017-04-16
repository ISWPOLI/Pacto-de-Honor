<?php

/**
 * Handles the rendering of the layout for AJAX refreshes.
 *
 * @since 1.7
 */
final class FLBuilderAJAXLayout {

	/**
	 * An array with data for partial refreshes.
	 *
	 * @since 1.7
	 * @access private
	 * @var array $partial_refresh_data
	 */
	static private $partial_refresh_data = null;

	/**
	 * Renders the layout data to be passed back to the builder.
	 *
	 * @since 1.7
	 * @param string $node_id The ID of a node to try and render instead of the entire layout.
	 * @param string $old_node_id The ID of a node that has been replaced in the layout.
	 * @return array
	 */
	static public function render( $node_id = null, $old_node_id = null )
	{
		// Update the node ID in the post data?
		if ( $node_id ) {
			FLBuilderModel::update_post_data( 'node_id', $node_id );
		}
		
		// Render the draft layout CSS that will be passed back.
		FLBuilder::render_assets();

		// Register scripts needed for shortcodes and widgets.
		self::register_scripts();
		
		// Dequeue scripts and styles to only capture those that are needed.
		self::dequeue_scripts_and_styles();
		
		// Get the partial refresh data.
		$partial_refresh_data = self::get_partial_refresh_data();
		
		// Render the markup.
		$html = self::render_html();
		
		// Render scripts and styles.
		$scripts_styles = self::render_scripts_and_styles();
		
		// Render the assets.
		$assets = self::render_assets();

		// Return the response.
		return array(
			'partial'			=> $partial_refresh_data['is_partial_refresh'],
			'nodeId'			=> $partial_refresh_data['node_id'],
			'nodeType'			=> $partial_refresh_data['node_type'],
			'oldNodeId'			=> $old_node_id,
			'html' 				=> $html,
			'scriptsStyles'		=> $scripts_styles,
			'css'  				=> $assets['css'],
			'js'   				=> $assets['js']
		);
	}

	/**
	 * Renders the layout data for a new row.
	 *
	 * @since 1.7
	 * @param string $cols The type of column layout to use.
	 * @param int $position The position of the new row in the layout.
	 * @param string $template_id The ID of a row template to render.
	 * @param string $template_type The type of template. Either "user" or "core".
	 * @return array
	 */
	static public function render_new_row( $cols = '1-col', $position = false, $template_id = null, $template_type = 'user' )
	{
		// Add a row template?
		if ( null !== $template_id ) {
			
			if ( 'core' == $template_type ) {
				$template = FLBuilderModel::get_template( $template_id, 'row' );
				$row      = FLBuilderModel::apply_node_template( $template_id, null, $position, $template );
			}
			else {
				$row = FLBuilderModel::apply_node_template( $template_id, null, $position );
			}
			
			// Return the response.
			return self::render( $row->node );
		}
		// Add a standard row.
		else {
			
			// Add the row.
			$row = FLBuilderModel::add_row( $cols, $position );
			
			// Render the row.
			ob_start();
			FLBuilder::render_row( $row );
			$html = ob_get_clean();
			
			// Return the response.	
			return array(
				'partial'	=> true,
				'nodeType'	=> $row->type,
				'html' 		=> $html,
				'js'		=> 'FLBuilder._renderLayoutComplete();'
			);
		}
	}

	/**
	 * Renders the layout data for a copied row.
	 *
	 * @since 1.7
	 * @param string $node_id The ID of a row to copy.
	 * @return array
	 */
	static public function copy_row( $node_id )
	{
		$row = FLBuilderModel::copy_row( $node_id );
		
		return self::render( $row->node );
	}

	/**
	 * Renders the layout data for a new column group.
	 *
	 * @since 1.7
	 * @param string $node_id The node ID of a row to add the new group to.
	 * @param string $cols The type of column layout to use.
	 * @param int $position The position of the new column group in the row.
	 * @return array
	 */
	static public function render_new_column_group( $node_id, $cols = '1-col', $position = false )
	{
		// Add the group.
		$group = FLBuilderModel::add_col_group( $node_id, $cols, $position );
		
		// Render the group.
		ob_start();
		FLBuilder::render_column_group( $group );
		$html = ob_get_clean();

		// Return the response.	
		return array(
			'partial'	=> true,
			'nodeType'	=> $group->type,
			'html' 		=> $html,
			'js'		=> 'FLBuilder._renderLayoutComplete();'
		);
	}

	/**
	 * Renders the layout data for a new column or columns.
	 *
	 * @since 1.7
	 * @param string $node_id Node ID of the column to insert before or after.
	 * @param string $insert Either before or after.
	 * @param string $type The type of column(s) to insert.
	 * @param boolean $nested Whether these columns are nested or not.
	 * @return array
	 */
	static public function render_new_columns( $node_id, $insert, $type, $nested )
	{
		// Add the column(s).
		$group = FLBuilderModel::add_cols( $node_id, $insert, $type, $nested );

		// Return the response.	
		return self::render( $group->node );
	}

	/**
	 * Renders the layout data for a new module.
	 *
	 * @since 1.7
	 * @param string $parent_id A column node ID.
	 * @param int $position The new module position.
	 * @param string $type The type of module.
	 * @param string $template_id The ID of a module template to render.
	 * @param string $template_type The type of template. Either "user" or "core".
	 * @return array
	 */
	static public function render_new_module( $parent_id, $position = false, $type = null, $template_id = null, $template_type = 'user' )
	{
		// Add a module template?
		if ( null !== $template_id ) {
			
			if ( 'core' == $template_type ) {
				$template = FLBuilderModel::get_template( $template_id, 'module' );
				$module   = FLBuilderModel::apply_node_template( $template_id, $parent_id, $position, $template );
			}
			else {
				$module = FLBuilderModel::apply_node_template( $template_id, $parent_id, $position );	
			}
		}
		// Add a standard module.
		else {
			$module = FLBuilderModel::add_default_module( $parent_id, $type, $position );
		}
		
		// Render the new module's settings.
		$settings = FLBuilder::render_module_settings( $module->node, $module->settings->type, $module->parent, false );

		// Maybe render the module's parent for a partial refresh?
		if ( $module->partial_refresh ) {
		
			// Get the new module parent.
			$parent = ! $parent_id ? null : FLBuilderModel::get_node( $parent_id );
			
			// Get the node to render.
			if ( ! $parent ) {
				$row 		= FLBuilderModel::get_module_parent( 'row', $module );
				$render_id 	= $row->node;
			}
			else if ( $parent->type == 'row' ) {
				$group 		= FLBuilderModel::get_module_parent( 'column-group', $module );
				$render_id 	= $group->node;
			}
			else if ( $parent->type == 'column-group' ) {
				$render_id 	= $parent->node;
			}
			else {
				$render_id = $module->node;
			}
		}
		else {
			$render_id = null;
		}
		
		// Return the response.
		return array(
			'layout' 	 => self::render( $render_id ),
			'settings'   => $settings['settings']
		);
	}

	/**
	 * Renders the layout data for a copied module.
	 *
	 * @since 1.7
	 * @param string $node_id The ID of a module to copy.
	 * @return array
	 */
	static public function copy_module( $node_id )
	{
		$module = FLBuilderModel::copy_module( $node_id );
		
		return self::render( $module->node );
	}

	/**
	 * Returns an array of partial refresh data.
	 *
	 * @since 1.7
	 * @access private
	 * @return array
	 */
	static private function get_partial_refresh_data()
	{
		// Get the data if it's not cached.
		if ( ! self::$partial_refresh_data ) {
			
			$post_data 		 = FLBuilderModel::get_post_data();
			$partial_refresh = false;
			
			// Check for partial refresh if we have a node ID.
			if ( isset( $post_data['node_id'] ) ) {
				
				// Get the node. 
				$node_id = $post_data['node_id'];
				$node 	 = FLBuilderModel::get_node( $post_data['node_id'] );
				
				// Check a module for partial refresh.
				if ( $node && 'module' == $node->type ) {
					$node 				= FLBuilderModel::get_module( $node_id );
					$node_type 			= 'module';
					$partial_refresh 	= $node->partial_refresh;
				}
				// Always partial refresh rows and columns.
				else if ( $node ) {
					$node_type 			= $node->type;
					$partial_refresh 	= self::node_modules_support_partial_refresh( $node );
				}
			}
			
			// Clear the node data if we're not doing a partial refresh.
			if ( ! $partial_refresh ) {
				$node_id 	= null;
				$node 	 	= null;
				$node_type 	= null;
			}
			
			// Cache the partial refresh data.
			self::$partial_refresh_data = array(
				'is_partial_refresh' => $partial_refresh,
				'node_id'			 => $node_id,
				'node'				 => $node,
				'node_type'			 => $node_type
			);
		}
		
		// Return the data.
		return self::$partial_refresh_data;
	}

	/**
	 * Checks to see if all modules in a node support partial refresh.
	 *
	 * @since 1.7
	 * @access private
	 * @param object $node The node to check.
	 * @return bool
	 */
	static private function node_modules_support_partial_refresh( $node )
	{
		$nodes 	= FLBuilderModel::get_categorized_nodes();
		
		if ( 'row' == $node->type ) {
			
			$template_post_id = FLBuilderModel::is_node_global( $node );
			
			foreach( $nodes['groups'] as $group ) {
				if ( $node->node == $group->parent || ( $template_post_id && $node->template_node_id == $group->parent ) ) {
					foreach( $nodes['columns'] as $column ) {
						if ( $group->node == $column->parent ) {
							foreach( $nodes['modules'] as $module ) {
								if ( $column->node == $module->parent ) {
									if ( ! $module->partial_refresh ) {
										return false;
									}
								}
							}
						}
					}
				}
			}
		}
		else if ( 'column-group' == $node->type ) {
			foreach( $nodes['columns'] as $column ) {
				if ( $node->node == $column->parent ) {
					foreach( $nodes['modules'] as $module ) {
						if ( $column->node == $module->parent ) {
							if ( ! $module->partial_refresh ) {
								return false;
							}
						}
					}
				}
			}
		}
		else if ( 'column' == $node->type ) {
			foreach( $nodes['modules'] as $module ) {
				if ( $node->node == $module->parent ) {
					if ( ! $module->partial_refresh ) {
						return false;
					}
				}
			}
		}
		
		return true;
	}

	/**
	 * Renders the html for the layout or node.
	 *
	 * @since 1.7
	 * @access private
	 * @return string
	 */
	static private function render_html()
	{
		// Get the partial refresh data.
		$partial_refresh_data = self::get_partial_refresh_data();

		// Start the output buffer.
		ob_start();
		
		// Render a node? 
		if ( $partial_refresh_data['is_partial_refresh'] ) {
			
			switch ( $partial_refresh_data[ 'node' ]->type ) {
				
				case 'row':
				FLBuilder::render_row( $partial_refresh_data['node'] );
				break;
				
				case 'column-group':
				FLBuilder::render_column_group( $partial_refresh_data['node'] );
				break;
				
				case 'column':
				FLBuilder::render_column( $partial_refresh_data['node'] );
				break;
				
				case 'module':
				FLBuilder::render_module( $partial_refresh_data['node'] );
				break;
			}
		}
		// Render the layout.
		else {
			FLBuilder::render_nodes();
		}
		
		// Get the rendered HTML.
		$html = ob_get_clean();
		
		// Render shortcodes.
		if ( apply_filters( 'fl_builder_render_shortcodes', true ) ) {
			$html = apply_filters( 'fl_builder_before_render_shortcodes', $html );
			ob_start();
			echo do_shortcode( $html );
			$html = ob_get_clean();
		}
		
		// Return the rendered HTML.
		return $html;
	}

	/**
	 * Renders the assets for the layout or a node.
	 *
	 * @since 1.7
	 * @access private
	 * @return array
	 */
	static private function render_assets()
	{
		$partial_refresh_data 	= self::get_partial_refresh_data();
		$asset_info 		  	= FLBuilderModel::get_asset_info();
		$asset_ver  			= FLBuilderModel::get_asset_version();
		$assets					= array( 'js' => '', 'css' => '' );
		
		// Render the JS.
		if ( $partial_refresh_data['is_partial_refresh'] ) {
			
			if ( ! class_exists( 'FLJSMin' ) ) {
				include FL_BUILDER_DIR . 'classes/class-fl-jsmin.php';
			}
			
			switch ( $partial_refresh_data['node']->type ) {
				
				case 'row':
				$assets['js'] = FLBuilder::render_row_js( $partial_refresh_data['node'] );
				$assets['js'] .= FLBuilder::render_row_modules_js( $partial_refresh_data['node'] );
				break;
				
				case 'column':
				$assets['js'] = FLBuilder::render_column_modules_js( $partial_refresh_data['node'] );
				break;
				
				case 'module':
				$assets['js'] = FLBuilder::render_module_js( $partial_refresh_data['node'] );
				break;
			}
			
			$assets['js'] .= 'FLBuilder._renderLayoutComplete();';

			try {
			    $min = FLJSMin::minify( $assets['js'] );
			} catch (Exception $e) {}

			if ( $min ) {
			    $assets['js'] = $min;
			}
		}
		else {
			$assets['js'] = $asset_info['js_url'] . '?ver=' . $asset_ver;
		}
		
		// Render the CSS.
		$assets['css'] = $asset_info['css_url'] . '?ver=' . $asset_ver;
		
		// Return the assets.
		return $assets;
	}

	/**
	 * Do the wp_enqueue_scripts action to register any scripts or 
	 * styles that might need to be registered for shortcodes or widgets.
	 *
	 * @since 1.7
	 * @access private
	 * @return void
	 */
	static private function register_scripts()
	{
		// Running these isn't necessary and can cause performance issues.
		remove_action( 'wp_enqueue_scripts', 'FLBuilder::register_layout_styles_scripts' );
		remove_action( 'wp_enqueue_scripts', 'FLBuilder::enqueue_ui_styles_scripts' );
		remove_action( 'wp_enqueue_scripts', 'FLBuilder::enqueue_all_layouts_styles_scripts' );
		
		ob_start();
		do_action( 'wp_enqueue_scripts' );
		ob_end_clean();
	}

	/**
	 * Dequeue scripts and styles so we can capture only those
	 * enqueued by shortcodes or widgets.
	 *
	 * @since 1.7
	 * @access private
	 * @return void
	 */
	static private function dequeue_scripts_and_styles()
	{
		global $wp_scripts;
		global $wp_styles;

		if ( isset( $wp_scripts ) ) {
			$wp_scripts->queue = array();
		}
		if ( isset( $wp_styles ) ) {
			$wp_styles->queue = array();
		}
		
		remove_action( 'wp_print_styles', 'print_emoji_styles' );
	}

	/**
	 * Renders scripts and styles enqueued by shortcodes or widgets. 
	 *
	 * @since 1.7
	 * @access private
	 * @return string
	 */
	static private function render_scripts_and_styles()
	{
		global $wp_scripts;
		global $wp_styles;
		
		$partial_refresh_data 	= self::get_partial_refresh_data();
		$scripts_styles			= '';
		
		// Start the output buffer.
		ob_start();

		// Print scripts and styles.
		if ( isset( $wp_scripts ) ) {
			$wp_scripts->done[] = 'jquery';
			wp_print_scripts( $wp_scripts->queue );
		}
		if ( isset( $wp_styles ) ) {
			wp_print_styles( $wp_styles->queue );
		}
		
		// Return the scripts and styles markup.
		return ob_get_clean();
	}
}