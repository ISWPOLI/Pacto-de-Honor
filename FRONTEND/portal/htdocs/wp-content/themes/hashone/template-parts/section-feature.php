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

if( get_theme_mod('hashone_disable_featured_sec') != 'on' ){ ?>
<section id="hs-featured-post-section" class="hs-section">
	<div class="hs-container">
		<?php
		$hashone_featured_title = get_theme_mod('hashone_featured_title', __( 'Our Features', 'hashone'));
		$hashone_featured_desc = get_theme_mod('hashone_featured_desc', __( 'Check out cool featured of the theme', 'hashone'));
		?>
		<?php if($hashone_featured_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_featured_title); ?></h2>
		<?php } ?>

		<?php if($hashone_featured_desc){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_featured_desc); ?></div>
		<?php } ?>

		<div class="hs-featured-post-wrap hs-clearfix">
			<?php 
			for( $i = 1; $i < 5; $i++ ){
				$hashone_featured_page_id = get_theme_mod('hashone_featured_page'.$i, $hashone_page); 
				$hashone_featured_page_icon = get_theme_mod('hashone_featured_page_icon'.$i, 'fa-bell');
			
			if($hashone_featured_page_id){
				$args = array( 'page_id' => $hashone_featured_page_id );
				$query = new WP_Query($args);
				if($query->have_posts()):
					while($query->have_posts()) : $query->the_post();
					$hashone_wow_delay = ($i/2)-1+0.5;
				?>
					<div class="hs-featured-post hs-featured-post<?php echo $i; ?> wow fadeInLeft" data-wow-duration="0.5s" data-wow-delay="<?php echo $hashone_wow_delay; ?>s">
						<div class="hs-featured-icon"><i class="fa <?php echo esc_attr($hashone_featured_page_icon); ?>"></i></div>
						<h3>
						<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
						</h3>
						<div class="hs-featured-excerpt">
						<?php 
						if(has_excerpt()){
							echo get_the_excerpt();
						}else{
							echo hashone_excerpt( get_the_content(), 100); 
						}?>
						</div>
					</div>
				<?php
				endwhile;
				endif;	
				wp_reset_postdata();
				}
			}
			?>
		</div>
	</div>
</section>
<?php } ?>
