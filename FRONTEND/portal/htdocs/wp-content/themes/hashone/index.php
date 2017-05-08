<?php
/**
 * The main template file.
 *
 * @package HashOne
 */

get_header(); ?>
<?php 
$title = "";
if( is_home() && 'page' == get_option( 'show_on_front' )){
	$blog_page_id = get_option('page_for_posts');
	$title = get_the_title( $blog_page_id );
}
?>
<header class="hs-main-header">
	<div class="hs-container">
		<h1 class="hs-main-title"><?php echo esc_html($title); ?></h1>
		<?php hashone_breadcrumbs(); ?>
	</div>
</header><!-- .entry-header -->

<div class="hs-container">
	<div id="primary" class="content-area">

		<?php if ( have_posts() ) : ?>

			<?php /* Start the Loop */ ?>
			<?php while ( have_posts() ) : the_post(); ?>

				<?php

					/*
					 * Include the Post-Format-specific template for the content.
					 * If you want to override this in a child theme, then include a file
					 * called content-___.php (where ___ is the Post Format name) and that will be used instead.
					 */
					get_template_part( 'template-parts/content', get_post_format() );
				?>

			<?php endwhile; ?>

			<?php the_posts_pagination(
				array(
				    'prev_text' => '<i class="fa fa-angle-double-left"></i>',
				    'next_text' => '<i class="fa fa-angle-double-right"></i>'
				)
			); ?>

		<?php else : ?>

			<?php get_template_part( 'template-parts/content', 'none' ); ?>

		<?php endif; ?>

	</div><!-- #primary -->

<?php get_sidebar(); ?>

</div>

<?php get_footer(); ?>
