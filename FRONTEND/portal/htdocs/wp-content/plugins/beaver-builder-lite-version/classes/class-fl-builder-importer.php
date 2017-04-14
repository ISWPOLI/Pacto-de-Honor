<?php

/**
 * The WordPress importer plugin has a few issues that break 
 * serialized data in certain cases. This class is our own 
 * patched version that fixes these issues.
 *
 * @since 1.8
 */
class FLBuilderImporter extends WP_Import {

	/** 
	 * @since 1.8
	 * @return array
	 */  
	function parse( $file ) {
		$parser = new FLBuilderImportParserRegex();
		return $parser->parse( $file );
	}
}

/**
 * The Regex parser is the only parser we have found that
 * doesn't break serialized data. It does have two bugs 
 * that can break serialized data. Those are calling rtrim
 * on each $importline and adding a newline to each $importline.
 * This class fixes those bugs.
 *
 * @since 1.8
 */
class FLBuilderImportParserRegex extends WXR_Parser_Regex {

	/** 
	 * @since 1.8
	 * @return array
	 */  
	function parse( $file ) {
		$wxr_version = $in_post = false;

		$fp = $this->fopen( $file, 'r' );
		if ( $fp ) {
			while ( ! $this->feof( $fp ) ) {
				$importline = $this->fgets( $fp );

				if ( ! $wxr_version && preg_match( '|<wp:wxr_version>(\d+\.\d+)</wp:wxr_version>|', $importline, $version ) )
					$wxr_version = $version[1];

				if ( false !== strpos( $importline, '<wp:base_site_url>' ) ) {
					preg_match( '|<wp:base_site_url>(.*?)</wp:base_site_url>|is', $importline, $url );
					$this->base_url = $url[1];
					continue;
				}
				if ( false !== strpos( $importline, '<wp:category>' ) ) {
					preg_match( '|<wp:category>(.*?)</wp:category>|is', $importline, $category );
					if ( isset($category[1]) ) {
						$this->categories[] = $this->process_category( $category[1] );
					}
					continue;
				}
				if ( false !== strpos( $importline, '<wp:tag>' ) ) {
					preg_match( '|<wp:tag>(.*?)</wp:tag>|is', $importline, $tag );
					if ( isset($tag[1]) ) {
						$this->tags[] = $this->process_tag( $tag[1] );
					}
					continue;
				}
				if ( false !== strpos( $importline, '<wp:term>' ) ) {
					preg_match( '|<wp:term>(.*?)</wp:term>|is', $importline, $term );
					if ( isset($term[1]) ) {
						$this->terms[] = $this->process_term( $term[1] );
					}
					continue;
				}
				if ( false !== strpos( $importline, '<wp:author>' ) ) {
					preg_match( '|<wp:author>(.*?)</wp:author>|is', $importline, $author );
					if ( isset($author[1]) ) {
						$a = $this->process_author( $author[1] );
					}
					$this->authors[$a['author_login']] = $a;
					continue;
				}
				if ( false !== strpos( $importline, '<item>' ) ) {
					$post = '';
					$in_post = true;
					continue;
				}
				if ( false !== strpos( $importline, '</item>' ) ) {
					$in_post = false;
					$this->posts[] = $this->process_post( $post );
					continue;
				}
				if ( $in_post ) {
					$post .= $importline;
				}
			}

			$this->fclose($fp);
			
			// Try to fix any broken builder data.
			foreach ( $this->posts as $post_index => $post ) {
				if ( ! isset( $post['postmeta'] ) || ! is_array( $post['postmeta'] ) ) {
					continue;
				}
				foreach ( $post['postmeta'] as $postmeta_index => $postmeta ) {
					if ( stristr( $postmeta['key'], '_fl_builder_' ) ) {
						$this->posts[ $post_index ]['postmeta'][ $postmeta_index ]['value'] = FLBuilderImporterDataFix::run( $postmeta['value'] );
					}
				}
			}
		}

		if ( ! $wxr_version )
			return new WP_Error( 'WXR_parse_error', __( 'This does not appear to be a WXR file, missing/invalid WXR version number', 'fl-builder' ) );

		return array(
			'authors' => $this->authors,
			'posts' => $this->posts,
			'categories' => $this->categories,
			'tags' => $this->tags,
			'terms' => $this->terms,
			'base_url' => $this->base_url,
			'version' => $wxr_version
		);
	}
}

/**
 * Portions borrowed from https://github.com/Blogestudio/Fix-Serialization/blob/master/fix-serialization.php
 *
 * Attempts to fix broken serialized data.
 *
 * @since 1.8
 */
final class FLBuilderImporterDataFix {

	/**
	 * @since 1.8
	 * @return string
	 */
	static public function run( $data ) 
	{
		if ( empty( $data ) || @unserialize( $data ) !== false ) {
			return $data;
		}
		
		return preg_replace_callback( '!s:(\d+):([\\\\]?"[\\\\]?"|[\\\\]?"((.*?)[^\\\\])[\\\\]?");!', 'FLBuilderImporterDataFix::regex_callback', $data );
	}

	/**
	 * @since 1.8
	 * @return string
	 */
	static public function regex_callback( $matches ) 
	{
		if ( ! isset( $matches[3] ) ) {
			return $matches[0];
		}
		
		return 's:' . strlen( self::unescape_mysql( $matches[3] ) ) . ':"' . self::unescape_quotes( $matches[3] ) . '";';
	}
	
	/**
	 * Unescape to avoid dump-text issues.
	 *
	 * @since 1.8
	 * @access private
	 * @return string
	 */
	static private function unescape_mysql( $value ) 
	{
		return str_replace( array( "\\\\", "\\0", "\\n", "\\r", "\Z",  "\'", '\"' ),
						   array( "\\",   "\0",  "\n",  "\r",  "\x1a", "'", '"' ), 
						   $value );
	}
	
	/**
	 * Fix strange behaviour if you have escaped quotes in your replacement.
	 *
	 * @since 1.8
	 * @access private
	 * @return string
	 */
	static private function unescape_quotes( $value ) 
	{
		return str_replace( '\"', '"', $value );
	}	
}