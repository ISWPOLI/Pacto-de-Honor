<?php
global $authordata;
$first = "";
$xyz = "";
$evolve_layout = evolve_get_option('evl_layout', '2cl');
$evolve_post_layout = evolve_get_option('evl_post_layout', 'two');
$evolve_nav_links = evolve_get_option('evl_nav_links', 'after');
$evolve_header_meta = evolve_get_option('evl_header_meta', 'single_archive');
$evolve_excerpt_thumbnail = evolve_get_option('evl_excerpt_thumbnail', '0');
$evolve_share_this = evolve_get_option('evl_share_this', 'single');
$evolve_post_links = evolve_get_option('evl_post_links', 'after');
$evolve_similar_posts = evolve_get_option('evl_similar_posts', 'disable');
$evolve_featured_images = evolve_get_option('evl_featured_images', '1');
$evolve_edit_post = evolve_get_option('evl_edit_post', '0');
$evolve_breadcrumbs = evolve_get_option('evl_breadcrumbs', '1');
$evolve_posts_excerpt_title_length = intval(evolve_get_option('evl_posts_excerpt_title_length', '40'));
?>

<!--BEGIN #primary .hfeed-->
<div id="primary" class="<?php evolve_layout_class($type = 1); ?>">

    <?php
    if ($evolve_breadcrumbs == "1"):
        if (!is_home() || !is_front_page()):
            evolve_breadcrumb();
        endif;
    endif;
    ?>

    <!-- 2 or 3 columns begin -->

    <?php
    if ($evolve_post_layout == "two" || $evolve_post_layout == "three") {

        $temp = $wp_query;
        $wp_query = null;
        $wp_query = new WP_Query();
        $wp_query->query('posts_per_page=6' . '&paged=' . $paged);

        if (($evolve_nav_links == "before") || ($evolve_nav_links == "both")) :
            ?>
            <span class="nav-top">
                <?php get_template_part('navigation', 'index'); ?>
            </span>
            <?php
        endif;

        while ($wp_query->have_posts()) : $wp_query->the_post();
            $first++;
            ?>

            <!--BEGIN .hentry-->
            <div id="post-<?php the_ID(); ?>" class="<?php
            semantic_entries();
            evolve_post_class($xyz);
            $xyz++;
            ?> margin-40">

                <?php if (($evolve_header_meta == "") || ($evolve_header_meta == "single_archive")) : ?>

                    <h2 class="entry-title">
                        <a href="<?php the_permalink() ?>" rel="bookmark" title="<?php _e('Permanent Link to ', 'evolve') . the_title(); ?>">
                            <?php
                            if (get_the_title()) {
                                $title = the_title('', '', false);
                                echo evolve_truncate($title, $evolve_posts_excerpt_title_length, '...');
                            }
                            ?>
                        </a>
                    </h2>

                    <!--BEGIN .entry-meta .entry-header-->
                    <div class="entry-meta entry-header">
                        <a href="<?php the_permalink() ?>"><span class="published updated"><?php the_time(get_option('date_format')); ?></span></a>
                        <span class="author vcard">
                            <?php _e('Written by', 'evolve'); ?> <strong><?php printf('<a class="url fn" href="' . get_author_posts_url($authordata->ID, $authordata->user_nicename) . '" title="' . sprintf('View all posts by %s', $authordata->display_name) . '">' . get_the_author() . '</a>') ?></strong>
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

                <?php else: ?>

                    <h1 class="entry-title">
                        <a href="<?php the_permalink(); ?>" rel="bookmark" title="<?php _e('Permanent Link to', 'evolve'); ?> <?php the_title(); ?>">
                            <?php
                            if (get_the_title()) {
                                $title = the_title('', '', false);
                                echo evolve_truncate($title, $evolve_posts_excerpt_title_length, '...');
                            }
                            ?>	
                        </a>
                    </h1>

                <?php endif; //if (($evolve_header_meta == "")    ?>

                <!--BEGIN .entry-content .article-->
                <div class="entry-content article">

                    <?php
                    if ($evolve_featured_images == "1") :

                        if (has_post_thumbnail()) :
                            ?>

                            <span class="thumbnail-post">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('post-thumbnail'); ?>
                                    <span class="mask">
                                        <span class="icon"></span>
                                    </span>
                                </a>
                            </span>

                            <?php
                        else: $image = evolve_get_first_image();

                            if ($image):
                                ?>

                                <span class="thumbnail-post">
                                    <a href="<?php the_permalink(); ?>"><img src="<?php echo $image; ?>" alt="<?php the_title(); ?>" />
                                        <span class="mask">
                                            <span class="icon"></span>
                                        </span>
                                    </a>
                                </span>

                            <?php else: ?>

                                <span class="thumbnail-post">
                                    <a href="<?php the_permalink(); ?>">
                                        <img src="<?php echo get_template_directory_uri() . '/assets/images/no-thumbnail.jpg'; ?>" alt="<?php the_title(); ?>" />
                                        <span class="mask">
                                            <span class="icon"></span>
                                        </span>
                                    </a>
                                </span>

                            <?php
                            endif; //if ($image):     

                        endif; //if (has_post_thumbnail()) :     

                    endif; //if ($evolve_featured_images == "1"):     

                    echo evolve_excerpt_max_charlength(350);
                    ?>

                    <div class="entry-meta entry-footer">                        

                        <a class="read-more btn t4p-button-default" href="<?php the_permalink(); ?>"><?php _e('Read More', 'evolve'); ?></a>

                        <?php if (comments_open()) : ?>
                            <span class="comment-count"><?php comments_popup_link(__('Leave a Comment', 'evolve'), __('1 Comment', 'evolve'), __('% Comments', 'evolve')); ?></span>
                        <?php endif; ?>

                    </div><!-- /.entry-meta -->

                    <div class="clearfix"></div>
                </div><!--END .entry-content .article-->

                <!--END .hentry-->
            </div>

            <?php
        endwhile;

        get_template_part('navigation', 'index');

        $wp_query = null;
        $wp_query = $temp;
        ?>


        <!-- 2 or 3 columns end -->


        <!-- 1 column begin -->


        <?php
    } else {

        $temp = $wp_query;
        $wp_query = null;
        $wp_query = new WP_Query();
        $default_posts_per_page = get_option('posts_per_page', 6);
        $wp_query->query("posts_per_page=$default_posts_per_page&paged=$paged");

        if (($evolve_nav_links == "before") || ($evolve_nav_links == "both")) :
            ?>
            <span class="nav-top">
                <?php get_template_part('navigation', 'index'); ?>
            </span>
            <?php
        endif;

        while ($wp_query->have_posts()) : $wp_query->the_post();
            $first++;
            ?>

            <!--BEGIN .hentry-->
            <div id="post-<?php the_ID(); ?>" class="<?php semantic_entries(); ?> <?php evolve_post_class_2(); ?>">

                <?php
                $evolve_header_meta = evolve_get_option('evl_header_meta', 'disable');
                if (($evolve_header_meta == "") || ($evolve_header_meta == "single_archive")) {
                    ?>

                    <h1 class="entry-title">
                        <a href="<?php the_permalink(); ?>" rel="bookmark" title="<?php _e('Permanent Link to', 'evolve'); ?> <?php the_title(); ?>">
                            <?php
                            if (get_the_title()) {
                                the_title();
                            }
                            ?>
                        </a>
                    </h1>

                    <!--BEGIN .entry-meta .entry-header-->
                    <div class="entry-meta entry-header">
                        <a href="<?php the_permalink() ?>"><span class="published updated"><?php the_time(get_option('date_format')); ?></span></a>

                        <?php if (comments_open()) : ?>
                            <span class="comment-count">
                                <a href="<?php comments_link(); ?>"><?php comments_popup_link(__('Leave a Comment', 'evolve'), __('1 Comment', 'evolve'), __('% Comments', 'evolve')); ?></a>
                            </span>
                        <?php endif; ?>

                        <span class="author vcard">
                            <?php
                            $evolve_author_avatar = evolve_get_option('evl_author_avatar', '0');
                            if ($evolve_author_avatar == "1") {
                                echo get_avatar(get_the_author_meta('email'), '30');
                            }

                            _e('Written by', 'evolve');
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

                    <h1 class="entry-title">
                        <a href="<?php the_permalink(); ?>" rel="bookmark" title="<?php _e('Permanent Link to', 'evolve'); ?> <?php the_title(); ?>">
                            <?php
                            if (get_the_title()) {
                                the_title();
                            }
                            ?>
                        </a>
                    </h1>
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
                    if ($evolve_featured_images == "1") {

                        if (has_post_thumbnail()) :
                            ?>

                            <span class="thumbnail-post">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('post-thumbnail'); ?>
                                    <span class="mask">
                                        <span class="icon"></span>
                                    </span>
                                </a>
                            </span>

                            <?php
                        else: $image = evolve_get_first_image();

                            if ($image):
                                ?>

                                <span class="thumbnail-post">
                                    <a href="<?php the_permalink(); ?>"><img src="<?php echo $image; ?>" alt="<?php the_title(); ?>" />
                                        <span class="mask">
                                            <span class="icon"></span>
                                        </span>
                                    </a>
                                </span>

                            <?php else: ?>

                                <span class="thumbnail-post">
                                    <a href="<?php the_permalink(); ?>">
                                        <img src="<?php echo get_template_directory_uri() . '/assets/images/no-thumbnail.jpg'; ?>" alt="<?php the_title(); ?>" />
                                        <span class="mask">
                                            <span class="icon"></span>
                                        </span>
                                    </a>
                                </span>

                            <?php
                            endif; //if ($image):     

                        endif; //if (has_post_thumbnail()) : 
                    }

                    if (($evolve_excerpt_thumbnail == "1")) :

                        the_excerpt();
                        ?>

                        <a class="read-more btn t4p-button-default" href="<?php the_permalink(); ?>"><?php _e('Read More', 'evolve'); ?></a>

                        <?php
                    else:

                        the_content(__('Read More &raquo;', 'evolve'));

                        wp_link_pages(array('before' => '<div id="page-links"><p><strong>' . __('Pages', 'evolve') . ':</strong>', 'after' => '</p></div>'));

                    endif;
                    ?>

                    <!--END .entry-content .article-->
                    <div class="clearfix"></div>
                </div>

                <!--BEGIN .entry-meta .entry-footer-->
                <div class="entry-meta entry-footer row">

                    <div class="col-md-6">
                        <?php if (evolve_get_terms('cats')) { ?>
                            <div class="entry-categories"> <?php echo evolve_get_terms('cats'); ?></div>
                            <?php
                        }
                        if (evolve_get_terms('tags')) {
                            ?>
                            <div class="entry-tags"> <?php echo evolve_get_terms('tags'); ?></div>
                        <?php } ?>

                        <!--END .entry-meta .entry-footer-->
                    </div>

                    <div class="col-md-6">
                        <?php
                        if (($evolve_share_this == "single_archive") || ($evolve_share_this == "all")) {
                            evolve_sharethis();
                        } else {
                            ?> <div class="margin-40"></div> 
                        <?php } ?>
                    </div>
                </div>

                <!--END .hentry-->
            </div>

            <?php
            comments_template();

        endwhile;

        if (($evolve_nav_links == "") || ($evolve_nav_links == "after") || ($evolve_nav_links == "both")) {

            get_template_part('navigation', 'index');
        } else {
            
        }

        $wp_query = null;
        $wp_query = $temp;
    }
    ?>

    <!-- 1 column end -->

    <!--END #primary .hfeed-->
</div>
