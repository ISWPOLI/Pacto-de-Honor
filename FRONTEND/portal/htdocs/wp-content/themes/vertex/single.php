<?php
get_header();
?>
<div class="content">
	<div class="container">
		<div class="post_content">
			<?php while ( have_posts() ) : the_post(); ?>
			<article class="post_box" id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
				<h1><?php the_title(); ?></h1>
				<?php the_content(); ?>
					<?php
					wp_link_pages(array(
						'before' => '<div class="link_pages">'.__('Pages', 'vertex'),
						'after' => '</div>',
						'link_before' => '<span>',
						'link_after' => '</span>'
					)); 
				?>
				<?php the_tags( '<div class="post_tags">'.__('Tags','vertex').': ', ', ', '</div>' ); ?>
				<div class="post-nav">
					<?php the_post_navigation( array('prev_text' => '&#8592; %title','next_text' => '%title &#8594;') ); ?>
				</div>
			</article>
			<div class="clear"></div>
			<?php if ( comments_open() || '0' != get_comments_number() ) : ?>
						<div class="home_blog_box">
							<div class="comments_cont">
							<?php
								comments_template( '', true );
							?>
							</div>
						</div>
			<?php endif;
			endwhile;
			?>
		</div>
	</div>
</div>
<?php
get_footer();
?>