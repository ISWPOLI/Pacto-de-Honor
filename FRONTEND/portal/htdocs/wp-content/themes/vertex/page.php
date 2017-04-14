<?php
get_header();
?>
<div class="content">
	<div class="container">
		<div class="post_content">
			<?php if(have_posts()): the_post(); ?>
			<article class="post_box" id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
				<h1><?php the_title(); ?></h1>
				<?php the_content(); ?>
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
			endif;
			?>
		</div>
		<div class="clear"></div>
	</div>
	</div>
	<?php
get_footer();
?>