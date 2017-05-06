<?php if ( get_theme_mod( 'left-sidebar-check', 0 ) != 0 ) : ?>
	<aside id="sidebar-secondary" class="col-md-<?php echo absint( get_theme_mod( 'left-sidebar-size', 3 ) ); ?>" role="complementary">
		<?php dynamic_sidebar( 'eleganto-left-sidebar' ); ?>
	</aside>
<?php endif; ?>