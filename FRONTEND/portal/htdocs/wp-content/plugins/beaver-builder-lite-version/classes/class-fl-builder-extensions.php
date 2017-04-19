<?php

/**
 * Helper class for builder extensions.
 *
 * @since 1.0
 */
final class FLBuilderExtensions {
	
	/**
	 * Initalizes any extensions found in the extensions directory.
	 *
	 * @since 1.8
	 * @return void
	 */
	static public function init()
	{
		$extensions = glob( FL_BUILDER_DIR . 'extensions/*' );
		
		if ( ! is_array( $extensions ) ) {
			return;
		}
		
		foreach ( $extensions as $extension ) {
			
			if ( ! is_dir( $extension ) ) {
				continue;	
			}
			
			$path = trailingslashit( $extension ) . basename( $extension ) . '.php';
			
			if ( file_exists( $path ) ) {
				require_once $path;
			}
		}
	}
}

FLBuilderExtensions::init();