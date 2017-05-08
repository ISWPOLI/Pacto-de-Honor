<?php if ( get_theme_mod( 'portfolio_intro_enable', '0' ) != '0' ) : ?>
	<div class="intro">  
	    <?php $bg = get_theme_mod( 'portfolio_intro_img_image', '' ) ?>
	    <div class="prlx <?php if ( $bg ) { echo 'img-holder'; } ?>" data-image="<?php echo esc_url( $bg ); ?>"></div>
		<?php if ( get_theme_mod( 'portfolio_intro_title', '' ) != '' ) : ?>
			<h2 class="text-center"><?php echo esc_html( get_theme_mod( 'portfolio_intro_title', '' ) ); ?></h2>
		<?php endif; ?>
		<?php if ( get_theme_mod( 'portfolio_intro_desc', '' ) != '' ) : ?>
			<h3 class="text-center"><?php echo esc_html( get_theme_mod( 'portfolio_intro_desc', '' ) ); ?></h3> 
		<?php endif; ?>
	</div>     
<?php endif; ?>
<div class="border-top"></div>
<div class="section">  
	<div class="container">
		<div class="container-heading text-center">
			<?php if ( get_theme_mod( 'portfolio_section_title', '' ) != '' ) : ?>
				<h4><?php echo esc_html( get_theme_mod( 'portfolio_section_title', '' ) ); ?></h4>
			<?php endif; ?>
			<?php if ( get_theme_mod( 'portfolio_section_desc', '' ) != '' ) : ?>
				<div class="sub-title"><span><?php echo esc_html( get_theme_mod( 'portfolio_section_desc', '' ) ); ?></span></div>
			<?php endif; ?>
		</div>

		<?php if ( post_type_exists( 'portfolio' ) ) : ?>
			<ul id="filter" class="list-inline text-center">
				<?php
				$terms	 = get_terms( 'portfolio_category' );
				$count	 = count( $terms );
				echo '<li><a class="btn btn-default" href="javascript:void(0)" title="" data-filter=".all" class="active">' . esc_html__( 'All', 'eleganto' ) . '</a></li>';
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
					'posts_per_page' => absint( get_theme_mod( 'portfolio_section_number_posts', 8 ) )
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
</div>  
<div class="border-bottom"></div>

