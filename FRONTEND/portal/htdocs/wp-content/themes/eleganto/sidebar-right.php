<?php if ( get_theme_mod( 'rigth-sidebar-check', 1 ) != 0 ) : ?>
	<aside id="sidebar" class="col-md-<?php echo absint( get_theme_mod( 'right-sidebar-size', 3 ) ); ?>" role="complementary">
		<?php dynamic_sidebar( 'eleganto-right-sidebar' );	?>
	</aside>
<?php endif; ?>