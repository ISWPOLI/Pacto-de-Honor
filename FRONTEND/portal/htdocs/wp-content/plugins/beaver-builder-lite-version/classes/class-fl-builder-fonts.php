<?php

/**
 * Helper class for font settings.
 *
 * @class   FLBuilderFonts
 * @since   1.6.3
 */
final class FLBuilderFonts {

	/**
	 * An array of fonts / weights.
	 * @var array
	 */
	static private $fonts = array();

	/**
	 * Renders the JavasCript variable for font settings dropdowns.
	 *
	 * @since  1.6.3
	 * @return void
	 */
	static public function js()
	{
		$default = json_encode( apply_filters( 'fl_builder_font_families_default', FLBuilderFontFamilies::$default ) );
		$system  = json_encode( apply_filters( 'fl_builder_font_families_system', FLBuilderFontFamilies::$system ) );
		$google  = json_encode( apply_filters( 'fl_builder_font_families_google', FLBuilderFontFamilies::$google ) );

		echo 'var FLBuilderFontFamilies = { default: '. $default .', system: '. $system .', google: '. $google .' };';
	}

	/**
	 * Renders a list of all available fonts.
	 *
	 * @since  1.6.3
	 * @param  string $font The current selected font.
	 * @return void
	 */
	static public function display_select_font($font)
	{
		$system_fonts = apply_filters( 'fl_builder_font_families_system', FLBuilderFontFamilies::$system );
		$google_fonts = apply_filters( 'fl_builder_font_families_google', FLBuilderFontFamilies::$google );

		echo '<option value="Default" '. selected('Default', $font) .'>'. __( 'Default', 'fl-builder' ) .'</option>';
		echo '<optgroup label="System">';

		foreach( $system_fonts as $name => $variants ) {
			echo '<option value="'. $name .'" '. selected($name, $font) .'>'. $name .'</option>';
		}

		echo '<optgroup label="Google">';

		foreach( $google_fonts as $name => $variants ) {
			echo '<option value="'. $name .'" '. selected($name, $font) .'>'. $name .'</option>';
		}
	}

	/**
	 * Renders a list of all available weights for a selected font.
	 *
	 * @since  1.6.3
	 * @param  string $font   The current selected font.
	 * @param  string $weight The current selected weight.
	 * @return void
	 */
	static public function display_select_weight( $font, $weight )
	{
		if( $font == 'Default' ){
			echo '<option value="default">'. __( 'Default', 'fl-builder' ) .'</option>';
		} else {
			$system_fonts = apply_filters( 'fl_builder_font_families_system', FLBuilderFontFamilies::$system );
			$google_fonts = apply_filters( 'fl_builder_font_families_google', FLBuilderFontFamilies::$google );

			if( array_key_exists( $font, $system_fonts ) ){
				foreach( $system_fonts[ $font ]['weights'] as $variant ) {
					echo '<option value="'. $variant .'" '. selected($variant, $weight) .'>'. FLBuilderFonts::get_weight_string( $variant ) .'</option>';
				}

			} else {
				foreach( $google_fonts[ $font ] as $variant) {

					echo '<option value="'. $variant .'" '. selected($variant, $weight) .'>'. FLBuilderFonts::get_weight_string( $variant ) .'</option>';
				}

			}

		}

	}

	/**
	 * Returns a font weight name for a respective weight.
	 *
	 * @since  1.6.3
	 * @param  string $weight The selected weight.
	 * @return string         The weight name.
	 */
	static public function get_weight_string( $weight ){

		$weight_string = apply_filters( 'fl_builder_font_weight_strings', array(
			'default' => __( 'Default', 'fl-builder' ),
			'regular' => __( 'Regular', 'fl-builder' ),
			'100' => 'Thin 100',
			'200' => 'Extra-Light 200',
			'300' => 'Light 300',
			'400' => 'Normal 400',
			'500' => 'Medium 500',
			'600' => 'Semi-Bold 600',
			'700' => 'Bold 700',
			'800' => 'Extra-Bold 800',
			'900' => 'Ultra-Bold 900'
		) );

		return $weight_string[ $weight ];
	}

	/**
	 * Helper function to render css styles for a selected font.
	 *
	 * @since  1.6.3
	 * @param  array $font An array with font-family and weight.
	 * @return void
	 */
	static public function font_css( $font ){

		$system_fonts = apply_filters( 'fl_builder_font_families_system', FLBuilderFontFamilies::$system );

		$css = '';

		if( array_key_exists( $font['family'], $system_fonts ) ){

			$css .= 'font-family: "'. $font['family'] .'",'. $system_fonts[ $font['family'] ]['fallback'] .';';

		} else {
			$css .= 'font-family: "'. $font['family'] .'";';
		}

		if ( 'regular' == $font['weight'] ) {
			$css .= 'font-weight: normal;';
		} else {
            if ( 'i' == substr( $font['weight'], -1 ) ) {
                $css .= 'font-weight: '. substr( $font['weight'], 0, -1 ) .';';
                $css .= 'font-style: italic;';
            } else {
                $css .= 'font-weight: '. $font['weight'] .';';
            }
		}

		echo $css;
	}

	/**
	 * Add fonts to the $font array for a module.
	 *
	 * @since  1.6.3
	 * @param  object $module The respective module.
	 * @return void
	 */
	static public function add_fonts_for_module( $module )
	{
		$fields = FLBuilderModel::get_settings_form_fields( $module->form );

		foreach ( $fields as $name => $field ) {
			if ( $field['type'] == 'font' && isset( $module->settings->$name ) ) {
				self::add_font( $module->settings->$name );
			}
			else if ( isset( $field['form'] ) ) {
				$form = FLBuilderModel::$settings_forms[ $field['form'] ];
				self::add_fonts_for_nested_module_form( $module, $form['tabs'], $name );
			}
		}
	}

	/**
	 * Add fonts to the $font array for a nested module form.
	 *
	 * @since 1.8.6
	 * @access private
	 * @param object $module The module to add for.
	 * @param array $form The nested form.
	 * @param string $setting The nested form setting key.
	 * @return void
	 */
	static private function add_fonts_for_nested_module_form( $module, $form, $setting )
	{
		$fields = FLBuilderModel::get_settings_form_fields( $form );

		foreach ( $fields as $name => $field ) {
			if ( $field['type'] == 'font' && isset( $module->settings->$setting ) ) {
				foreach ( $module->settings->$setting as $key => $val ) {
					if ( isset( $val->$name ) ) {
						self::add_font( ( array )$val->$name );
					}
					else if( $name == $key && ! empty( $val ) ) {
						self::add_font( ( array )$val );
					}
				}
			}
		}
	}

	/**
	 * Enqueue the stylesheet for fonts.
	 *
	 * @since  1.6.3
	 * @return void
	 */
	static public function enqueue_styles(){
		$google_fonts_domain = apply_filters( 'fl_builder_google_fonts_domain', '//fonts.googleapis.com/');
		$google_url = $google_fonts_domain . 'css?family=';

		if( count( self::$fonts ) > 0 ){

			foreach( self::$fonts as $family => $weights ){
				$google_url .= $family . ':' . implode( ',', $weights ) . '|';
			}

			$google_url = substr( $google_url, 0, -1 );

			wp_enqueue_style( 'fl-builder-google-fonts-' . md5( $google_url ), $google_url, array() );

			self::$fonts = array();
		}
	}

	/**
	 * Adds data to the $fonts array for a font to be rendered.
	 *
	 * @since  1.6.3
	 * @param  array $font an array with the font family and weight to add.
	 * @return void
	 */
	static public function add_font( $font ){

		if( $font['family'] != 'Default' ){

			$system_fonts = apply_filters( 'fl_builder_font_families_system', FLBuilderFontFamilies::$system );

			// check if is a Google Font
			if( !array_key_exists( $font['family'], $system_fonts ) ){

				// check if font family is already added
				if( array_key_exists( $font['family'], self::$fonts ) ){

					// check if the weight is already added
					if( !in_array( $font['weight'], self::$fonts[ $font['family'] ] ) ){
						self::$fonts[ $font['family'] ][] = $font['weight'];
					}
				} else {
					// adds a new font and height
					self::$fonts[ $font['family'] ] = array( $font['weight'] );

				}

			}

		}
	}

}

/**
 * Font info class for system and Google fonts.
 *
 * @class FLFontFamilies
 * @since 1.6.3
 */
final class FLBuilderFontFamilies {

	static public $default = array(
		"Default" => array(
			'default'
		)
	);

	/**
	 * Array with a list of system fonts.
	 * @var array
	 */
	static public $system = array(
		"Helvetica" => array(
			"fallback" => "Verdana, Arial, sans-serif",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
		"Verdana" => array(
			"fallback" => "Helvetica, Arial, sans-serif",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
		"Arial" => array(
			"fallback" => "Helvetica, Verdana, sans-serif",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
		"Times" => array(
			"fallback" => "Georgia, serif",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
		"Georgia" => array(
			"fallback" => "Times, serif",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
		"Courier" => array(
			"fallback" => "monospace",
			"weights"  => array(
				"300",
				"400",
				"700",
			)
		),
	);

	/**
	 * Array with Google Fonts.
	 * @var array
	 */
	static public $google = array(
		"ABeeZee" => array(
			"regular",
		),
		"Abel" => array(
		    "regular",
		),
		"Abhaya Libre" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Abril Fatface" => array(
		    "regular",
		),
		"Aclonica" => array(
		    "regular",
		),
		"Acme" => array(
		    "regular",
		),
		"Actor" => array(
		    "regular",
		),
		"Adamina" => array(
		    "regular",
		),
		"Advent Pro" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Aguafina Script" => array(
		    "regular",
		),
		"Akronim" => array(
		    "regular",
		),
		"Aladin" => array(
		    "regular",
		),
		"Aldrich" => array(
		    "regular",
		),
		"Alef" => array(
		    "regular",
		    "700",
		),
		"Alegreya" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Alegreya SC" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Alegreya Sans" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "800",
		    "900",
		),
		"Alegreya Sans SC" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "800",
		    "900",
		),
		"Alex Brush" => array(
		    "regular",
		),
		"Alfa Slab One" => array(
		    "regular",
		),
		"Alice" => array(
		    "regular",
		),
		"Alike" => array(
		    "regular",
		),
		"Alike Angular" => array(
		    "regular",
		),
		"Allan" => array(
		    "regular",
		    "700",
		),
		"Allerta" => array(
		    "regular",
		),
		"Allerta Stencil" => array(
		    "regular",
		),
		"Allura" => array(
		    "regular",
		),
		"Almendra" => array(
		    "regular",
		    "700",
		),
		"Almendra Display" => array(
		    "regular",
		),
		"Almendra SC" => array(
		    "regular",
		),
		"Amarante" => array(
		    "regular",
		),
		"Amaranth" => array(
		    "regular",
		    "700",
		),
		"Amatic SC" => array(
		    "regular",
		    "700",
		),
		"Amatica SC" => array(
		    "regular",
		    "700",
		),
		"Amethysta" => array(
		    "regular",
		),
		"Amiko" => array(
		    "regular",
		    "600",
		    "700",
		),
		"Amiri" => array(
		    "regular",
		    "700",
		),
		"Amita" => array(
		    "regular",
		    "700",
		),
		"Anaheim" => array(
		    "regular",
		),
		"Andada" => array(
		    "regular",
		),
		"Andika" => array(
		    "regular",
		),
		"Angkor" => array(
		    "regular",
		),
		"Annie Use Your Telescope" => array(
		    "regular",
		),
		"Anonymous Pro" => array(
		    "regular",
		    "700",
		),
		"Antic" => array(
		    "regular",
		),
		"Antic Didone" => array(
		    "regular",
		),
		"Antic Slab" => array(
		    "regular",
		),
		"Anton" => array(
		    "regular",
		),
		"Arapey" => array(
		    "regular",
		),
		"Arbutus" => array(
		    "regular",
		),
		"Arbutus Slab" => array(
		    "regular",
		),
		"Architects Daughter" => array(
		    "regular",
		),
		"Archivo Black" => array(
		    "regular",
		),
		"Archivo Narrow" => array(
		    "regular",
		    "700",
		),
		"Aref Ruqaa" => array(
		    "regular",
		    "700",
		),
		"Arima Madurai" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "800",
		    "900",
		),
		"Arimo" => array(
		    "regular",
		    "700",
		),
		"Arizonia" => array(
		    "regular",
		),
		"Armata" => array(
		    "regular",
		),
		"Arsenal" => array(
		    "regular",
		    "700",
		),
		"Artifika" => array(
		    "regular",
		),
		"Arvo" => array(
		    "regular",
		    "700",
		),
		"Arya" => array(
		    "regular",
		    "700",
		),
		"Asap" => array(
		    "regular",
		    "500",
		    "700",
		),
		"Asar" => array(
		    "regular",
		),
		"Asset" => array(
		    "regular",
		),
		"Assistant" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		),
		"Astloch" => array(
		    "regular",
		    "700",
		),
		"Asul" => array(
		    "regular",
		    "700",
		),
		"Athiti" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Atma" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Atomic Age" => array(
		    "regular",
		),
		"Aubrey" => array(
		    "regular",
		),
		"Audiowide" => array(
		    "regular",
		),
		"Autour One" => array(
		    "regular",
		),
		"Average" => array(
		    "regular",
		),
		"Average Sans" => array(
		    "regular",
		),
		"Averia Gruesa Libre" => array(
		    "regular",
		),
		"Averia Libre" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Averia Sans Libre" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Averia Serif Libre" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Bad Script" => array(
		    "regular",
		),
		"Bahiana" => array(
		    "regular",
		),
		"Baloo" => array(
		    "regular",
		),
		"Baloo Bhai" => array(
		    "regular",
		),
		"Baloo Bhaina" => array(
		    "regular",
		),
		"Baloo Chettan" => array(
		    "regular",
		),
		"Baloo Da" => array(
		    "regular",
		),
		"Baloo Paaji" => array(
		    "regular",
		),
		"Baloo Tamma" => array(
		    "regular",
		),
		"Baloo Thambi" => array(
		    "regular",
		),
		"Balthazar" => array(
		    "regular",
		),
		"Bangers" => array(
		    "regular",
		),
		"Barrio" => array(
		    "regular",
		),
		"Basic" => array(
		    "regular",
		),
		"Battambang" => array(
		    "regular",
		    "700",
		),
		"Baumans" => array(
		    "regular",
		),
		"Bayon" => array(
		    "regular",
		),
		"Belgrano" => array(
		    "regular",
		),
		"Belleza" => array(
		    "regular",
		),
		"BenchNine" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Bentham" => array(
		    "regular",
		),
		"Berkshire Swash" => array(
		    "regular",
		),
		"Bevan" => array(
		    "regular",
		),
		"Bigelow Rules" => array(
		    "regular",
		),
		"Bigshot One" => array(
		    "regular",
		),
		"Bilbo" => array(
		    "regular",
		),
		"Bilbo Swash Caps" => array(
		    "regular",
		),
		"BioRhyme" => array(
		    "200",
		    "300",
		    "regular",
		    "700",
		    "800",
		),
		"BioRhyme Expanded" => array(
		    "200",
		    "300",
		    "regular",
		    "700",
		    "800",
		),
		"Biryani" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Bitter" => array(
		    "regular",
		    "700",
		),
		"Black Ops One" => array(
		    "regular",
		),
		"Bokor" => array(
		    "regular",
		),
		"Bonbon" => array(
		    "regular",
		),
		"Boogaloo" => array(
		    "regular",
		),
		"Bowlby One" => array(
		    "regular",
		),
		"Bowlby One SC" => array(
		    "regular",
		),
		"Brawler" => array(
		    "regular",
		),
		"Bree Serif" => array(
		    "regular",
		),
		"Bubblegum Sans" => array(
		    "regular",
		),
		"Bubbler One" => array(
		    "regular",
		),
		"Buda" => array(
		    "300",
		),
		"Buenard" => array(
		    "regular",
		    "700",
		),
		"Bungee" => array(
		    "regular",
		),
		"Bungee Hairline" => array(
		    "regular",
		),
		"Bungee Inline" => array(
		    "regular",
		),
		"Bungee Outline" => array(
		    "regular",
		),
		"Bungee Shade" => array(
		    "regular",
		),
		"Butcherman" => array(
		    "regular",
		),
		"Butterfly Kids" => array(
		    "regular",
		),
		"Cabin" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cabin Condensed" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cabin Sketch" => array(
		    "regular",
		    "700",
		),
		"Caesar Dressing" => array(
		    "regular",
		),
		"Cagliostro" => array(
		    "regular",
		),
		"Cairo" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "900",
		),
		"Calligraffitti" => array(
		    "regular",
		),
		"Cambay" => array(
		    "regular",
		    "700",
		),
		"Cambo" => array(
		    "regular",
		),
		"Candal" => array(
		    "regular",
		),
		"Cantarell" => array(
		    "regular",
		    "700",
		),
		"Cantata One" => array(
		    "regular",
		),
		"Cantora One" => array(
		    "regular",
		),
		"Capriola" => array(
		    "regular",
		),
		"Cardo" => array(
		    "regular",
		    "700",
		),
		"Carme" => array(
		    "regular",
		),
		"Carrois Gothic" => array(
		    "regular",
		),
		"Carrois Gothic SC" => array(
		    "regular",
		),
		"Carter One" => array(
		    "regular",
		),
		"Catamaran" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Caudex" => array(
		    "regular",
		    "700",
		),
		"Caveat" => array(
		    "regular",
		    "700",
		),
		"Caveat Brush" => array(
		    "regular",
		),
		"Cedarville Cursive" => array(
		    "regular",
		),
		"Ceviche One" => array(
		    "regular",
		),
		"Changa" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Changa One" => array(
		    "regular",
		),
		"Chango" => array(
		    "regular",
		),
		"Chathura" => array(
		    "100",
		    "300",
		    "regular",
		    "700",
		    "800",
		),
		"Chau Philomene One" => array(
		    "regular",
		),
		"Chela One" => array(
		    "regular",
		),
		"Chelsea Market" => array(
		    "regular",
		),
		"Chenla" => array(
		    "regular",
		),
		"Cherry Cream Soda" => array(
		    "regular",
		),
		"Cherry Swash" => array(
		    "regular",
		    "700",
		),
		"Chewy" => array(
		    "regular",
		),
		"Chicle" => array(
		    "regular",
		),
		"Chivo" => array(
		    "300",
		    "regular",
		    "700",
		    "900",
		),
		"Chonburi" => array(
		    "regular",
		),
		"Cinzel" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Cinzel Decorative" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Clicker Script" => array(
		    "regular",
		),
		"Coda" => array(
		    "regular",
		    "800",
		),
		"Coda Caption" => array(
		    "800",
		),
		"Codystar" => array(
		    "300",
		    "regular",
		),
		"Coiny" => array(
		    "regular",
		),
		"Combo" => array(
		    "regular",
		),
		"Comfortaa" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Coming Soon" => array(
		    "regular",
		),
		"Concert One" => array(
		    "regular",
		),
		"Condiment" => array(
		    "regular",
		),
		"Content" => array(
		    "regular",
		    "700",
		),
		"Contrail One" => array(
		    "regular",
		),
		"Convergence" => array(
		    "regular",
		),
		"Cookie" => array(
		    "regular",
		),
		"Copse" => array(
		    "regular",
		),
		"Corben" => array(
		    "regular",
		    "700",
		),
		"Cormorant" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cormorant Garamond" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cormorant Infant" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cormorant SC" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cormorant Unicase" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Cormorant Upright" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Courgette" => array(
		    "regular",
		),
		"Cousine" => array(
		    "regular",
		    "700",
		),
		"Coustard" => array(
		    "regular",
		    "900",
		),
		"Covered By Your Grace" => array(
		    "regular",
		),
		"Crafty Girls" => array(
		    "regular",
		),
		"Creepster" => array(
		    "regular",
		),
		"Crete Round" => array(
		    "regular",
		),
		"Crimson Text" => array(
		    "regular",
		    "600",
		    "700",
		),
		"Croissant One" => array(
		    "regular",
		),
		"Crushed" => array(
		    "regular",
		),
		"Cuprum" => array(
		    "regular",
		    "700",
		),
		"Cutive" => array(
		    "regular",
		),
		"Cutive Mono" => array(
		    "regular",
		),
		"Damion" => array(
		    "regular",
		),
		"Dancing Script" => array(
		    "regular",
		    "700",
		),
		"Dangrek" => array(
		    "regular",
		),
		"David Libre" => array(
		    "regular",
		    "500",
		    "700",
		),
		"Dawning of a New Day" => array(
		    "regular",
		),
		"Days One" => array(
		    "regular",
		),
		"Dekko" => array(
		    "regular",
		),
		"Delius" => array(
		    "regular",
		),
		"Delius Swash Caps" => array(
		    "regular",
		),
		"Delius Unicase" => array(
		    "regular",
		    "700",
		),
		"Della Respira" => array(
		    "regular",
		),
		"Denk One" => array(
		    "regular",
		),
		"Devonshire" => array(
		    "regular",
		),
		"Dhurjati" => array(
		    "regular",
		),
		"Didact Gothic" => array(
		    "regular",
		),
		"Diplomata" => array(
		    "regular",
		),
		"Diplomata SC" => array(
		    "regular",
		),
		"Domine" => array(
		    "regular",
		    "700",
		),
		"Donegal One" => array(
		    "regular",
		),
		"Doppio One" => array(
		    "regular",
		),
		"Dorsa" => array(
		    "regular",
		),
		"Dosis" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Dr Sugiyama" => array(
		    "regular",
		),
		"Droid Sans" => array(
		    "regular",
		    "700",
		),
		"Droid Sans Mono" => array(
		    "regular",
		),
		"Droid Serif" => array(
		    "regular",
		    "700",
		),
		"Duru Sans" => array(
		    "regular",
		),
		"Dynalight" => array(
		    "regular",
		),
		"EB Garamond" => array(
		    "regular",
		),
		"Eagle Lake" => array(
		    "regular",
		),
		"Eater" => array(
		    "regular",
		),
		"Economica" => array(
		    "regular",
		    "700",
		),
		"Eczar" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Ek Mukta" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"El Messiri" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Electrolize" => array(
		    "regular",
		),
		"Elsie" => array(
		    "regular",
		    "900",
		),
		"Elsie Swash Caps" => array(
		    "regular",
		    "900",
		),
		"Emblema One" => array(
		    "regular",
		),
		"Emilys Candy" => array(
		    "regular",
		),
		"Engagement" => array(
		    "regular",
		),
		"Englebert" => array(
		    "regular",
		),
		"Enriqueta" => array(
		    "regular",
		    "700",
		),
		"Erica One" => array(
		    "regular",
		),
		"Esteban" => array(
		    "regular",
		),
		"Euphoria Script" => array(
		    "regular",
		),
		"Ewert" => array(
		    "regular",
		),
		"Exo" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Exo 2" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Expletus Sans" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Fanwood Text" => array(
		    "regular",
		),
		"Farsan" => array(
		    "regular",
		),
		"Fascinate" => array(
		    "regular",
		),
		"Fascinate Inline" => array(
		    "regular",
		),
		"Faster One" => array(
		    "regular",
		),
		"Fasthand" => array(
		    "regular",
		),
		"Fauna One" => array(
		    "regular",
		),
		"Federant" => array(
		    "regular",
		),
		"Federo" => array(
		    "regular",
		),
		"Felipa" => array(
		    "regular",
		),
		"Fenix" => array(
		    "regular",
		),
		"Finger Paint" => array(
		    "regular",
		),
		"Fira Mono" => array(
		    "regular",
		    "500",
		    "700",
		),
		"Fira Sans" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Fira Sans Condensed" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Fira Sans Extra Condensed" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Fjalla One" => array(
		    "regular",
		),
		"Fjord One" => array(
		    "regular",
		),
		"Flamenco" => array(
		    "300",
		    "regular",
		),
		"Flavors" => array(
		    "regular",
		),
		"Fondamento" => array(
		    "regular",
		),
		"Fontdiner Swanky" => array(
		    "regular",
		),
		"Forum" => array(
		    "regular",
		),
		"Francois One" => array(
		    "regular",
		),
		"Frank Ruhl Libre" => array(
		    "300",
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Freckle Face" => array(
		    "regular",
		),
		"Fredericka the Great" => array(
		    "regular",
		),
		"Fredoka One" => array(
		    "regular",
		),
		"Freehand" => array(
		    "regular",
		),
		"Fresca" => array(
		    "regular",
		),
		"Frijole" => array(
		    "regular",
		),
		"Fruktur" => array(
		    "regular",
		),
		"Fugaz One" => array(
		    "regular",
		),
		"GFS Didot" => array(
		    "regular",
		),
		"GFS Neohellenic" => array(
		    "regular",
		    "700",
		),
		"Gabriela" => array(
		    "regular",
		),
		"Gafata" => array(
		    "regular",
		),
		"Galada" => array(
		    "regular",
		),
		"Galdeano" => array(
		    "regular",
		),
		"Galindo" => array(
		    "regular",
		),
		"Gentium Basic" => array(
		    "regular",
		    "700",
		),
		"Gentium Book Basic" => array(
		    "regular",
		    "700",
		),
		"Geo" => array(
		    "regular",
		),
		"Geostar" => array(
		    "regular",
		),
		"Geostar Fill" => array(
		    "regular",
		),
		"Germania One" => array(
		    "regular",
		),
		"Gidugu" => array(
		    "regular",
		),
		"Gilda Display" => array(
		    "regular",
		),
		"Give You Glory" => array(
		    "regular",
		),
		"Glass Antiqua" => array(
		    "regular",
		),
		"Glegoo" => array(
		    "regular",
		    "700",
		),
		"Gloria Hallelujah" => array(
		    "regular",
		),
		"Goblin One" => array(
		    "regular",
		),
		"Gochi Hand" => array(
		    "regular",
		),
		"Gorditas" => array(
		    "regular",
		    "700",
		),
		"Goudy Bookletter 1911" => array(
		    "regular",
		),
		"Graduate" => array(
		    "regular",
		),
		"Grand Hotel" => array(
		    "regular",
		),
		"Gravitas One" => array(
		    "regular",
		),
		"Great Vibes" => array(
		    "regular",
		),
		"Griffy" => array(
		    "regular",
		),
		"Gruppo" => array(
		    "regular",
		),
		"Gudea" => array(
		    "regular",
		    "700",
		),
		"Gurajada" => array(
		    "regular",
		),
		"Habibi" => array(
		    "regular",
		),
		"Halant" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Hammersmith One" => array(
		    "regular",
		),
		"Hanalei" => array(
		    "regular",
		),
		"Hanalei Fill" => array(
		    "regular",
		),
		"Handlee" => array(
		    "regular",
		),
		"Hanuman" => array(
		    "regular",
		    "700",
		),
		"Happy Monkey" => array(
		    "regular",
		),
		"Harmattan" => array(
		    "regular",
		),
		"Headland One" => array(
		    "regular",
		),
		"Heebo" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "800",
		    "900",
		),
		"Henny Penny" => array(
		    "regular",
		),
		"Herr Von Muellerhoff" => array(
		    "regular",
		),
		"Hind" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Hind Guntur" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Hind Madurai" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Hind Siliguri" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Hind Vadodara" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Holtwood One SC" => array(
		    "regular",
		),
		"Homemade Apple" => array(
		    "regular",
		),
		"Homenaje" => array(
		    "regular",
		),
		"IM Fell DW Pica" => array(
		    "regular",
		),
		"IM Fell DW Pica SC" => array(
		    "regular",
		),
		"IM Fell Double Pica" => array(
		    "regular",
		),
		"IM Fell Double Pica SC" => array(
		    "regular",
		),
		"IM Fell English" => array(
		    "regular",
		),
		"IM Fell English SC" => array(
		    "regular",
		),
		"IM Fell French Canon" => array(
		    "regular",
		),
		"IM Fell French Canon SC" => array(
		    "regular",
		),
		"IM Fell Great Primer" => array(
		    "regular",
		),
		"IM Fell Great Primer SC" => array(
		    "regular",
		),
		"Iceberg" => array(
		    "regular",
		),
		"Iceland" => array(
		    "regular",
		),
		"Imprima" => array(
		    "regular",
		),
		"Inconsolata" => array(
		    "regular",
		    "700",
		),
		"Inder" => array(
		    "regular",
		),
		"Indie Flower" => array(
		    "regular",
		),
		"Inika" => array(
		    "regular",
		    "700",
		),
		"Inknut Antiqua" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Irish Grover" => array(
		    "regular",
		),
		"Istok Web" => array(
		    "regular",
		    "700",
		),
		"Italiana" => array(
		    "regular",
		),
		"Italianno" => array(
		    "regular",
		),
		"Itim" => array(
		    "regular",
		),
		"Jacques Francois" => array(
		    "regular",
		),
		"Jacques Francois Shadow" => array(
		    "regular",
		),
		"Jaldi" => array(
		    "regular",
		    "700",
		),
		"Jim Nightshade" => array(
		    "regular",
		),
		"Jockey One" => array(
		    "regular",
		),
		"Jolly Lodger" => array(
		    "regular",
		),
		"Jomhuria" => array(
		    "regular",
		),
		"Josefin Sans" => array(
		    "100",
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Josefin Slab" => array(
		    "100",
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Joti One" => array(
		    "regular",
		),
		"Judson" => array(
		    "regular",
		    "700",
		),
		"Julee" => array(
		    "regular",
		),
		"Julius Sans One" => array(
		    "regular",
		),
		"Junge" => array(
		    "regular",
		),
		"Jura" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		),
		"Just Another Hand" => array(
		    "regular",
		),
		"Just Me Again Down Here" => array(
		    "regular",
		),
		"Kadwa" => array(
		    "regular",
		    "700",
		),
		"Kalam" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Kameron" => array(
		    "regular",
		    "700",
		),
		"Kanit" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Kantumruy" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Karla" => array(
		    "regular",
		    "700",
		),
		"Karma" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Katibeh" => array(
		    "regular",
		),
		"Kaushan Script" => array(
		    "regular",
		),
		"Kavivanar" => array(
		    "regular",
		),
		"Kavoon" => array(
		    "regular",
		),
		"Kdam Thmor" => array(
		    "regular",
		),
		"Keania One" => array(
		    "regular",
		),
		"Kelly Slab" => array(
		    "regular",
		),
		"Kenia" => array(
		    "regular",
		),
		"Khand" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Khmer" => array(
		    "regular",
		),
		"Khula" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		),
		"Kite One" => array(
		    "regular",
		),
		"Knewave" => array(
		    "regular",
		),
		"Kotta One" => array(
		    "regular",
		),
		"Koulen" => array(
		    "regular",
		),
		"Kranky" => array(
		    "regular",
		),
		"Kreon" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Kristi" => array(
		    "regular",
		),
		"Krona One" => array(
		    "regular",
		),
		"Kumar One" => array(
		    "regular",
		),
		"Kumar One Outline" => array(
		    "regular",
		),
		"Kurale" => array(
		    "regular",
		),
		"La Belle Aurore" => array(
		    "regular",
		),
		"Laila" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Lakki Reddy" => array(
		    "regular",
		),
		"Lalezar" => array(
		    "regular",
		),
		"Lancelot" => array(
		    "regular",
		),
		"Lateef" => array(
		    "regular",
		),
		"Lato" => array(
		    "100",
		    "300",
		    "regular",
		    "700",
		    "900",
		),
		"League Script" => array(
		    "regular",
		),
		"Leckerli One" => array(
		    "regular",
		),
		"Ledger" => array(
		    "regular",
		),
		"Lekton" => array(
		    "regular",
		    "700",
		),
		"Lemon" => array(
		    "regular",
		),
		"Lemonada" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Libre Baskerville" => array(
		    "regular",
		    "700",
		),
		"Libre Franklin" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Life Savers" => array(
		    "regular",
		    "700",
		),
		"Lilita One" => array(
		    "regular",
		),
		"Lily Script One" => array(
		    "regular",
		),
		"Limelight" => array(
		    "regular",
		),
		"Linden Hill" => array(
		    "regular",
		),
		"Lobster" => array(
		    "regular",
		),
		"Lobster Two" => array(
		    "regular",
		    "700",
		),
		"Londrina Outline" => array(
		    "regular",
		),
		"Londrina Shadow" => array(
		    "regular",
		),
		"Londrina Sketch" => array(
		    "regular",
		),
		"Londrina Solid" => array(
		    "regular",
		),
		"Lora" => array(
		    "regular",
		    "700",
		),
		"Love Ya Like A Sister" => array(
		    "regular",
		),
		"Loved by the King" => array(
		    "regular",
		),
		"Lovers Quarrel" => array(
		    "regular",
		),
		"Luckiest Guy" => array(
		    "regular",
		),
		"Lusitana" => array(
		    "regular",
		    "700",
		),
		"Lustria" => array(
		    "regular",
		),
		"Macondo" => array(
		    "regular",
		),
		"Macondo Swash Caps" => array(
		    "regular",
		),
		"Mada" => array(
		    "300",
		    "regular",
		    "500",
		    "900",
		),
		"Magra" => array(
		    "regular",
		    "700",
		),
		"Maiden Orange" => array(
		    "regular",
		),
		"Maitree" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Mako" => array(
		    "regular",
		),
		"Mallanna" => array(
		    "regular",
		),
		"Mandali" => array(
		    "regular",
		),
		"Marcellus" => array(
		    "regular",
		),
		"Marcellus SC" => array(
		    "regular",
		),
		"Marck Script" => array(
		    "regular",
		),
		"Margarine" => array(
		    "regular",
		),
		"Marko One" => array(
		    "regular",
		),
		"Marmelad" => array(
		    "regular",
		),
		"Martel" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Martel Sans" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Marvel" => array(
		    "regular",
		    "700",
		),
		"Mate" => array(
		    "regular",
		),
		"Mate SC" => array(
		    "regular",
		),
		"Maven Pro" => array(
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"McLaren" => array(
		    "regular",
		),
		"Meddon" => array(
		    "regular",
		),
		"MedievalSharp" => array(
		    "regular",
		),
		"Medula One" => array(
		    "regular",
		),
		"Meera Inimai" => array(
		    "regular",
		),
		"Megrim" => array(
		    "regular",
		),
		"Meie Script" => array(
		    "regular",
		),
		"Merienda" => array(
		    "regular",
		    "700",
		),
		"Merienda One" => array(
		    "regular",
		),
		"Merriweather" => array(
		    "300",
		    "regular",
		    "700",
		    "900",
		),
		"Merriweather Sans" => array(
		    "300",
		    "regular",
		    "700",
		    "800",
		),
		"Metal" => array(
		    "regular",
		),
		"Metal Mania" => array(
		    "regular",
		),
		"Metamorphous" => array(
		    "regular",
		),
		"Metrophobic" => array(
		    "regular",
		),
		"Michroma" => array(
		    "regular",
		),
		"Milonga" => array(
		    "regular",
		),
		"Miltonian" => array(
		    "regular",
		),
		"Miltonian Tattoo" => array(
		    "regular",
		),
		"Miniver" => array(
		    "regular",
		),
		"Miriam Libre" => array(
		    "regular",
		    "700",
		),
		"Mirza" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Miss Fajardose" => array(
		    "regular",
		),
		"Mitr" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Modak" => array(
		    "regular",
		),
		"Modern Antiqua" => array(
		    "regular",
		),
		"Mogra" => array(
		    "regular",
		),
		"Molengo" => array(
		    "regular",
		),
		"Molle" => array(
		),
		"Monda" => array(
		    "regular",
		    "700",
		),
		"Monofett" => array(
		    "regular",
		),
		"Monoton" => array(
		    "regular",
		),
		"Monsieur La Doulaise" => array(
		    "regular",
		),
		"Montaga" => array(
		    "regular",
		),
		"Montez" => array(
		    "regular",
		),
		"Montserrat" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Montserrat Alternates" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Montserrat Subrayada" => array(
		    "regular",
		    "700",
		),
		"Moul" => array(
		    "regular",
		),
		"Moulpali" => array(
		    "regular",
		),
		"Mountains of Christmas" => array(
		    "regular",
		    "700",
		),
		"Mouse Memoirs" => array(
		    "regular",
		),
		"Mr Bedfort" => array(
		    "regular",
		),
		"Mr Dafoe" => array(
		    "regular",
		),
		"Mr De Haviland" => array(
		    "regular",
		),
		"Mrs Saint Delafield" => array(
		    "regular",
		),
		"Mrs Sheppards" => array(
		    "regular",
		),
		"Mukta Vaani" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Muli" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Mystery Quest" => array(
		    "regular",
		),
		"NTR" => array(
		    "regular",
		),
		"Neucha" => array(
		    "regular",
		),
		"Neuton" => array(
		    "200",
		    "300",
		    "regular",
		    "700",
		    "800",
		),
		"New Rocker" => array(
		    "regular",
		),
		"News Cycle" => array(
		    "regular",
		    "700",
		),
		"Niconne" => array(
		    "regular",
		),
		"Nixie One" => array(
		    "regular",
		),
		"Nobile" => array(
		    "regular",
		    "700",
		),
		"Nokora" => array(
		    "regular",
		    "700",
		),
		"Norican" => array(
		    "regular",
		),
		"Nosifer" => array(
		    "regular",
		),
		"Nothing You Could Do" => array(
		    "regular",
		),
		"Noticia Text" => array(
		    "regular",
		    "700",
		),
		"Noto Sans" => array(
		    "regular",
		    "700",
		),
		"Noto Serif" => array(
		    "regular",
		    "700",
		),
		"Nova Cut" => array(
		    "regular",
		),
		"Nova Flat" => array(
		    "regular",
		),
		"Nova Mono" => array(
		    "regular",
		),
		"Nova Oval" => array(
		    "regular",
		),
		"Nova Round" => array(
		    "regular",
		),
		"Nova Script" => array(
		    "regular",
		),
		"Nova Slim" => array(
		    "regular",
		),
		"Nova Square" => array(
		    "regular",
		),
		"Numans" => array(
		    "regular",
		),
		"Nunito" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Nunito Sans" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Odor Mean Chey" => array(
		    "regular",
		),
		"Offside" => array(
		    "regular",
		),
		"Old Standard TT" => array(
		    "regular",
		    "700",
		),
		"Oldenburg" => array(
		    "regular",
		),
		"Oleo Script" => array(
		    "regular",
		    "700",
		),
		"Oleo Script Swash Caps" => array(
		    "regular",
		    "700",
		),
		"Open Sans" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		),
		"Open Sans Condensed" => array(
		    "300",
		    "700",
		),
		"Oranienbaum" => array(
		    "regular",
		),
		"Orbitron" => array(
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Oregano" => array(
		    "regular",
		),
		"Orienta" => array(
		    "regular",
		),
		"Original Surfer" => array(
		    "regular",
		),
		"Oswald" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Over the Rainbow" => array(
		    "regular",
		),
		"Overlock" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Overlock SC" => array(
		    "regular",
		),
		"Overpass" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Overpass Mono" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Ovo" => array(
		    "regular",
		),
		"Oxygen" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Oxygen Mono" => array(
		    "regular",
		),
		"PT Mono" => array(
		    "regular",
		),
		"PT Sans" => array(
		    "regular",
		    "700",
		),
		"PT Sans Caption" => array(
		    "regular",
		    "700",
		),
		"PT Sans Narrow" => array(
		    "regular",
		    "700",
		),
		"PT Serif" => array(
		    "regular",
		    "700",
		),
		"PT Serif Caption" => array(
		    "regular",
		),
		"Pacifico" => array(
		    "regular",
		),
		"Padauk" => array(
		    "regular",
		    "700",
		),
		"Palanquin" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Palanquin Dark" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Pangolin" => array(
		    "regular",
		),
		"Paprika" => array(
		    "regular",
		),
		"Parisienne" => array(
		    "regular",
		),
		"Passero One" => array(
		    "regular",
		),
		"Passion One" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Pathway Gothic One" => array(
		    "regular",
		),
		"Patrick Hand" => array(
		    "regular",
		),
		"Patrick Hand SC" => array(
		    "regular",
		),
		"Pattaya" => array(
		    "regular",
		),
		"Patua One" => array(
		    "regular",
		),
		"Pavanam" => array(
		    "regular",
		),
		"Paytone One" => array(
		    "regular",
		),
		"Peddana" => array(
		    "regular",
		),
		"Peralta" => array(
		    "regular",
		),
		"Permanent Marker" => array(
		    "regular",
		),
		"Petit Formal Script" => array(
		    "regular",
		),
		"Petrona" => array(
		    "regular",
		),
		"Philosopher" => array(
		    "regular",
		    "700",
		),
		"Piedra" => array(
		    "regular",
		),
		"Pinyon Script" => array(
		    "regular",
		),
		"Pirata One" => array(
		    "regular",
		),
		"Plaster" => array(
		    "regular",
		),
		"Play" => array(
		    "regular",
		    "700",
		),
		"Playball" => array(
		    "regular",
		),
		"Playfair Display" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Playfair Display SC" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Podkova" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Poiret One" => array(
		    "regular",
		),
		"Poller One" => array(
		    "regular",
		),
		"Poly" => array(
		    "regular",
		),
		"Pompiere" => array(
		    "regular",
		),
		"Pontano Sans" => array(
		    "regular",
		),
		"Poppins" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Port Lligat Sans" => array(
		    "regular",
		),
		"Port Lligat Slab" => array(
		    "regular",
		),
		"Pragati Narrow" => array(
		    "regular",
		    "700",
		),
		"Prata" => array(
		    "regular",
		),
		"Preahvihear" => array(
		    "regular",
		),
		"Press Start 2P" => array(
		    "regular",
		),
		"Pridi" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Princess Sofia" => array(
		    "regular",
		),
		"Prociono" => array(
		    "regular",
		),
		"Prompt" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Prosto One" => array(
		    "regular",
		),
		"Proza Libre" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Puritan" => array(
		    "regular",
		    "700",
		),
		"Purple Purse" => array(
		    "regular",
		),
		"Quando" => array(
		    "regular",
		),
		"Quantico" => array(
		    "regular",
		    "700",
		),
		"Quattrocento" => array(
		    "regular",
		    "700",
		),
		"Quattrocento Sans" => array(
		    "regular",
		    "700",
		),
		"Questrial" => array(
		    "regular",
		),
		"Quicksand" => array(
		    "300",
		    "regular",
		    "500",
		    "700",
		),
		"Quintessential" => array(
		    "regular",
		),
		"Qwigley" => array(
		    "regular",
		),
		"Racing Sans One" => array(
		    "regular",
		),
		"Radley" => array(
		    "regular",
		),
		"Rajdhani" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Rakkas" => array(
		    "regular",
		),
		"Raleway" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Raleway Dots" => array(
		    "regular",
		),
		"Ramabhadra" => array(
		    "regular",
		),
		"Ramaraja" => array(
		    "regular",
		),
		"Rambla" => array(
		    "regular",
		    "700",
		),
		"Rammetto One" => array(
		    "regular",
		),
		"Ranchers" => array(
		    "regular",
		),
		"Rancho" => array(
		    "regular",
		),
		"Ranga" => array(
		    "regular",
		    "700",
		),
		"Rasa" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Rationale" => array(
		    "regular",
		),
		"Ravi Prakash" => array(
		    "regular",
		),
		"Redressed" => array(
		    "regular",
		),
		"Reem Kufi" => array(
		    "regular",
		),
		"Reenie Beanie" => array(
		    "regular",
		),
		"Revalia" => array(
		    "regular",
		),
		"Rhodium Libre" => array(
		    "regular",
		),
		"Ribeye" => array(
		    "regular",
		),
		"Ribeye Marrow" => array(
		    "regular",
		),
		"Righteous" => array(
		    "regular",
		),
		"Risque" => array(
		    "regular",
		),
		"Roboto" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Roboto Condensed" => array(
		    "300",
		    "regular",
		    "700",
		),
		"Roboto Mono" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		),
		"Roboto Slab" => array(
		    "100",
		    "300",
		    "regular",
		    "700",
		),
		"Rochester" => array(
		    "regular",
		),
		"Rock Salt" => array(
		    "regular",
		),
		"Rokkitt" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Romanesco" => array(
		    "regular",
		),
		"Ropa Sans" => array(
		    "regular",
		),
		"Rosario" => array(
		    "regular",
		    "700",
		),
		"Rosarivo" => array(
		    "regular",
		),
		"Rouge Script" => array(
		    "regular",
		),
		"Rozha One" => array(
		    "regular",
		),
		"Rubik" => array(
		    "300",
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Rubik Mono One" => array(
		    "regular",
		),
		"Ruda" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Rufina" => array(
		    "regular",
		    "700",
		),
		"Ruge Boogie" => array(
		    "regular",
		),
		"Ruluko" => array(
		    "regular",
		),
		"Rum Raisin" => array(
		    "regular",
		),
		"Ruslan Display" => array(
		    "regular",
		),
		"Russo One" => array(
		    "regular",
		),
		"Ruthie" => array(
		    "regular",
		),
		"Rye" => array(
		    "regular",
		),
		"Sacramento" => array(
		    "regular",
		),
		"Sahitya" => array(
		    "regular",
		    "700",
		),
		"Sail" => array(
		    "regular",
		),
		"Salsa" => array(
		    "regular",
		),
		"Sanchez" => array(
		    "regular",
		),
		"Sancreek" => array(
		    "regular",
		),
		"Sansita" => array(
		    "regular",
		    "700",
		    "800",
		    "900",
		),
		"Sarala" => array(
		    "regular",
		    "700",
		),
		"Sarina" => array(
		    "regular",
		),
		"Sarpanch" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Satisfy" => array(
		    "regular",
		),
		"Scada" => array(
		    "regular",
		    "700",
		),
		"Scheherazade" => array(
		    "regular",
		    "700",
		),
		"Schoolbell" => array(
		    "regular",
		),
		"Scope One" => array(
		    "regular",
		),
		"Seaweed Script" => array(
		    "regular",
		),
		"Secular One" => array(
		    "regular",
		),
		"Sevillana" => array(
		    "regular",
		),
		"Seymour One" => array(
		    "regular",
		),
		"Shadows Into Light" => array(
		    "regular",
		),
		"Shadows Into Light Two" => array(
		    "regular",
		),
		"Shanti" => array(
		    "regular",
		),
		"Share" => array(
		    "regular",
		    "700",
		),
		"Share Tech" => array(
		    "regular",
		),
		"Share Tech Mono" => array(
		    "regular",
		),
		"Shojumaru" => array(
		    "regular",
		),
		"Short Stack" => array(
		    "regular",
		),
		"Shrikhand" => array(
		    "regular",
		),
		"Siemreap" => array(
		    "regular",
		),
		"Sigmar One" => array(
		    "regular",
		),
		"Signika" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Signika Negative" => array(
		    "300",
		    "regular",
		    "600",
		    "700",
		),
		"Simonetta" => array(
		    "regular",
		    "900",
		),
		"Sintony" => array(
		    "regular",
		    "700",
		),
		"Sirin Stencil" => array(
		    "regular",
		),
		"Six Caps" => array(
		    "regular",
		),
		"Skranji" => array(
		    "regular",
		    "700",
		),
		"Slabo 13px" => array(
		    "regular",
		),
		"Slabo 27px" => array(
		    "regular",
		),
		"Slackey" => array(
		    "regular",
		),
		"Smokum" => array(
		    "regular",
		),
		"Smythe" => array(
		    "regular",
		),
		"Sniglet" => array(
		    "regular",
		    "800",
		),
		"Snippet" => array(
		    "regular",
		),
		"Snowburst One" => array(
		    "regular",
		),
		"Sofadi One" => array(
		    "regular",
		),
		"Sofia" => array(
		    "regular",
		),
		"Sonsie One" => array(
		    "regular",
		),
		"Sorts Mill Goudy" => array(
		    "regular",
		),
		"Source Code Pro" => array(
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "900",
		),
		"Source Sans Pro" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "900",
		),
		"Source Serif Pro" => array(
		    "regular",
		    "600",
		    "700",
		),
		"Space Mono" => array(
		    "regular",
		    "700",
		),
		"Special Elite" => array(
		    "regular",
		),
		"Spicy Rice" => array(
		    "regular",
		),
		"Spinnaker" => array(
		    "regular",
		),
		"Spirax" => array(
		    "regular",
		),
		"Squada One" => array(
		    "regular",
		),
		"Sree Krushnadevaraya" => array(
		    "regular",
		),
		"Sriracha" => array(
		    "regular",
		),
		"Stalemate" => array(
		    "regular",
		),
		"Stalinist One" => array(
		    "regular",
		),
		"Stardos Stencil" => array(
		    "regular",
		    "700",
		),
		"Stint Ultra Condensed" => array(
		    "regular",
		),
		"Stint Ultra Expanded" => array(
		    "regular",
		),
		"Stoke" => array(
		    "300",
		    "regular",
		),
		"Strait" => array(
		    "regular",
		),
		"Sue Ellen Francisco" => array(
		    "regular",
		),
		"Suez One" => array(
		    "regular",
		),
		"Sumana" => array(
		    "regular",
		    "700",
		),
		"Sunshiney" => array(
		    "regular",
		),
		"Supermercado One" => array(
		    "regular",
		),
		"Sura" => array(
		    "regular",
		    "700",
		),
		"Suranna" => array(
		    "regular",
		),
		"Suravaram" => array(
		    "regular",
		),
		"Suwannaphum" => array(
		    "regular",
		),
		"Swanky and Moo Moo" => array(
		    "regular",
		),
		"Syncopate" => array(
		    "regular",
		    "700",
		),
		"Tangerine" => array(
		    "regular",
		    "700",
		),
		"Taprom" => array(
		    "regular",
		),
		"Tauri" => array(
		    "regular",
		),
		"Taviraj" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Teko" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Telex" => array(
		    "regular",
		),
		"Tenali Ramakrishna" => array(
		    "regular",
		),
		"Tenor Sans" => array(
		    "regular",
		),
		"Text Me One" => array(
		    "regular",
		),
		"The Girl Next Door" => array(
		    "regular",
		),
		"Tienne" => array(
		    "regular",
		    "700",
		    "900",
		),
		"Tillana" => array(
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		),
		"Timmana" => array(
		    "regular",
		),
		"Tinos" => array(
		    "regular",
		    "700",
		),
		"Titan One" => array(
		    "regular",
		),
		"Titillium Web" => array(
		    "200",
		    "300",
		    "regular",
		    "600",
		    "700",
		    "900",
		),
		"Trade Winds" => array(
		    "regular",
		),
		"Trirong" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Trocchi" => array(
		    "regular",
		),
		"Trochut" => array(
		    "regular",
		    "700",
		),
		"Trykker" => array(
		    "regular",
		),
		"Tulpen One" => array(
		    "regular",
		),
		"Ubuntu" => array(
		    "300",
		    "regular",
		    "500",
		    "700",
		),
		"Ubuntu Condensed" => array(
		    "regular",
		),
		"Ubuntu Mono" => array(
		    "regular",
		    "700",
		),
		"Ultra" => array(
		    "regular",
		),
		"Uncial Antiqua" => array(
		    "regular",
		),
		"Underdog" => array(
		    "regular",
		),
		"Unica One" => array(
		    "regular",
		),
		"UnifrakturCook" => array(
		    "700",
		),
		"UnifrakturMaguntia" => array(
		    "regular",
		),
		"Unkempt" => array(
		    "regular",
		    "700",
		),
		"Unlock" => array(
		    "regular",
		),
		"Unna" => array(
		    "regular",
		    "700",
		),
		"VT323" => array(
		    "regular",
		),
		"Vampiro One" => array(
		    "regular",
		),
		"Varela" => array(
		    "regular",
		),
		"Varela Round" => array(
		    "regular",
		),
		"Vast Shadow" => array(
		    "regular",
		),
		"Vesper Libre" => array(
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Vibur" => array(
		    "regular",
		),
		"Vidaloka" => array(
		    "regular",
		),
		"Viga" => array(
		    "regular",
		),
		"Voces" => array(
		    "regular",
		),
		"Volkhov" => array(
		    "regular",
		    "700",
		),
		"Vollkorn" => array(
		    "regular",
		    "700",
		),
		"Voltaire" => array(
		    "regular",
		),
		"Waiting for the Sunrise" => array(
		    "regular",
		),
		"Wallpoet" => array(
		    "regular",
		),
		"Walter Turncoat" => array(
		    "regular",
		),
		"Warnes" => array(
		    "regular",
		),
		"Wellfleet" => array(
		    "regular",
		),
		"Wendy One" => array(
		    "regular",
		),
		"Wire One" => array(
		    "regular",
		),
		"Work Sans" => array(
		    "100",
		    "200",
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		    "800",
		    "900",
		),
		"Yanone Kaffeesatz" => array(
		    "200",
		    "300",
		    "regular",
		    "700",
		),
		"Yantramanav" => array(
		    "100",
		    "300",
		    "regular",
		    "500",
		    "700",
		    "900",
		),
		"Yatra One" => array(
		    "regular",
		),
		"Yellowtail" => array(
		    "regular",
		),
		"Yeseva One" => array(
		    "regular",
		),
		"Yesteryear" => array(
		    "regular",
		),
		"Yrsa" => array(
		    "300",
		    "regular",
		    "500",
		    "600",
		    "700",
		),
		"Zeyada" => array(
		    "regular",
		),
	);
}