<?php

/**
 * Helper class for builder shortcodes
 *
 * @since 1.7
 */
final class FLBuilderShortcodes {

	/**
	 * Adds all shortcodes for the builder.
	 *
	 * @since 1.7
	 * @return void
	 */
	static public function init()
	{
		add_shortcode( 'fl_builder_insert_layout', 'FLBuilderShortcodes::insert_layout' );
	}

	/**
	 * Renders a layout with the provided post ID and enqueues the 
	 * necessary styles and scripts.
	 *
	 * @since 1.7
	 * @param array $attrs The shortcode attributes.
	 * @return string
	 */
	static public function insert_layout( $attrs )
	{
		$builder_active = in_the_loop() && FLBuilderModel::is_builder_active();
		$post_type 		= isset( $attrs['type'] ) ? $attrs['type'] : get_post_types();
		$site_id        = isset( $attrs['site'] ) ? absint( $attrs['site'] ) : null;
		$args  	   		= array(
			'post_type' 	 => $post_type,
			'posts_per_page' => -1
		);
		
		// Build the args array.
		if ( isset( $attrs['id'] ) ) {
			
			$args['orderby'] = 'post__in';
			$args['ignore_sticky_posts'] = true;
			
			if ( is_numeric( $attrs['id'] ) ) {
				$args['post__in'] = array( $attrs['id'] );
			}
			else {
				$args['post__in'] = explode( ',', $attrs['id'] );
			}
		}
		else if ( isset( $attrs['slug'] ) ) {
			$args['orderby'] = 'name';
			$args['name'] 	 = $attrs['slug'];
		}
		else {
			return;
		}
		
		// Render and return the layout.
		ob_start();
		
		if ( $builder_active ) {
			echo '<div class="fl-builder-shortcode-mask-wrap"><div class="fl-builder-shortcode-mask"></div>';
		}
		
		FLBuilder::render_query( $args, $site_id );
		
		if ( $builder_active ) {
			echo '</div>';
		}
		
		return ob_get_clean();
	}
}

FLBuilderShortcodes::init();