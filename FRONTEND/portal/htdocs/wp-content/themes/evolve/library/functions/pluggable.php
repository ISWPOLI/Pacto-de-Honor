<?php

/**
 * Pluggable - evolve pluggable functions.
 *
 * These functions can be replaced via styles/plugins. If styles/plugins do
 * not redefine these functions, then these will be used instead.
 *
 * @package WPevolve
 * @subpackage Core
 */
/**
 * evolve_comment_name() - short description
 *
 * @since 0.3
 */
if (!function_exists('evolve_comment_name')):

    function evolve_comment_name() {
        $commenter = get_comment_author_link(); // Get comentor's details
        return "<cite class=\"commenter fn n\">{$commenter}</cite>"; // Commentor vcard
    }

endif;

/**
 * evolve_comment_avatar() - short description
 *
 * @since 0.3
 */
if (!function_exists('evolve_comment_avatar')):

    function evolve_comment_avatar() {
        global $default;
        $gravatar_email = get_comment_author_email();
        $author = get_comment_author();
        $output = get_avatar($gravatar_email, 45, $default, $author);

        if (get_option('show_avatars')) {  // Avatars enabled?
            return apply_filters('evolve_comment_avatar', (string) $output); // Available filter: evolve_comment_avatar
        }
    }

endif;

/**
 * evolve_comment_date() - short description
 *
 * @since 0.3.1
 */
if (!function_exists('evolve_comment_date')):

    function evolve_comment_date() {
        $date = '<span class="comment-date">';
        $date .= get_comment_date();
        $date .= '</span>' . "\n";
        return apply_filters('evolve_comment_date', (string) $date); // Available filter: evolve_comment_date
    }

endif;

/**
 * evolve_comment_time() - short description
 *
 * @since 0.3.1
 */
if (!function_exists('evolve_comment_time')):

    function evolve_comment_time() {
        $time = '<span class="comment-date">';
        $time .= get_comment_time();
        $time .= '</span>' . "\n";
        return apply_filters('evolve_comment_time', (string) $time); // Available filter: evolve_comment_time
    }

endif;

/**
 * evolve_comment_link() - short description
 *
 * @since 0.3.1
 */
if (!function_exists('evolve_comment_link')):

    function evolve_comment_link() {
        $link = '<span class="comment-permalink">';
        $link .= '<a rel="bookmark" title="' . __('Permalink to this comment', 'evolve') . '" href="' . htmlspecialchars(get_comment_link()) . '">';
        $link .= apply_filters('evolve_comment_link_text', (string) '<i class="t4p-icon-link"></i>');
        $link .= '</a></span>' . "\n";
        return apply_filters('evolve_comment_link', (string) $link); // Available filter: evolve_comment_link
    }

endif;

/**
 * evolve_comment_edit() - short description
 *
 * @since 0.3.1
 */
if (!function_exists('evolve_comment_edit')):

    function evolve_comment_edit() {
        ob_start();
        edit_comment_link(__('EDIT', 'evolve'), '<span class="edit-comment">', '</span>');
        return ob_get_clean();
    }

endif;

/**
 * evolve_comment_reply() - short description
 *
 * @since - 0.3.1
 */
if (!function_exists('evolve_comment_reply')):

    function evolve_comment_reply($return = false) {
        global $comment_depth;
        $max_depth = get_option('thread_comments_depth');
        $reply_text = apply_filters('evolve_reply_text', (string) 'Reply'); // Available filter: evolve_reply_text
        $login_text = apply_filters('evolve_login_text', (string) 'Log in to reply.'); // Available filter: evolve_login_text
        if (( get_option('thread_comments') ) && get_comment_type() == 'comment') {

            if ($return) {
                return get_comment_reply_link(array(
                    'reply_text' => $reply_text,
                    'login_text' => $login_text,
                    'depth' => $comment_depth,
                    'max_depth' => $max_depth,
                    'before' => '<span class="comment-reply">',
                    'after' => '</span>'
                ));
            } else {
                comment_reply_link(array(
                    'reply_text' => $reply_text,
                    'login_text' => $login_text,
                    'depth' => $comment_depth,
                    'max_depth' => $max_depth,
                    'before' => '<div class="comment-reply">',
                    'after' => '</div>'
                ));
            }
        }
    }

endif;



add_filter('wp_get_attachment_link', 'add_lighbox_rel');

function add_lighbox_rel($attachment_link) {
    if (strpos($attachment_link, 'a href') != false && strpos($attachment_link, 'img src') != false)
        $attachment_link = str_replace('a href', 'a rel="gallery" href', $attachment_link);
    return $attachment_link;
}
