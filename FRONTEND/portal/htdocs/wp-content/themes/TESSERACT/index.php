<?php
/**
 * The main template file.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package Tesseract
 */

get_header();  
?>

	<?php
		$bplayout = get_theme_mod('tesseract_blog_post_layout');
 
		switch ( $bplayout ) {
			case 'fullwidth':
				$primary_classnw = 'full-width-page no-sidebar';

				break;
			case 'sidebar-right':
				$primary_classnw = 'content-area sidebar-right';

				break;
			default:
				// sidebar-left
				$primary_classnw = 'content-area';
		}
	?>

	<div id="primary" class="<?php echo $primary_classnw; ?>">
		<main id="main" class="site-main" role="main">
        
        <?php if ( is_home() && !is_front_page() &&is_single() ) { ?>
			<header class="page-header">
				</br>
			</header><!-- .page-header -->
		<?php } ?>    

			<?php while ( have_posts() ) : the_post(); ?>

				<?php
					get_template_part( 'content', get_post_format() );
				?>

			<?php endwhile; ?>



		</main><!-- #main -->
	</div><!-- #primary -->

<?php
		if ( !$bplayout || ( $bplayout == 'sidebar-left' ) || ( $bplayout == 'sidebar-right' ) ) get_sidebar();
	?>
<?php //get_footer(); ?>
<?php get_footer('custes'); ?>