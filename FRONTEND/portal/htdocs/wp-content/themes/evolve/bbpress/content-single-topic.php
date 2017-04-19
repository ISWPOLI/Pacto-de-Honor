<?php
/**
 * Single Topic Content Part
 *
 * @package bbPress
 * @subpackage Theme
 */
?>

<div id="bbpress-forums">

    <?php
    $evolve_breadcrumbs = evolve_get_option('evl_breadcrumbs', '1');
    if ($evolve_breadcrumbs == "1"):
        bbp_breadcrumb();
    endif;

    if (bbp_allow_search()) :
        ?>

        <div class="bbp-search-form">

            <?php bbp_get_template_part('form', 'search'); ?>

        </div>

        <?php
    endif;

    do_action('bbp_template_before_single_topic');

    if (post_password_required()) :

        bbp_get_template_part('form', 'protected');

    else :

        bbp_topic_tag_list(bbp_get_topic_id(), array('before' => '<div class="bbp-topic-tags"><p>' . esc_html__('Tags:', 'evolve') . '&nbsp;', 'sep' => ' ', 'after' => '</p></div>'));

        if (bbp_show_lead_topic()) :

            bbp_get_template_part('content', 'single-topic-lead');

        endif;

        if (bbp_has_replies()) :
            ?>
            <div class="top_pagination">
                <?php bbp_get_template_part('pagination', 'replies'); ?>
            </div>
            <?php
            bbp_get_template_part('loop', 'replies');

            bbp_get_template_part('pagination', 'replies');

        endif;

        bbp_get_template_part('form', 'reply');

    endif;

    do_action('bbp_template_after_single_topic');
    ?>

</div>
