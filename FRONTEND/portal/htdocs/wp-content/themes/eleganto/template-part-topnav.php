<?php if ( has_nav_menu( 'top_menu' ) || get_theme_mod( 'eleganto_socials', 0 ) == 1 ) : ?>
	<div class="rsrc-top-menu ">
		<div class="container">
	        <nav id="site-navigation" class="navbar navbar-inverse" role="navigation">    
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-1-collapse">
						<span class="sr-only"><?php _e( 'Toggle navigation', 'eleganto' ); ?></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<div class="visible-xs navbar-brand"><?php _e( 'Menu', 'eleganto' ); ?></div>
				</div>
				<?php if ( get_theme_mod( 'eleganto_socials', 0 ) == 1 ) : ?>
					<div class="top-section nav navbar-nav navbar-right">
						<?php eleganto_social_links();  ?>                 
					</div>
				<?php endif; ?>
				<?php
				wp_nav_menu( array(
					'theme_location'	 => 'top_menu',
					'depth'				 => 3,
					'container'			 => 'div',
					'container_class'	 => 'collapse navbar-collapse navbar-1-collapse',
					'menu_class'		 => 'nav navbar-nav',
					'fallback_cb'		 => 'wp_bootstrap_navwalker::fallback',
					'walker'			 => new wp_bootstrap_navwalker() )
				);
				?>
	        </nav>
		</div>
	</div>
<?php endif; ?>
