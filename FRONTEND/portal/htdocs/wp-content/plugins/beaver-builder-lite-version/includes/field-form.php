<?php
// Allow filtering of preview text output of a field
$preview_text = apply_filters('fl_builder_form_field_preview_text', $field['preview_text'], $name, $field, $i);
?>
<div class="fl-form-field fl-builder-custom-field"<?php if ( isset( $preview_text ) ) echo ' data-preview-text="'. $preview_text .'"'; ?>>
	<div class="fl-form-field-preview-text">
	<?php

	if ( isset( $preview_text ) && is_object( $value ) ) {
	
		$form        = FLBuilderModel::get_settings_form( $field['form'] );
		$form_fields = FLBuilderModel::get_settings_form_fields( $form['tabs'] );
		
		if ( isset( $form_fields[ $preview_text ] ) ) {
			
			$preview_field = $form_fields[ $preview_text ];
			
			if ( 'icon' == $preview_field['type'] ) {
				echo '<i class="' . $value->$preview_text . '"></i>';
			}
			else if ( 'select' == $preview_field['type'] ) {
				echo $preview_field['options'][ $value->$preview_text ];
			}
			else if ( ! empty( $value->{$preview_text} ) ) {
				echo FLBuilderUtils::snippetwop( strip_tags( str_replace( '&#39;', "'", $value->{$preview_text} ) ), 35 );
			}
		}
	}
	
	// JSON encode the value and fix encoding conflicts.
	if ( ! empty( $value ) ) {
		$value = str_replace( "'", '&#39;', json_encode( $value ) );
		$value = str_replace( '<wbr \/>', '<wbr>', $value );
	}

	?>
	</div>
	<a class="fl-form-field-edit" href="javascript:void(0);" onclick="return false;" data-type="<?php echo $field['form']; ?>"><?php printf( _x( 'Edit %s', '%s stands for form field label.', 'fl-builder' ), $field['label'] ); ?></a>
	<input name="<?php echo $name; ?>" type="hidden" value='<?php echo $value; ?>' />
</div>