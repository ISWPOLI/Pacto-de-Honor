<?php
/**
 * Replies Loop - Single Reply
 *
 * @package bbPress
 * @subpackage Theme
 */
?>

<div <?php bbp_reply_class(); ?>>

    <div class="bbp-reply-author">

        <?php
        do_action('bbp_theme_before_reply_author_details');

        bbp_reply_author_link(array('sep' => '', 'show_role' => true));
        ?>

        <div class="bbp-reply-post-date"><?php bbp_reply_post_date(); ?></div>

        <div class="bbps-post-count"><?php printf(__('Post count: %s', 'evolve'), bbp_get_user_reply_count_raw(bbp_get_reply_author_id())); ?></div>

        <?php
        if (bbp_is_user_keymaster()) :

            do_action('bbp_theme_before_reply_author_admin_details');
            ?>

            <div class="bbp-reply-ip"><?php bbp_author_ip(bbp_get_reply_id()); ?></div>

            <?php
            do_action('bbp_theme_after_reply_author_admin_details');

        endif;

        do_action('bbp_theme_after_reply_author_details');
        ?>

    </div><!-- .bbp-reply-author -->

    <div class="bbp-reply-content">

        <div id="post-<?php bbp_reply_id(); ?>" class="bbp-reply-header clearfix">

            <div class="bbp-meta">

                <?php if (bbp_is_single_user_replies()) : ?>

                    <span class="bbp-header">
                        <?php _e('in reply to: ', 'evolve'); ?>
                        <a class="bbp-topic-permalink" href="<?php bbp_topic_permalink(bbp_get_reply_topic_id()); ?>"><?php bbp_topic_title(bbp_get_reply_topic_id()); ?></a>
                    </span>

                <?php endif; ?>

                <a href="<?php bbp_reply_url(); ?>" class="bbp-reply-permalink">#<?php bbp_reply_id(); ?></a>

                <?php
                do_action('bbp_theme_before_reply_admin_links');

                bbp_reply_admin_links(array('after' => '<span class="admin_links_sep"> | </span></span>'));

                do_action('bbp_theme_after_reply_admin_links');
                ?>

            </div><!-- .bbp-meta -->

        </div><!-- #post-<?php bbp_reply_id(); ?> -->

        <div class="bbp-reply-entry">
            <?php
            do_action('bbp_theme_before_reply_content');

            bbp_reply_content();

            do_action('bbp_theme_after_reply_content');
            ?>
        </div>
        <div class="bbp-arrow"></div>

    </div><!-- .bbp-reply-content -->

</div><!-- .reply -->
