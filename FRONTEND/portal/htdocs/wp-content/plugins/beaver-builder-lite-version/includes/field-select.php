<?php
/**
 * Select field
 *
 * Setup attributes example:
 *
 *   'select_field_name' => array(
 *     'type'         => 'select',
 *     'label'        => esc_html__( 'Select Field', 'fl-builder' ),
 *     'default'      => 'option-1',
 *     'class'        => '',
 *     'multi-select' => false,
 *     'options'      => array(
 *       'option-1' => esc_html__( 'Option 1', 'fl-builder' ),
 *       'option-2' => array(
 *         'label'   => esc_html__( 'Premium Option 2', 'fl-builder' ),
 *         'premium' => true,
 *       ),
 *       'optgroup-1' => array(
 *         'label'   => esc_html__( 'Optgroup 1', 'fl-builder' ),
 *         'options' => array( *
 *           'option-3' => esc_html__( 'Option 3', 'fl-builder' ),
 *           'option-4' => array(
 *             'label'   => esc_html__( 'Premium Option 4', 'fl-builder' ),
 *             'premium' => true,
 *           ),
 *         ),
 *         'premium' => false,
 *       ),
 *     ),
 *     'toggle' => array(
 *       'option-1' => array(
 *         'fields'   => array( 'my_field_1', 'my_field_2' ),
 *         'sections' => array( 'my_section' ),
 *         'tabs'     => array( 'my_tab' ),
 *       ),
 *       'option-2' => array(),
 *     ),
 *     'hide'    => '', @todo Write example setup attribute value
 *     'trigger' => '', @todo Write example setup attribute value
 *   );
 *
 */



$atts = '';

// Multiselect?
if ( isset( $field['multi-select'] ) ) {
	$atts .= ' multiple';
	$name .= '[]';
}

// Class
if ( isset( $field['class'] ) ) {
	$atts .= ' class="' . esc_attr( $field['class'] ) . '"';
}

// Toggle data
if ( isset( $field['toggle'] ) ) {
	$atts .= ' data-toggle="' . esc_attr( json_encode( $field['toggle'] ) ) . '"';
}

// Hide data
if ( isset( $field['hide'] ) ) {
	$atts .= ' data-hide="' . esc_attr( json_encode( $field['hide'] ) ) . '"';
}

// Trigger data
if ( isset( $field['trigger'] ) ) {
	$atts .= ' data-trigger="' . esc_attr( json_encode( $field['trigger'] ) ) . '"';
}

?>

<select name="<?php echo esc_attr( $name ); ?>"<?php echo $atts; ?>>

	<?php

	foreach ( (array) $field['options'] as $option_key => $option_val ) {

		// Don't display premium options if using lite plugin version
		if ( is_array( $option_val ) && isset( $option_val['premium' ] ) && $option_val['premium'] && true === FL_BUILDER_LITE ) {
			continue;
		}

		if ( is_array( $option_val ) && isset( $option_val['label'] ) && isset( $option_val['options'] ) ) {

			echo '<optgroup label="' . esc_attr( $option_val['label'] ) . '">';

				foreach( (array) $option_val['options'] as $optgroup_option_key => $optgroup_option_val ) {

					// Don't display premium optgroup options if using lite plugin version
					if ( is_array( $optgroup_option_val ) && isset( $optgroup_option_val['premium' ] ) && $optgroup_option_val['premium'] && true === FL_BUILDER_LITE ) {
						continue;
					}

					// Is selected?

						$selected = '';

						if ( is_array( $value ) && in_array( $optgroup_option_key, $value ) ) {
							// Multi select
							$selected = ' selected="selected"';
						} elseif ( ! is_array( $value ) && selected( $value, $optgroup_option_key, false ) ) {
							// Single select
							$selected = ' selected="selected"';
						}

					// Option label
					$label = ( is_array( $optgroup_option_val ) ) ? ( $optgroup_option_val['label'] ) : ( $optgroup_option_val );

					// Output option
					echo '<option value="' . esc_attr( $optgroup_option_key ) . '"' . $selected . '>' . esc_html( $label ) . '</option>';

				} // /foreach

			echo '</optgroup>';

		} else {

			// Is selected?

				$selected = '';

				if ( is_array( $value ) && in_array( $option_key, $value ) ) {
					// Multi select
					$selected = ' selected="selected"';
				} elseif ( ! is_array( $value ) && selected( $value, $option_key, false ) ) {
					// Single select
					$selected = ' selected="selected"';
				}

			// Option label
			$label = ( is_array( $option_val ) ) ? ( $option_val['label'] ) : ( $option_val );

			// Output option
			echo '<option value="' . esc_attr( $option_key ) . '"' . $selected . '>' . esc_html( $label ) . '</option>';

		}

	} // /foreach

	?>

</select>
