<?php
/**
 * Replies Loop
 *
 * @package bbPress
 * @subpackage Theme
 */
do_action('bbp_template_before_replies_loop');
?>


<div class="bbp-header">

    <div class="bbp-reply-favs">

        <?php
        if (!bbp_show_lead_topic()) :

            bbp_user_favorites_link();

            bbp_user_subscribe_link();

        else :

            _e('Replies', 'evolve');

        endif;
        ?>

    </div><!-- .bbp-reply-content -->

</div><!-- .bbp-header -->
<div class="clearfix"></div>

<ul id="topic-<?php bbp_topic_id(); ?>-replies" class="forums bbp-replies">

    <li class="bbp-body">

        <?php
        if (bbp_thread_replies()) :

            bbp_list_replies();

        else :

            while (bbp_replies()) : bbp_the_reply();

                bbp_get_template_part('loop', 'single-reply');

            endwhile;

        endif;
        ?>

    </li><!-- .bbp-body -->

</ul><!-- #topic-<?php bbp_topic_id(); ?>-replies -->

<?php
do_action('bbp_template_after_replies_loop');
