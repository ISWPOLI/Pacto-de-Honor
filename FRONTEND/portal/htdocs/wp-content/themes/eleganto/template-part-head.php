<?php 
$sortable_value = maybe_unserialize( get_theme_mod( 'home_layout', array( 'blog_section' ) ) ); 
if ( is_front_page() || is_home() || is_404() ) {
	$heading = 'h1';
	$desc	 = 'h2';
} else {
	$heading = 'h2';
	$desc	 = 'h3';
}
?> 			 
	<div class="rsrc-main-menu">
		<div class="container">     
			<nav id="main-navigation" class="navbar navbar-inverse" role="navigation">                    
				<?php if (function_exists( 'has_custom_logo' ) && has_custom_logo( ) ) : ?>
					<div class="rsrc-header-img navbar-brand">
						<?php the_custom_logo( ); ?>
					</div>
				<?php else : ?>
					<div class="rsrc-header-text navbar-brand">
						<<?php echo $heading ?> class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php echo esc_attr( get_bloginfo( 'name', 'display' ) ); ?>" rel="home"><?php echo esc_attr( get_bloginfo( 'name', 'display' ) ); ?></a></<?php echo $heading ?>>
					</div>
				<?php endif; ?>
				<?php 
				$home_template = get_post_meta( get_option( 'page_on_front' ), '_wp_page_template', true ); // Check if the homepage is our custom template
				if ( !empty( $sortable_value ) && get_option( 'show_on_front' ) == 'page' && $home_template == 'template-home.php' ) : // Check static front page, homepage template and values
				?> 
					<div class="navbar-header">                        
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-2-collapse">                            
							<span class="sr-only">
								<?php _e( 'Toggle navigation', 'eleganto' ); ?>
							</span>                            
							<span class="icon-bar"></span>                            
							<span class="icon-bar"></span>                            
							<span class="icon-bar"></span>                        
						</button>                    
					</div>
					<div class="collapse navbar-collapse navbar-2-collapse" id="main-navigation-inner">      
						<ul class="nav navbar-nav navbar-right">        
							<?php foreach ( $sortable_value as $checked_value ) : ?>
									<?php $title = str_replace( '_section', '', $checked_value ); ?>				      
									<?php if ( get_theme_mod( '' . $checked_value . '_menu_title', $title ) != '' ) : ?>
									<li>
										<?php if ( is_front_page() ) : ?>   
											<a class="nav-<?php echo esc_attr( $checked_value ); ?>" href="#<?php echo esc_attr( $checked_value ); ?>"><?php echo get_theme_mod( '' . esc_attr( $checked_value ) . '_menu_title', $title ); ?></a>
										<?php else : ?>
											<a class="nav-<?php echo esc_attr( $checked_value ); ?>" href="<?php echo esc_url( home_url( '/' ) ); ?>#<?php echo esc_attr( $checked_value ); ?>"><?php echo get_theme_mod( '' . esc_attr( $checked_value ) . '_menu_title', $title ); ?></a>
									<?php endif; ?>
									</li>
								<?php endif; ?>				       
							<?php endforeach; ?> 	       
						</ul>    
					</div>
					<!-- /.navbar-collapse -->
				<?php endif; ?>
			</nav>
		</div>
	</div>

<div class="container-fluid rsrc-container" role="main">


