<?php
/**
 *
 * @package HashOne
 */

if( get_theme_mod('hashone_disable_contact_sec') != 'on' ){ ?>
<section id="hs-contact-section" data-stellar-background-ratio="0.2">
<div class="hs-contact-section hs-section">
	<div class="hs-contact-overlay"></div>
	<div class="hs-container">
		<?php
		$hashone_contact_title = get_theme_mod('hashone_contact_title', __( 'Contact Us', 'hashone' ));
		$hashone_contact_sub_title = get_theme_mod('hashone_contact_sub_title', __( 'We would love to hear from you', 'hashone' ));
		?>

		<?php if($hashone_contact_title){ ?>
		<h2 class="hs-section-title wow fadeInUp" data-wow-duration="0.5s"><?php echo esc_html($hashone_contact_title); ?></h2>
		<?php } ?>

		<?php if($hashone_contact_sub_title){ ?>
		<div class="hs-section-tagline wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.5s"><?php echo esc_html($hashone_contact_sub_title); ?></div>
		<?php } ?>

		<div class="hs-clearfix">
			<div class="hs-contact-form wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="1s">
				<?php 
				$hashone_contact_form = get_theme_mod( 'hashone_contact_form' );

				if($hashone_contact_form){
					echo do_shortcode(wp_kses_post($hashone_contact_form));
				}else{
					if(is_active_sidebar('hashone-contact-form')){
						dynamic_sidebar('hashone-contact-form');
					}
				}
				?>
			</div>
			
			<div class="hs-contact-address wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="1.5s">
				<?php
				$hashone_contact_detail = get_theme_mod( 'hashone_contact_detail', __( 'Contact us on the detail given below', 'hashone' ) );
				$hashone_contact_address = get_theme_mod( 'hashone_contact_address', __( 'Address: 2400 South Avenue', 'hashone' ) );
				$hashone_contact_phone = get_theme_mod( 'hashone_contact_phone', __( 'Phone: +928 336 2000', 'hashone' ) );
				$hashone_contact_email = get_theme_mod( 'hashone_contact_email', __( 'Email: support@hashthemes.com', 'hashone' ) );
				$hashone_contact_website = get_theme_mod( 'hashone_contact_website', __( 'Website: http://hashthemes.com', 'hashone' ) );
				?>
				<ul>
					<?php if(!empty($hashone_contact_detail)){ ?>
					<li><?php echo wp_kses_post(wpautop($hashone_contact_detail)); ?></li>
					<?php } ?>

					<?php if(!empty($hashone_contact_address)){ ?>
					<li><i class="fa fa-map-marker"></i><?php echo esc_html($hashone_contact_address); ?></li>
					<?php } ?>

					<?php if(!empty($hashone_contact_phone)){ ?>
					<li><i class="fa fa-phone"></i><?php echo esc_html($hashone_contact_phone); ?></li>
					<?php } ?>

					<?php if(!empty($hashone_contact_email)){ ?>
					<li><i class="fa fa-envelope"></i><?php echo esc_html($hashone_contact_email); ?></li>
					<?php } ?>

					<?php if(!empty($hashone_contact_website)){ ?>
					<li><i class="fa fa-globe"></i><?php echo esc_html($hashone_contact_website); ?></li>
					<?php } ?>
				</ul>

				<div class="hs-social">
				<?php 
					$facebook = get_theme_mod('hashone_social_facebook');
					$twitter = get_theme_mod('hashone_social_twitter');
					$google_plus = get_theme_mod('hashone_social_google_plus');
					$pinterest = get_theme_mod('hashone_social_pinterest');
					$youtube = get_theme_mod('hashone_social_youtube');
					$linkedin = get_theme_mod('hashone_social_linkedin');

					if($facebook)
						echo '<a class="sq-facebook" href="'.esc_url( $facebook ).'" target="_blank"><i class="fa fa-facebook"></i></a>';

					if($twitter)
						echo '<a class="sq-twitter" href="'.esc_url( $twitter ).'" target="_blank"><i class="fa fa-twitter"></i></a>';

					if($google_plus)
						echo '<a class="sq-googleplus" href="'.esc_url( $google_plus ).'" target="_blank"><i class="fa fa-google-plus"></i></a>';

					if($pinterest)
						echo '<a class="sq-pinterest" href="'.esc_url( $pinterest ).'" target="_blank"><i class="fa fa-pinterest"></i></a>';

					if($youtube)
						echo '<a class="sq-youtube" href="'.esc_url( $youtube ).'" target="_blank"><i class="fa fa-youtube"></i></a>';

					if($linkedin)
						echo '<a class="sq-linkedin" href="'.esc_url( $linkedin ).'" target="_blank"><i class="fa fa-linkedin"></i></a>';
				?>
				</div>
			</div>	
		</div>
	</div>
</div>
</section>
<?php }