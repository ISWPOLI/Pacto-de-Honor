<?php
/**
 *	HEX to RGBA
 */
function paraxis_lite_hex2rgba($color, $opacity = false) {
	if ($color[0] == '#' ) {
		$color = substr( $color, 1 );
	}

	$hex = array( $color[0] . $color[1], $color[2] . $color[3], $color[4] . $color[5] );
	$rgb =  array_map('hexdec', $hex);
	$opacity = 0.4;
	$output = 'rgba('.implode(",",$rgb).','.$opacity.')';

	return $output;
}

/**
 *	Customizer
 */
if( !function_exists( 'paraxis_lite_custimizer_style' ) ) {
	add_action('wp_head', 'paraxis_lite_custimizer_style');
	function paraxis_lite_custimizer_style() {
		$background_color = get_theme_mod('background_color', '#ffffff');
		$primary_color = get_theme_mod('primary_color', '#9e005d');
		$body_text_color = get_theme_mod('body_text_color', '#333333');
		$entry_titles = get_theme_mod('entry_titles', '#333333');
		$entry_meta = get_theme_mod('entry_meta', '#333333');
		$footer_background = get_theme_mod('footer_background', '#ffffff');
		$social_color = get_theme_mod('social_color', '#d0d0d0');
		$logo_size = get_theme_mod('logo_size', '450');
		$branding_padding = get_theme_mod('branding_padding', '232');

		$output = '';

		$output .= '<style type="text/css">';
			$output .= ($background_color) ? 'body {background-color: '. esc_html($background_color) .';}' : '';
			$output .= ($background_color) ? '.svg-block {fill: '. esc_html($background_color) .';}' : '';
			$output .= ($primary_color) ? '.entry-meta a:hover, .entry-title a:hover, .widget-area a:hover, .social-navigation li a:hover, a {color: '. esc_html($primary_color) .';}' : '';
			$output .= ($primary_color) ? '.read-more, .nav-previous:hover, .nav-next:hover, button, .button, input[type=\"button\"], input[type=\"reset\"], input[type=\"submit\"] {background-color: '. esc_html($primary_color) .';}' : '';
			$output .= ($primary_color) ? '.entry-thumb:after {background-color: '. paraxis_lite_hex2rgba($primary_color, 0.3) .';}' : '';
			$output .= ($body_text_color) ? 'body {color: '. esc_html($body_text_color) .';}' : '';
			$output .= ($entry_titles) ? '.entry-title, .entry-title a {color: '. esc_html($entry_titles) .';}' : '';
			$output .= ($entry_meta) ? '.entry-meta, .entry-meta a, .entry-footer, .entry-footer a {color: '. esc_html($entry_meta) .';}' : '';
			$output .= ($footer_background) ? '.footer-svg.svg-block {fill: '. esc_html($footer_background) .' !important;}' : '';
			$output .= ($footer_background) ? '.site-footer {background-color: '. esc_html($footer_background) .';}' : '';
			$output .= ($social_color) ? '.social-navigation li a {color: '. esc_html($social_color) .';}' : '';
			$output .= ($logo_size) ? '.site-logo {max-width: '. intval($logo_size) .'px;}' : '';
			$output .= ($branding_padding) ? '.site-branding {padding: '. intval($branding_padding) .'px 0;}' : '';
		$output .= '</style>';

		echo $output;
	}
}