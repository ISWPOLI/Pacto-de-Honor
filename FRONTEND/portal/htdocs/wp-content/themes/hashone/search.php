<?php
/**
 * The template for displaying search results pages.
 *
 * @package HashOne
 */

get_header(); ?>

<header class="hs-main-header">
	<div class="hs-container">
		<h1 class="hs-main-title"><?php printf( esc_html__( 'Search Results for: %s', 'hashone' ), '<span>' . get_search_query() . '</span>' ); ?></h1>
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
				/**
				 * Run the loop for the search to output the results.
				 * If you want to overload this in a child theme then include a file
				 * called content-search.php and that will be used instead.
				 */
				get_template_part( 'template-parts/content', 'search' );
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
