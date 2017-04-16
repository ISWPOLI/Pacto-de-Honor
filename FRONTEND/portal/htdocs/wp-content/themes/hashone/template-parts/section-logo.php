<?php
/**
 *
 * @package HashOne
 */

if( get_theme_mod('hashone_disable_logo_sec') != 'on' ){ ?>
<section id="hs-logo-section" class="hs-section">
	<div class="hs-container">
		<?php
		$hashone_logo_title = get_theme_mod('hashone_logo_title', __( 'We are Associated with', 'hashone' ));
		$hashone_logo_sub_title = get_theme_mod('hashone_logo_sub_title', __( 'Meet our Awesome Clients', 'hashone' ));
		?>

		<?php if($hashone_logo_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_logo_title); ?></h2>
		<?php } ?>

		<?php if($hashone_logo_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_logo_sub_title); ?></div>
		<?php } ?>

		<?php 
		$hashone_client_logo_image = get_theme_mod('hashone_client_logo_image');
		$hashone_client_logo_image = explode(',', $hashone_client_logo_image);
		?>

		<div class="wow zoomIn" data-wow-duration="0.5s" data-wow-delay="0.5s">
		<div class="hs_client_logo_slider">
		<?php
		foreach ($hashone_client_logo_image as $hashone_client_logo_image_single) {
			?>
			<img alt="<?php _e('logo','hashone') ?>" src="<?php echo esc_url(wp_get_attachment_url($hashone_client_logo_image_single)); ?>">
			<?php
		}
		?>
		</div>
		</div>
	</div>
</section>
<?php } ?>