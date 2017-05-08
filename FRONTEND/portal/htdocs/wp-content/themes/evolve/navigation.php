<?php
/*
 * 
 * Template: Navigation.php 
 *
 */
$evolve_pagination_type = evolve_get_option('evl_pagination_type', 'pagination');

if (is_singular() and ! is_page()) {
    ?>
    <!--BEGIN .navigation-links-->
    <div class="navigation-links single-page-navigation clearfix row">
        <div class="col-sm-6 col-md-6 nav-previous"><?php previous_post_link('%link', '%title'); ?></div>
        <div class="col-sm-6 col-md-6 nav-next"><?php next_post_link('%link', '%title'); ?></div>
        <!--END .navigation-links-->
    </div>
    <div class="clearfix"></div> 
<?php } else { ?>
    <!--BEGIN .navigation-links-->
    <div class="navigation-links page-navigation clearfix">
        <?php
        if (function_exists('wp_pagenavi')) {
            wp_pagenavi();
        } elseif ($evolve_pagination_type == "number_pagination") {
            ?>
            <div class="number-pagination">
            <?php evolve_custom_number_paging_nav(); ?>
            </div>
        <?php } else { ?>
            <div class="col-sm-6 col-md-6 nav-next"><?php previous_posts_link(__('Newer Entries', 'evolve')); ?></div>
            <div class="col-sm-6 col-md-6 nav-previous"><?php next_posts_link(__('Older Entries', 'evolve')); ?></div>
    <?php } ?>
        <!--END .navigation-links-->
    </div>
    <div class="clearfix"></div> 
    <?php
}
