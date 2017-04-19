<?php
/**
 * @package Tesseract
 */
?>

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
<?php $contentType = get_theme_mod('tesseract_blog_content'); ?>
    <?php if( $contentType == 'titleonly' ) { ?>
	<div id="bloglist_title" class="onlytitle">
		<h2 class="entry-title"><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
    </div>
	<?php } else { ?>
	
    <?php $featImg_pos = get_theme_mod('tesseract_blog_featimg_pos'); 
	
	if ( has_post_thumbnail() && ( !$featImg_pos || ( $featImg_pos == 'above' ) ) ) 
		tesseract_output_featimg_blog(); ?>
    
	<!--<header class="entry-header">-->
	    <div id="bloglist_title">
		<h2 class="entry-title"><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
        </div>
		
		<?php
		if ( is_home() || is_archive() ) {		
			$postDate = get_theme_mod('tesseract_blog_date');
			if ( $postDate == 'showdate' ) { ?>
				<span><i class="fa fa-calendar" aria-hidden="true"></i><?php the_time('F j, Y'); ?></span>
		    <?php }	?>
						
		<?php $postAuthor = get_theme_mod('tesseract_blog_author');
			if ( $postAuthor == 'showauthor' ) { ?>
				<span><i class="fa fa-user" aria-hidden="true"></i><?php the_author(); ?></span>
		<?php } ?>
		
        <?php		
			$mypostComment = get_theme_mod('tesseract_blog_comments');
			if ( ( $mypostComment == 'showcomment' ) && ( comments_open() ) ) { ?>
				<span><i class="fa fa-comments-o" aria-hidden="true"></i><?php //comments_number('(No Comments)', '(1 Comment)', '(% Comments)' );?><?php comments_popup_link(
    'No comments exist',  '1 comment', '% comments'); ?></span>
		<?php }
		}	
		?>
		
	<!--</header>--><!-- .entry-header -->

	<?php if ( has_post_thumbnail() && ( $featImg_pos == 'below' ) ) 
		tesseract_output_featimg_blog(); ?>

	<div class="entry-content">
		<?php if ( has_post_thumbnail() && ( $featImg_pos == 'left' ) ) { ?>
			<div class="myleft">
				<?php tesseract_output_featimg_blog(); ?>
				<?php
					if ( is_home() || is_archive() ) {
						if ( $contentType == 'content' ) {
							the_content();
						} else {
							the_excerpt(); 
							?>
							<?php $blbutton_pos = get_theme_mod('tesseract_blog_button_pos'); 
							switch ( $blbutton_pos ) {
								case 'center':
									$button_classnw = 'rmbutton-center';

									break;
								case 'right':
									$button_classnw = 'rmbutton-right';

									break;
								default:
									$button_classnw = 'rmbutton-left';
							}
							?>
							
							<?php $blbutton_size = get_theme_mod('tesseract_blog_button_size'); 
							switch ( $blbutton_size ) {
								case 'small':
									$button_classsize = 'rmbutton-small';

									break;
								case 'large':
									$button_classsize = 'rmbutton-large';

									break;
								default:
									$button_classsize = 'rmbutton-medium';
							}
							?>
							<?php $blbutton_txt = get_theme_mod('tesseract_blog_button_txt'); ?>
							<?php $blbutton_radius = get_theme_mod('tesseract_blog_button_radius'); ?>
							<?php $blbutton_bgcolor = get_theme_mod('tesseract_blog_buttonbgcolor'); ?>
						<?php //$blbutton_txtonly = get_theme_mod('tesseract_blog_button_textonly'); ?>
							<?php if( $blbutton_size == 'textonly') { ?>
							<div id="bloglist_morebutton">
							<div class="blmore <?php echo $button_classnw; ?> <?php echo $button_classsize; ?>"><a href="<?php the_permalink(); ?>"><?php echo $blbutton_txt; ?></a></div>
							</div>
							<?php } else { ?> 
							<div id="bloglist_morebutton">
							<div class="blmore <?php echo $button_classnw; ?> <?php echo $button_classsize; ?>"><a style="background-color: <?php echo $blbutton_bgcolor; ?>; border-radius: <?php echo $blbutton_radius; ?>px;" href="<?php the_permalink(); ?>"><?php echo $blbutton_txt; ?></a></div>
							</div>	
							<?php } ?>

						<?php }
						
					} else {
					the_content( sprintf(
						__( 'Continue reading %s <span class="meta-nav">&rarr;</span>', 'tesseract' ),
						the_title( '<span class="screen-reader-text">"', '"</span>', false )
					) );
					 }
				?>
			</div>
		<?php } elseif ( has_post_thumbnail() && ( $featImg_pos == 'right' ) ){ ?>
			<div class="myright">
				<?php  tesseract_output_featimg_blog(); ?> 
				<?php //the_content(); ?>
				<?php
					if ( is_home() || is_archive() ) {
						if ( $contentType == 'content' ) {
							the_content();
						} else {
							the_excerpt(); 
							?>
							
							<?php $blbutton_pos = get_theme_mod('tesseract_blog_button_pos'); 
							switch ( $blbutton_pos ) {
								case 'center':
									$button_classnw = 'rmbutton-center';

									break;
								case 'right':
									$button_classnw = 'rmbutton-right';

									break;
								default:
									$button_classnw = 'rmbutton-left';
							}
							?>
							
							<?php $blbutton_size = get_theme_mod('tesseract_blog_button_size'); 
							switch ( $blbutton_size ) {
								case 'small':
									$button_classsize = 'rmbutton-small';

									break;
								case 'large':
									$button_classsize = 'rmbutton-large';

									break;
								default:
									$button_classsize = 'rmbutton-medium';
							}
							?>
							<?php $blbutton_txt = get_theme_mod('tesseract_blog_button_txt'); ?>
							<?php $blbutton_radius = get_theme_mod('tesseract_blog_button_radius'); ?>
							<?php $blbutton_bgcolor = get_theme_mod('tesseract_blog_buttonbgcolor'); ?>
						<?php //$blbutton_txtonly = get_theme_mod('tesseract_blog_button_textonly'); ?>
							
							<?php if( $blbutton_size == 'textonly') { ?>
							<div id="bloglist_morebutton">
							<div class="blmore <?php echo $button_classnw; ?> <?php echo $button_classsize; ?>"><a href="<?php the_permalink(); ?>"><?php echo $blbutton_txt; ?></a></div>
							</div>
							<?php } else { ?> 
							<div id="bloglist_morebutton">
							<div class="blmore <?php echo $button_classnw; ?> <?php echo $button_classsize; ?>"><a style="background-color: <?php echo $blbutton_bgcolor; ?>; border-radius: <?php echo $blbutton_radius; ?>px;" href="<?php the_permalink(); ?>"><?php echo $blbutton_txt; ?></a></div>
							</div>	
							<?php } ?>
							
						<?php }
						
					} else {

					the_content( sprintf(
						__( 'Continue reading %s <span class="meta-nav">&rarr;</span>', 'tesseract' ),
						the_title( '<span class="screen-reader-text">"', '"</span>', false )
					) );
					
					 }
				?>
			</div>
		<?php } else { ?>
		<?php the_content(); ?>
		<?php } ?>
	

	</div><!-- .entry-content -->
	<?php } ?>
	<div style="clear:both"></div>
    
</article><!-- #post-## -->