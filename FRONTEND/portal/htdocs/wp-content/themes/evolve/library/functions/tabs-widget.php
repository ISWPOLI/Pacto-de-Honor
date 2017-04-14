<?php
add_action('widgets_init', 'evolve_tabs_load_widgets');

function evolve_tabs_load_widgets() {
    register_widget('evolve_Tabs_Widget');
}

class evolve_Tabs_Widget extends WP_Widget {

    function __construct() {
        parent::__construct(
                'evolve_tabs-widget', __('evolve: Tabs', 'evolve'), // Name
                array('classname' => 'evolve_tabs', 'description' => __('Popular posts, recent post and comments.', 'evolve'),) // Args
        );
    }

    function widget($args, $instance) {
        global $data, $post;

        extract($args);

        $posts = $instance['posts'];
        $comments = $instance['comments'];
        $tags_count = $instance['tags'];
        $show_popular_posts = isset($instance['show_popular_posts']) ? 'true' : 'false';
        $show_recent_posts = isset($instance['show_recent_posts']) ? 'true' : 'false';
        $show_comments = isset($instance['show_comments']) ? 'true' : 'false';
        $show_tags = isset($instance['show_tags']) ? 'true' : 'false';
        $orderby = $instance['orderby'];

        if (!$orderby) {
            $orderby = 'Highest Comments';
        }

        echo $before_widget;
        ?>
        <div class="tab-holder">
            <div class="tabs-wrapper">
                <ul id="tabs" class="tabset tabs">
                    <?php if ($show_popular_posts == 'true'): ?>
                        <li><a href="#tab-popular"><?php _e('Popular', 'evolve'); ?></a></li>
                        <?php
                    endif;
                    if ($show_recent_posts == 'true'):
                        ?>
                        <li><a href="#tab-recent"><?php _e('Recent', 'evolve'); ?></a></li>
                        <?php
                    endif;
                    if ($show_comments == 'true'):
                        ?>
                        <li><a href="#tab-comments"><?php _e('Comments', 'evolve'); ?></a></li>
                    <?php endif; ?>
                </ul>
                <div class="tab-box tabs-container">
                    <?php if ($show_popular_posts == 'true'): ?>
                        <div id="tab-popular" class="tab tab_content" style="display: none;">
                            <?php
                            if ($orderby == 'Highest Comments') {
                                $order_string = '&orderby=comment_count';
                            } else {
                                $order_string = '&meta_key=evolve_post_views_count&orderby=meta_value_num';
                            }
                            $popular_posts = new WP_Query('showposts=' . $posts . $order_string . '&order=DESC');
                            if ($popular_posts->have_posts()):
                                ?>
                                <ul class="news-list">
                                    <?php while ($popular_posts->have_posts()): $popular_posts->the_post(); ?>
                                        <li>
                                            <?php if (has_post_thumbnail()): ?>
                                                <div class="image">
                                                    <a href="<?php the_permalink(); ?>">
                                                        <?php the_post_thumbnail('tabs-img'); ?>
                                                    </a>
                                                </div>
                                            <?php endif; ?>
                                            <div class="post-holder">
                                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>

                                                <div class="meta">
                                                    <?php the_time(get_option('date_format')); ?>
                                                </div>
                                            </div>
                                        </li>
                                    <?php endwhile; ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                        <?php
                    endif;
                    if ($show_recent_posts == 'true'):
                        ?>
                        <div id="tab-recent" class="tab tab_content" style="display: none;">
                            <?php
                            $recent_posts = new WP_Query('showposts=' . $tags_count);
                            if ($recent_posts->have_posts()):
                                ?>
                                <ul class="news-list">
                                    <?php while ($recent_posts->have_posts()): $recent_posts->the_post(); ?>
                                        <li>
                                            <?php if (has_post_thumbnail()): ?>
                                                <div class="image">
                                                    <a href="<?php the_permalink(); ?>">
                                                        <?php the_post_thumbnail('tabs-img'); ?>
                                                    </a>
                                                </div>
                                            <?php endif; ?>
                                            <div class="post-holder">
                                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>

                                                <div class="meta">
                                                    <?php the_time(get_option('date_format')); ?>
                                                </div>
                                            </div>
                                        </li>
                                    <?php endwhile; ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                        <?php
                    endif;
                    if ($show_comments == 'true'):
                        ?>
                        <div id="tab-comments" class="tab tab_content" style="display: none;">
                            <ul class="news-list">
                                <?php
                                $number = $instance['comments'];
                                global $wpdb;
                                $recent_comments = "SELECT DISTINCT ID, post_title, post_password, comment_ID, comment_post_ID, comment_author, comment_author_email, comment_date_gmt, comment_approved, comment_type, comment_author_url, SUBSTRING(comment_content,1,110) AS com_excerpt FROM $wpdb->comments LEFT OUTER JOIN $wpdb->posts ON ($wpdb->comments.comment_post_ID = $wpdb->posts.ID) WHERE comment_approved = '1' AND comment_type = '' AND post_password = '' ORDER BY comment_date_gmt DESC LIMIT $number";
                                $the_comments = $wpdb->get_results($recent_comments);
                                foreach ($the_comments as $comment) {
                                    ?>
                                    <li>
                                        <div class="image">
                                            <?php echo get_avatar($comment, '50'); ?>
                                        </div>
                                        <div class="post-holder">
                                            <a class="comment-text-side" href="<?php echo get_permalink($comment->ID); ?>#comment-<?php echo $comment->comment_ID; ?>" title="<?php echo strip_tags($comment->comment_author); ?> on <?php echo $comment->post_title; ?>"><?php echo strip_tags($comment->comment_author); ?><?php _e(' says', 'evolve'); ?></a>

                                            <div class="meta">
                                                <?php echo evolve_truncate(strip_tags($comment->com_excerpt), 70); ?>
                                            </div>
                                        </div>
                                    </li>
                                <?php } ?>
                            </ul>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
        <?php
        echo $after_widget;
    }

    function update($new_instance, $old_instance) {
        $instance = $old_instance;

        $instance['posts'] = stripslashes(wp_filter_post_kses(addslashes($new_instance['posts'])));
        $instance['comments'] = stripslashes(wp_filter_post_kses(addslashes($new_instance['comments'])));
        $instance['tags'] = stripslashes(wp_filter_post_kses(addslashes($new_instance['tags'])));
        $instance['show_popular_posts'] = $new_instance['show_popular_posts'];
        $instance['show_recent_posts'] = $new_instance['show_recent_posts'];
        $instance['show_comments'] = $new_instance['show_comments'];
        $instance['show_tags'] = $new_instance['show_tags'];
        $instance['orderby'] = $new_instance['orderby'];

        return $instance;
    }

    function form($instance) {
        $defaults = array(
            'posts' => 3,
            'comments' => '3',
            'tags' => 3,
            'show_popular_posts' => 'on',
            'show_recent_posts' => 'on',
            'show_comments' => 'on',
            'show_tags' => 'on',
            'orderby' => 'Highest Comments'
        );
        $instance = wp_parse_args((array) $instance, $defaults);
        ?>
        <p>
            <label for="<?php echo $this->get_field_id('orderby'); ?>"><?php _e('Popular Posts Order By', 'evolve'); ?>:</label>
            <select id="<?php echo $this->get_field_id('orderby'); ?>" name="<?php echo $this->get_field_name('orderby'); ?>" class="widefat" style="width:100%;">
                <option <?php
                if ('Highest Comments' == $instance['orderby']) {
                    echo 'selected="selected"';
                }
                ?>><?php _e('Highest Comments', 'evolve'); ?></option>
                <option <?php
                if ('Highest Views' == $instance['orderby']) {
                    echo 'selected="selected"';
                }
                ?>><?php _e('Highest Views', 'evolve'); ?></option>
            </select>
        </p>
        <p>
            <label for="<?php echo $this->get_field_id('posts'); ?>"><?php _e('Number of popular posts', 'evolve'); ?>:</label>
            <input class="widefat" style="width: 30px;" id="<?php echo $this->get_field_id('posts'); ?>" name="<?php echo $this->get_field_name('posts'); ?>" value="<?php echo $instance['posts']; ?>"/>
        </p>
        <p>
            <label for="<?php echo $this->get_field_id('tags'); ?>"><?php _e('Number of recent posts', 'evolve'); ?>:</label>
            <input class="widefat" style="width: 30px;" id="<?php echo $this->get_field_id('tags'); ?>" name="<?php echo $this->get_field_name('tags'); ?>" value="<?php echo $instance['tags']; ?>"/>
        </p>
        <p>
            <label for="<?php echo $this->get_field_id('comments'); ?>"><?php _e('Number of comments', 'evolve'); ?>:</label>
            <input class="widefat" style="width: 30px;" id="<?php echo $this->get_field_id('comments'); ?>" name="<?php echo $this->get_field_name('comments'); ?>" value="<?php echo $instance['comments']; ?>"/>
        </p>
        <p>
            <input class="checkbox" type="checkbox" <?php checked($instance['show_popular_posts'], 'on'); ?> id="<?php echo $this->get_field_id('show_popular_posts'); ?>" name="<?php echo $this->get_field_name('show_popular_posts'); ?>"/>
            <label for="<?php echo $this->get_field_id('show_popular_posts'); ?>"><?php _e('Show popular posts', 'evolve'); ?></label>
        </p>
        <p>
            <input class="checkbox" type="checkbox" <?php checked($instance['show_recent_posts'], 'on'); ?> id="<?php echo $this->get_field_id('show_recent_posts'); ?>" name="<?php echo $this->get_field_name('show_recent_posts'); ?>"/>
            <label for="<?php echo $this->get_field_id('show_recent_posts'); ?>"><?php _e('Show recent posts', 'evolve'); ?></label>
        </p>
        <p>
            <input class="checkbox" type="checkbox" <?php checked($instance['show_comments'], 'on'); ?> id="<?php echo $this->get_field_id('show_comments'); ?>" name="<?php echo $this->get_field_name('show_comments'); ?>"/>
            <label for="<?php echo $this->get_field_id('show_comments'); ?>"><?php _e('Show comments', 'evolve'); ?></label>
        </p>
        <?php
    }

}
