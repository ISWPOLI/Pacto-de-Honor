<?php
/**
 *
 * @package HashOne
 */
?>

<section id="hs-home-slider-section">
	<div class="slide-banner-overlay"></div>
	<div id="hs-bx-slider">
	<?php for ($i=1; $i < 4; $i++) {  
		$hashone_slider_page_id = get_theme_mod( 'hashone_slider_page'.$i );

		if($hashone_slider_page_id){
			$args = array( 
                        'page_id' => absint($hashone_slider_page_id) 
                        );
			$query = new WP_Query($args);
			if( $query->have_posts() ):
				while($query->have_posts()) : $query->the_post();
				?>
				<div class="hs-slide">
					<div class="hs-slide-overlay"></div>

					<?php 
					if(has_post_thumbnail()){
						$hashone_slider_image = wp_get_attachment_image_src(get_post_thumbnail_id(),'full');	
						echo '<img alt="'.esc_attr(get_the_title()).'" src="'.esc_url($hashone_slider_image[0]).'">';
					} ?>
				
					<div class="hs-slide-caption">
						<div class="hs-slide-cap-title animated fadeInLeft">
							<span><?php echo esc_html(get_the_title()); ?></span>
						</div>

						<div class="hs-slide-cap-desc animated fadeInRight">
							<?php echo get_the_content(); ?>
						</div>
					</div>
				</div>
				<?php
				endwhile;
			endif;
		}
	} ?>
	</div>
</section>