<?php
/*
 *
 * Template: 404.php
 *
 */
get_header();
$xyz = "";
$evolve_layout = evolve_get_option('evl_layout', '2cl');
$evolve_post_layout = evolve_get_option('evl_post_layout', 'two');
$evolve_nav_links = evolve_get_option('evl_nav_links', 'after');
$evolve_header_meta = evolve_get_option('evl_header_meta', 'single_archive');
$evolve_category_page_title = evolve_get_option('evl_category_page_title', '1');
$evolve_excerpt_thumbnail = evolve_get_option('evl_excerpt_thumbnail', '0');
$evolve_share_this = evolve_get_option('evl_share_this', 'single');
$evolve_post_links = evolve_get_option('evl_post_links', 'after');
$evolve_similar_posts = evolve_get_option('evl_similar_posts', 'disable');
$evolve_featured_images = evolve_get_option('evl_featured_images', '1');
$evolve_thumbnail_default_images = evolve_get_option('evl_thumbnail_default_images', '0');
$evolve_posts_excerpt_title_length = intval(evolve_get_option('evl_posts_excerpt_title_length', '40'));
$evolve_blog_featured_image = evolve_get_option('evl_blog_featured_image', '0');
if (evolve_lets_get_sidebar_2() == true):
    get_sidebar('2');
endif;
?>

<!--BEGIN #primary .hfeed-->
<div id="primary" class="<?php evolve_layout_class($type = 1); ?>">

    <?php
    $evolve_breadcrumbs = evolve_get_option('evl_breadcrumbs', '1');
    if ($evolve_breadcrumbs == "1"):
        if (is_home() || is_front_page()):
        elseif ((is_single() && get_post_meta($post->ID, 'evolve_page_breadcrumb', true) == 'no') || (is_page() && get_post_meta($post->ID, 'evolve_page_breadcrumb', true) == 'no')):
        else:evolve_breadcrumb();
        endif;
    endif;
    ?>

    <!--BEGIN #post-0-->
    <div id="post-0">
        <h1 class="entry-title"><?php _e('Not Found', 'evolve'); ?></h1>
        <!--BEGIN .entry-content-->
        <div class="entry-content">
            <p><?php _e('Sorry, but you are looking for something that isn\'t here.', 'evolve'); ?></p>
            <form role="search" method="get" action="<?php echo home_url('/'); ?>">
                <input type="search" id="search-text" placeholder="<?php echo _e('Search ...', 'evolve') ?>" value="<?php echo esc_attr(get_search_query()) ?>" name="s" title="<?php echo _e('Type and Hit Enter ...', 'evolve') ?>" />
            </form>
        </div><!-- .header_search_menu -->
        <!--END .entry-content-->
    </div>
    <!--END #post-0-->

    <!--END #primary .hfeed-->
</div>

<?php
if (evolve_lets_get_sidebar() == true):
    get_sidebar();
endif;

get_footer();
