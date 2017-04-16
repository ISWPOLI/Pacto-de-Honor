<header id="header" class="sticky-header 
<?php
$evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');
if ($evolve_width_layout == "fixed") {
    echo "container row";
}
?>">
    <div class="container">
        <?php
        $evolve_pos_logo = evolve_get_option('evl_pos_logo', 'left');
        if ($evolve_pos_logo == "disable") {
            
        } else {

            $evolve_header_logo = evolve_get_option('evl_header_logo', '');
            if ($evolve_header_logo) {
                echo "<a class='logo-url' href=" . home_url() . "><img id='logo-image' src=" . $evolve_header_logo . "  alt=" . get_bloginfo('name') . "/></a>";
            }
        }

        $evolve_blog_title = evolve_get_option('evl_blog_title', '0');
        if ($evolve_blog_title == "0") {
            ?>
            <div id="sticky-logo"><a class='logo-url-text' href="<?php echo home_url(); ?>"><?php bloginfo('name') ?></a></div>
        <?php }
        ?>
        <div class="sticky-menubar col-md-10 col-sm-10">    
            <?php
            if (has_nav_menu('sticky_navigation')) {
                echo '<nav class="nav nav-holder link-effect">';
                wp_nav_menu(array('theme_location' => 'sticky_navigation', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu', 'walker' => new evolve_Walker_Nav_Menu()));
            } elseif (has_nav_menu('primary-menu')) {
                echo '<nav class="nav nav-holder link-effect">';
                wp_nav_menu(array('theme_location' => 'primary-menu', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu', 'walker' => new evolve_Walker_Nav_Menu()));
            } else {
                ?>
                <nav class="nav nav-holder link-effect">
                    <?php
                    wp_nav_menu(array('theme_location' => 'primary-menu', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu'));
                }
                ?>
            </nav>
        </div>
        <?php
        $evolve_searchbox_sticky_header = evolve_get_option('evl_searchbox_sticky_header', '1');
        if ($evolve_searchbox_sticky_header == "1") {
            ?>
            <!--BEGIN #searchform-->
            <form action="<?php echo home_url(); ?>" method="get" class="stickysearchform">
                <div id="stickysearch-text-box" class="col-md-2 col-sm-2" >
                    <label class="searchfield" id="stickysearch_label" for="search-stickyfix"><input id="search-stickyfix" type="text" tabindex="1" name="s" class="search" placeholder="<?php _e('Type your search', 'evolve'); ?>" /></label>
                </div>
            </form>
            <div class="clearfix"></div>
            <!--END #searchform-->
        <?php } ?>
    </div>
</header>
