<?php 
	$prepend    = array('01','02','03','04','05','06','07','08','09'); 
	$hours      = array_merge( $prepend, range( 10, 12 ) ); 
	$minutes    = array_merge( array('00'), $prepend, range( 10, 59 ) ); 
	$day_period = array( 'am', 'pm' ); 

	if ( is_object( $value ) ) {
		$value = (array) $value;
	}
?> 
<select name="<?php echo $name . '[][hours]'; ?>" class="fl-time-field-hours">
<?php foreach( $hours as $hour ) : ?>
	<?php $selected = isset( $value['hours'] ) && $value['hours'] == $hour ? ' selected="selected"' : ''; ?>
	<option value="<?php echo $hour ?>"<?php echo $selected ?>><?php echo $hour ?></option>
<?php endforeach; ?>	
</select>
<select name="<?php echo $name . '[][minutes]'; ?>" class="fl-time-field-minutes">
<?php foreach( $minutes as $minute ) : ?>
	<?php $selected = isset( $value['minutes'] ) && $value['minutes'] == $minute ? ' selected="selected"' : ''; ?>
	<option value="<?php echo $minute ?>"<?php echo $selected ?>><?php echo $minute ?></option>
<?php endforeach; ?>
</select>
<select name="<?php echo $name . '[][day_period]'; ?>" class="fl-time-field-day_period">
<?php foreach( $day_period as $period ) : ?>
	<?php $selected = isset( $value['day_period'] ) && $value['day_period'] == $period ? ' selected="selected"' : ''; ?>
	<option value="<?php echo $period ?>"<?php echo $selected ?>><?php echo $period ?></option>
<?php endforeach; ?>	
</select>