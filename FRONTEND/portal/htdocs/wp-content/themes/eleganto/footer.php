<footer id="colophon" class="rsrc-footer" role="contentinfo">
	<div class="container">  
		<div class="row rsrc-author-credits">
			<?php if ( get_theme_mod( 'eleganto_socials', 0 ) == 1 ) : ?>
				<div class="footer-socials text-center">
					<?php
					if ( get_theme_mod( 'eleganto_socials', 0 ) == 1 ) {
						eleganto_social_links();
					}
					?>                 
				</div>
			<?php endif; ?>
			<p class="text-center">
				<?php printf( __( 'Proudly powered by %s', 'eleganto' ), '<a href="' . esc_url( __( 'https://wordpress.org/', 'eleganto' ) ) . '">WordPress</a>' ); ?>
				<span class="sep"> | </span>
				<?php printf( __( 'Theme: %1$s by %2$s', 'eleganto' ), '<a href="http://themes4wp.com/theme/eleganto" title="' . esc_attr__( 'Free Business WordPress Theme', 'eleganto') . '">Eleganto</a>', 'Themes4WP' ); ?>
			</p> 
		</div>
	</div>       
</footer> 
<p id="back-top">
	<a href="#top"><span></span></a>
</p>
<!-- end main container -->
</div>
<?php wp_footer(); ?>
</body>
</html>