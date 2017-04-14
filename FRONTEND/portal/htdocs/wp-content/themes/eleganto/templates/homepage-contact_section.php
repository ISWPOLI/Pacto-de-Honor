<?php if ( get_theme_mod( 'contact_intro_enable', '0' ) != '0' ) : ?>
	<div class="intro">  
	    <?php $bg = get_theme_mod( 'contact_intro_img_image', '' ) ?>
	    <div class="prlx <?php if ( $bg ) { echo 'img-holder'; } ?>" data-image="<?php echo esc_url( $bg ); ?>"></div>
		<?php if ( get_theme_mod( 'contact_intro_title', '' ) != '' ) : ?>
			<h2 class="text-center"><?php echo esc_html( get_theme_mod( 'contact_intro_title', '' ) ); ?></h2>
		<?php endif; ?>
		<?php if ( get_theme_mod( 'contact_intro_desc', '' ) != '' ) : ?>
			<h3 class="text-center"><?php echo esc_html( get_theme_mod( 'contact_intro_desc', '' ) ); ?></h3> 
		<?php endif; ?>
	</div>     
<?php endif; ?>
<div class="border-top"></div>
<div class="section">  
	<div class="container">
		<div class="container-heading text-center">
			<?php if ( get_theme_mod( 'contact_section_title', '' ) != '' ) : ?>
				<h4><?php echo esc_html( get_theme_mod( 'contact_section_title', '' ) ); ?></h4>
			<?php endif; ?>
			<?php if ( get_theme_mod( 'contact_section_desc', '' ) != '' ) : ?>
				<div class="sub-title"><span><?php echo esc_html( get_theme_mod( 'contact_section_desc', '' ) ); ?></span></div>
			<?php endif; ?>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8">
				<?php if ( get_theme_mod( 'conatact_form', '' ) != '' ) : ?>
					<?php echo do_shortcode( '[contact-form-7 id="' . get_theme_mod( 'conatact_form' ) . '"]' ); ?>
				<?php endif; ?>
			</div>
			<div class="col-sm-4">
				<?php if ( get_theme_mod( 'conatact_company_text', '' ) != '' ) : ?>
					<p class="about-us">
						<i class="fa fa-pencil-square"></i><strong><?php esc_html_e( ' About Us', 'eleganto' ); ?></strong><br>
						<?php echo wp_kses_post( get_theme_mod( 'conatact_company_text', '' ) ); ?>
					</p> 
				<?php endif; ?>
				<?php if ( get_theme_mod( 'conatact_company_name', '' ) != '' || get_theme_mod( 'conatact_company_address', '' ) != '' ) : ?> 
					<address>
						<i class="fa fa-map-marker"></i><strong><?php esc_html_e( ' Our Address', 'eleganto' ); ?></strong><br>
						<strong><?php echo get_theme_mod( 'conatact_company_name', '' ); ?></strong><br>
						<span id="map-input">
							<?php echo wp_kses_post( get_theme_mod( 'conatact_company_address', '' ) ); ?>
						</span>
					</address>
				<?php endif; ?>
				<?php if ( get_theme_mod( 'conatact_company_telephone', '' ) != '' ) : ?>
					<address>
						<i class="fa fa-phone-square"></i><strong><?php _e( ' Phone', 'eleganto' ); ?></strong><br>
						<?php echo esc_html( get_theme_mod( 'conatact_company_telephone', '' ) ); ?>
					</address> 
				<?php endif; ?>
				<?php if ( get_theme_mod( 'conatact_company_email', '' ) != '' ) : ?>
					<address>
						<i class="fa fa-envelope"></i><strong><?php esc_html_e( ' Email Us', 'eleganto' ); ?></strong><br>
						<?php $mail = sanitize_email( get_theme_mod( 'conatact_company_email', '' ) ); ?>
						<a href="mailto:#"><?php echo antispambot( $mail ); ?></a>
					</address>
				<?php endif; ?> 
			</div>
		</div>
		<!--/row-->
	</div>
</div>  
<div class="border-bottom"></div>
