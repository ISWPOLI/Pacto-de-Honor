<!--BEGIN .header-pattern-->
<div class="new-top-menu">
    <div class="container">
        <div class="col-md-6 col-sm-6">
            <?php
            $evolve_social_links = evolve_get_option('evl_social_links', '1');
            if ($evolve_social_links == "1") {
                ?>
                <div class="top-menu-social-container">
                    <!--BEGIN #subscribe-follow-->
                    <div class="top-menu-social">
                        <?php
                        get_template_part('social-buttons', 'header');
                        ?>                                        
                    </div>
                </div>
                <!--END #subscribe-follow-->
            <?php } ?>
        </div>
    </div>
</div>
<div class="clearfix"></div>

<div class="header-pattern">
    <!--BEGIN .header-border-->
    <div class="header-border-sticky">
        <div class="header-border<?php
        $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');
        if (get_header_image()) {
            echo ' custom-header';
        }
        ?>">
        	<div class="header-bg"></div>
            <!--BEGIN .header-->
            <div class="header">
                <div class="container">
                    <!--BEGIN .container-header-->   
                    <div class="container-header">

                        <!--BEGIN .title-container-->
                        <div class="title-container col-md-3 col-sm-3">
                            <?php
                            $evolve_header_logo = evolve_get_option('evl_header_logo', '');
                            if ($evolve_header_logo) {
                                echo "<div class='header-logo-container clearfix'><a href=" . home_url() . "><img id='logo-image' class='img-responsive' alt='" . get_bloginfo('name') . "' src=" . $evolve_header_logo . " /></a></div>";
                            }

                            $tagline = '<span id="tagline">' . get_bloginfo('description') . '</span>';
                            $evolve_tagline_pos = evolve_get_option('evl_tagline_pos', 'next');
                            $evolve_blog_title = evolve_get_option('evl_blog_title', '0');
                            if ($evolve_blog_title == "0" || !$evolve_blog_title) {
                                ?>
                                <span id="logo"><a href="<?php echo home_url(); ?>"><?php bloginfo('name') ?></a></span>
                                <?php
                            } else {
                                
                            }
                            if (($evolve_tagline_pos !== "disable")) {
                                echo $tagline;
                            }
                            ?> 								
                        </div>
                        <!--END .title-container-->
                        <div class="headerbar col-md-7 col-sm-7">
                            <!--BEGIN .container-menu-->
                            <div class="container-menu">
                                <?php
                                $evolve_main_menu = evolve_get_option('evl_main_menu', '0');
                                if ($evolve_main_menu == "1") {
                                    ?>
                                    
                                <?php } else { ?>
                                    <div class="primary-menu p-menu-stick ">

                                        <?php
                                        if (has_nav_menu('primary-menu')) {
                                            echo '<nav class="nav nav-holder link-effect">';
                                            wp_nav_menu(array('theme_location' => 'primary-menu', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu', 'walker' => new evolve_Walker_Nav_Menu()));
                                            
                                            $evolve_responsive_menu_layout = evolve_get_option('evl_responsive_menu_layout', 'basic');
                                            if($evolve_responsive_menu_layout == 'dropdown'){
                                                wp_nav_menu(array('theme_location' => 'primary-menu', 'container_class' => 'evolve_mobile_menu', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu'));
                                            }
                                        } else {
                                            ?>
                                            <nav class="nav nav-holder">
                                                <?php
                                                wp_nav_menu(array('theme_location' => 'primary-menu', 'menu_class' => 'nav-menu', 'fallback_cb' => 'wp_page_menu'));
                                            }
                                            ?>
                                        </nav>
                                    </div><!-- /.primary-menu -->
                                <?php } ?>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <?php
                        $evolve_searchbox = evolve_get_option('evl_searchbox', '1');
                        if ($evolve_searchbox == "1") {
                            ?>
                            <div class="col-md-2">
                                <!--BEGIN #searchform-->
                                <form action="<?php echo home_url(); ?>" method="get" class="searchform">
                                    <div id="search-text-box">
                                        <label class="searchfield" id="search_label_top" for="search-text-top"><input id="search-text-top" type="text" tabindex="1" name="s" class="search" placeholder="<?php _e('Type your search', 'evolve'); ?>" /><span class="srch-btn"></span></label>
                                    </div>                                    
                                </form>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <!--END .header-->
        </div>
        <!--END .header-border-->
    </div>
</div>

<!--END .header-pattern-->
<div class="menu-header">
    <!--BEGIN .container-menu-->
    <div class="container nacked-menu container-menu">
        <?php
        $evolve_sticky_header = evolve_get_option('evl_sticky_header', '1');
        if ($evolve_sticky_header == "1") {
            // sticky header
            get_template_part('sticky-header');
        }
        ?>
    </div><!-- /.container -->
</div><!-- /.menu-header -->
