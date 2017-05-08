<input type="text" name="<?php echo $name; ?>" value="<?php echo esc_attr($value); ?>" class="text<?php if(isset($field['class'])) echo ' '. $field['class']; if(!isset($field['size'])) echo ' text-full'; ?>" <?php if(isset($field['placeholder'])) echo ' placeholder="'. $field['placeholder'] .'"'; if(isset($field['maxlength'])) echo ' maxlength="'. $field['maxlength'] .'"';  if(isset($field['size'])) echo ' size="'. $field['size'] .'"'; ?> />

<?php

/**
 * Adding predefined values selector
 */

if (
		isset( $field['options'] )
		&& is_array( $field['options'] )
		&& ! empty( $field['options'] )
	) :

	// Adding empty value if missing

		if ( ! isset( $field['options'][''] ) ) {
			$field['options'][''] = esc_html_x( '- Add predefined -', 'Add predefined value.', 'fl-builder' );
		}

	// Moving the empty value to top

		$selector_value_empty = $field['options'][''];

		unset( $field['options'][''] );

		$field['options'] = array( '' => $selector_value_empty ) + $field['options'];

	// Outputting select field

	?>

	<select class="fl-select-add-value" data-target="<?php echo esc_attr( $name ); ?>">
		<?php

		foreach( $field['options'] as $option_value => $option ) {

			if (
					is_array( $option )
					&& isset( $option['label'] )
					&& isset( $option['options'] )
				) {

				// Optgroups

					echo '<optgroup label="' . esc_attr( $option['label'] ) . '">';

					foreach( (array) $option['options'] as $optgroup_option_value => $optgroup_option ) {
						echo '<option value="' . esc_attr( $optgroup_option_value ) . '">' . esc_html( $optgroup_option ) . '</option>';
					}

					echo '</optgroup>';


			} else {

				// Standard options

					echo '<option value="' . esc_attr( $option_value ) . '">' . esc_html( $option ) . '</option>';

			}

		} // /foreach

		?>
	</select>

	<?php

endif;

?>
