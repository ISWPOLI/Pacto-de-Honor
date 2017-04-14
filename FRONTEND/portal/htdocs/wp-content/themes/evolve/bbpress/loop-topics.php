<?php
/**
 * Topics Loop
 *
 * @package bbPress
 * @subpackage Theme
 */
do_action('bbp_template_before_topics_loop');
?>

<ul id="bbp-forum-<?php bbp_forum_id(); ?>" class="bbp-topics">

    <li class="bbp-header">

        <ul class="forum-titles">
            <li class="bbp-topic-title"><?php _e('Topic', 'evolve'); ?></li>
            <li class="bbp-topic-voice-count"><?php _e('Voices', 'evolve'); ?></li>
            <li class="bbp-topic-reply-count"><?php bbp_show_lead_topic() ? _e('Replies', 'evolve') : _e('Posts', 'evolve'); ?></li>
            <li class="bbp-topic-freshness"><?php _e('Freshness', 'evolve'); ?></li>
        </ul>

    </li>

    <li class="bbp-body">

        <?php
        while (bbp_topics()) : bbp_the_topic();

            bbp_get_template_part('loop', 'single-topic');

        endwhile;
        ?>

    </li>

</ul><!-- #bbp-forum-<?php bbp_forum_id(); ?> -->

<?php
do_action('bbp_template_after_topics_loop');
