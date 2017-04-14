<?php
/**
 * The template for displaying 404 pages (not found).
 *
 * @package HashOne
 */

get_header(); ?>

<header class="hs-main-header">
	<div class="hs-container">
		<h1 class="hs-main-title"><?php esc_html_e( '404 Error', 'hashone' ); ?></h1>
		<?php hashone_breadcrumbs(); ?>
	</div>
</header><!-- .entry-header -->


<div class="hs-container">
	<div class="oops-text"><?php esc_html_e( 'Oops! That page can&rsquo;t be found.', 'hashone' ); ?></div>
	<span class="error-404">404</span>
</div>

<?php get_footer(); ?>
