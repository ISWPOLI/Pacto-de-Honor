<?php if ( get_theme_mod( 'blog_intro_enable', '0' ) != '0' ) : ?>
	<div class="intro">  
	    <?php $bg = get_theme_mod( 'blog_intro_img_image', '' ); ?>
	    <div class="prlx <?php if ( $bg ) { echo 'img-holder'; } ?>" data-image="<?php echo esc_url( $bg ); ?>"></div>
		<?php if ( get_theme_mod( 'blog_intro_title', '' ) != '' ) : ?>
			<h2 class="text-center"><?php echo esc_html( get_theme_mod( 'blog_intro_title', '' ) ); ?></h2>
		<?php endif; ?>
		<?php if ( get_theme_mod( 'blog_intro_desc', '' ) != '' ) : ?>
			<h3 class="text-center"><?php echo esc_html( get_theme_mod( 'blog_intro_desc', '' ) ); ?></h3> 
		<?php endif; ?>
	</div>     
<?php endif; ?>
<div class="border-top"></div>
<div class="section">  
	<div class="container">
		<div class="container-heading text-center">
			<?php if ( get_theme_mod( 'blog_section_title', '' ) != '' ) : ?>
				<h4><?php echo esc_html( get_theme_mod( 'blog_section_title', '' ) ); ?></h4>
				<?php endif; ?>
				<?php if ( get_theme_mod( 'blog_section_desc', '' ) != '' ) : ?>
					<div class="sub-title"><span><?php echo esc_html( get_theme_mod( 'blog_section_desc', '' ) ); ?></span></div>
				<?php endif; ?>
		</div>
		<div class="blog-home">
			<?php
			$query_args	 = array(
				'post_type'		 => 'post',
				'posts_per_page' => absint( get_theme_mod( 'blog_section_number_posts', 3 ))
			);
			$the_query	 = new WP_Query( $query_args );
			if ( $the_query->have_posts() ) : while ( $the_query->have_posts() ) : $the_query->the_post();
					 get_template_part( 'content', '' ); 
				endwhile;
			wp_reset_postdata();
			else : ?>
				<p><?php esc_html_e( 'Sorry, no posts matched your criteria.', 'eleganto' ); ?></p>
			<?php endif; ?>
		</div>
	</div>
</div>  
<div class="border-bottom"></div>

