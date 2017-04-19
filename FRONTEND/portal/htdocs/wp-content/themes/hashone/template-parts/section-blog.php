<?php
/**
 *
 * @package HashOne
 */

if( get_theme_mod('hashone_disable_blog_sec') != 'on' ){ ?>
<section id="hs-blog-section" class="hs-section">
	<div class="hs-container">
		<?php
		$hashone_blog_title = get_theme_mod('hashone_blog_title', __('Latest blogs','hashone'));
		$hashone_blog_sub_title = get_theme_mod('hashone_blog_sub_title', __('Check out the latest post from our blog','hashone'));
		?>

		<?php if($hashone_blog_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_blog_title); ?></h2>
		<?php } ?>

		<?php if($hashone_blog_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_blog_sub_title); ?></div>
		<?php } ?>

		<div class="hs-blog-wrap hs-clearfix">
		<?php 
			$hashone_blog_post_count = get_theme_mod('hashone_blog_post_count', 4);
			$hashone_blog_cat_exclude = get_theme_mod('hashone_blog_cat_exclude');

			$hashone_count = 0;
			$hashone_check = array( 3, 4, 7, 8);
			$args = array(
				'posts_per_page' => absint($hashone_blog_post_count),
				'category__not_in' => $hashone_blog_cat_exclude
				);
			$query = new WP_Query($args);
			if($query -> have_posts()):
				while($query -> have_posts()) : $query -> the_post();
				$hashone_image = wp_get_attachment_image_src(get_post_thumbnail_id() , 'hashone-portfolio-thumb');
				$hashone_count++;
				if(in_array($hashone_count, $hashone_check)){
					$hashone_class = "hs-right-img fadeInRight";
				}else{
					$hashone_class = "hs-left-img fadeInLeft";
				}

				$hashone_wow_delay = ($hashone_count*300)+300;
				?>
				<div class="hs-blog-post hs-clearfix wow <?php echo esc_attr($hashone_class); ?>" data-wow-duration="0.5s" data-wow-delay="<?php echo $hashone_wow_delay?>ms">
					<div class="hs-blog-thumbnail" style='background-image:url(<?php echo esc_url($hashone_image[0]) ?>);'>
						<a href="<?php the_permalink(); ?>">
							<img alt="<?php _e('portfolio thumb', 'hashone') ?>" src="<?php echo get_template_directory_uri() ?>/images/portfolio-thumb.png"/>
						</a>
					</div>

					<div class="hs-blog-excerpt">
					<h5><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h5>
					<div class="hs-blog-date"><i class="fa fa-calendar"></i><?php echo get_the_date(); ?></div>
						<?php 
						if(has_excerpt()){
							echo get_the_excerpt();
						}else{
							echo hashone_excerpt( get_the_content() , 160 );
						}
						?>
					</div>
				</div>
				<?php
				endwhile;
			endif;
			wp_reset_postdata();
		?>
		</div>	
	</div>
</section>
<?php } ?>