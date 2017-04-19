<?php
$evolve_show_rss = evolve_get_option('evl_show_rss', '1');
$evolve_rss_feed = evolve_get_option('evl_rss_feed', '');
$evolve_newsletter = evolve_get_option('evl_newsletter', '');
$evolve_facebook = evolve_get_option('evl_facebook', '');
$evolve_twitter_id = evolve_get_option('evl_twitter_id', '');
$evolve_googleplus = evolve_get_option('evl_googleplus', '');
$evolve_instagram = evolve_get_option('evl_instagram', '');
$evolve_skype = evolve_get_option('evl_skype', '');
$evolve_youtube = evolve_get_option('evl_youtube', '');
$evolve_flickr = evolve_get_option('evl_flickr', '');
$evolve_linkedin = evolve_get_option('evl_linkedin', '');
$evolve_pinterest = evolve_get_option('evl_pinterest', '');
$evolve_tumblr = evolve_get_option('evl_tumblr', '');
?>   

<ul class="sc_menu">
    <?php if ($evolve_show_rss == '1') { ?>   
        <li><a target="_blank" href="<?php
            if ($evolve_rss_feed != "") {
                echo $evolve_rss_feed;
            } else {
                bloginfo('rss_url');
            }
            ?>" class="tipsytext" id="rss" title="<?php _e('RSS Feed', 'evolve'); ?>"><i class="t4p-icon-social-rss"></i></a></li>
               <?php
           }

           if (!empty($evolve_newsletter)) {
               ?>
        <li><a target="_blank" href="<?php if ($evolve_newsletter != "") echo $evolve_newsletter; ?>" class="tipsytext" id="email-newsletter" title="<?php _e('Newsletter', 'evolve'); ?>"><i class="t4p-icon-social-envelope-o"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_facebook)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_facebook == "") $evolve_facebook = $default_facebook;echo esc_attr($evolve_facebook); ?>" class="tipsytext" id="facebook" title="<?php _e('Facebook', 'evolve'); ?>"><i class="t4p-icon-social-facebook"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_twitter_id)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_twitter_id == "") $evolve_twitter_id = $default_twitter_id;echo esc_attr($evolve_twitter_id); ?>" class="tipsytext" id="twitter" title="<?php _e('Twitter', 'evolve'); ?>"><i class="t4p-icon-social-twitter"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_googleplus)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_googleplus != "") echo $evolve_googleplus; ?>" class="tipsytext" id="plus" title="<?php _e('Google Plus', 'evolve'); ?>"><i class="t4p-icon-social-google-plus"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_instagram)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_instagram != "") echo $evolve_instagram; ?>" class="tipsytext" id="instagram" title="<?php _e('Instagram', 'evolve'); ?>"><i class="t4p-icon-social-instagram"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_skype)) {
        ?>
        <li><a href="skype:<?php if ($evolve_skype != "") echo $evolve_skype; ?>?call" class="tipsytext" id="skype" title="<?php _e('Skype', 'evolve'); ?>"><i class="t4p-icon-social-skype"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_youtube)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_youtube != "") echo $evolve_youtube; ?>" class="tipsytext" id="youtube" title="<?php _e('YouTube', 'evolve'); ?>"><i class="t4p-icon-social-youtube"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_flickr)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_flickr != "") echo $evolve_flickr; ?>" class="tipsytext" id="flickr" title="<?php _e('Flickr', 'evolve'); ?>"><i class="t4p-icon-social-flickr"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_linkedin)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_linkedin != "") echo $evolve_linkedin; ?>" class="tipsytext" id="linkedin" title="<?php _e('LinkedIn', 'evolve'); ?>"><i class="t4p-icon-social-linkedin"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_pinterest)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_pinterest != "") echo $evolve_pinterest; ?>" class="tipsytext" id="pinterest" title="<?php _e('Pinterest', 'evolve'); ?>"><i class="t4p-icon-social-pinterest"></i></a></li>
        <?php
    } else {
        
    }
    if (!empty($evolve_tumblr)) {
        ?>
        <li><a target="_blank" href="<?php if ($evolve_tumblr != "") echo $evolve_tumblr; ?>" class="tipsytext" id="tumblr" title="<?php _e('Tumblr', 'evolve'); ?>"><i class="t4p-icon-social-tumblr"></i></a></li>
                <?php
            } else {
                
            }
            ?>
</ul>