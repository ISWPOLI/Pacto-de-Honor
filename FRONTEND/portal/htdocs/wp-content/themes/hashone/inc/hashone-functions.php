<?php
/**
 * Custom functions that act independently of the theme templates
 *
 * @package HashOne
 */

/**
 * Adds custom classes to the array of body classes.
 *
 * @param array $classes Classes for the body element.
 * @return array
 */
function hashone_body_classes( $classes ) {
	// Adds a class of group-blog to blogs with more than 1 published author.
	if ( is_multi_author() ) {
		$classes[] = 'group-blog';
	}

	$hs_post_type = array( 'post' ,'page' );

	if(is_singular($hs_post_type)){
		global $post;
		$hs_sidebar_layout = get_post_meta( $post->ID, 'hs_sidebar_layout', true );

		if(!$hs_sidebar_layout){
			$hs_sidebar_layout = 'right_sidebar';
		}

		$classes[] = esc_attr('hs_'.$hs_sidebar_layout);
	}

	return $classes;
}
add_filter( 'body_class', 'hashone_body_classes' );

if( !function_exists( 'hashone_excerpt' ) ){
	function hashone_excerpt( $content , $letter_count ){
		$content = strip_shortcodes( $content );
		$content = strip_tags( $content );
		$content = mb_substr( $content, 0 , $letter_count );

		if( strlen( $content ) == $letter_count ){
			$content .= "...";
		}
		return $content;
	}
}

add_filter( 'wp_page_menu_args' , 'hashone_change_wp_page_menu_args');

if( !function_exists( 'hashone_change_wp_page_menu_args' ) ){
	function hashone_change_wp_page_menu_args( $args ){
		$args['menu_class'] = 'hs-menu hs-clearfix';	
		return $args;
	}
}

function hashone_dynamic_styles(){
	echo "<style>";
	$hashone_service_left_bg = get_theme_mod('hashone_service_left_bg', get_template_directory_uri().'/images/bg.jpg');
	$hashone_counter_bg = get_theme_mod('hashone_counter_bg', get_template_directory_uri().'/images/bg.jpg');
	$hashone_contact_bg = get_theme_mod('hashone_contact_bg', get_template_directory_uri().'/images/bg.jpg');
	$hashone_page_header_bg = get_theme_mod( 'hashone_page_header_bg', get_template_directory_uri().'/images/bg.jpg');

	echo '.hs-main-header,#hs-home-slider-section{background-image: url('. esc_url($hashone_page_header_bg) .')}';
	echo '.hs-service-left-bg{ background-image:url(' .esc_url($hashone_service_left_bg). ');}';
	echo '#hs-counter-section{ background-image:url(' .esc_url($hashone_counter_bg). ');}';
	echo '#hs-contact-section{ background-image:url(' .esc_url($hashone_contact_bg). ');}';
	echo "</style>";
}

add_action( 'wp_head', 'hashone_dynamic_styles' );

function hashone_comment( $comment, $args, $depth ) {
	$GLOBALS['comment'] = $comment;
	extract($args, EXTR_SKIP);
	$tag = ( 'div' === $args['style'] ) ? 'div' : 'li';
	?>
	<<?php echo $tag; ?> id="comment-<?php comment_ID(); ?>" <?php comment_class( empty( $args['has_children'] )  ? 'parent' : '', $comment ); ?>>
		<article id="div-comment-<?php comment_ID(); ?>" class="comment-body">
			<footer class="comment-meta">
				<div class="comment-author vcard">
					<?php if ( 0 != $args['avatar_size'] ) echo get_avatar( $comment, $args['avatar_size'] ); ?>
					<?php echo sprintf( '<b class="fn">%s</b>', get_comment_author_link( $comment )  ); ?>
				</div><!-- .comment-author -->

				<?php if ( '0' == $comment->comment_approved ) : ?>
				<p class="comment-awaiting-moderation"><?php _e( 'Your comment is awaiting moderation.', 'hashone' ); ?></p>
				<?php endif; ?>
				<?php edit_comment_link( __( 'Edit' , 'hashone' ), '<span class="edit-link">', '</span>' ); ?>
			</footer><!-- .comment-meta -->

			<div class="comment-content">
				<?php comment_text(); ?>
			</div><!-- .comment-content -->

			<div class="comment-metadata hs-clearfix">
				<a href="<?php echo esc_url( get_comment_link( $comment, $args ) ); ?>">
					<time datetime="<?php comment_time( 'c' ); ?>">
						<?php
							/* translators: 1: comment date, 2: comment time */
							printf( __( '%1$s at %2$s' , 'hashone' ), get_comment_date( '', $comment ), get_comment_time() );
						?>
					</time>
				</a>

				<?php
				comment_reply_link( array_merge( $args, array(
					'add_below' => 'div-comment',
					'depth'     => $depth,
					'max_depth' => $args['max_depth'],
					'before'    => '<div class="reply">',
					'after'     => '</div>'
				) ) );
				?>
			</div><!-- .comment-metadata -->
		</article><!-- .comment-body -->
<?php
}

if( !function_exists('hashone_home_section') ){
	function hashone_home_section(){
		$hashone_home_sections = apply_filters('hashone_home_sections',
		array(
			'slider',
			'about',
			'feature',
			'portfolio',
			'service',
			'team',
			'counter',
			'logo',
			'testimonial',
			'blog',
			'contact'
			)
		);

		return $hashone_home_sections;
	}
}