<?php
/**
 *
 * @package HashOne
 */

if( get_theme_mod('hashone_disable_counter_sec') != 'on' ){ ?>
<section id="hs-counter-section" data-stellar-background-ratio="0.4">
<div class="hs-counter-section hs-section">
<div class="hs-counter-overlay"></div>
	<div class="hs-container">
		<?php
		$hashone_counter_title = get_theme_mod('hashone_counter_title', __( 'OUR FACTS', 'hashone' ));
		$hashone_counter_sub_title = get_theme_mod('hashone_counter_sub_title', __( 'Some Numbers that Speaks', 'hashone' ));
		?>

		<?php if($hashone_counter_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_counter_title); ?></h2>
		<?php } ?>

		<?php if($hashone_counter_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_counter_sub_title); ?></div>
		<?php } ?>

		<div class="hs-counter-wrap hs-clearfix">
			<?php 
			for( $i = 1; $i < 5; $i++ ){
				$hashone_counter_title = get_theme_mod('hashone_counter_title'.$i, __( 'Cups of Coffee', 'hashone' )); 
				$hashone_counter_count = get_theme_mod('hashone_counter_count'.$i, rand(600,2000));
				$hashone_counter_icon = get_theme_mod('hashone_counter_icon'.$i, 'fa-coffee');
				$hashone_wow_delay = ($i/2)-1+0.5;
				if($hashone_counter_count){
					?>
					<div class="hs-counter hs-counter<?php echo $i; ?> wow fadeInDown" data-wow-duration="0.5s" data-wow-delay="<?php echo $hashone_wow_delay; ?>s">
						<div class="hs-counter-count odometer odometer<?php echo $i; ?>" data-count="<?php echo absint($hashone_counter_count); ?>">
							99
						</div>

						<div class="hs-counter-icon">
							<i class="fa <?php echo esc_attr($hashone_counter_icon); ?>"></i>
						</div>

						<div class="hs-counter-title">
							<?php echo esc_html($hashone_counter_title); ?>
						</div>
					</div>
					<?php
				}
			}
			?>
		</div>
	</div>
</div>
</section>
<?php } ?>