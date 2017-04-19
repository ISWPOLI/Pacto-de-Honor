<?php
get_header();
?>
	<div class="content">
		<div class="container">
			<div class="post_content">
			<?php if ( have_posts() ) : ?>
				 <div class="blog">
						<div class="blog-posts">
							<?php
								while ( have_posts() ) : the_post();
								?>
									<div class="blog-post-box <?php echo (is_sticky() ? 'sticky-post': ''); ?>">
										<div class="blog-post-feature">
										<?php

							 				if ( 'video' == get_post_format( get_the_ID() ) ) :

							 					echo vertex_get_video( get_the_ID() );

							 				else :

							 					$thumbnail = wp_get_attachment_image_src( get_post_thumbnail_id($post->ID), array(600,600) ); 
												echo '<div class="blog-post-image">
															<a href="'.esc_url( get_permalink() ).'" style="background-image: url('. esc_url( $thumbnail[0] ).')"></a>
														</div>';
											endif;
												
										?>
										</div>
										<div class="blog-post-info">
											<h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
											<div class="blog-post-meta"> <?php the_time(get_option('date_format')); ?> | <a href="<?php comments_link(); ?>"><?php  comments_number( __('0 Comments','vertex'), __(' 1 Comment','vertex'), '% '.__('Comments','vertex') ); ?></a></div>
											<div class="blog-post-excerpt">
												<p><?php echo wp_trim_words( get_the_excerpt(), 25, '...' ) ?></p>
											</div>
										</div>
									</div>
								<?php
									endwhile;
								?>
						</div><!-- blog-posts -->

						<div class="blog-pagination">
							<?php
								the_posts_pagination();
							?>
						</div>
				</div><!-- blog -->
			<?php else: echo '<p>'.__('Sorry, no blog posts found. Please create a post and assign it in "blog" category.','vertex').'</p>'; endif; ?>
			</div>
		</div>
	</div>
	
<?php
	get_footer();
?>