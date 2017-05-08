<?php if ( get_theme_mod( 'carousel_intro_enable', '0' ) != '0' ) : ?>
	<div class="intro">  
		  <?php $bg = get_theme_mod( 'carousel_intro_img_image', '' ) ?>
	    <div class="prlx <?php if ( $bg ) { echo 'img-holder'; } ?>" data-image="<?php echo esc_url( $bg ); ?>"></div>
		<?php if ( get_theme_mod( 'carousel_intro_title', '' ) != '' ) : ?>
			<h2 class="text-center"><?php echo esc_html( get_theme_mod( 'carousel_intro_title', '' ) ); ?></h2>
		<?php endif; ?>
		<?php if ( get_theme_mod( 'carousel_intro_desc', '' ) != '' ) : ?>
			<h3 class="text-center"><?php echo esc_html( get_theme_mod( 'carousel_intro_desc', '' ) ); ?></h3> 
		<?php endif; ?>
	</div>     
<?php endif; ?>
<div class="border-top"></div>
<div class="section">  
	<div class="container">
		<div class="container-heading text-center">
			<?php if ( get_theme_mod( 'carousel_section_title', '' ) != '' ) : ?>
				<h4><?php echo esc_html( get_theme_mod( 'carousel_section_title', '' ) ); ?></h4>
			<?php endif; ?>
			<?php if ( get_theme_mod( 'carousel_section_desc', '' ) != '' ) : ?>
				<div class="sub-title"><span><?php echo esc_html( get_theme_mod( 'carousel_section_desc', '' ) ); ?></span></div>
			<?php endif; ?>
		</div>
		<?php
		$repeater_value = get_theme_mod( 'repeater_carousel', array() );
		?>
		<?php if ( ! empty( $repeater_value ) ) : ?>
			<div id="carousel-home" class="flexslider carousel-loading">										   
				<ul class="slides">
					<?php foreach ( $repeater_value as $row ) : ?>
						<?php $image_thumb = wp_get_attachment_image( $row[ 'carousel_image' ], 'eleganto-square' ); ?> 
						<li class="carousel-item text-center">
							<?php if ( isset( $row[ 'carousel_image' ] ) && !empty( $row[ 'carousel_image' ] ) ) : ?>
								<?php
								if ( $image_thumb ) {
									echo $image_thumb;
								} else {
									echo '<img src="' . esc_url( $row[ 'carousel_image' ] ) . '" alt="">';
								}
								?>
								<?php endif; ?>
								<?php if ( isset( $row[ 'carousel_title' ] ) && !empty( $row[ 'carousel_title' ] ) ) : ?>
									<h2 class="flexslider-title">
										<?php echo esc_html( $row[ 'carousel_title' ] ); ?>
									</h2>
								<?php endif; ?>
								<?php if ( isset( $row[ 'carousel_desc' ] ) && !empty( $row[ 'carousel_desc' ] ) ) : ?>
									<p class="flexslider-desc">
										<?php echo esc_html( $row[ 'carousel_desc' ] ); ?>
									</p>
								<?php endif; ?>
								<?php if ( isset( $row[ 'carousel_url' ] ) && !empty( $row[ 'carousel_url' ] ) ) : ?>
										<a class="btn btn-default btn-sm" href="<?php echo esc_url( $row[ 'carousel_url' ] ); ?>">
									<?php esc_html_e( 'Read More', 'eleganto' ); ?>  
									</a>
							<?php endif; ?>
						</li>
					<?php endforeach; ?>
				</ul>					 
			</div>
		<?php endif; ?>
	</div>
</div>  
<div class="border-bottom"></div>
