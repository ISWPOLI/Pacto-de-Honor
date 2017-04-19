<?php
/*
 *
 * Template: Footer.php
 *
 */
?>
<!--END #content-->
</div>
<!--END .container-->
</div>
<!--END .content-->
</div>
<!--BEGIN .content-bottom-->
<div class="content-bottom">
<!--END .content-bottom-->
</div>
<!--BEGIN .footer-->
<div class="footer">
<!--BEGIN .container-->
    <div class="container container-footer">
        <?php
        $evolve_widgets_footer = evolve_get_option('evl_widgets_num', 'disable');
        // if Footer widgets exist
        if (($evolve_widgets_footer == "") || ($evolve_widgets_footer == "disable")) {
            
        } else {

            $evolve_footer_css = '';
            if ($evolve_widgets_footer == "one") {
                $evolve_footer_css = 'widget-one-column col-sm-12';
            }
            if ($evolve_widgets_footer == "two") {
                $evolve_footer_css = 'col-sm-6 col-md-6';
            }
            if ($evolve_widgets_footer == "three") {
                $evolve_footer_css = 'col-sm-6 col-md-4';
            }
            if ($evolve_widgets_footer == "four") {
                $evolve_footer_css = 'col-sm-6 col-md-3';
            }
            ?>
            <div class="footer-widgets">
                <div class="widgets-back-inside row">
                    <div class="<?php echo $evolve_footer_css; ?>">
                        <?php
                        if (!dynamic_sidebar('footer-1')) :
                        endif;
                        ?>
                    </div>
                    <div class="<?php echo $evolve_footer_css; ?>">
                        <?php
                        if (!dynamic_sidebar('footer-2')) :
                        endif;
                        ?>
                    </div>
                    <div class="<?php echo $evolve_footer_css; ?>">
                        <?php
                        if (!dynamic_sidebar('footer-3')) :
                        endif;
                        ?>
                    </div>
                    <div class="<?php echo $evolve_footer_css; ?>">
                        <?php
                        if (!dynamic_sidebar('footer-4')) :
                        endif;
                        ?>
                    </div>
                </div>
            </div>
        <?php } ?>
        <div class="clearfix"></div>
        <?php
        $footer_content = evolve_get_option('evl_footer_content', '<p id=\'copyright\'><span class=\'credits\'><a href=\'http://theme4press.com/evolve-multipurpose-wordpress-theme/\'>evolve</a> theme by Theme4Press&nbsp;&nbsp;&bull;&nbsp;&nbsp;Powered by <a href=\'http://wordpress.org\'>WordPress</a></span></p>');
        if ($footer_content === false)
            $footer_content = '';
        echo do_shortcode($footer_content);
        ?>
        <!-- Theme Hook -->
        <?php evolve_footer_hooks(); ?>
        <!--END .container-->
    </div>
    <!--END .footer-->
</div>
<!--END body-->
<?php
$evolve_pos_button = evolve_get_option('evl_pos_button', 'right');
if ($evolve_pos_button == "disable" || $evolve_pos_button == "") {
    
} else {
    ?>
    <a href="#top" id="top-link"><div id="backtotop"></div></a>
        <?php
    }

    $evolve_custom_background = evolve_get_option('evl_custom_background', '1');
    if ($evolve_custom_background == "1") {
        ?>
    </div>
    <?php
}
wp_footer();
?>
</body>
<!--END html(kthxbye)-->
</html>
