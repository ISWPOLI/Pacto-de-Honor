<?php

/**
 * WP Cli commands for page builder.
 */
class FLbuilder_WPCLI_Command extends WP_CLI_Command {

	/**
	 * Deletes preview, draft and live CSS/JS asset cache for all posts.
	 *
	 * ## OPTIONS
	 * 
	 * [--network]
	 * Clears the page builder cache for all sites on a network.
	 *
	 * ## EXAMPLES
	 *
	 * 1. wp beaver clearcache
	 * 		- Clears the page builder cache for all the posts on the site.
	 * 2. wp beaver clearcache --network
	 * 		- Clears the page builder cache for all the posts on a network.
	*/
	public function clearcache( $args, $assoc_args )
	{

		$network = false;

		if ( isset( $assoc_args['network'] ) && $assoc_args['network'] == true && is_multisite() ) {
			$network = true;
		}

		if ( class_exists( 'FLBuilderModel' ) ) {

			if ( $network == true ) {

				if ( function_exists( 'get_sites' ) ) {
					$blogs = get_sites();
				} else {
					$blogs = wp_get_sites();
				}

				foreach ( $blogs as $keys => $blog ) {

					// Cast $blog as an array instead of WP_Site object
					if ( is_object( $blog ) ) {
						$blog = (array) $blog;
					}

					$blog_id = $blog['blog_id'];
					switch_to_blog( $blog_id );
					FLBuilderModel::delete_asset_cache_for_all_posts();
					WP_CLI::success( "Cleared the page builder cache for blog " . get_option( 'home' ) );
					restore_current_blog();
				}

			} else {
				FLBuilderModel::delete_asset_cache_for_all_posts();
				WP_CLI::success( "Cleared the page builder cache" );
			}
			
		}

	}

}

WP_CLI::add_command( 'beaver', 'FLbuilder_WPCLI_Command' );
