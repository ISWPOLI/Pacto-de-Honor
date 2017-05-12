<hr />
<h3><?php _e( 'Available Downloads', 'fl-builder' ); ?></h3>
<p><?php _e( 'The following downloads are currently available for remote update with the subscription(s) associated with this license.', 'fl-builder' ); ?></p>
<ul>
	<?php 
		
	foreach ( $subscription->downloads as $download ) {
		
		if ( stristr( $download, 'child theme' ) ) {
			continue;
		}
		
		echo '<li>' . $download . '</li>';
	}
	
	?>
</ul>