<?php
/*
 * 
 * Template: attachment.php
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
$evolve_edit_post = evolve_get_option('evl_edit_post', '0');
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


    <!-- attachment begin -->
    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>

            <!--BEGIN .hentry-->
            <div id="post-<?php the_ID(); ?>" class="<?php semantic_entries(); ?>">

                <?php if (($evolve_header_meta == "") || ($evolve_header_meta == "single_archive")) {
                    ?>
                    <h1 class="entry-title"><a href="<?php echo get_permalink($post->post_parent); ?>" rev="attachment" class="attach-font"><?php echo get_the_title($post->post_parent); ?></a> &raquo; <?php
                        if (get_the_title()) {
                            the_title();
                        }
                        ?>
                    </h1>

                    <!--BEGIN .entry-meta .entry-header-->
                    <div class="entry-meta entry-header">
                        <a href="<?php the_permalink() ?>"><span class="published updated"><?php the_time(get_option('date_format')); ?></span></a>

                        <?php if (comments_open()) : ?>
                            <span class="comment-count"><?php comments_popup_link(__('Leave a Comment', 'evolve'), __('1 Comment', 'evolve'), __('% Comments', 'evolve')); ?></span>
                            <?php
                        else : // comments are closed
                        endif;
                        ?>

                        <span class="author vcard">
                            <?php
                            $evolve_author_avatar = evolve_get_option('evl_author_avatar', '0');
                            if ($evolve_author_avatar == "1") {
                                echo get_avatar(get_the_author_meta('email'), '30');
                            }

                            _e('By', 'evolve');
                            ?> <strong><?php printf('<a class="url fn" href="' . get_author_posts_url($authordata->ID, $authordata->user_nicename) . '" title="' . sprintf('View all posts by %s', $authordata->display_name) . '">' . get_the_author() . '</a>') ?></strong>
                        </span>
                        <?php
                        if ($evolve_edit_post == "1") {
                            if (current_user_can('edit_post', $post->ID)):
                                edit_post_link(__('EDIT', 'evolve'), '<span class="edit-post">', '</span>');
                            endif;
                        }
                        ?>
                        <!--END .entry-meta .entry-header-->
                    </div>

        <?php } else { ?>

                    <h1 class="entry-title"><a href="<?php echo get_permalink($post->post_parent); ?>" rev="attachment"><?php echo get_the_title($post->post_parent); ?></a> &raquo; <?php the_title(); ?></h1>

                    <?php
                    if ($evolve_edit_post == "1") {
                        if (current_user_can('edit_post', $post->ID)):
                            edit_post_link(__('EDIT', 'evolve'), '<span class="edit-post edit-attach">', '</span>');
                        endif;
                    }
                }
                ?>

                <!--BEGIN .entry-content .article-->
                <div class="entry-content article">

                    <?php
                    if (wp_attachment_is_image()) :

                        $attachments = array_values(get_children(array('post_parent' => $post->post_parent, 'post_status' => 'inherit', 'post_type' => 'attachment', 'post_mime_type' => 'image', 'order' => 'ASC', 'orderby' => 'menu_order ID')));
                        foreach ($attachments as $k => $attachment) {
                            if ($attachment->ID == $post->ID)
                                break;
                        }
                        $k++;
                        // If there is more than 1 image attachment in a gallery
                        if (count($attachments) > 1) {
                            if (isset($attachments[$k]))
                            // get the URL of the next image attachment
                                $next_attachment_url = get_attachment_link($attachments[$k]->ID);
                            else
                            // or get the URL of the first image attachment
                                $next_attachment_url = get_attachment_link($attachments[0]->ID);
                        } else {
                            // or, if there's only 1 image attachment, get the URL of the image
                            $next_attachment_url = wp_get_attachment_url();
                        }
                        ?>
                        <p class="attachment" align="center">
                            <a href="<?php echo wp_get_attachment_url(); ?>" title="<?php echo esc_attr(get_the_title()); ?>" class="single-gallery-image" rel='prettyPhoto'>
            <?php echo wp_get_attachment_image($post->ID, $size = 'large'); // filterable image width with, essentially, no limit for image height.      ?>
                            </a>
                        </p>
                        <div class="navigation-links single-page-navigation clearfix row">
                            <div class="col-sm-6 col-md-6 nav-previous"><?php previous_image_link(false, '<div class="btn btn-left icon-arrow-left icon-big">Previous Image</div>'); ?></div>
                            <div class="col-sm-6 col-md-6 nav-next"><?php next_image_link(false, '<div class="btn btn-right icon-arrow-right icon-big">Next Image</div>'); ?></div>
                            <!--END .navigation-links-->
                        </div>

        <?php else : ?>

                        <a href="<?php echo wp_get_attachment_url(); ?>" title="<?php echo esc_attr(get_the_title()); ?>" rel="attachment"><?php echo basename(get_permalink()); ?></a>

        <?php endif; ?>

                    <div class="entry-caption"><?php if (!empty($post->post_excerpt)) the_excerpt(); ?></div>

                    <div class="clearfix"></div>

                </div><!--END .entry-content .article-->

                <!--END .hentry-->
            </div>

            <?php
            if (($evolve_share_this == "single_archive") || ($evolve_share_this == "all")) {
                evolve_sharethis();
            } else {
                ?> <div class="margin-40"></div> 
                <?php
            }

            comments_template('', true);

        endwhile;
    endif;
    ?>

    <!--END #primary .hfeed-->
</div>

<?php
if (evolve_lets_get_sidebar() == true):
    get_sidebar();
endif;

get_footer();
