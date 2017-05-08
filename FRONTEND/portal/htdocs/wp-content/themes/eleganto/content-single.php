<?php if ( has_post_thumbnail() ) : ?>                                
	<div class="single-thumbnail row"><?php echo get_the_post_thumbnail( $post->ID, 'eleganto-single' ); ?></div>                                     
	<div class="clear"></div>                            
<?php endif; ?>     
<!-- start content container -->
<div class="row container rsrc-content">    
	<?php //left sidebar ?>    
	<?php get_sidebar( 'left' ); ?>    
	<article class="col-md-<?php eleganto_main_content_width(); ?> rsrc-main">        
		<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>                                       
				<div <?php post_class( 'rsrc-post-content' ); ?>>                            
					<header>                              
						<h1 class="entry-title page-header">
							<?php the_title(); ?>
						</h1>                              
						<?php 
						if ( ! is_singular( 'portfolio' ) ) {
							get_template_part( 'template-part', 'postmeta' ); 
						}
						?>                            
					</header>                                                                                      
					<div class="entry-content">
						<?php the_content(); ?>
					</div>   
					<div id="custom-box"></div>                         
					<?php wp_link_pages(); ?>                                                        
					<?php get_template_part( 'template-part', 'posttags' ); ?>
					<?php if ( get_theme_mod( 'post-nav-check', 1 ) == 1 ) : ?>                            
						<div class="post-navigation row">
							<div class="post-previous col-md-6"><?php previous_post_link( '%link', '<span class="meta-nav">' . __( 'Previous:', 'eleganto' ) . '</span> %title' ); ?></div>
							<div class="post-next col-md-6"><?php next_post_link( '%link', '<span class="meta-nav">' . __( 'Next:', 'eleganto' ) . '</span> %title' ); ?></div>
						</div>                          
					<?php endif; ?>                            
					<?php if ( get_theme_mod( 'related-posts-check', 1 ) == 1 ) : ?>
						<?php get_template_part( 'template-part', 'related' ); ?>
					<?php endif; ?>
					<?php if ( get_theme_mod( 'author-check', 1 ) == 1 ) : ?>                               
						<?php get_template_part( 'template-part', 'postauthor' ); ?> 
					<?php endif; ?>                            
					<?php comments_template(); ?>                         
				</div>        
			<?php endwhile; ?>        
		<?php else: ?>            
			<?php get_template_part( 'content', 'none' ); ?>        
		<?php endif; ?>    
	</article>     
	<?php //get the right sidebar ?>    
	<?php get_sidebar( 'right' ); ?>
</div>
<!-- end content container -->