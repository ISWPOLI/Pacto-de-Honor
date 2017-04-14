<!-- Start Related Posts -->
<?php
$tags = wp_get_post_tags( $post->ID );
if ( $tags ) {
	$tag_ids	 = array();
	foreach ( $tags as $individual_tag )
		$tag_ids[]	 = $individual_tag->term_id;
	$args		 = array(
		'tag__in'				 => $tag_ids,
		'post__not_in'			 => array( $post->ID ),
		'showposts'				 => 2, // Number of related posts that will be shown.
		'ignore_sticky_posts'	 => 1
	);
	$my_query	 = new wp_query( $args );
	if ( $my_query->have_posts() ) {
		echo '<div class="related-posts row"><div class="related-posts-content col-md-12"><div class="related-posts-title"><h4>' . __( 'Related posts', 'eleganto' ) . '</h4></div><ul class="row">';
		while ( $my_query->have_posts() ) {
			$my_query->the_post();
			?> 
			<li class="rpost col-sm-6 hover-style">
				<?php if ( has_post_thumbnail() ) : ?>
					<?php the_post_thumbnail( 'eleganto_home', array( 'title' => '' ) ); ?>
				<?php else : ?>
					<img src="<?php echo get_template_directory_uri(); ?>/img/noprew-related.jpg" alt="<?php the_title_attribute(); ?>">                                                           
				<?php endif; ?>
				<div class="home-header"> 
					<header>
						<h2 class="page-header">                                
							<a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" rel="bookmark">
								<?php the_title(); ?>
							</a>                            
						</h2> 
					</header>
					<div class="entry-summary hidden-xs">
						<?php the_excerpt(); ?>
					</div><!-- .entry-summary -->                                                                                                                                                                                                                                          
				</div> 
			</li>
			<?php
		}
		echo '</ul></div></div>';
	}
}
?>
<!-- End Related Posts -->
<?php wp_reset_postdata(); ?>