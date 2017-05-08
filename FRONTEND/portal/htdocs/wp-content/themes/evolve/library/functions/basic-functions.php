<?php
/* Theme Setup Functions */

function evolve_after_setup() {

    add_theme_support('automatic-feed-links');
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_image_size('post-thumbnail', 680, 330, true);
    add_image_size('slider-thumbnail', 400, 280, true);
    add_image_size('tabs-img', 50, 50, true);
    add_editor_style('editor-style.css');

    if (version_compare($GLOBALS['wp_version'], '4.1', '<')) :

        /**
         * Filters wp_title to print a neat <title> tag based on what is being viewed.
         *
         * @param string $title Default title text for current view.
         * @param string $sep   Optional separator.
         *
         * @return string The filtered title.
         */
        function evolve_wp_title($title, $sep) {
            if (is_feed()) {
                return $title;
            }
            global $page, $paged;

            // Add the blog name
            $title .= get_bloginfo('name', 'display');

            // Add the blog description for the home/front page.
            $site_description = get_bloginfo('description', 'display');
            if ($site_description && ( is_home() || is_front_page() )) {
                $title .= " $sep $site_description";
            }

            // Add a page number if necessary:
            if (( $paged >= 2 || $page >= 2 ) && !is_404()) {
                $title .= " $sep " . sprintf(__('Page %s', 'evolve'), max($paged, $page));
            }

            return $title;
        }

        add_filter('wp_title', 'evolve_wp_title', 10, 2);

        /**
         * Title shim for sites older than WordPress 4.1.
         *
         * @link https://make.wordpress.org/core/2014/10/29/title-tags-in-4-1/
         * @todo Remove this function when WordPress 4.3 is released.
         */
        function evolve_render_title() {
            ?>
            <title><?php wp_title('-', true, 'right'); ?></title>
            <?php
        }

        add_action('wp_head', 'evolve_render_title');
    endif;

    $evolve_width_px = evolve_get_option('evl_width_px', '1200');
    $evolve_width_px = apply_filters('evolve_header_image_width', $evolve_width_px);
//define( 'HEADER_IMAGE_WIDTH', apply_filters( 'evolve_header_image_width', $evolve_width_px ) );
//define( 'HEADER_IMAGE_HEIGHT', apply_filters( 'evolve_header_image_height', 170 ) );
//define( 'HEADER_TEXTCOLOR', '' );
//define( 'NO_HEADER_TEXT', true );
//mod by denzel, allow flexible width and flexible height.
    $args = array(
        'flex-width' => true,
        'width' => $evolve_width_px,
        'flex-height' => true,
        'height' => 200,
        'header-text' => false,
    );
    add_theme_support('custom-header', $args);


    $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');

    if ($evolve_width_layout == "fixed") {
        $defaults = array(
            'default-color' => 'e5e5e5',
            'default-image' => ''
        );
        add_theme_support('custom-background', $defaults);
    }

    add_theme_support('post-formats', array(
        'aside',
        'audio',
        'chat',
        'gallery',
        'image',
        'link',
        'quote',
        'status',
        'video'
    ));

    load_theme_textdomain('evolve', get_template_directory() . '/languages');

    register_nav_menu('primary-menu', __('Primary Menu', 'evolve'));

    $evolve_layout = evolve_get_option('evl_layout', '2cr');
    $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');

    global $content_width;

    if ($evolve_layout == "2cl" || $evolve_layout == "2cr") {
        if (!isset($content_width)) {
            $content_width = 610;
        }
    }
    if (( $evolve_layout == "3cl" || $evolve_layout == "3cr" ) ||
            ( $evolve_layout == "3cm" )
    ) {
        if (!isset($content_width)) {
            $content_width = 506;
        }
    }
    if ($evolve_layout == "1c") {
        if (!isset($content_width)) {
            $content_width = 955;
        }
    }
}

add_action('after_setup_theme', 'evolve_after_setup');

/**
 * bbPress Integration
 *
 * @since 3.1.5
 */

load_theme_textdomain('evolve', get_template_directory() . '/languages');

/**
 * Functions - Evolve gatekeeper
 * This file defines a few constants variables, loads up the core Evolve file,
 * and finally initialises the main WP Evolve Class.
 *
 * @package    EvoLve
 * @subpackage Functions
 */
/* Blast you red baron! Initialise WP Evolve */
get_template_part('library/evolve');
WPevolve::init();

get_template_part('library/functions/tabs-widget');

/* evolve_truncate */

function evolve_truncate($str, $length = 10, $trailing = '..') {
    $length -= mb_strlen($trailing);
    if (mb_strlen($str) > $length) {
        return mb_substr($str, 0, $length) . $trailing;
    } else {
        $res = $str;
    }

    return $res;
}

/* evolve_excerpt_max_charlength */

function evolve_excerpt_max_charlength($num) {
    $limit = $num + 1;
    $excerpt = explode(' ', get_the_excerpt(), $limit);
    array_pop($excerpt);
    $excerpt = implode(" ", $excerpt) . " [...]";
    echo $excerpt;
}

/* Get first image */

function evolve_get_first_image() {
    global $post, $posts;
    $first_img = '';
    $output = preg_match_all('/<img.+src=[\'"]([^\'"]+)[\'"].*>/i', $post->post_content, $matches);
    if (isset($matches[1][0])) {
        $first_img = $matches [1][0];

        return $first_img;
    }
}

// Tiny URL

function evolve_tinyurl($url) {
    $response = esc_url(wp_remote_retrieve_body(wp_remote_get('http://tinyurl.com/api-create.php?url=' . $url)));

    return $response;
}

// Similar Posts

function evolve_similar_posts() {

    $post = '';
    $orig_post = $post;
    global $post;
    $evolve_similar_posts = evolve_get_option('evl_similar_posts', 'disable');

    if ($evolve_similar_posts == "category") {
        $matchby = get_the_category($post->ID);
        $matchin = 'category';
    } else {
        $matchby = wp_get_post_tags($post->ID);
        $matchin = 'tag';
    }

    if ($matchby) {
        $matchby_ids = array();
        foreach ($matchby as $individual_matchby) {
            $matchby_ids[] = $individual_matchby->term_id;
        }

        $args = array(
            $matchin . '__in' => $matchby_ids,
            'post__not_in' => array($post->ID),
            'showposts' => 5, // Number of related posts that will be shown.
            'ignore_sticky_posts' => 1
        );

        $my_query = new wp_query($args);
        if ($my_query->have_posts()) {
            echo '<div class="similar-posts"><h5>' . __('Similar posts', 'evolve') . '</h5><ul>';
            while ($my_query->have_posts()) {
                $my_query->the_post();
                ?>
                <li>
                    <a href="<?php the_permalink() ?>" rel="bookmark" title="<?php _e('Permanent Link to', 'evolve'); ?> <?php the_title(); ?>">
                        <?php
                        if (get_the_title()) {
                            $title = the_title('', '', false);
                            $evolve_posts_excerpt_title_length = intval(evolve_get_option('evl_posts_excerpt_title_length', '40'));
                            echo evolve_truncate($title, $evolve_posts_excerpt_title_length, '...');
                        } else {
                            echo __("Untitled", "evolve");
                        }
                        ?>
                    </a>
                    <?php if (get_the_content()) { ?> &mdash;
                        <small><?php echo evolve_excerpt_max_charlength(60); ?></small> <?php } ?>
                </li>
                <?php
            }
            echo '</ul></div>';
        }
    }
    $post = $orig_post;
    wp_reset_query();
}

function evolve_footer_hooks() {

    if (is_page_template('contact.php')):
        $status_gmap = evolve_get_option('evl_status_gmap', '1');

        if ($status_gmap):

            $evolve_gmap_address = evolve_get_option('evl_gmap_address', 'Via dei Fori Imperiali');
            $evolve_gmap_type = evolve_get_option('evl_gmap_type', 'hybrid');
            $evolve_map_zoom_level = evolve_get_option('evl_map_zoom_level', '18');
            $evolve_map_scrollwheel = evolve_get_option('evl_map_scrollwheel', '0');
            $evolve_map_scale = evolve_get_option('evl_map_scale', '0');
            $evolve_map_zoomcontrol = evolve_get_option('evl_map_zoomcontrol', '0');
            $evolve_map_pin = evolve_get_option('evl_map_pin', '0');
            $evolve_map_pop = evolve_get_option('evl_map_popup', '0');
            $evolve_gmap_address = addslashes($evolve_gmap_address);
            $addresses = explode('|', $evolve_gmap_address);
            $markers = '';
            if ($evolve_map_pop == '0') {
                $map_popup = "false";
            } else {
                $map_popup = "true";
            }
            foreach ($addresses as $address_string) {
                $markers .= "{
			address: '{$address_string}',
			html: {
				content: '{$address_string}',
				popup: {$map_popup}
			}
		},";
            }
            ?>

            <script type='text/javascript'>
                jQuery(document).ready(
                        function($) {
                        jQuery('#gmap').goMap(
                        {
                        address: '<?php echo $addresses[0]; ?>',
                                maptype: '<?php echo $evolve_gmap_type; ?>',
                                zoom: <?php echo $evolve_map_zoom_level; ?>,
                                scrollwheel: <?php if ($evolve_map_scrollwheel): ?>false<?php else: ?>true<?php endif; ?>,
                                                    scaleControl: <?php if ($evolve_map_scale): ?>false<?php else: ?>true<?php endif; ?>,
                                                                        navigationControl: <?php if ($evolve_map_zoomcontrol): ?>false<?php else: ?>true<?php endif; ?>,
            <?php if (!$evolve_map_pin): ?>markers: [<?php echo $markers; ?>], <?php endif; ?>
                                    }
                            );
                        }
                );</script>
            <?php
        endif;
    endif;
    ?>

    <script type="text/javascript">
        var $jx = jQuery.noConflict();
        $jx("div.post").mouseover(
                function() {
                $jx(this).find("span.edit-post").css('visibility', 'visible');
                }
        ).mouseout(
                function() {
                $jx(this).find("span.edit-post").css('visibility', 'hidden');
                }
        );
        $jx("div.type-page").mouseover(
                function() {
                $jx(this).find("span.edit-page").css('visibility', 'visible');
                }
        ).mouseout(
                function() {
                $jx(this).find("span.edit-page").css('visibility', 'hidden');
                }
        );
        $jx("div.type-attachment").mouseover(
                function() {
                $jx(this).find("span.edit-post").css('visibility', 'visible');
                }
        ).mouseout(
                function() {
                $jx(this).find("span.edit-post").css('visibility', 'hidden');
                }
        );
        $jx("li.comment").mouseover(
                function() {
                $jx(this).find("span.edit-comment").css('visibility', 'visible');
                }
        ).mouseout(
                function() {
                $jx(this).find("span.edit-comment").css('visibility', 'hidden');
                }
        );</script>

    <?php
    $evolve_sticky_header = evolve_get_option('evl_sticky_header', '1');
    $page_ID = get_queried_object_id();
    $evolve_slider_position = evolve_get_option('evl_slider_position', 'below');
    if ($evolve_sticky_header == "1" && get_post_meta($page_ID, 'evolve_slider_position', true) == 'above' || (get_post_meta($page_ID, 'evolve_slider_position', true) == 'default' && $evolve_slider_position == 'above') || (is_home() && $evolve_slider_position == 'above')) {
        ?>

        <script type="text/javascript">
            jQuery(document).ready(
                    function ($) {
                        if (jQuery('.sticky-header').length >= 1) {
                            jQuery(window).scroll(function () {
                                var header = jQuery(document).scrollTop();
                                var headerHeight = jQuery('.sliderblock').height() + jQuery('.new-top-menu').height() + jQuery('.menu-header').height() + jQuery('.header-pattern').height();
                                if (header > headerHeight) {
                                    jQuery('.sticky-header').addClass('sticky');
                                    jQuery('.sticky-header').show();
                                } else {
                                    jQuery('.sticky-header').removeClass('sticky');
                                    jQuery('.sticky-header').hide();
                                }
                            });
                        }
                    }
            );</script>

        <?php
    } elseif ($evolve_sticky_header == "1") {
        ?>

        <script type="text/javascript">
            jQuery(document).ready(
                    function($) {
                    if (jQuery('.sticky-header').length >= 1) {
                    jQuery(window).scroll(function() {
                    var header = jQuery(document).scrollTop();
                    var headerHeight = jQuery('.new-top-menu').height() + jQuery('.menu-header').height() + jQuery('.header-pattern').height();
                    if (header > headerHeight) {
                    jQuery('.sticky-header').addClass('sticky');
                    jQuery('.sticky-header').show();
                    } else {
                    jQuery('.sticky-header').removeClass('sticky');
                    jQuery('.sticky-header').hide();
                    }
                    });
                    }
                    }
            );</script>

        <?php
    }

    $evolve_animatecss = evolve_get_option('evl_animatecss', '1');

    if ($evolve_animatecss == "1") {
        ?>

        <script type="text/javascript">
            /*----------------------------*/
            /* Animated Buttons
             /*----------------------------*/

            var $animated = jQuery.noConflict();
            $animated('.post-more').hover(
                    function () {
                        $animated(this).addClass('animated pulse')
                    },
                    function () {
                        $animated(this).removeClass('animated pulse')
                    }
            )
            $animated('.read-more').hover(
                    function () {
                        $animated(this).addClass('animated pulse')
                    },
                    function () {
                        $animated(this).removeClass('animated pulse')
                    }
            )
            $animated('#submit').hover(
                    function () {
                        $animated(this).addClass('animated pulse')
                    },
                    function () {
                        $animated(this).removeClass('animated pulse')
                    }
            )
            $animated('input[type="submit"]').hover(
                    function () {
                        $animated(this).addClass('animated pulse')
                    },
                    function () {
                        $animated(this).removeClass('animated pulse')
                    }
            )

        </script>

        <?php
    }

    $evolve_carousel_slider = evolve_get_option('evl_carousel_slider', '1');

    if ($evolve_carousel_slider == "1"):

        $evolve_carousel_speed = evolve_get_option('evl_carousel_speed', '3500');
        if (empty($evolve_carousel_speed)): $evolve_carousel_speed = '3500';
        endif;
        ?>

        <script type="text/javascript">
            /*----------------*/
            /* AnythingSlider
             /*----------------*/
            var $s = jQuery.noConflict();
            $s(
                    function() {
                    $s('#slides')
                            .anythingSlider({autoPlay: true, delay: <?php echo $evolve_carousel_speed; ?>, })
                    }
            )
        </script>

        <?php
    endif;

    $evolve_bootstrap_speed = evolve_get_option('evl_bootstrap_speed', '7000');
    if (empty($evolve_bootstrap_speed)): $evolve_bootstrap_speed = '7000';
    endif;

    $evolve_parallax_slider = evolve_get_option('evl_parallax_slider_support', '1');

    if ($evolve_parallax_slider == "1"):

        $evolve_parallax_speed = evolve_get_option('evl_parallax_speed', '4000');
        if (empty($evolve_parallax_speed)): $evolve_parallax_speed = '4000';
        endif;
        ?>
        <script type="text/javascript">
            /*----------------*/
            /* Parallax Slider
             /*----------------*/

            var $par = jQuery.noConflict();
            $par('#da-slider').cslider(
                    {
                        autoplay: true,
                        bgincrement: 450,
                        interval: <?php echo $evolve_parallax_speed; ?>
                    }
            );</script>

    <?php endif; ?>

    <script type="text/javascript">
        /*----------------------*/
        /* Bootstrap Slider
         /*---------------------*/

        var $carousel = jQuery.noConflict();
        $carousel('#myCarousel').carousel(
                {
                    interval: 7000
                }
        )

                $carousel('#carousel-nav a').click(
                function(q) {
                q.preventDefault();
                targetSlide = $carousel(this).attr('data-to') - 1;
                $carousel('#myCarousel').carousel(targetSlide);
                $carousel(this).addClass('active').siblings().removeClass('active');
                }
        );
        $carousel('#bootstrap-slider').carousel(
                {
                    interval: <?php echo $evolve_bootstrap_speed; ?>
                }
        )

        $carousel('#carousel-nav a').click(
                function (q) {
                    q.preventDefault();
                    targetSlide = $carousel(this).attr('data-to') - 1;
                    $carousel('#bootstrap-slider').carousel(targetSlide);
                    $carousel(this).addClass('active').siblings().removeClass('active');
                }
        );
    </script>

    <?php
}

function evolve_hexDarker($hex, $factor = 30) {
    $new_hex = '';

    // if hex code null than assign transparent for hide PHP warning /
    $hex = empty($hex) ? 'ransparent' : $hex;

    $base['R'] = hexdec($hex{0} . $hex{1});
    $base['G'] = hexdec($hex{2} . $hex{3});
    $base['B'] = hexdec($hex{4} . $hex{5});

    foreach ($base as $k => $v) {
        $amount = $v / 100;
        $amount = round($amount * $factor);
        $new_decimal = $v - $amount;

        $new_hex_component = dechex($new_decimal);
        if (strlen($new_hex_component) < 2) {
            $new_hex_component = "0" . $new_hex_component;
        }
        $new_hex .= $new_hex_component;
    }

    return $new_hex;
}

function evolve_enqueue_comment_reply() {
    if (is_singular() && comments_open() && get_option('thread_comments')) {
        wp_enqueue_script('comment-reply');
    }
}

add_action('wp_enqueue_scripts', 'evolve_enqueue_comment_reply');

// Share This Buttons

function evolve_sharethis() {
    global $post;
    $image_url = wp_get_attachment_url(get_post_thumbnail_id($post->ID));
    if (empty($image_url)) {
        $image_url = get_template_directory_uri() . '/assets/images/no-thumbnail.jpg';
    }
    ?>
    <div class="share-this">
        <a rel="nofollow" class="tipsytext" title="<?php _e('Share on Twitter', 'evolve'); ?>" target="_blank" href="http://twitter.com/intent/tweet?status=<?php the_title(); ?>+&raquo;+<?php echo esc_url(evolve_tinyurl(get_permalink())); ?>"><i class="t4p-icon-social-twitter"></i></a>
        <a rel="nofollow" class="tipsytext" title="<?php _e('Share on Facebook', 'evolve'); ?>" target="_blank" href="http://www.facebook.com/sharer/sharer.php?u=<?php the_permalink(); ?>&amp;t=<?php the_title(); ?>"><i class="t4p-icon-social-facebook"></i></a>
        <a rel="nofollow" class="tipsytext" title="<?php _e('Share on Google Plus', 'evolve'); ?>" target="_blank" href="https://plus.google.com/share?url=<?php the_permalink(); ?>"><i class="t4p-icon-social-google-plus"></i></a>
        <a rel="nofollow" class="tipsytext" title="<?php _e('Share on Pinterest', 'evolve'); ?>" target="_blank" href="http://pinterest.com/pin/create/button/?url=<?php the_permalink(); ?>&media=<?php echo $image_url; ?>&description=<?php the_title(); ?>"><i class="t4p-icon-social-pinterest"></i></a>			
        <a rel="nofollow" class="tipsytext" title="<?php _e('Share by Email', 'evolve'); ?>" target="_blank" href="http://www.addtoany.com/email?linkurl=<?php the_permalink(); ?>&linkname=<?php the_title(); ?>"><i class="t4p-icon-social-envelope-o"></i></a>
        <a rel="nofollow" class="tipsytext" title="<?php _e('More options', 'evolve'); ?>" target="_blank" href="http://www.addtoany.com/share_save#url=<?php the_permalink(); ?>&linkname=<?php the_title(); ?>"><i class="t4p-icon-redo"></i></a>
    </div>
    <?php
}

/* Bootstrap Slider */

function evolve_bootstrap() {
    global $evl_options;
    $wrap = false;
    for ($i = 1; $i <= 5; $i ++) {

        if ($evl_options["evl_bootstrap_slide{$i}"] == 1) {
            $active = "";
            if (!$wrap) {
                $wrap = true;
                echo "<div id='bootstrap-slider' class='carousel slide' data-ride='carousel'>";
                echo "<div class='carousel-inner'>";
                $active = " active";
            }

            echo "<div class='item" . $active . "'>";
            echo "<img class='img-responsive' src='" . $evl_options["evl_bootstrap_slide{$i}_img"]['url'] . "' alt='" . $evl_options["evl_bootstrap_slide{$i}_title"] . "' />";
            if (( strlen($evl_options["evl_bootstrap_slide{$i}_title"]) > 0 ) || ( strlen($evl_options["evl_bootstrap_slide{$i}_desc"]) > 0 )) {
                ?>    
                <div class="carousel-caption <?php echo evolve_bootstrap_layout_class(); ?>" >
                    <?php
                    if (strlen($evl_options["evl_bootstrap_slide{$i}_title"]) > 0) {
                        echo "<h2>" . esc_attr($evl_options["evl_bootstrap_slide{$i}_title"]) . "</h2>";
                    }

                    if (strlen($evl_options["evl_bootstrap_slide{$i}_desc"]) > 0) {
                        echo "<p>" . esc_attr($evl_options["evl_bootstrap_slide{$i}_desc"]) . "</p>";
                    }

                    echo do_shortcode($evl_options["evl_bootstrap_slide{$i}_button"]);

                    echo "</div>";
                }
                echo "</div>";
            }
        }

        if ($wrap) {
            echo "</div>
            <a class='left carousel-control' href='#bootstrap-slider' data-slide='prev'></a><a class='right carousel-control' href='#bootstrap-slider' data-slide='next'></a></div>";
        }
    }

    /* Function use for add css class in Bootstrap Slider */

    function evolve_bootstrap_layout_class() {
        $bootstrap_layout = '';

        $evolve_bootstrap_layout = evolve_get_option('evl_bootstrap_layout', 'bootstrap_left');

        if ($evolve_bootstrap_layout == "bootstrap_right") {
            $bootstrap_layout = 'layout-right';
        } elseif ($evolve_bootstrap_layout == "bootstrap_center") {
            $bootstrap_layout = 'layout-center';
        } else {
            $bootstrap_layout = 'layout-left';
        }

        return $bootstrap_layout;
    }

    /* Parallax Slider */

    function evolve_parallax() {
        global $evl_options;
        if ($evl_options['evl_show_slide1'] == "1" || $evl_options['evl_show_slide2'] == "1" || $evl_options['evl_show_slide3'] == "1" || $evl_options['evl_show_slide4'] == "1" || $evl_options['evl_show_slide5'] == "1") {
            echo "<div id='da-slider' class='da-slider'>";

            for ($i = 1; $i <= 5; $i++) {
                if ($evl_options["evl_show_slide{$i}"] == "1") {

                    echo "<div class='da-slide'>";

                    echo "<h2>" . esc_attr($evl_options["evl_slide{$i}_title"]) . "</h2>";

                    echo "<p>" . esc_attr($evl_options["evl_slide{$i}_desc"]) . "</p>";

                    echo do_shortcode($evl_options["evl_slide{$i}_button"]);

                    echo "<div class='da-img'><img class='img-responsive' src='" . $evl_options["evl_slide{$i}_img"]['url'] . "' alt='" . $evl_options["evl_slide{$i}_title"] . "' /></div>";

                    echo "</div>";
                }
            }

            echo "<nav class='da-arrows'><span class='da-arrows-prev'></span><span class='da-arrows-next'></span></nav></div>";
        }
    }

    /* Front Page Content Boxes */

    function evolve_content_boxes() {

        $evolve_content_boxes = evolve_get_option('evl_content_boxes', '1');
        $evolve_content_box1_enable = evolve_get_option('evl_content_box1_enable', '1');
        if ($evolve_content_box1_enable === false) {
            $evolve_content_box1_enable = '';
        }
        $evolve_content_box2_enable = evolve_get_option('evl_content_box2_enable', '1');
        if ($evolve_content_box2_enable === false) {
            $evolve_content_box2_enable = '';
        }
        $evolve_content_box3_enable = evolve_get_option('evl_content_box3_enable', '1');
        if ($evolve_content_box3_enable === false) {
            $evolve_content_box3_enable = '';
        }
        $evolve_content_box4_enable = evolve_get_option('evl_content_box4_enable', '1');
        if ($evolve_content_box4_enable === false) {
            $evolve_content_box4_enable = '';
        }
        if ($evolve_content_boxes == "1") {

            echo "<div class='home-content-boxes'><div class='row'>";

            $evolve_content_box1_title = evolve_get_option('evl_content_box1_title', 'Beautifully Simple');
            if ($evolve_content_box1_title === false) {
                $evolve_content_box1_title = '';
            }
            $evolve_content_box1_desc = evolve_get_option('evl_content_box1_desc', 'Clean modern theme with smooth and pixel perfect design focused on details');
            if ($evolve_content_box1_desc === false) {
                $evolve_content_box1_desc = '';
            }
            $evolve_content_box1_button = evolve_get_option('evl_content_box1_button', '<a class="read-more btn t4p-button" href="#">Learn more</a>');
            if ($evolve_content_box1_button === false) {
                $evolve_content_box1_button = '';
            }
            $evolve_content_box1_icon = evolve_get_option('evl_content_box1_icon', 'fa-cube');
            if ($evolve_content_box1_icon === false) {
                $evolve_content_box1_icon = '';
            }

            /**
             * Count how many boxes are enabled on frontpage
             * Apply proper responsivity class
             *
             * @since 3.1.5
             */
            $BoxCount = 0; // Box Counter

            if ($evolve_content_box1_enable == true) {
                $BoxCount ++;
            }
            if ($evolve_content_box2_enable == true) {
                $BoxCount ++;
            }
            if ($evolve_content_box3_enable == true) {
                $BoxCount ++;
            }
            if ($evolve_content_box4_enable == true) {
                $BoxCount ++;
            }

            switch ($BoxCount):
                case $BoxCount == 1:
                    $BoxClass = 'col-md-12';
                    break;

                case $BoxCount == 2:
                    $BoxClass = 'col-md-6';
                    break;

                case $BoxCount == 3:
                    $BoxClass = 'col-md-4';
                    break;

                case $BoxCount == 4:
                    $BoxClass = 'col-md-3';
                    break;

                default:
                    $BoxClass = 'col-md-3';
            endswitch;

            if ($evolve_content_box1_enable == true) {

                echo "<div class='col-sm-12 $BoxClass content-box content-box-1'>";

                echo "<i class='fa " . $evolve_content_box1_icon . "'></i>";

                echo "<h2>" . esc_attr($evolve_content_box1_title) . "</h2>";

                echo "<p>" . do_shortcode($evolve_content_box1_desc) . "</p>";

                echo "<div class='cntbox_btn sbtn1'>" . do_shortcode($evolve_content_box1_button) . "</div>";

                echo "</div>";
            }

            $evolve_content_box2_title = evolve_get_option('evl_content_box2_title', 'Easy Customizable');
            if ($evolve_content_box2_title === false) {
                $evolve_content_box2_title = '';
            }
            $evolve_content_box2_desc = evolve_get_option('evl_content_box2_desc', 'Over a hundred theme options ready to make your website unique');
            if ($evolve_content_box2_desc === false) {
                $evolve_content_box2_desc = '';
            }
            $evolve_content_box2_button = evolve_get_option('evl_content_box2_button', '<a class="read-more btn t4p-button" href="#">Learn more</a>');
            if ($evolve_content_box2_button === false) {
                $evolve_content_box2_button = '';
            }
            $evolve_content_box2_icon = evolve_get_option('evl_content_box2_icon', 'fa-circle-o-notch');
            if ($evolve_content_box2_icon === false) {
                $evolve_content_box2_icon = '';
            }

            if ($evolve_content_box2_enable == true) {

                echo "<div class='col-sm-12 $BoxClass content-box content-box-2'>";

                echo "<i class='fa " . $evolve_content_box2_icon . "'></i>";

                echo "<h2>" . esc_attr($evolve_content_box2_title) . "</h2>";

                echo "<p>" . do_shortcode($evolve_content_box2_desc) . "</p>";

                echo "<div class='cntbox_btn sbtn2'>" . do_shortcode($evolve_content_box2_button) . "</div>";

                echo "</div>";
            }


            $evolve_content_box3_title = evolve_get_option('evl_content_box3_title', 'Contact Form Ready');
            if ($evolve_content_box3_title === false) {
                $evolve_content_box3_title = '';
            }
            $evolve_content_box3_desc = evolve_get_option('evl_content_box3_desc', 'Built-In Contact Page with Google Maps is a standard for this theme');
            if ($evolve_content_box3_desc === false) {
                $evolve_content_box3_desc = '';
            }
            $evolve_content_box3_button = evolve_get_option('evl_content_box3_button', '<a class="read-more btn t4p-button" href="#">Learn more</a>');
            if ($evolve_content_box3_button === false) {
                $evolve_content_box3_button = '';
            }
            $evolve_content_box3_icon = evolve_get_option('evl_content_box3_icon', 'fa-send');
            if ($evolve_content_box3_icon === false) {
                $evolve_content_box3_icon = '';
            }

            if ($evolve_content_box3_enable == true) {

                echo "<div class='col-sm-12 $BoxClass content-box content-box-3'>";

                echo "<i class='fa " . $evolve_content_box3_icon . "'></i>";

                echo "<h2>" . esc_attr($evolve_content_box3_title) . "</h2>";

                echo "<p>" . do_shortcode($evolve_content_box3_desc) . "</p>";

                echo "<div class='cntbox_btn sbtn3'>" . do_shortcode($evolve_content_box3_button) . "</div>";

                echo "</div>";
            }

            $evolve_content_box4_title = evolve_get_option('evl_content_box4_title', 'Modern Blog Layouts');
            if ($evolve_content_box4_title === false) {
                $evolve_content_box4_title = '';
            }
            $evolve_content_box4_desc = evolve_get_option('evl_content_box4_desc', 'Up to 3 Blog Layouts, responsive on all media devices');
            if ($evolve_content_box4_desc === false) {
                $evolve_content_box4_desc = '';
            }
            $evolve_content_box4_button = evolve_get_option('evl_content_box4_button', '<a class="read-more btn t4p-button" href="#">Learn more</a>');
            if ($evolve_content_box4_button === false) {
                $evolve_content_box4_button = '';
            }
            $evolve_content_box4_icon = evolve_get_option('evl_content_box4_icon', 'fa-tablet');
            if ($evolve_content_box4_icon === false) {
                $evolve_content_box4_icon = '';
            }

            if ($evolve_content_box4_enable == true) {

                echo "<div class='col-sm-12 $BoxClass content-box content-box-4'>";

                echo "<i class='fa " . $evolve_content_box4_icon . "'></i>";

                echo "<h2>" . esc_attr($evolve_content_box4_title) . "</h2>";

                echo "<p>" . do_shortcode($evolve_content_box4_desc) . "</p>";

                echo "<div class='cntbox_btn sbtn4'>" . do_shortcode($evolve_content_box4_button) . "</div>";

                echo "</div>";
            }
            echo "</div></div><div class='clearfix'></div>";
        }
    }

    /**
     * evolve_Walker_Nav_Menu
     */
    class evolve_Walker_Nav_Menu extends Walker_Nav_Menu {
        /**
         * @see   Walker::start_lvl()
         * @since 3.0.0
         *
         * @param string $output Passed by reference. Used to append additional content.
         * @param int    $depth  Depth of page. Used for padding.
         */

        /**
         * @see   Walker::start_el()
         * @since 3.0.0
         *
         * @param string $output       Passed by reference. Used to append additional content.
         * @param object $item         Menu item data object.
         * @param int    $depth        Depth of menu item. Used for padding.
         * @param int    $current_page Menu item ID.
         * @param object $args
         */
        public function start_el(&$output, $item, $depth = 0, $args = array(), $id = 0) {
            $indent = ( $depth ) ? str_repeat("\t", $depth) : '';

            /**
             * Dividers, Headers or Disabled
             * =============================
             * Determine whether the item is a Divider, Header, Disabled or regular
             * menu item. To prevent errors we use the strcasecmp() function to so a
             * comparison that is not case sensitive. The strcasecmp() function returns
             * a 0 if the strings are equal.
             */
            $class_names = $value = '';

            $classes = empty($item->classes) ? array() : (array) $item->classes;
            $classes[] = 'menu-item-' . $item->ID;

            $class_names = join(' ', apply_filters('nav_menu_css_class', array_filter($classes), $item, $args));

            if ($args->has_children) {
                $class_names .= ' dropdown';
            }

            if (in_array('current-menu-item', $classes)) {
                $class_names .= ' active';
            }

            $class_names = $class_names ? ' class="' . esc_attr($class_names) . '"' : '';

            $id = apply_filters('nav_menu_item_id', 'menu-item-' . $item->ID, $item, $args);
            $id = $id ? ' id="' . esc_attr($id) . '"' : '';

            $output .= $indent . '<li' . $id . $value . $class_names . '>';

            /**
             * PolyLang Broken Flag Images - Fix
             * =================================
             *
             * @by    jerry
             * @since 3.2.0
             * @todo  find better solution
             */
            $item->title_2 = $item->title; // Let's take flag image
            if (class_exists('Polylang')) {
                if (preg_match('/<img src=/', $item->title)) {
                    $item->title = strip_tags($item->title); // Let's remove flag image
                }
            }

            $atts = array();
            $atts['title'] = !empty($item->title) ? $item->title : '';
            $atts['target'] = !empty($item->target) ? $item->target : '';
            $atts['rel'] = !empty($item->xfn) ? $item->xfn : '';
            $atts['href'] = !empty($item->url) ? $item->url : '';


            $atts = apply_filters('nav_menu_link_attributes', $atts, $item, $args);

            $attributes = '';
            foreach ($atts as $attr => $value) {
                if (!empty($value)) {
                    $value = ( 'href' === $attr ) ? esc_url($value) : esc_attr($value);
                    $attributes .= ' ' . $attr . '="' . $value . '"';
                }
            }

            $item_output = $args->before;

            /*
             * Glyphicons
             * ===========
             * Since the the menu item is NOT a Divider or Header we check the see
             * if there is a value in the attr_title property. If the attr_title
             * property is NOT null we apply it as the class name for the glyphicon.
             */
            if (evolve_get_option('evl_main_menu_hover_effect', 'rollover') == 'disable') {
                $item_output .= '<a' . $attributes . '>';
            } else {
                $item_output .= '<a' . $attributes . '><span data-hover="' . $item->title . '">';
            }

            $item_output .= $args->link_before . apply_filters('the_title', $item->title_2, $item->ID) . $args->link_after;
            $item_output .= ( $args->has_children && 0 === $depth ) ? ' <span class="arrow"></span>' : '';
            if (evolve_get_option('evl_main_menu_hover_effect', 'rollover') == 'disable') {
                $item_output .= '</a>';
            } else {
                $item_output .= '</span></a>';
            }
            $item_output .= $args->after;

            $output .= apply_filters('walker_nav_menu_start_el', $item_output, $item, $depth, $args);
        }

        /**
         * Traverse elements to create list from elements.
         * Display one element if the element doesn't have any children otherwise,
         * display the element and its children. Will only traverse up to the max
         * depth and no ignore elements under that depth.
         * This method shouldn't be called directly, use the walk() method instead.
         *
         * @see   Walker::start_el()
         * @since 2.5.0
         *
         * @param object $element           Data object
         * @param array  $children_elements List of elements to continue traversing.
         * @param int    $max_depth         Max depth to traverse.
         * @param int    $depth             Depth of current element.
         * @param array  $args
         * @param string $output            Passed by reference. Used to append additional content.
         *
         * @return null Null on failure with no changes to parameters.
         */
        public function display_element($element, &$children_elements, $max_depth, $depth, $args, &$output) {
            if (!$element) {
                return;
            }

            $id_field = $this->db_fields['id'];

            // Display this element.
            if (is_object($args[0])) {
                $args[0]->has_children = !empty($children_elements[$element->$id_field]);
            }

            parent::display_element($element, $children_elements, $max_depth, $depth, $args, $output);
        }

    }

//end evolve_Walker_Nav_Menu
// Breadcrumbs //

    function evolve_breadcrumb() {
        global $data, $post;

        echo '<ul class="breadcrumbs">';

        echo '<li><a class="home" href="';
        echo home_url();
        echo '">' . __('Home', 'evolve');
        echo "</a></li>";

        $params['link_none'] = '';
        $separator = '';

        if (is_category()) {
            $category = get_the_category();
            $ID = $category[0]->cat_ID;
            echo is_wp_error($cat_parents = get_category_parents($ID, TRUE, '', FALSE)) ? '' : '<li>' . $cat_parents . '</li>';
        }

        if (is_tax()) {
            $term = get_term_by('slug', get_query_var('term'), get_query_var('taxonomy'));
            echo '<li>' . $term->name . '</li>';
        }

        if (is_home()) {
            echo '<li>' . __('Blog', 'evolve') . '</li>';
        }
        if (is_page() && !is_front_page()) {
            $parents = array();
            $parent_id = $post->post_parent;
            while ($parent_id) :
                $page = get_page($parent_id);
                if ($params["link_none"]) {
                    $parents[] = get_the_title($page->ID);
                } else {
                    $parents[] = '<li><a href="' . get_permalink($page->ID) . '" title="' . get_the_title($page->ID) . '">' . get_the_title($page->ID) . '</a></li>' . $separator;
                }
                $parent_id = $page->post_parent;
            endwhile;
            $parents = array_reverse($parents);
            echo join(' ', $parents);
            echo '<li>' . get_the_title() . '</li>';
        }
        if (is_single() && !is_attachment()) {
            $cat_1_line = '';
            $categories_1 = get_the_category($post->ID);
            if ($categories_1):
                foreach ($categories_1 as $cat_1):
                    $cat_1_ids[] = $cat_1->term_id;
                endforeach;
                $cat_1_line = implode(',', $cat_1_ids);
            endif;
            $categories = get_categories(array(
                'include' => $cat_1_line,
                'orderby' => 'id'
            ));
            if ($categories) :
                foreach ($categories as $cat) :
                    $cats[] = '<li><a href="' . get_category_link($cat->term_id) . '" title="' . $cat->name . '">' . $cat->name . '</a></li>';
                endforeach;
                echo join(' ', $cats);
            endif;
            echo '<li>' . get_the_title() . '</li>';
        }
        if (is_tag()) {
            echo '<li>' . "Tag: " . single_tag_title('', false) . '</li>';
        }
        if (is_404()) {
            echo '<li>' . __("404 - Page not Found", 'evolve') . '</li>';
        }
        if (is_search()) {
            echo '<li>' . __("Search", 'evolve') . '</li>';
        }
        if (is_year()) {
            echo '<li>' . get_the_time('Y') . '</li>';
        }
        if (is_attachment()) {
            if (!empty($post->post_parent)) {
                echo "<li><a href='" . get_permalink($post->post_parent) . "'>" . get_the_title($post->post_parent) . "</a></li>";
            }
            echo "<li>" . get_the_title() . "</li>";
        }

        echo "</ul>";
    }

    function evolve_posts_slider() {
        ?>
        <div id="slide_holder">
            <div class="slide-container">

                <ul id="slides">

                    <?php
                    $number_items = evolve_get_option('evl_posts_number', '5');
                    $slider_content = evolve_get_option('evl_posts_slider_content', 'recent');
                    $slider_content_category = '';
                    $slider_content_category = evolve_get_option('evl_posts_slider_id', '');
                    //make array categories into string with commas.
                    if (is_array($slider_content_category)) {
                        $slider_content_category = implode(",", $slider_content_category);
                    }

                    if ($slider_content == "category" && !empty($slider_content_category)) {
                        $slider_content_ID = $slider_content_category;
                    } else {
                        $slider_content_ID = '';
                    }

                    $args = array(
                        'cat' => $slider_content_ID,
                        'showposts' => $number_items,
                        'ignore_sticky_posts' => 1,
                    );
                    query_posts($args);

                    if (have_posts()) : $featured = new WP_Query($args);
                        while ($featured->have_posts()) : $featured->the_post();
                            ?>

                            <li class="slide">

                                <?php
                                if (has_post_thumbnail()) {
                                    echo '<div class="featured-thumbnail"><a href="';
                                    the_permalink();
                                    echo '">';
                                    the_post_thumbnail('slider-thumbnail');
                                    echo '</a></div>';
                                } else {
                                    $image = evolve_get_first_image();
                                    if ($image):
                                        echo '<div class="featured-thumbnail"><a href="';
                                        the_permalink();
                                        echo '"><img src="' . $image . '" alt="';
                                        the_title();
                                        echo '" /></a></div>';
                                    endif;
                                }
                                ?>

                                <h2 class="featured-title">
                                    <a class="title" href="<?php the_permalink() ?>">
                                        <?php
                                        $title = the_title('', '', false);
                                        $length = evolve_get_option('evl_posts_slider_title_length', 40);
                                        echo evolve_truncate($title, $length, '...');
                                        ?>
                                    </a>
                                </h2>

                                <p><?php
                                    $excerpt_length = evolve_get_option('evl_posts_slider_excerpt_length', 40);
                                    echo evolve_excerpt_max_charlength($excerpt_length);
                                    ?></p>
                                <a class="button post-more" href="<?php the_permalink(); ?>"><?php _e('Read More', 'evolve'); ?></a>

                            </li>

                            <?php
                        endwhile;
                    else:
                        ?>
                        <li><?php _e('<h2 style="color:#fff;">Oops, no posts to display! Please check your post slider Category (ID) settings</h2>', 'evolve'); ?></li>

                    <?php
                    endif;
                    wp_reset_query();
                    ?>
                </ul>
            </div>
        </div>
        <?php
    }

// Register default function when plugin not activated
    add_action('wp_head', 'evolve_plugins_loaded');

    function evolve_plugins_loaded() {
        if (!function_exists('is_woocommerce')) {

            function is_woocommerce() {
                return false;
            }

        }
        if (!function_exists('is_product')) {

            function is_product() {
                return false;
            }

        }
        if (!function_exists('is_buddypress')) {

            function is_buddypress() {
                return false;
            }

        }
        if (!function_exists('is_bbpress')) {

            function is_bbpress() {
                return false;
            }

        }
    }


    /**
     * Infinite Scroll
     *
     * @since 3.2.0
     */
    add_action('wp_footer', 'evolve_infinite_scroll_blog');

    function evolve_infinite_scroll_blog() {
        echo '<script>
            if (jQuery(".posts-container-infinite").length == 1) {
                var ias = jQuery.ias({
                    container: ".posts-container-infinite",
                    item: "div.post",
                    pagination: "div.pagination",
                    next: "a.pagination-next",
                });

                ias.extension(new IASTriggerExtension({
                        text: "Load more items",
                        offset: 99999
                }));
                ias.extension(new IASSpinnerExtension({
                }));
                ias.extension(new IASNoneLeftExtension());
            }else{';
        $evolve_pagination_type = evolve_get_option('evl_pagination_type', 'pagination');
        if ($evolve_pagination_type == "infinite" && !is_single() && (is_page_template('blog-page.php') || is_home() )) {
            echo '
                        var ias = jQuery.ias({
                             container: "#primary",
                             item: ".post",
                             pagination: ".navigation-links",
                             next: ".nav-previous a",
                        });

                        ias.extension(new IASTriggerExtension({
                                text: "Load more items",
                                offset: 99999
                        }));
                        ias.extension(new IASSpinnerExtension({
                        }));
                        ias.extension(new IASNoneLeftExtension());';
        }
        echo '}
    </script>';

	   
    }

    /*
     * function to use get buddypress page id
     *
     * 
     */

    function evolve_bp_get_id() {
        $post_id = '';
        $bp_page_id = get_option('bp-pages');

        if (is_buddypress()) {
            if (bp_is_current_component('members')) {
                $post_id = $bp_page_id['members'];
            } elseif (bp_is_current_component('activity')) {
                $post_id = $bp_page_id['activity'];
            } elseif (bp_is_current_component('groups')) {
                $post_id = $bp_page_id['groups'];
            } elseif (bp_is_current_component('register')) {
                $post_id = $bp_page_id['register'];
            } elseif (bp_is_current_component('activate')) {
                $post_id = $bp_page_id['activate'];
            } else {
                $post_id = '';
            }
        }

        return $post_id;
    }

    /*
     * function to print out css class according to layout or post meta
     * used in content-blog.php, index.php, buddypress.php, bbpress.php
     * @since 3.3.0
     *
     * added by Denzel
     */

    function evolve_layout_class($type = 1) {
//$type = 1 is for content-blog.php and index.php, which includes the get_post_meta($post->ID, 'evolve_full_width', true)..
//$type = 2 is for buddypress.php and bbpress.php, which EXCLUDES the get_post_meta($post->ID, 'evolve_full_width', true)..  
        global $post;
        global $wp_query;
        $evolve_layout = evolve_get_option('evl_layout', '2cl');
        $evolve_post_layout = evolve_get_option('evl_post_layout', 'two');

        $post_id = '';
        if ($wp_query->is_posts_page) {
            $post_id = get_option('page_for_posts');
        } elseif (is_buddypress()) {
            $post_id = evolve_bp_get_id();
        } else {
            $post_id = isset($post->ID) ? $post->ID : '';
        }

        $layout_css = '';

        if ($evolve_layout == "1c") {
            $layout_css.= ' col-md-12';
        } else {

            $layout_css.= ' col-xs-12 col-sm-6';

            if (($evolve_layout == "2cr" && ($evolve_post_layout == "two") || $evolve_layout == "2cl" && ($evolve_post_layout == "two"))) {
                $layout_css.= ' col-md-8';
            }

            if (($evolve_layout == "3cm" || $evolve_layout == "3cl" || $evolve_layout == "3cr")) {
                $layout_css.= ' col-md-6';
            } else {
                $layout_css.= ' col-md-8';
            }

            if (is_single() || is_page() || is_404() || is_search()) {
                $layout_css.= ' col-single';
            }
        }

        if (is_single() || is_page() || $wp_query->is_posts_page || is_buddypress() || is_bbpress()):

            $evolve_sidebar_position = get_post_meta($post_id, 'evolve_sidebar_position', true);

            if (($type == 1 && $evolve_sidebar_position == 'default') || ($type == 2 && $evolve_sidebar_position == 'default')) {
                if (get_post_meta($post_id, 'evolve_full_width', true) == 'yes') {
                    $layout_css .= ' full-width';
                }
            }

            if ($evolve_sidebar_position == '2cl') {
                $layout_css = 'col-xs-12 col-sm-6 col-md-8 col-md-8 float-left';
            }

            if ($evolve_sidebar_position == '2cr') {
                $layout_css = 'col-xs-12 col-sm-6 col-md-8 col-md-8 float-right';
            }

            if ($evolve_sidebar_position == "3cm") {
                $layout_css = 'col-xs-12 col-sm-6 col-md-6 float-left';
            }

            if ($evolve_sidebar_position == "3cr") {
                $layout_css = 'col-xs-12 col-sm-6 col-md-6 float-right';
            }

            if ($evolve_sidebar_position == "3cl") {
                $layout_css = 'col-xs-12 col-sm-6 col-md-6 float-left';
            }

            if (is_single() || is_page() || $wp_query->is_posts_page) {
                $layout_css.= ' col-single';
            }

        endif;

        echo $layout_css;
    }

    /*
     * function to print out css class according to layout
     * used in content-blog.php, index.php.
     *
     * added by Denzel
     */

    function evolve_post_class($xyz) {

        $evolve_post_layout = evolve_get_option('evl_post_layout', 'two');

        if ($evolve_post_layout == "two") {
            echo ' col-md-6 odd' . ( $xyz % 2 );
        } else {
            echo ' col-md-4 odd' . ( $xyz % 3 );
        }

        if (has_post_format(array(
                    'aside',
                    'audio',
                    'chat',
                    'gallery',
                    'image',
                    'link',
                    'quote',
                    'status',
                    'video'
                        ), '')) {
            echo ' formatted-post';
        }
    }

    /*
     * function to print out css class according to post format
     * used in content-blog.php, index.php.
     * 
     * added by Denzel
     */

    function evolve_post_class_2() {
        if (has_post_format(array(
                    'aside',
                    'audio',
                    'chat',
                    'gallery',
                    'image',
                    'link',
                    'quote',
                    'status',
                    'video'
                        ), '') || is_sticky()
        ) {
            echo 'formatted-post formatted-single margin-40';
        }
    }

    /*
     * function to print out css class according to layout
     * used in sidebar.php
     * 
     * added by Denzel
     */

    function evolve_sidebar_class() {

        global $wp_query;
        global $post;
        $post_id = '';
        if ($wp_query->is_posts_page) {
            $post_id = get_option('page_for_posts');
        } elseif (is_buddypress()) {
            $post_id = evolve_bp_get_id();
        } else {
            $post_id = isset($post->ID) ? $post->ID : '';
        }

        $sidebar_css = '';

        $evolve_layout = evolve_get_option('evl_layout', '2cl');

        //use PHP switch statement, is easier to understand.
        switch ($evolve_layout):
            case "1c":
                //do nothing
                break;
            case "2cl":
                $sidebar_css = 'col-sm-6 col-md-4';
                break;
            case "2cr":
                $sidebar_css = 'col-sm-6 col-md-4';
                break;
            case "3cm":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3';
                break;
            case "3cl":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3';
                break;
            case "3cr":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3';
                break;
        endswitch;

        $evolve_sidebar_position = get_post_meta($post_id, 'evolve_sidebar_position', true);

		if(is_page() || is_single()):
        //use PHP switch statement, is easier to understand.
        switch ($evolve_sidebar_position):
            case "default":
                //do nothing
                break;
            case "2cl":
                $sidebar_css = 'col-sm-6 col-md-4';
                break;
            case "2cr":
                $sidebar_css = 'col-sm-6 col-md-4';
                break;
            case "3cm":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3';
                break;
            case "3cl":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3 float-right';
                break;
            case "3cr":
                $sidebar_css = 'col-xs-12 col-sm-6 col-md-3 float-left';
                break;
        endswitch;
		endif;


        echo $sidebar_css;
    }

    /*
     * function to determine whether to get_sidebar, depending on theme options layout and post meta layout.
     * used in 404.php, archive.php, attachment.php, author.php, bbpress.php, blog-page.php,... 
     * buddypress.php, index.php, page.php, search.php single.php
     * 
     * @return boolean indicates whether to load sidebar.
     * added by Denzel
     */

    function evolve_lets_get_sidebar() {

        global $wp_query, $post;
        $post_id = '';
        if ($wp_query->is_posts_page) {
            $post_id = get_option('page_for_posts');
        } elseif (is_buddypress()) {
            $post_id = evolve_bp_get_id();
        } else {
            $post_id = isset($post->ID) ? $post->ID : '';
        }

        $get_sidebar = false;

        $evolve_layout = evolve_get_option('evl_layout', '2cl');

        if ($evolve_layout != "1c") {
            $get_sidebar = true;
        }

        if (( is_page() || is_single() || $wp_query->is_posts_page || is_buddypress() || is_bbpress()) && get_post_meta($post_id, 'evolve_full_width', true) == 'yes') {
            $get_sidebar = false;
        }

        if (is_single() || is_page() || $wp_query->is_posts_page || is_buddypress() || is_bbpress()):

            $evolve_sidebar_position = get_post_meta($post_id, 'evolve_sidebar_position', true);

            if ($evolve_sidebar_position != 'default' && $evolve_sidebar_position != '') {
                $get_sidebar = true;
            }

        endif;

        return $get_sidebar;
    }

    /*
     * function to determine whether to get_sidebar('2'), depending on theme options layout and post meta layout.
     * used in 404.php, archive.php, attachment.php, author.php, bbpress.php, blog-page.php,... 
     * buddypress.php, index.php, page.php, search.php single.php
     * 
     * @return boolean indicates whether to load sidebar.
     * added by Denzel
     */

    function evolve_lets_get_sidebar_2() {

        global $wp_query, $post;
        $post_id = '';
        if ($wp_query->is_posts_page) {
            $post_id = get_option('page_for_posts');
        } elseif (is_buddypress()) {
            $post_id = evolve_bp_get_id();
        } else {
            $post_id = isset($post->ID) ? $post->ID : '';
        }

        $get_sidebar = false;

        $evolve_layout = evolve_get_option('evl_layout', '2cl');

        if ($evolve_layout == "3cm" || $evolve_layout == "3cl" || $evolve_layout == "3cr") {
            $get_sidebar = true;
        }

        if (( is_page() || is_single() || $wp_query->is_posts_page || is_buddypress() || is_bbpress()) && get_post_meta($post_id, 'evolve_full_width', true) == 'yes') {
            $get_sidebar = false;
        }

        if (is_single() || is_page() || $wp_query->is_posts_page || is_buddypress() || is_bbpress()):

            $evolve_sidebar_position = get_post_meta($post_id, 'evolve_sidebar_position', true);

            if ($evolve_sidebar_position == '2cl' || $evolve_sidebar_position == '2cr') {
                $get_sidebar = false;
            }

            if ($evolve_sidebar_position == "3cm" || $evolve_sidebar_position == "3cl" || $evolve_sidebar_position == "3cr") {
                $get_sidebar = true;
            }

        endif;

        return $get_sidebar;
    }

    function evolve_print_fonts($name, $css_class, $additional_css = '', $additional_color_css_class = '', $imp = '') {
        global $evl_options;
        $options = $evl_options;
        $css = '';
        $font_size = '';
        $font_family = '';
        $font_style = '';
        $font_weight = '';
        $color = '';
        if ($options[$name]['font-size'] != '') {
            $font_size = $options[$name]['font-size'];
            $css .= "$css_class{font-size:" . $font_size . " " . $imp . ";}";
        }
        if ($options[$name]['font-family'] != '') {
            $font_family = $options[$name]['font-family'];
            $css .= "$css_class{font-family:" . $font_family . ";}";
        }
        if (isset($options[$name]['font-style']) && $options[$name]['font-style'] != '') {
            $font_style = $options[$name]['font-style'];
            $css .= "$css_class{font-style:" . $font_style . ";}";
        }
        if (isset($options[$name]['font-weight']) && $options[$name]['font-weight'] != '') {
            $font_weight = $options[$name]['font-weight'];
            $css .= "$css_class{font-weight:" . $font_weight . ";}";
        }
        if (isset($options[$name]['color']) && $options[$name]['color'] != '') {
            $color = $options[$name]['color'];
            $css .= "$css_class{color:" . $color . ";}";
        }
        if ($additional_css != '') {
            $css .= "$css_class{" . $additional_css . ";}";
        }
        if ($additional_color_css_class != '') {
            $color = $options[$name]['color'];
            $css .= "$additional_color_css_class{color:" . $color . ";}";
        }

        return $css;
    }

    if (!function_exists('evolve_custom_number_paging_nav')) :

        function evolve_custom_number_paging_nav() {
            // Don't print empty markup if there's only one page.
            if ($GLOBALS['wp_query']->max_num_pages < 2) {
                return;
            }

            $paged = get_query_var('paged') ? intval(get_query_var('paged')) : 1;
            $pagenum_link = html_entity_decode(get_pagenum_link());
            $query_args = array();
            $url_parts = explode('?', $pagenum_link);

            if (isset($url_parts[1])) {
                wp_parse_str($url_parts[1], $query_args);
            }

            $pagenum_link = remove_query_arg(array_keys($query_args), $pagenum_link);
            $pagenum_link = trailingslashit($pagenum_link) . '%_%';

            $format = $GLOBALS['wp_rewrite']->using_index_permalinks() && !strpos($pagenum_link, 'index.php') ? 'index.php/' : '';
            $format .= $GLOBALS['wp_rewrite']->using_permalinks() ? user_trailingslashit('page/%#%', 'paged') : '?paged=%#%';

            // Set up paginated links.
            $links = paginate_links(array(
                'base' => $pagenum_link,
                'format' => $format,
                'total' => $GLOBALS['wp_query']->max_num_pages,
                'current' => $paged,
                'mid_size' => 3,
                'add_args' => array_map('urlencode', $query_args),
                'prev_text' => sprintf('<span class="t4p-icon-chevron-left"></span> %s', __('Previous ', 'evolve')),
                'next_text' => sprintf('%s <span class="t4p-icon-chevron-right"></span>', __('Next ', 'evolve')),
                'type' => 'list',
            ));

            if ($links) :

                echo $links;

            endif;
        }

    endif;

    /* change in bbpress breadcrumb */

    function evolve_custom_bbp_breadcrumb() {
        $args['sep'] = ' / ';
        return $args;
    }

    add_filter('bbp_before_get_breadcrumb_parse_args', 'evolve_custom_bbp_breadcrumb');

    /* Change prefix pyre to evolve */

    $evolve_change_metabox_prefix = get_option('evl_change_metabox_prefix', 0);
    if ($evolve_change_metabox_prefix != 1) {
        add_action('admin_init', 'evolve_change_prefix');
        update_option('evl_change_metabox_prefix', 1);
    }

    function evolve_change_prefix() {
        global $wpdb;

        $querystr = " SELECT meta_key FROM $wpdb->postmeta WHERE `meta_key` LIKE '%pyre_%' ";

        $evolve_meta_key = $wpdb->get_results($querystr);
        foreach ($evolve_meta_key as $meta_key) {
            $original_meta_key = $meta_key->meta_key;

            $change_meta_key = str_replace("pyre_", "evolve_", $original_meta_key);

            $wpdb->query("UPDATE $wpdb->postmeta SET meta_key = REPLACE(meta_key, '$original_meta_key', '$change_meta_key')");
        }
    }

    //filter added for buddypress-docs comment show
    add_filter( 'bp_docs_allow_comment_section', '__return_true', 100 );
