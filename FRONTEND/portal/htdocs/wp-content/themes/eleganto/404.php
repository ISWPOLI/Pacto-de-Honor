<?php get_header(); ?>

<?php get_template_part( 'template-part', 'topnav' ); ?>

<?php get_template_part( 'template-part', 'head' ); ?>

<?php
if ( get_theme_mod( 'breadcrumbs-check', 1 ) != 0 ) {
	eleganto_breadcrumb();
}
?>

<!-- start content container -->
<div class="row container rsrc-content">

<?php //left sidebar   ?>
<?php get_sidebar( 'left' ); ?>

	<div class="col-md-<?php eleganto_main_content_width(); ?> rsrc-main">
		<div class="rsrc-post-content">
            <div class="error-template text-center">
                <h1><?php esc_html_e( 'Oops!', 'eleganto' ); ?></h1>
                <h2><?php esc_html_e( '404 Not Found', 'eleganto' ); ?></h2>
                <p class="error-details">
					<?php esc_html_e( 'Sorry, an error has occured, Requested page not found!', 'eleganto' ); ?>
                </p>
                <div class="error-actions">
                    <a href="<?php echo esc_url( home_url( '/' ) ); ?>" class="btn btn-primary btn-lg"><span class="fa fa-home"></span><?php esc_html_e( ' Take Me Home', 'eleganto' ); ?></a>    
                </div>
            </div>
		</div>
	</div>

<?php //get the right sidebar   ?>
<?php get_sidebar( 'right' ); ?>

</div>
<!-- end content container -->

<?php get_footer(); ?>