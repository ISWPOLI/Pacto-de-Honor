<?php
/**
 *
 * @package HashOne
 */

$hashone_page = '';
$hashone_page_array = get_pages();
if(is_array($hashone_page_array)){
	$hashone_page = $hashone_page_array[0]->ID;
}

if( get_theme_mod('hashone_disable_testimonial_sec') != 'on' ){ ?>
<section id="hs-testimonial-section" class="hs-section">
	<div class="hs-container">
		<?php
		$hashone_testimonial_title = get_theme_mod('hashone_testimonial_title', __( 'Testimonials', 'hashone' ));
		$hashone_testimonial_sub_title = get_theme_mod('hashone_testimonial_sub_title', __( 'What our client says', 'hashone' ));
		?>

		<?php if($hashone_testimonial_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_testimonial_title); ?></h2>
		<?php } ?>

		<?php if($hashone_testimonial_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_testimonial_sub_title); ?></div>
		<?php } ?>

		<div class="hs-testimonial-wrap wow fadeIn" data-wow-duration="1s" data-wow-delay="1s">
			<div class="hs-testimonial-slider">
			<?php 
			$hashone_testimonial_page = get_theme_mod('hashone_testimonial_page', array($hashone_page));
				if(is_array($hashone_testimonial_page)){
					$args = array(
							'post_type' => 'page',
							'post__in' => $hashone_testimonial_page,
							'posts_per_page' => 12
					 			);
					$query = new WP_Query($args);
					if($query->have_posts()):
						while($query->have_posts()) : $query->the_post();
						$hashone_image = wp_get_attachment_image_src(get_post_thumbnail_id(),'hashone-thumb');
					?>
						<div class="hs-testimonial">
							<?php
								if(has_post_thumbnail()){
									?>
									<img class="animated wobble" src="<?php echo esc_url($hashone_image[0]) ?>" alt="<?php esc_attr(get_the_title()); ?>">
									<?php
								}
							?>
							<h3><?php the_title(); ?></h3>
							<div class="hs-testimonial-excerpt">
							<i class="fa fa-quote-left"></i>
							<?php 
							if(has_excerpt()){
								echo get_the_excerpt();
							}else{
								echo hashone_excerpt( get_the_content(), 300 );
							}
							?>
							<i class="fa fa-quote-right"></i>
							</div>
						</div>
					<?php
					endwhile;
					endif;	
					wp_reset_postdata();
				}
			?>
			</div>
		</div>
	</div>	
</section>
<?php } ?>