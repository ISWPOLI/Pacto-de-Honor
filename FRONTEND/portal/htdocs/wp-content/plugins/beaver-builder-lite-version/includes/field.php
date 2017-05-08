<?php if(empty($field['label'])) : ?>
<td colspan="2">
<?php else : ?>
<th>
	<label for="<?php echo $name; ?>">
	<?php 
	
	if ( 'button' == $field['type'] ) {
		echo '&nbsp;';
	}
	else {

		echo $field['label']; 
	
		if ( isset( $i ) ) {
			echo ' <span class="fl-builder-field-index">' . ( $i + 1 ) . '</span>';
		}    
	}
	
	?>
	<?php if(isset($field['help'])) : ?>
	<span class="fl-help-tooltip">
		<i class="fl-help-tooltip-icon fa fa-question-circle"></i>
		<span class="fl-help-tooltip-text"><?php echo $field['help']; ?></span>
	</span>
	<?php endif; ?>
	</label>
</th>
<td>
<?php endif; ?>
	<?php if ( $responsive ) : ?>
	<i class="fl-field-responsive-toggle dashicons dashicons-desktop" data-mode="default"></i>
	<?php endif; ?>
	<?php
	
	foreach ( array( 'default', 'medium', 'responsive' ) as $device ) {
		
		if ( 'default' != $device && ! $responsive ) {
			continue;
		}
		
		if ( $responsive ) {
			
			$name  = 'default' == $device ? $root_name : $root_name . '_' . $device;
			$value = isset( $settings->$name ) ? $settings->$name : '';
			
			echo '<div class="fl-field-responsive-setting fl-field-responsive-setting-' . $device . '" data-device="' . $device . '">';
			
			if ( is_array( $responsive ) ) {			
				foreach ( $responsive as $responsive_key => $responsive_var ) {
					if ( is_array( $responsive_var ) && isset( $responsive_var[ $device ] ) ) {
						$field[ $responsive_key ] = $responsive_var[ $device ];
					}
				}
			}
		}
		
		$field_file = FL_BUILDER_DIR . 'includes/field-' . $field['type'] . '.php';
		
		if(file_exists($field_file)) {
		    do_action('fl_builder_before_control_' . $field['type'], $name, $value, $field, $settings);
		    include $field_file;
		    do_action('fl_builder_after_control_' . $field['type'], $name, $value, $field, $settings);
		}
		else {
		    do_action('fl_builder_before_control_' . $field['type'], $name, $value, $field, $settings);
		    do_action('fl_builder_control_' . $field['type'], $name, $value, $field, $settings);
		    do_action('fl_builder_after_control_' . $field['type'], $name, $value, $field, $settings);
		}
		
		if ( $responsive ) {
			echo '</div>';
		}
	}
		
	?>
	<?php if(isset($field['description'])) : ?>
	<span class="fl-field-description"><?php echo $field['description']; ?></span>
	<?php endif; ?>
</td>