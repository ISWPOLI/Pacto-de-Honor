<?php
$repeater_value = get_theme_mod( 'repeater_slider', array() );
if ( ! empty( $repeater_value ) ) :
?>
  <section id="slider" class="content">
      <div class="flexslider-container">
  		<div class="homepage-slider flexslider">
  			<ul class="slides">
  				<?php foreach ( $repeater_value as $row ) : ?>
  					<?php if ( isset( $row[ 'slider_image' ] ) && !empty( $row[ 'slider_image' ] ) ) : ?>
  						<?php $image_id = wp_get_attachment_url( $row[ 'slider_image' ] ); ?>                                                  
  						<li style="background-image: url(<?php if ( $image_id ) {
  								echo esc_url( $image_id );
  							} else {
  								echo esc_url( $row[ 'slider_image' ] );
  							} ?>);" >
  							<div class="flexslider-inner">
  								<?php if ( isset( $row[ 'slider_title' ] ) && !empty( $row[ 'slider_title' ] ) ) : ?>
  									<h2 class="flexslider-title">
  										<?php echo esc_html( $row[ 'slider_title' ] ); ?>
  									</h2>
  								<?php endif; ?>
  								<?php if ( isset( $row[ 'slider_desc' ] ) && !empty( $row[ 'slider_desc' ] ) ) : ?>
  									<p class="flexslider-desc hidden-xs">
  										<?php echo esc_html( $row[ 'slider_desc' ] ); ?>
  									</p>
  								<?php endif; ?>
  								<?php if ( isset( $row[ 'slider_url' ] ) && !empty( $row[ 'slider_url' ] ) ) : ?>
  									<a class="btn btn-default btn-sm" href="<?php echo esc_url( $row[ 'slider_url' ] ); ?>">
  										<?php esc_html_e( 'Read More', 'eleganto' ); ?>  
  									</a>
  								<?php endif; ?>
  							</div>
  						</li>
  					<?php endif; ?> 
  				<?php endforeach; ?>
  			</ul>
  		</div>
  	</div>
  </section>
<?php endif; ?>
