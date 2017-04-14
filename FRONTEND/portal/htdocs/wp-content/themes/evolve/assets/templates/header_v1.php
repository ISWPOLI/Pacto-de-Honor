<!--BEGIN .header-pattern-->
<div class="header-pattern">
    <!--BEGIN .header-border-->

    <div class="header-border<?php
    $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');
    if (get_header_image()) {
        echo ' custom-header';
    }
    ?>">

        <div class="header-border-sticky">
            <!--BEGIN .header-->
            <div class="header-bg"></div>
            <div class="header">
                <!--BEGIN .container-header-->
                <div class="container container-header header_v0">
                    <!--BEGIN #righttopcolumn-->
                    <div id="righttopcolumn">
                        <?php
                        $evolve_social_links = evolve_get_option('evl_social_links', '1');
                        if ($evolve_social_links == "1") {
                            ?>
                            <!--BEGIN #subscribe-follow-->
                            <div id="social">
                                <?php
                                get_template_part('social-buttons', 'header');
                                ?>                                        
                            </div>
                            <!--END #subscribe-follow-->
                        <?php } ?>
                    </div>
                    <!--END #righttopcolumn-->

                    <?php
                    $evolve_pos_logo = evolve_get_option('evl_pos_logo', 'left');
                    if ($evolve_pos_logo == "disable") {
                        
                    } else {
                        $evolve_header_logo = evolve_get_option('evl_header_logo', '');
                        if ($evolve_header_logo) {
                            if ($evolve_pos_logo == "center") {

                                echo "<div class='header-logo-container clearfix'><a href=" . home_url() . "><img id='logo-image' class='img-responsive' alt='" . get_bloginfo('name') . "' src=" . $evolve_header_logo . " /></a></div>";
                            } else {
                                echo "<div class='header-logo-container'><a href=" . home_url() . "><img id='logo-image' class='img-responsive' alt='" .get_bloginfo('name') . "' src=" . $evolve_header_logo . " /></a></div>";
                            }
                        }
                    }
                    ?>
                    <!--BEGIN .title-container-->
                    <div class="title-container <?php
                    if (($evolve_pos_logo == "center" ) && ($evolve_header_logo != "")) {
                        echo "clearfix";
                    } elseif ($evolve_pos_logo == "center") {
                        echo "clearfix";
                    }
                    ?>">
                             <?php
                             $tagline = '<div id="tagline">' . get_bloginfo('description') . '</div>';
                             $evolve_tagline_pos = evolve_get_option('evl_tagline_pos', 'next');
                             if (($evolve_tagline_pos !== "disable") && ($evolve_tagline_pos == "above")) {
                                 echo $tagline;
                             }
                             $evolve_blog_title = evolve_get_option('evl_blog_title', '0');
                             if ($evolve_blog_title == "0" || !$evolve_blog_title) {
                                 ?>
                            <div id="logo"><a href="<?php echo home_url(); ?>"><?php bloginfo('name') ?></a></div>
                            <?php
                        } else {
                            
                        }
                        if (($evolve_tagline_pos !== "disable") && (($evolve_tagline_pos == "") || ($evolve_tagline_pos == "next") || ($evolve_tagline_pos == "under"))) {
                            echo $tagline;
                        }
                        ?>                        
                    </div>
                    <!--END .title-container-->
                </div>
                <!--END .container-header-->
            </div>
            <!--END .header-->
        </div>
    </div>
    <!--END .header-border-->
</div>
<!--END .header-pattern-->
<div class="menu-container header_v0">
    <?php
    $evolve_menu_background = evolve_get_option('evl_disable_menu_back', '1');
    $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');
    if ($evolve_width_layout == "fluid" && $evolve_menu_background == "1") {
        ?>
        <div class="fluid-width">
        <?php } ?>

        <div class="menu-header">
            <div class="menu-header-sticky">
                <!--BEGIN .container-menu-->
                <div class="container nacked-menu container-menu">
                    <?php
                    $evolve_main_menu = evolve_get_option('evl_main_menu', '0');
                    if ($evolve_main_menu == "1") {
                        ?>
                        
                    <?php } else { ?>
                        <div class="primary-menu col-md-11 col-sm-11">
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
                        <?php
                        $evolve_searchbox = evolve_get_option('evl_searchbox', '1');
                        if ($evolve_searchbox == "1") {
                            ?>
                            <!--BEGIN #searchform-->
                            <form action="<?php echo home_url(); ?>" method="get" class="searchform">
                                <div id="search-text-box">
                                    <label class="searchfield col-md-1 col-sm-1" id="search_label_top" for="search-text-top"><input id="search-text-top" type="text" tabindex="1" name="s" class="search" placeholder="<?php _e('Type your search', 'evolve'); ?>" /></label>
                                </div>
                            </form>
                            <div class="clearfix"></div>
                            <!--END #searchform-->
                            <?php
                        }
                        $evolve_sticky_header = evolve_get_option('evl_sticky_header', '1');
                        if ($evolve_sticky_header == "1") {
                            // sticky header
                            get_template_part('sticky-header');
                        }
                     } ?>
                </div><!-- /.container -->
            </div><!-- /.menu-header -->
        </div>
        <?php
        $evolve_width_layout = evolve_get_option('evl_width_layout', 'fixed');
        if ($evolve_width_layout == "fluid") {
            ?>
        </div><!-- /.fluid-width -->
    <?php } ?>
</div>             
