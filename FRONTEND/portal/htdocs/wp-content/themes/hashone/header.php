<?php
/**
 * The header for our theme.
 *
 * @package HashOne
 */

?>
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">

<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<div id="hs-page">
	<?php
	$hashone_header_bg = get_theme_mod('hashone_header_bg','hs-black');
	?>
	<header id="hs-masthead" class="hs-site-header hs-clearfix <?php echo esc_attr($hashone_header_bg) ?>">
		<div class="hs-container">
			<div id="hs-site-branding">
				<?php 
				if ( function_exists( 'has_custom_logo' ) && has_custom_logo() ) :
					the_custom_logo();
				else:
					if ( is_front_page() ) : ?>
					<h1 class="hs-site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home"><?php bloginfo( 'name' ); ?></a></h1>
					<?php else : ?>
					<p class="hs-site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home"><?php bloginfo( 'name' ); ?></a></p>
					<?php endif; ?>
					
					<p class="hs-site-description"><?php bloginfo( 'description' ); ?></p>
					
				<?php endif; // End header image check. ?>
			</div><!-- .site-branding -->

			<nav id="hs-site-navigation" class="hs-main-navigation">
				<div class="hs-toggle-menu"><span></span></div>
				<?php 
				wp_nav_menu( array( 
					'theme_location' => 'primary', 
					'container_class' => 'hs-menu' ,
					'menu_class' => 'hs-clearfix',
					'items_wrap' => '<ul id="%1$s" class="%2$s">%3$s</ul>',
				) ); 
				?>
			</nav><!-- #hs-site-navigation -->
		</div>
	</header><!-- #hs-masthead -->

	<div id="hs-content" class="hs-site-content hs-clearfix">