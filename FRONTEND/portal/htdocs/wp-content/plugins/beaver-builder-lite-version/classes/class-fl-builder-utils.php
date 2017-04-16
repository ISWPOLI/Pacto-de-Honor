<?php

/**
 * Misc helper methods.
 *
 * @since 1.0
 */

final class FLBuilderUtils {

	/**
	 * Get an instance of WP_Filesystem_Direct.
	 *
	 * @since 1.4.6
	 * @return object A WP_Filesystem_Direct instance.
	 */
	static public function get_filesystem()
	{
		global $wp_filesystem;
		
		require_once ABSPATH .'/wp-admin/includes/file.php';
		
		add_filter('filesystem_method', 'FLBuilderUtils::filesystem_method');
				
		WP_Filesystem();
		
		remove_filter('filesystem_method', 'FLBuilderUtils::filesystem_method');
		
		return $wp_filesystem;
	}

	/**
	 * Sets the filesystem method to direct.
	 *
	 * @since 1.4.6
	 * @return string
	 */
	static public function filesystem_method()
	{
		return 'direct';
	}

	/**
	 * Return a snippet without punctuation at the end.
	 *
	 * @since 1.2.3
	 * @param string $text The text to truncate.
	 * @param int $length The number of characters to return.
	 * @param string $tail The trailing characters to append.
	 * @return string
	 */
	static public function snippetwop($text, $length = 64, $tail = "...")
	{
		$text = trim($text);
		$txtl = function_exists('mb_strlen') ? mb_strlen($text) : strlen($text);

		if($txtl > $length) {
			
			for($i=1;$text[$length-$i]!=" ";$i++) {
				
				if($i == $length) {
					
					if(function_exists('mb_substr')) {
						return mb_substr($text,0,$length) . $tail;
					}
					
					return substr($text,0,$length) . $tail;
				}
			}
			
			for(;$text[$length-$i]=="," || $text[$length-$i]=="." || $text[$length-$i]==" ";$i++) {;}
			
			if(function_exists('mb_substr')) {
				return mb_substr($text,0,$length-$i+1) . $tail;
			}
			
			return substr($text,0,$length-$i+1) . $tail;
		}
		
		return $text;
	}

	/**
	 * JSON decode multidimensional array values or object properties.
	 *
	 * @since 1.5.6
	 * @param mixed $data The data to decode.
	 * @return mixed The decoded data.
	 */
	static public function json_decode_deep( $data )
	{
		// First check if we have a string and try to decode that. 
		if ( is_string( $data ) ) {
			$data = json_decode( $data );
		}
		
		// Decode object properies or array values.
		if ( is_object( $data ) || is_array( $data ) ) {

			foreach ( $data as $key => $val ) {

				$new_val = null;

				if ( is_string( $val ) ) {

					$decoded = json_decode( $val );

					if ( is_object( $decoded ) || is_array( $decoded ) ) {
						$new_val = $decoded;
					}
				}
				else if ( is_object( $val ) || is_array( $val ) ) {
					$new_val = self::json_decode_deep( $val );
				}

				if ( $new_val ) {

					if ( is_object( $data ) ) {
						$data->{$key} = $new_val;
					}
					else if ( is_array( $data ) ) {
						$data[ $key ] = $new_val;
					}
				}
			}
		}

		return $data;
	}

	/**
	 * Base64 decode settings if our ModSecurity fix is enabled. 
	 *
	 * @since 1.8.4
	 * @return array
	 */
	static public function modsec_fix_decode( $settings )
	{
		if ( defined( 'FL_BUILDER_MODSEC_FIX' ) && FL_BUILDER_MODSEC_FIX ) {
			
			if ( is_string( $settings ) ) {
				$settings = wp_slash( base64_decode( $settings ) );
			}
			else {
				
				foreach ( $settings as $key => $value ) {
					
					if ( is_string( $settings[ $key ] ) ) {
						$settings[ $key ] = wp_slash( base64_decode( $value ) );
					}
					else if ( is_array( $settings[ $key ] ) ) {
						$settings[ $key ] = self::modsec_fix_decode( $settings[ $key ] );
					}
				}
			}
		}

		return $settings;
	}

	/**
	 * Get video type and ID from a given URL
	 *
	 * @since 1.9
	 * @param string $url 	The URL to check for video type
	 * @param string $type 	The type of video to check
	 * @return array
	 */
	static public function get_video_data( $url, $type = '' )
	{
		if ( empty($url) ) 
		return false;

		$y_matches 	= array();
		$vm_matches = array();
	    $yt_pattern = '/^(?:(?:(?:https?:)?\/\/)?(?:www.)?(?:youtu(?:be.com|.be))\/(?:watch\?v\=|v\/|embed\/)?([\w\-]+))/is';
	    $vm_pattern = '#(?:https?://)?(?:www.)?(?:player.)?vimeo.com/(?:[a-z]*/)*([0-9]{6,11})[?]?.*#';
	    $video_data = array('type' => 'mp4', 'video_id' => '');

	    preg_match($yt_pattern, $url, $yt_matches);
	    preg_match($vm_pattern, $url, $vm_matches);

	    if ( isset($yt_matches[1]) ) {
	    	$video_data['type'] 	= 'youtube';
	    	$video_data['video_id'] = $yt_matches[1];
	    }
	    else if (isset($vm_matches[1]) ) {
	    	$video_data['type'] 	= 'vimeo';
	    	$video_data['video_id'] = $vm_matches[1];
	    }

	    if ( !empty($type) ) {
	    	if ( $type === $video_data['type'] ) {
	    		return $video_data['video_id'];
	    	}
	    	else {
	    		return false;
	    	}
	    }

	    return $video_data;
	}

}