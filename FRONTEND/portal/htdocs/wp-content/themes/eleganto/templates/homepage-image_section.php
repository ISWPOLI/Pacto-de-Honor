<?php if ( get_theme_mod( 'image_intro_enable', '0' ) != '0' ) : ?>
	<div class="intro parascroll">
      <?php $bg = get_theme_mod( 'image_intro_img_image', '' ); ?>
	    <div class="prlx <?php if ( $bg ) { echo 'img-holder'; } ?>" data-image="<?php echo esc_url( $bg ); ?>"></div>
		<?php if ( get_theme_mod( 'image_intro_title', '' ) != '' ) : ?>
			<h2 class="text-center"><?php echo esc_html( get_theme_mod( 'image_intro_title', '' ) ); ?></h2>
		<?php endif; ?>
		<?php if ( get_theme_mod( 'image_intro_desc', '' ) != '' ) : ?>
			<h3 class="text-center"><?php echo esc_html( get_theme_mod( 'image_intro_desc', '' ) ); ?></h3> 
		<?php endif; ?>
	</div>     
<?php endif; ?>
<div class="border-top"></div>
<div class="section">  
	<div class="container">
		<div class="container-heading text-center">
			<?php if ( get_theme_mod( 'image_section_title', '' ) != '' ) : ?>
				<h4><?php echo esc_html( get_theme_mod( 'image_section_title', '' ) ); ?></h3>
			<?php endif; ?>
			<?php if ( get_theme_mod( 'image_section_desc', '' ) != '' ) : ?>
				<div class="sub-title"><span><?php echo esc_html( get_theme_mod( 'image_section_desc', '' ) ); ?></span></div>
			<?php endif; ?>
		</div>
		<?php if ( get_theme_mod( 'image_section_image', '' ) != '' ) : ?>
			<div class="row">
				<?php if ( get_theme_mod( 'image_section_text_left', '' ) != '' ) : ?>
					<div class="image-section-left col-md-3">
						<?php echo wp_kses_post( get_theme_mod( 'image_section_text_left', '' ) ); ?>
					</div>
				<?php endif; ?>
				<?php if ( get_theme_mod( 'image_section_image', '' ) != '' ) : ?>
					<div class="image-section-center col-md-6">
						<img src="<?php echo esc_url( get_theme_mod( 'image_section_image', '' ) ); ?>" alt="">
					</div>
				<?php endif; ?>
				<?php if ( get_theme_mod( 'image_section_text_right', '' ) != '' ) : ?>
					<div class="image-section-right col-md-3">
						<?php echo wp_kses_post( get_theme_mod( 'image_section_text_right', '' ) ); ?>
					</div>
				<?php endif; ?>
			</div>
		<?php endif; ?>
	</div>
</div>  
<div class="border-bottom"></div>
