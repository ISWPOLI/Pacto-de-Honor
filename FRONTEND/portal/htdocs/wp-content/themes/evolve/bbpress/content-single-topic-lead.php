<?php
/**
 * Single Topic Lead Content Part
 *
 * @package bbPress
 * @subpackage Theme
 */
do_action('bbp_template_before_lead_topic');
?>

<ul id="bbp-topic-<?php bbp_topic_id(); ?>-lead" class="bbp-lead-topic">

    <li class="bbp-header">

        <div class="bbp-topic-author"><?php _e('Creator', 'evolve'); ?></div><!-- .bbp-topic-author -->

        <div class="bbp-topic-content">

            <?php
            _e('Topic', 'evolve');

            bbp_user_subscribe_link();

            bbp_user_favorites_link();
            ?>

        </div><!-- .bbp-topic-content -->

    </li><!-- .bbp-header -->

    <li class="bbp-body">

        <div class="bbp-topic-header">

            <div class="bbp-meta">

                <span class="bbp-topic-post-date"><?php bbp_topic_post_date(); ?></span>

                <a href="<?php bbp_topic_permalink(); ?>" class="bbp-topic-permalink">#<?php bbp_topic_id(); ?></a>

                <?php
                do_action('bbp_theme_before_topic_admin_links');

                bbp_topic_admin_links();

                do_action('bbp_theme_after_topic_admin_links');
                ?>

            </div><!-- .bbp-meta -->

        </div><!-- .bbp-topic-header -->

        <div id="post-<?php bbp_topic_id(); ?>" <?php bbp_topic_class(); ?>>

            <div class="bbp-topic-author">

                <?php
                do_action('bbp_theme_before_topic_author_details');

                bbp_topic_author_link(array('sep' => '<br />', 'show_role' => true));

                if (bbp_is_user_keymaster()) :

                    do_action('bbp_theme_before_topic_author_admin_details');
                    ?>

                    <div class="bbp-topic-ip"><?php bbp_author_ip(bbp_get_topic_id()); ?></div>

                    <?php
                    do_action('bbp_theme_after_topic_author_admin_details');

                endif;

                do_action('bbp_theme_after_topic_author_details');
                ?>

            </div><!-- .bbp-topic-author -->

            <div class="bbp-topic-content">

                <?php
                do_action('bbp_theme_before_topic_content');

                bbp_topic_content();

                do_action('bbp_theme_after_topic_content');
                ?>

            </div><!-- .bbp-topic-content -->

        </div><!-- #post-<?php bbp_topic_id(); ?> -->

    </li><!-- .bbp-body -->

    <li class="bbp-footer">

        <div class="bbp-topic-author"><?php _e('Creator', 'evolve'); ?></div>

        <div class="bbp-topic-content">

            <?php _e('Topic', 'evolve'); ?>

        </div><!-- .bbp-topic-content -->

    </li>

</ul><!-- #bbp-topic-<?php bbp_topic_id(); ?>-lead -->

<?php
do_action('bbp_template_after_lead_topic');
