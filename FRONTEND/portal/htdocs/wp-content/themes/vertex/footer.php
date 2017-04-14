		<footer id="foot">
			<div class="main-foot">
				<div class="container">
					<div class="foot-col">
						<?php dynamic_sidebar('footer-1'); ?>
					</div>
					<div class="foot-col">
						<?php dynamic_sidebar('footer-2'); ?>
					</div>
					<div class="foot-col">
						<?php dynamic_sidebar('footer-3'); ?>
					</div>
					<div class="foot-col">
						<?php dynamic_sidebar('footer-4'); ?>
					</div>
				</div>
			</div>
			<div class="bottom-foot">
				<div class="container">
					<p class="credits"><?php echo ( vertex_setting('vertex_copyright') !='' ? sanitize_text_field( vertex_setting('vertex_copyright') ) : vertex_footer_copyright() ); ?></p>
				</div>
			</div>
		</footer>
		<?php wp_footer(); ?>
	</body>
</html>