<?php
get_header();
$evolve_layout = evolve_get_option('evl_layout', '2cl');
$evolve_post_layout = evolve_get_option('evl_post_layout', 'two');
if (evolve_lets_get_sidebar_2() == true):
    get_sidebar('2');
endif;
?>

<div id="primary" class="<?php evolve_layout_class($type = 2); ?>">

<?php if (have_posts()): the_post(); ?>

        <div id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <span class="entry-title" style="display: none;"><?php the_title(); ?></span>
            <span class="vcard" style="display: none;"><span class="vcard author"><span class="fn"><?php the_author_posts_link(); ?></span></span></span>

            <div class="post-content">
                <?php the_content();
                wp_link_pages(array('before' => '<div id="page-links"><p><strong>' . __('Pages', 'evolve') . ':</strong>', 'after' => '</p></div>'));
                ?>
            </div>    
        </div>

<?php endif; ?>

</div>
<?php
wp_reset_query();

if (evolve_lets_get_sidebar() == true):
    get_sidebar();
endif;

get_footer();
