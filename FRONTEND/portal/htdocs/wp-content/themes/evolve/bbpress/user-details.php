<?php
/**
 * User Details
 *
 * @package bbPress
 * @subpackage Theme
 */
do_action('bbp_template_before_user_details');

if (bbp_allow_search()) :
    ?>

    <div class="bbp-search-form">

        <?php bbp_get_template_part('form', 'search'); ?>

    </div>

<?php endif; ?>

<div id="bbp-single-user-details">
    <div id="bbp-user-avatar">

        <span class='vcard'>
            <a class="url fn n" href="<?php bbp_user_profile_url(); ?>" title="<?php bbp_displayed_user_field('display_name'); ?>" rel="me">
                <?php echo get_avatar(bbp_get_displayed_user_field('user_email', 'raw'), apply_filters('bbp_single_user_details_avatar_size', 100)); ?>
            </a>
        </span>

    </div><!-- #author-avatar -->

    <div id="bbp-user-navigation">
        <div class="first-col">
            <ul>
                <li class="<?php if (bbp_is_single_user_profile()) : ?>current<?php endif; ?>">
                    <span class="vcard bbp-user-profile-link">
                        <a class="url fn n" href="<?php bbp_user_profile_url(); ?>" title="<?php printf(esc_attr__("%s's Profile", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>" rel="me"><?php _e('Profile', 'evolve'); ?></a>
                    </span>
                </li>

                <li class="<?php if (bbp_is_single_user_topics()) : ?>current<?php endif; ?>">
                    <span class='bbp-user-topics-created-link'>
                        <a href="<?php bbp_user_topics_created_url(); ?>" title="<?php printf(esc_attr__("%s's Topics Started", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>"><?php _e('Topics Started', 'evolve'); ?></a>
                    </span>
                </li>

                <li class="<?php if (bbp_is_single_user_replies()) : ?>current<?php endif; ?>">
                    <span class='bbp-user-replies-created-link'>
                        <a href="<?php bbp_user_replies_created_url(); ?>" title="<?php printf(esc_attr__("%s's Replies Created", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>"><?php _e('Replies Created', 'evolve'); ?></a>
                    </span>
                </li>

            </ul>
        </div>
        <div class="second-col">
            <ul>
                <?php if (bbp_is_favorites_active()) : ?>
                    <li class="<?php if (bbp_is_favorites()) : ?>current<?php endif; ?>">
                        <span class="bbp-user-favorites-link">
                            <a href="<?php bbp_favorites_permalink(); ?>" title="<?php printf(esc_attr__("%s's Favorites", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>"><?php _e('Favorites', 'evolve'); ?></a>
                        </span>
                    </li>
                    <?php
                endif;

                if (bbp_is_user_home() || current_user_can('edit_users')) :

                    if (bbp_is_subscriptions_active()) :
                        ?>
                        <li class="<?php if (bbp_is_subscriptions()) : ?>current<?php endif; ?>">
                            <span class="bbp-user-subscriptions-link">
                                <a href="<?php bbp_subscriptions_permalink(); ?>" title="<?php printf(esc_attr__("%s's Subscriptions", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>"><?php _e('Subscriptions', 'evolve'); ?></a>
                            </span>
                        </li>
                    <?php endif; ?>

                    <li class="<?php if (bbp_is_single_user_edit()) : ?>current<?php endif; ?>">
                        <span class="bbp-user-edit-link">
                            <a href="<?php bbp_user_profile_edit_url(); ?>" title="<?php printf(esc_attr__("Edit %s's Profile", 'evolve'), bbp_get_displayed_user_field('display_name')); ?>"><?php _e('Edit', 'evolve'); ?></a>
                        </span>
                    </li>

                <?php endif; ?>

            </ul>
        </div>
    </div><!-- #bbp-user-navigation -->
</div><!-- #bbp-single-user-details -->

<?php
do_action('bbp_template_after_user_details');
