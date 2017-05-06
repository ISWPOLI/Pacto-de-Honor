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

if( get_theme_mod('hashone_disable_about_sec') != 'on' ){ ?>
<section id="hs-about-us-section" class="hs-section">
	<div class="hs-container">
		<div class="hs-about-sec wow zoomIn" data-wow-duration="1s" data-wow-delay="0.5s">
		<?php 
			$args = array(
				'page_id' => absint( get_theme_mod('hashone_about_page' , $hashone_page ) )
				);
			$query = new WP_Query($args);
			if($query->have_posts()):
				while($query->have_posts()) : $query->the_post();
			?>
			<h2 class="hs-section-title"><?php the_title(); ?></h2>
			<div class="hs-content"><?php the_content(); ?></div>
			<?php
			endwhile;
			endif;	
			wp_reset_postdata();
			?>
		</div>

		<div class="hs-progress-bar-sec">
		<?php 
			$hashone_about_widget = get_theme_mod('hashone_about_widget');
			if($hashone_about_widget){
				dynamic_sidebar($hashone_about_widget);
			}else{
				for ($i=1; $i < 6; $i++) { 
					$hashone_about_progressbar_title = get_theme_mod('hashone_about_progressbar_title'.$i , __( 'Progress Bar Title', 'hashone' ).$i);
					$hashone_about_progressbar_percentage = get_theme_mod('hashone_about_progressbar_percentage'.$i, rand( 80, 100 ));
					$hashone_about_progressbar_disable = get_theme_mod('hashone_about_progressbar_disable'.$i);
					if(!$hashone_about_progressbar_disable){
				?>
					<div class="hs-progress hs-progress-count<?php echo esc_attr($i); ?>">
						<h6><?php echo esc_html($hashone_about_progressbar_title); ?></h6>
						<div class="hs-progress-bar">
							<div class="hs-progress-bar-length" data-width="<?php echo absint($hashone_about_progressbar_percentage); ?>">
								<?php echo absint($hashone_about_progressbar_percentage)."%"; ?>
							</div>
						</div>
					</div>
				<?php
					}
				}
			}
		?>
		</div>
	</div>
</section>
<?php } ?>