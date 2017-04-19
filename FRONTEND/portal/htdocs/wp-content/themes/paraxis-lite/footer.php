<?php
/**
 *	The template for displaying the footer.
 *
 *	Contains the closing of the #content div and all content after.
 *
 *	@link https://developer.wordpress.org/themes/basics/template-files/#template-partials
 *
 *	@package WordPress
 *	@subpackage paraxis-lite
 */
?>				
				</div>
			</div><!-- #content -->

			<div class="svg-container footer-svg svg-block">
				<?php oblique_svg_1(); ?>
			</div>
			<footer id="colophon" class="site-footer" role="contentinfo">
				<div class="site-info container">
					<?php _e('Theme: Paraxis Lite. Built by:', 'paraxis-lite') . '<a href="https://www.machothemes.com/" title="'.__('Professional WordPress Themes', 'paraxis-lite').'">'.__('Macho Themes', 'paraxis-lite').'</a>' . __('Running on: WordPress.', 'paraxis-lite'); ?> 
				</div><!-- .site-info -->
			</footer><!-- #colophon -->
		</div><!-- #page -->
		<?php wp_footer(); ?>
	</body>
</html>