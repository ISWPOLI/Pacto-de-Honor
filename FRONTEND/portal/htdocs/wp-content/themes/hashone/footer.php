<?php
/**
 * The template for displaying the footer.
 *
 * @package HashOne
 */

?>

	</div><!-- #content -->

	<footer id="hs-colophon" class="hs-site-footer">
		<?php if(is_active_sidebar('hashone-footer1') || is_active_sidebar('hashone-footer2') || is_active_sidebar('hashone-footer3') || is_active_sidebar('hashone-footer4')){ ?>
		<div id="hs-top-footer">
			<div class="hs-container">
				<div class="hs-top-footer hs-clearfix">
					<div class="hs-footer hs-footer1">
						<?php if(is_active_sidebar('hashone-footer1')): 
							dynamic_sidebar('hashone-footer1');
						endif;
						?>	
					</div>

					<div class="hs-footer hs-footer2">
						<?php if(is_active_sidebar('hashone-footer2')): 
							dynamic_sidebar('hashone-footer2');
						endif;
						?>	
					</div>

					<div class="hs-footer hs-footer3">
						<?php if(is_active_sidebar('hashone-footer3')): 
							dynamic_sidebar('hashone-footer3');
						endif;
						?>	
					</div>

					<div class="hs-footer hs-footer4">
						<?php if(is_active_sidebar('hashone-footer4')): 
							dynamic_sidebar('hashone-footer4');
						endif;
						?>	
					</div>
				</div>
			</div>
		</div>
		<?php } ?>

		<div id="hs-bottom-footer">
			<div class="hs-container">
				<div class="hs-copy-right">	
					<?php 
					$hashone_copyright = get_theme_mod( 'hashone_copyright' );
					if($hashone_copyright){
						echo wp_kses_post($hashone_copyright);
					}else{
						 printf( esc_html__('&copy; Copyright %d %s', 'hashone') , date_i18n('Y'), get_bloginfo('name') );
					} ?>
				</div>
					
				<div class="hs-site-info">
					<?php printf( esc_html__( 'WordPress Theme', 'hashone' ) ); ?>
					<span class="sep"> | </span>
					<?php printf( esc_html__( '%1$s by %2$s', 'hashone' ), '<a href="https://hashthemes.com/wordpress-theme/hashone/" target="_blank">Hashone</a>', 'Hash Themes' ); ?>
				</div><!-- #site-info -->
			</div>
		</div>
	</footer><!-- #colophon -->
</div><!-- #page -->

<div id="hs-back-top" class="animated hs-hide"><i class="fa fa-angle-up"></i></div>
<?php wp_footer(); ?>

</body>
</html>
