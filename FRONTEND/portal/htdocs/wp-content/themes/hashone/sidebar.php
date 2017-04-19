<?php
/**
 * The sidebar containing the main widget area.
 *
 * @package HashOne
 */
$hs_sidebar_layout = 'right_sidebar';

if(is_singular( array( 'post', 'page' ) )){
	$hs_sidebar_layout = get_post_meta( $post->ID, 'hs_sidebar_layout', true );

	if(empty($hs_sidebar_layout)){
		$hs_sidebar_layout = 'right_sidebar';
	}
}

if ( $hs_sidebar_layout == "no_sidebar" || $hs_sidebar_layout == "no_sidebar_condensed" ) {
	return;
}

if( is_active_sidebar( 'hashone-right-sidebar' ) &&  $hs_sidebar_layout == "right_sidebar" ){
	?>
	<div id="secondary" class="widget-area">
		<?php dynamic_sidebar( 'hashone-right-sidebar' ); ?>
	</div><!-- #secondary -->
	<?php
}

if( is_active_sidebar( 'hashone-left-sidebar' ) &&  $hs_sidebar_layout == "left_sidebar" ){
	?>
	<div id="secondary" class="widget-area">
		<?php dynamic_sidebar( 'hashone-left-sidebar' ); ?>
	</div><!-- #secondary -->
	<?php
}
