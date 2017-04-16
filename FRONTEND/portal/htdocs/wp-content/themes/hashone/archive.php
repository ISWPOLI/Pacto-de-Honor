<?php
/**
 * The template for displaying archive pages.
 *
 * @package HashOne
 */

get_header(); ?>

<header class="hs-main-header">
	<div class="hs-container">
		<?php
			the_archive_title( '<h1 class="hs-main-title">', '</h1>' );
			the_archive_description( '<div class="taxonomy-description">', '</div>' );
		?>
		<?php hashone_breadcrumbs(); ?>
	</div>
</header><!-- .hs-main-header -->

<div class="hs-container">
	<div id="primary" class="content-area">
		<main id="main" class="site-main" role="main">

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

			<?php the_posts_pagination(array(
								    'prev_text' => __( 'Prev', 'hashone' ),
								    'next_text' => __( 'Next', 'hashone' ),
								)); ?>

		<?php else : ?>

			<?php get_template_part( 'template-parts/content', 'none' ); ?>

		<?php endif; ?>

		</main><!-- #main -->
	</div><!-- #primary -->

<?php get_sidebar(); ?>

</div>

<?php get_footer();
