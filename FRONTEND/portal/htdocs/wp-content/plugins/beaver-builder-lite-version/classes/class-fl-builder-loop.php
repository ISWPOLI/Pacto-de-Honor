<?php

/**
 * Helper class for building custom WordPress loops.
 *
 * @since 1.2.3
 */
final class FLBuilderLoop {

	/**
	 * Loop query counter
	 *
	 * @since 1.9.5
	 * @var int $loop_counter
	 */
	static public $loop_counter = 0;

	/**
	 * Initializes hooks.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function init()
	{
		add_filter( 'found_posts', 			__CLASS__ . '::found_posts', 1, 2 );		
		add_action( 'init', 				__CLASS__ . '::init_rewrite_rules' );
		add_filter( 'redirect_canonical', 	__CLASS__ . '::override_canonical', 1, 2 );
	}

	/**
	 * Returns a new instance of WP_Query based on 
	 * the provided module settings. 
	 *
	 * @since 1.2.3
	 * @param object $settings Module settings to use for the query.
	 * @return object A WP_Query instance.
	 */
	static public function query($settings) 
	{
		$posts_per_page	 = empty($settings->posts_per_page) ? 10 : $settings->posts_per_page;
		$post_type		 = empty($settings->post_type) ? 'post' : $settings->post_type;
		$order_by		 = empty($settings->order_by) ? 'date' : $settings->order_by;
		$order			 = empty($settings->order) ? 'DESC' : $settings->order;
		$users			 = empty($settings->users) ? '' : $settings->users;
		$fields			 = empty($settings->fields) ? '' : $settings->fields;		

		// Count how many times this method has been called
		self::$loop_counter++;
		$paged = self::get_paged();

		// Get the offset.
		if ( ! isset( $settings->offset ) || ! is_int( ( int )$settings->offset ) ) {
			$offset = 0;
		}
		else {
			$offset = $settings->offset;
		}

		// Get the paged offset. 
		if ( $paged < 2 ) {
			$paged_offset = $offset;
		}
		else {
			$paged_offset = $offset + ( ( $paged - 1 ) * $posts_per_page );
		}
		
		// Build the query args.
		$args = apply_filters( 'fl_builder_loop_query_args', array(
			'paged'					=> $paged,
			'posts_per_page'		=> $posts_per_page,
			'post_type'				=> $post_type,
			'orderby'				=> $order_by,
			'order'					=> $order,
			'author'				=> $users,
			'tax_query'				=> array('relation' => 'AND'),
			'ignore_sticky_posts'	=> true,
			'offset'				=> $paged_offset,
			'fl_original_offset'	=> $offset,
			'fl_builder_loop'		=> true,
			'fields'				=> $fields
		) );
		
		// Build the taxonomy query.
		$taxonomies = self::taxonomies($post_type);
		
		foreach($taxonomies as $tax_slug => $tax) {
			
			$tax_value = '';
		
			// New settings slug.
			if(isset($settings->{'tax_' . $post_type . '_' . $tax_slug})) {
				$tax_value = $settings->{'tax_' . $post_type . '_' . $tax_slug};
			}
			// Legacy settings slug.
			else if(isset($settings->{'tax_' . $tax_slug})) {
				$tax_value = $settings->{'tax_' . $tax_slug};
			}
				
			if(!empty($tax_value)) {
			 
				$args['tax_query'][] = array(
					'taxonomy'	=> $tax_slug,
					'field'		=> 'id',
					'terms'		=> explode(',', $tax_value)
				);
			}
		}
		
		// Post in query.
		if(isset($settings->{'posts_' . $post_type})) {
		
			$ids = $settings->{'posts_' . $post_type};
			
			if(!empty($ids)) {
				$args['post__in'] = explode(',', $settings->{'posts_' . $post_type});  
			}
		}
		
		// Build the query.
		$query = new WP_Query($args);
		
		// Return the query.
		return $query;
	}

	/**
	 * Called by the found_posts filter to adjust the number of posts
	 * found based on the user defined offset.
	 *
	 * @since 1.2.3
	 * @param int $found_posts The number of found posts.
	 * @param object $query An instance of WP_Query.
	 * @return int
	 */ 
	static public function found_posts( $found_posts, $query ) 
	{
		if ( isset( $query->query ) && isset( $query->query['fl_builder_loop'] ) ) {
			return $found_posts - $query->query['fl_original_offset'];
		}
		
		return $found_posts;
	}

		
	/**
	 * Add rewrite rules for custom pagination that allows post modules
	 * on the same page to be paged independently.
	 *
	 * @since 1.9.5
	 * @return void
	 */
	static public function init_rewrite_rules()
	{
		for ( $x = 2; $x <= 10; $x++ ) {
			add_rewrite_rule( 'paged-'. $x .'/([0-9]*)/?', 'index.php?page_id=' . get_option( 'page_on_front' ) . '&flpaged'. $x .'=$matches[1]', 'top' );
			add_rewrite_rule( 'paged-'. $x .'/?([0-9]{1,})/?$', 'index.php?&flpaged'. $x .'=$matches[1]', 'top');
			add_rewrite_rule( '(.?.+?)/paged-'. $x .'/?([0-9]{1,})/?$', 'index.php?pagename=$matches[1]&flpaged'. $x .'=$matches[2]', 'top');
			add_rewrite_rule( '([^/]+)/paged-'. $x .'/?([0-9]{1,})/?$', 'index.php?name=$matches[1]&flpaged'. $x .'=$matches[2]', 'top');
			add_rewrite_tag( "%flpaged{$x}%", '([^&]+)');
		}
	}

	/**
	 * Disable canonical redirection on the frontpage when query var 'flpaged' is found.
	 * 
	 * @param  string $redirect_url  The redirect URL.
	 * @param  string $requested_url The requested URL.
	 * @since  1.9.5
	 * @return bool|string
	 */
	static public function override_canonical( $redirect_url, $requested_url ) {
		global $wp_the_query;

		if ( is_array($wp_the_query->query) ) {
			foreach ($wp_the_query->query as $key => $value) {
				if (strpos($key, 'flpaged') === 0 && is_page() && get_option( 'page_on_front' )) {
					$redirect_url = false;
					break;
				}
			}
		}

    	return $redirect_url;
	}

	/**
	 * Builds and renders the pagination for a query.
	 *
	 * @since 1.2.3
	 * @param object $query An instance of WP_Query.
	 * @return void
	 */ 
	static public function pagination($query) 
	{
		$total_pages = $query->max_num_pages;
		$permalink_structure = get_option('permalink_structure');
		$paged = self::get_paged();
		$base = get_pagenum_link();

		if($total_pages > 1) {
		
			if(!$current_page = $paged) { 
				$current_page = 1;
			}

			if ( self::$loop_counter > 1 ) {
				$page_prefix = 'paged-'. self::$loop_counter;
			}
			else {
				$page_prefix = empty($permalink_structure) ? 'paged' : 'page';
			}
			
			if(empty($permalink_structure)) {
				$format = '&'. $page_prefix .'=%#%';
			}

			else if ("/" == substr($base, -1)) {
				$format = $page_prefix . '/%#%/';
			}
			else {
				$format = '/'. $page_prefix .'/%#%';
			}
			
			$pos = strrpos($base, "paged-");
			if ( $pos ) {
				$base = substr_replace( $base, '', $pos, strlen( $base ) );	
			}
			
			echo paginate_links(array(
				'base'	   => $base . '%_%',
				'format'   => $format,
				'current'  => $current_page,
				'total'	   => $total_pages,
				'type'	   => 'list'
			));
		}
	}

	/**
	 * Returns the paged number for the query.
	 *
	 * @since 1.9.5
	 * @return int
	 */
	static public function get_paged()
	{
		global $wp_the_query, $paged;
		
		// Check first for custom pagination from post module
		$flpaged = $wp_the_query->get( 'flpaged'. self::$loop_counter );
		
		if ( is_numeric( $flpaged ) ) {
			return $flpaged;
		}
		else if ( self::$loop_counter > 1 ) {
			// If we have multiple paginations, make sure it won't affect the other loops.
			return 0;
		}

		// Check the 'page' query var.
		$page_qv = $wp_the_query->get( 'page' );
		
		if ( is_numeric( $page_qv ) ) {
			return $page_qv;
		}
			
		// Check the 'paged' query var.
		$paged_qv = $wp_the_query->get( 'paged' );
		
		if ( is_numeric( $paged_qv ) ) {
			return $paged_qv;
		}
		
		// Check the $paged global?
		if ( is_numeric( $paged ) ) {
			return $paged;
		}

		return 0;
	}

	/**
	 * Returns an array of data for post types supported
	 * by module loop settings.
	 *
	 * @since 1.2.3
	 * @return array
	 */  
	static public function post_types() 
	{
		$post_types = get_post_types(array(
			'public'	=> true,
			'show_ui'	=> true
		), 'objects');
		
		unset($post_types['attachment']);
		unset($post_types['fl-builder-template']);
		
		return $post_types;
	}
	
	/**
	 * Get an array of supported taxonomy data for a post type.
	 *
	 * @since 1.2.3
	 * @param string $post_type The post type to get taxonomies for.
	 * @return array
	 */   
	static public function taxonomies($post_type) 
	{
		$taxonomies = get_object_taxonomies($post_type, 'objects');
		$data		= array();
		
		foreach($taxonomies as $tax_slug => $tax) {
		
			if(!$tax->public || !$tax->show_ui) {
				continue;
			}
			
			$data[$tax_slug] = $tax;
		}
		
		return apply_filters( 'fl_builder_loop_taxonomies', $data, $taxonomies, $post_type );
	}

	/**
	 * Displays the date for the current post in the loop.
	 *
	 * @since 1.7
	 * @param string $format The date format to use.
	 * @return void
	 */
	static public function post_date( $format = 'default' )
	{
		if ( 'default' == $format ) {
			$format = get_option( 'date_format' );
		}
		
		the_time( $format );
	}
}

FLBuilderLoop::init();