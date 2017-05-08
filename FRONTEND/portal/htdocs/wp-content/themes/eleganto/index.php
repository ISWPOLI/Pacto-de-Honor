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

		<?php
		if ( have_posts() ) : while ( have_posts() ) : the_post();
				get_template_part( 'content', get_post_format() );
			endwhile;

			the_posts_pagination();

		else :
			get_template_part( 'content', 'none' );
		endif;
		?>

	</div>

	<?php //get the right sidebar  ?>
	<?php get_sidebar( 'right' ); ?>

</div>
<!-- end content container -->

<?php get_template_part( 'template-part', 'footernav' ); ?>

<?php get_footer(); ?>

