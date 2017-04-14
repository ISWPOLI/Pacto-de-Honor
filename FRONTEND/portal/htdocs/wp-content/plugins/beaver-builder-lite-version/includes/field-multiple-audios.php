<?php

// Normalize the value so we have an array.	
if ( ! empty( $value ) && is_string( $value ) ) {
	
	$value = json_decode( $value );
	if ( is_string( $value ) ) {
		$value = json_decode( $value );
	}
	if ( is_int( $value ) ) {
		$value = (array) $value;
	}
}
else if ( empty( $value ) ) {
	$value = array();
}
	
?>
<div class="fl-multiple-audios-field fl-builder-custom-field<?php if(empty($value)) echo ' fl-multiple-audios-empty'; if(isset($field['class'])) echo ' ' . $field['class']; ?>" <?php if(isset($field['toggle'])) echo "data-toggle='". json_encode($field['toggle']) ."'";?>>
	<div class="fl-multiple-audios-count">
	<?php printf( _n( '1 Audio File Selected', '%d Audio Files Selected', count( $value ), 'fl-builder' ), count( $value ) ); ?>
	</div>
	<a class="fl-multiple-audios-select" href="javascript:void(0);" onclick="return false;"><?php _e('Select Audio', 'fl-builder'); ?></a>
	<a class="fl-multiple-audios-edit" href="javascript:void(0);" onclick="return false;"><?php _e('Edit Playlist', 'fl-builder'); ?></a>
	<a class="fl-multiple-audios-add" href="javascript:void(0);" onclick="return false;"><?php _e('Add Audio Files', 'fl-builder'); ?></a>
	<input name="<?php echo $name; ?>" type="hidden" value='<?php if ( ! empty( $value ) ) echo json_encode( $value ); ?>' />
</div>