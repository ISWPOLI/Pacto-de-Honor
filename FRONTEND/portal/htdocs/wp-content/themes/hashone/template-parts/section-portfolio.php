<?php
/**
 *
 * @package HashOne
 */

if( get_theme_mod('hashone_disable_portfolio_sec') != 'on' ){ ?>
<section id="hs-portfolio-section" class="hs-section">
	<?php
	$hashone_portfolio_title = get_theme_mod('hashone_portfolio_title', __('What we do it love', 'hashone'));
	$hashone_portfolio_sub_title = get_theme_mod('hashone_portfolio_sub_title', __('Check our beautiful works we do', 'hashone'));
	?>

	<?php if($hashone_portfolio_title){ ?>
	<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_portfolio_title); ?></h2>
	<?php } ?>

	<?php if($hashone_portfolio_sub_title){ ?>
	<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_portfolio_sub_title); ?></div>
	<?php } ?>

	<?php 
	$hashone_portfolio_cat = get_theme_mod('hashone_portfolio_cat');
	if($hashone_portfolio_cat){ 
		$hashone_portfolio_cat_array = explode(',', $hashone_portfolio_cat);
	?>	
	<div class="hs-portfolio-cat-name-list hs-container wow zoomIn" data-wow-duration="0.5s" data-wow-delay="1s">
		<?php  
			foreach ($hashone_portfolio_cat_array as $hashone_portfolio_cat_single) {
				$category_slug = "";
				$category_slug = get_category($hashone_portfolio_cat_single);
				$category_slug = 'hashone-portfolio-'.$category_slug->term_id;
				?>
				<div class="hs-portfolio-cat-name" data-filter=".<?php echo esc_attr($category_slug); ?>">
					<?php echo esc_html(get_cat_name($hashone_portfolio_cat_single)); ?>
				</div>
				<?php
			}
		?>
	</div>
	<?php } ?>

	<div class="hs-portfolio-post-wrap wow zoomIn" data-wow-duration="0.5s" data-wow-delay="1.5s">
		<div class="hs-portfolio-posts hs-clearfix">
			<?php 
			if($hashone_portfolio_cat){ 
				$args = array( 'cat' => $hashone_portfolio_cat, 'posts_per_page' => -1 );
				$query = new WP_Query($args);
				if($query->have_posts()):
					while($query->have_posts()) : $query->the_post();
					$hashone_image = wp_get_attachment_image_src(get_post_thumbnail_id(),'hashone-portfolio-thumb');	
					$hashone_image_large = wp_get_attachment_image_src(get_post_thumbnail_id(),'large');	
					$categories = get_the_category();
			 		$category_slug = "";
			 		$cat_slug = array();

			 		foreach ($categories as $category) {
			 			$cat_slug[] = 'hashone-portfolio-'.$category->term_id;
			 		}

			 		$category_slug = implode(" ", $cat_slug);
				?>
					<div class="hs-portfolio <?php echo esc_attr($category_slug); ?>">
						<div class="hs-portfolio-inner">
						<?php
							if(has_post_thumbnail()){
								?>
								<img src="<?php echo esc_url($hashone_image[0]) ?>" alt="<?php echo esc_attr(get_the_title()); ?>">
								<?php
							}
						?>
						<div class="hs-portfolio-caption">
							<h4><?php the_title(); ?></h4>
							<a class="hs-portfolio-link" href="<?php the_permalink(); ?>"><i class="fa fa-link"></i></a>
							<a class="hs-portfolio-image" data-lightbox-gallery="gallery1" href="<?php echo esc_url($hashone_image_large[0]) ?>"><i class="fa fa-search"></i></a>
						</div>
						</div>
					</div>
				<?php
				endwhile;
				endif;	
				wp_reset_postdata();
			}
			?>
		</div>
		<?php
		?>
	</div>
</section>
<?php } ?>