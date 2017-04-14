<?php
/**
 * @package Tesseract
 */
?>

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
<?php $featImg_pos = get_theme_mod('tesseract_blog_featimg_pos'); 
	
	if ( has_post_thumbnail() && ( !$featImg_pos || ( $featImg_pos == 'above' ) ) ) 
		tesseract_output_featimg_blog(); ?>

	<?php //if ( my_theme_show_page_header() ) : ?>
		<header class="entry-header">
			<?php the_title( '<div id="blogpost_title"><h1 class="entry-title">', '</h1></div>' ); ?>
			<?php
			$postDate = get_theme_mod('tesseract_blog_date');
			if ( $postDate == 'showdate' ) { ?>
				<span><i class="fa fa-calendar" aria-hidden="true"></i><?php the_time('F j, Y'); ?></span>
			<?php } ?>
			
			<?php
			$postAuthor = get_theme_mod('tesseract_blog_author');
			if ( $postAuthor == 'showauthor' ) { ?>
				<span><i class="fa fa-user" aria-hidden="true"></i><?php the_author(); ?></span>
			<?php } ?>
			
			<?php
			$mypostComment = get_theme_mod('tesseract_blog_comments');
			if ( ( $mypostComment == 'showcomment' ) && ( comments_open() ) ) { ?>
			    <span><i class="fa fa-comments-o" aria-hidden="true"></i><?php //comments_number('(No Comments)', '(1 Comment)', '(% Comments)' );?><?php comments_popup_link(
    'No comments exist',  '1 comment', '% comments'); ?></span>
			<?php }
			?>
		</header><!-- .entry-header -->
	<?php //endif; ?>
    <?php if ( has_post_thumbnail() && ( $featImg_pos == 'below' ) ) 
		tesseract_output_featimg_blog(); ?>
	<div class="entry-content">
        <div class="entry-meta">
	        <?php tesseract_posted_on(); ?>
		</div><!-- .entry-meta -->
		<?php if ( has_post_thumbnail() && ( $featImg_pos == 'left' ) ) { ?>
		<div class="myleft">
		<?php tesseract_output_featimg_blog(); ?>
		<?php the_content(); ?>
		<?php the_tags()?>
		</div>
		<?php } elseif ( has_post_thumbnail() && ( $featImg_pos == 'right' ) ){ ?>
		<div class="myright">
		<?php  tesseract_output_featimg_blog(); ?> 
		<?php the_content(); ?>
		<?php the_tags()?>
        </div>
		<?php } else { ?>
		<?php the_content(); ?>
		<?php } ?>
		
		<?php
			wp_link_pages( array(
				'before' => '<div class="page-links">' . __( 'Pages:', 'tesseract' ),
				'after'  => '</div>',
			) );
		?>
	</div><!-- .entry-content -->

</article><!-- #post-## -->