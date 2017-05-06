<?php get_header(); ?>

<?php get_template_part( 'template-part', 'topnav' ); ?>

<?php get_template_part( 'template-part', 'head' ); ?>

<!-- start content container -->
<div class="row container rsrc-content">
	<?php if ( post_type_exists( 'portfolio' ) ) : ?>
		<ul id="filter" class="list-inline text-center">
			<?php
			$terms	 = get_terms( 'portfolio_category' );
			$count	 = count( $terms );
			echo '<li><a class="btn btn-default" href="javascript:void(0)" title="" data-filter=".all" class="active">All</a></li>';
			if ( $count > 0 ) {
				foreach ( $terms as $term ) {
					$termname	 = strtolower( $term->name );
					$termname	 = str_replace( ' ', '-', $termname );
					echo '<li><a class="btn btn-default" href="javascript:void(0)" title="" data-filter=".' . esc_attr( $termname ) . '">' . esc_html( $term->name ) . '</a></li>';
				}
			}
			?>
		</ul>

		<ul id="portfolio" class="grid">
			<?php
			$args	 = array(
				'post_type'		 => 'portfolio',
				'posts_per_page' => get_theme_mod( 'portfolio_section_number_posts', 8 )
			);
			$loop	 = new WP_Query( $args );
			while ( $loop->have_posts() ) : $loop->the_post();
				$terms = get_the_terms( $post->ID, 'portfolio_category' );
				if ( $terms && !is_wp_error( $terms ) ) :
					$links = array();
					foreach ( $terms as $term ) {
						$links[] = $term->name;
					}
					$tax_links	 = join( " ", str_replace( ' ', '-', $links ) );
					$tax		 = strtolower( $tax_links );
				else :
					$tax = '';
				endif;
				?>     					 					     					 							                                                    
				<li class="all portfolio-item col-md-<?php echo absint( get_theme_mod( 'portfolio_section_size', 3 ) ); ?> col-sm-6 <?php echo esc_attr( $tax ); ?>">                          
					<figure class="effect-<?php echo esc_attr( get_theme_mod( 'portfolio_section_animation', 'lily' ) ); ?>">                              
						<?php if ( has_post_thumbnail() ) { ?>            												                                                                       
							<?php the_post_thumbnail( 'eleganto-home' ); ?>          											                                                                 
						<?php } else { ?>                                                                                                       
							<img src="<?php echo get_template_directory_uri(); ?>/img/noprew-index.png" alt="<?php the_title_attribute(); ?>">       									                                                                       
						<?php } ?> 																			 									                                                                               
						<figcaption>     									                                                                
							<h2 class="portfolio-title">                                                                                                                                  
								<?php esc_html( eleganto_portfolio_title() ); ?>                                                              
							</h2>              
							<p>
								<?php the_excerpt(); ?>  
							</p>			         
							<a href="<?php the_permalink(); ?>">
								<?php esc_html_e( 'Read more', 'eleganto' ) ?>
							</a>								 							                                                          
						</figcaption>                           
					</figure> 	                          
				</li>	 					                                                        		 					                                                    
			<?php endwhile; ?> 
			<?php wp_reset_postdata(); ?>    					   			    				                                      
		</ul>
	<?php endif; ?>     
</div>
<!-- end content container -->
<?php get_template_part( 'template-part', 'footernav' ); ?>

<?php get_footer(); ?>

