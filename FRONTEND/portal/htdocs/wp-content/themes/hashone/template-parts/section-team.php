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

if( get_theme_mod('hashone_disable_team_sec') != 'on' ){ ?>
<section id="hs-team-section" class="hs-section">
	<div class="hs-container">
		<?php
		$hashone_team_title = get_theme_mod('hashone_team_title', __('Meet Our Team', 'hashone'));
		$hashone_team_sub_title = get_theme_mod('hashone_team_sub_title', __( 'Experts who works for us','hashone' ));
		?>

		<?php if($hashone_team_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_team_title); ?></h2>
		<?php } ?>

		<?php if($hashone_team_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_team_sub_title); ?></div>
		<?php } ?>

		<div class="hs-team-member-wrap hs-clearfix">
			<?php 
			for( $i = 1; $i < 5; $i++ ){
				$hashone_team_page_id = get_theme_mod('hashone_team_page'.$i, $hashone_page); 
			
				if($hashone_team_page_id){
					$args = array( 'page_id' => $hashone_team_page_id );
					$query = new WP_Query($args);
					if($query->have_posts()):
						while($query->have_posts()) : $query->the_post();
						$hashone_image = wp_get_attachment_image_src(get_post_thumbnail_id(),'hashone-team-thumb');	
						$hashone_team_designation = get_theme_mod('hashone_team_designation'.$i, __('CEO', 'hashone'));
						$hashone_team_facebook = get_theme_mod('hashone_team_facebook'.$i, '#');
						$hashone_team_twitter = get_theme_mod('hashone_team_twitter'.$i, '#');
						$hashone_team_google_plus = get_theme_mod('hashone_team_google_plus'.$i, '#');
						$hashone_team_linkedin = get_theme_mod('hashone_team_linkedin'.$i, '#');
						$hashone_wow_delay = ($i/2)-1+0.5;
					?>
						<div class="hs-team-member wow pulse" data-wow-duration="0.5s" data-wow-delay="<?php echo $hashone_wow_delay; ?>s">
							<?php if( has_post_thumbnail() ){ ?>
							<div class="hs-team-member-image">
								<img src="<?php echo esc_url($hashone_image[0]);?>" alt="<?php esc_attr(get_the_title()); ?>" />
								
								<a href="<?php the_permalink(); ?>" class="hs-team-member-excerpt">
									<div class="hs-team-member-excerpt-wrap">
									<span>
									<?php 
										if(has_excerpt()){
											echo get_the_excerpt();
										}else{
											echo hashone_excerpt( get_the_content() , 100 );
										}
									?>
									</span>
									</div>
								</a>

								<?php if( $hashone_team_facebook || $hashone_team_twitter || $hashone_team_google_plus ){ ?>
									<div class="hs-team-social-id">
										<?php if($hashone_team_facebook){ ?>
										<a target="_blank" href="<?php echo esc_url($hashone_team_facebook) ?>"><i class="fa fa-facebook"></i></a>
										<?php } ?>

										<?php if($hashone_team_twitter){ ?>
										<a target="_blank" href="<?php echo esc_url($hashone_team_twitter) ?>"><i class="fa fa-twitter"></i></a>
										<?php } ?>

										<?php if($hashone_team_google_plus){ ?>
										<a target="_blank" href="<?php echo esc_url($hashone_team_google_plus) ?>"><i class="fa fa-google-plus"></i></a>
										<?php } ?>

										<?php if($hashone_team_linkedin){ ?>
										<a target="_blank" href="<?php echo esc_url($hashone_team_linkedin) ?>"><i class="fa fa-linkedin"></i></a>
										<?php } ?>
									</div>
								<?php } ?>
							</div>
							<?php } ?>

							<h6><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h6>
							
							<?php if($hashone_team_designation){ ?>
								<div class="hs-team-designation"><?php echo esc_html($hashone_team_designation); ?></div>
							<?php } ?>

							
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