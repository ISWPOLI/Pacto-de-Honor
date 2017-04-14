<div class="post-meta text-left">
	<span class="fa fa-clock-o"></span><time class="posted-on published" datetime="<?php the_time( 'Y-m-d' ); ?>"><?php the_time( get_option( 'date_format' ) ); ?></time>
	<span class="fa fa-user"></span><span class="author-link"><?php the_author_posts_link(); ?></span>
	<span class="fa fa-comment"></span><span class="comments-meta"><?php comments_popup_link( __( '0', 'eleganto' ), __( '1', 'eleganto' ), __( '%', 'eleganto' ), 'comments-link', __( 'Off', 'eleganto' ) ); ?></span>
	<span class="fa fa-folder-open"></span><?php the_category(', '); ?>
	<?php edit_post_link( __( 'Edit', 'eleganto' ), '<span class="fa fa-pencil-square"></span>', '' ); ?>
</div>