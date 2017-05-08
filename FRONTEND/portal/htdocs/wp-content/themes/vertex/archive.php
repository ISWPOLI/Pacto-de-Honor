<?php
get_header();
?>
<div class="content">
	<div class="container">
		<div class="post_content">
			<?php if (have_posts() ) : ?>
				<div class="blog">
						<div class="archive_title">
							<h2><?php the_archive_title(); ?></h2>
						</div><!--//archive_title-->
						<div class="archive-portfolio">
							<?php
								while ( have_posts() ) : the_post();
								?>
								<div class="portfolio-box">
									<div class="port-image">
										<?php
											if ( 'video' == get_post_format( get_the_ID() ) ) :

							 					echo vertex_get_video( get_the_ID() );

							 				else :

							 					$thumbnail = wp_get_attachment_image_src( get_post_thumbnail_id($post->ID), array(600,600) ); 
												echo '<a href="'.esc_url( get_permalink() ).'" style="background-image: url('.esc_url( $thumbnail[0] ).')"></a>';
											endif;

										?>
									</div>
									<div class="port-body">
										<h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
										<div class="port-cats"><?php the_category(', '); ?></div>
									</div>
								</div>
								<?php
									endwhile;
								?>
								<div class="clear"></div>
						</div><!-- blog-posts -->
						<div class="blog-pagination">
							<?php
								the_posts_pagination();
							?>
						</div>
				</div><!-- blog -->
		<?php endif; ?>
		</div>
	</div>
</div>
<?php
get_footer();