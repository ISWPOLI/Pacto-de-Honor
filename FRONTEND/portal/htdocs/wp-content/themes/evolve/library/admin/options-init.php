<?php
// If using image radio buttons, define a directory path
$evolve_imagepath = get_template_directory_uri() . '/assets/images/functions/';
$evolve_imagepathfolder = get_template_directory_uri() . '/assets/images/';
global $evolve_shortname, $evolve_opt_name, $evolve_prem_inpt_name;
$evolve_prem_inpt_name = "evl_hiden_premium"; // Switch control's id and name [Show/Hide premium options control]
$evolve_prem_class = "evl_premium_feature";
$evolve_shortname = "evl";
$evolve_template_url = get_template_directory_uri();

$evolve_opt_name = "evl_options";
$evolve_rss_url = get_bloginfo('rss_url');
$evolve_theme = wp_get_theme();

$evolve_t4p_url = esc_url("http://theme4press.com/");
$evolve_fb_url = esc_url("https://www.facebook.com/Theme4Press");

// OLD DATA MIGRATION
add_action('after_setup_theme', 'evolve_migrate_options');

function evolve_migrate_options() {
    global $evolve_shortname, $evolve_opt_name;
    $migrate_done = get_option('evl_33_migrate', false);
    if ($migrate_done !== 'done') {
        $newData = get_option('evl_options', false);
        if (empty($newData)) {
            $config = get_option('evolve');
            if (isset($config['id'])) {
                $oldData = get_option($config['id'], array());
                if (!empty($oldData)) {
                    foreach ($oldData as $key => $value) {
                        $fontKeys = array(
                            'evl_bootstrap_slide_subtitle_font',
                            'evl_bootstrap_slide_title_font',
                            'evl_carousel_slide_subtitle_font',
                            'evl_carousel_slide_title_font',
                            'evl_content_font',
                            'evl_content_h1_font',
                            'evl_content_h2_font',
                            'evl_content_h3_font',
                            'evl_content_h4_font',
                            'evl_content_h5_font',
                            'evl_content_h6_font',
                            'evl_menu_font',
                            'evl_parallax_slide_subtitle_font',
                            'evl_parallax_slide_title_font',
                            'evl_post_font',
                            'evl_tagline_font',
                            'evl_title_font',
                            'evl_widget_content_font',
                            'evl_widget_title_font',
                        );
                        $mediaKeys = array(
                            'evl_bootstrap_slide1_img',
                            'evl_bootstrap_slide2_img',
                            'evl_bootstrap_slide3_img',
                            'evl_bootstrap_slide4_img',
                            'evl_bootstrap_slide5_img',
                            'evl_content_background_image',
                            'evl_favicon',
                            'evl_footer_background_image',
                            'evl_header_logo',
                            'evl_scheme_background',
                            'evl_slide1_img',
                            'evl_slide2_img',
                            'evl_slide3_img',
                            'evl_slide4_img',
                            'evl_slide5_img',
                        );
                        // Typography SHIM
                        if (in_array($key, $fontKeys)) {
                            if (isset($value['size'])) {
                                $value['font-size'] = $value['size'];
                                unset($value['size']);
                            }
                            if (isset($value['face'])) {
                                $value['font-family'] = $value['face'];
                                unset($value['face']);
                            }
                            if (isset($value['style'])) {
                                $value['font-style'] = $value['style'];
                                unset($value['style']);
                            }
                            $oldData[$key] = $value;
                        } elseif (in_array($key, $mediaKeys)) {
                            $oldData[$key] = array('url' => isset($value) ? $value : '');
                        }
                    }

                    update_option($evolve_opt_name, $oldData);
                    update_option('evl_33_migrate', 'done');
                }
            }
        }
    }
}

if (!class_exists('Redux')) {
    return;
}


// Upgrade from version 3.3 and below
$upgrade_from_33 = get_option('evolve', false);

// If the Redux plugin is installed
if (ReduxFramework::$_is_plugin) {
    Redux::setArgs($evolve_opt_name, array(
        'customizer_only' => false,
        'customizer' => true,
    ));
} else {
    // No Redux plugin. Use embedded. Customizer only!
    Redux::setArgs($evolve_opt_name, array(
        'customizer_only' => true,
    ));
}

//Register sidebar options for category/archive pages 
global $wp_registered_sidebars;
$sidebar_options[] = 'None';
for ($i = 0; $i < 1; $i++) {
    $sidebars = $wp_registered_sidebars; // sidebar_generator::get_sidebars(); 
    //var_dump($sidebars); 
    if (is_array($sidebars) && !empty($sidebars)) {
        foreach ($sidebars as $key => $sidebar) {
            $sidebar_options[$key] = $sidebar['name'];
        }
    }
}

// Pull all the categories into an array
$options_categories = array();
$options_categories_obj = get_categories();
foreach ($options_categories_obj as $category) {
    $options_categories[$category->cat_ID] = $category->cat_name;
}

// Pull all the pages into an array
$options_pages = array();
$options_pages_obj = get_pages('sort_column=post_parent,menu_order');
$options_pages[''] = 'Select a page:';
foreach ($options_pages_obj as $page) {
    $options_pages[$page->ID] = $page->post_title;
}

function evolve_addPanelCSS() {
    wp_register_style(
            'evolve-redux-custom-css', get_template_directory_uri() . '/library/admin/panel.css', array('redux-admin-css'), // Be sure to include redux-admin-css so it's appended after the core css is applied
            time(), //$evolve_theme->get( 'Version' )
            'all'
    );
    wp_enqueue_style('evolve-redux-custom-css');
}

// This example assumes your opt_name is set to redux_demo, replace with your opt_name value
add_action("redux/page/{$evolve_opt_name}/enqueue", 'evolve_addPanelCSS');

function evolve_newIconFont() {
    wp_register_style(
            'evolve-icomoon', get_template_directory_uri() . '/library/admin/icomoon-admin/style.css', array(), time(), 'all'
    );
    wp_enqueue_style('evolve-icomoon');
}

// This example assumes the opt_name is set to redux_demo.  Please replace it with your opt_name value.
add_action("redux/page/{$evolve_opt_name}/enqueue", 'evolve_newIconFont');

function evolve_headerdefault() {
    wp_enqueue_script('evolve-headerdefault', get_template_directory_uri() . '/library/admin/headerdefault/headerdefault.js', array(), '', true);
}

add_action("redux/page/{$evolve_opt_name}/enqueue", "evolve_headerdefault");

Redux::setArgs($evolve_opt_name, array(
    'display_name' => __('evolve', 'evolve'),
    'display_name' => '<img width="135" height="28" src="' . get_template_directory_uri() . '/assets/images/functions/logo.png" alt="evolve">',
    // Name that appears at the top of your panel
    'display_version' => $evolve_theme->get('Version'),
    'menu_type' => 'submenu',
    'dev_mode' => false,
    'menu_title' => __('Theme Options', 'evolve'),
    'page_title' => $evolve_theme->get('Name') . ' ' . __('Options', 'evolve'),
    'admin_bar' => true,
    'customizer' => true,
    'save_defaults' => empty($upgrade_from_33),
    //Override Redux plugin template files:
    'templates_path' => dirname(__FILE__) . '/evolve-redux-templates/panel',
    'share_icons' => array(
        array(
            'url' => $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/',
            'title' => __('Theme Homepage', 'evolve'),
            'icon' => 't4p-icon-appbarhome'
        ),
        array(
            'url' => $evolve_t4p_url . 'docs/',
            'title' => __('Documentation', 'evolve'),
            'icon' => 't4p-icon-appbarpagetext'
        ),
        array(
            'url' => $evolve_t4p_url . 'support-forums/',
            'title' => __('Support', 'evolve'),
            'icon' => 't4p-icon-appbarlifesaver'
        ),
        array(
            'url' => $evolve_fb_url,
            'title' => __('Facebook', 'evolve'),
            'icon' => 't4p-icon-appbarsocialfacebook'
        )
    ),
    'intro_text' => '
					<a href="' . $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/" title="Theme Homepage" target="_blank">
						<i class="t4p-icon-appbarhome"></i>
						 Theme Homepage
					</a>
					<a href="' . $evolve_t4p_url . 'docs/" title="Documentation" target="_blank">
						<i class="t4p-icon-appbarpagetext"></i>
						 Documentation
					</a>
					<a href="' . $evolve_t4p_url . 'support-forums/" title="Support" target="_blank">
						<i class="t4p-icon-appbarlifesaver"></i>
						 Support
					</a>
					<a href="' . $evolve_fb_url . '" title="Facebook" target="_blank">
						<i class="t4p-icon-appbarsocialfacebook"></i>
						 Facebook
					</a>
			</div>
			<div>',
));


// Premium features visibility Customizer section
Redux::setSection($evolve_opt_name, array(
    /*
     * Be carefull if you change the item ID,
     * because this ID is referenced by the JS scripts!
     */
    'id' => 'evl-SH-custom-section',
    'title' => __('Premium features visibility', 'evolve'),
    /*
      Hide this section tab in the Theme options panel and
      make this section visible only in the Customizer
     */
    'customizer_only' => true,
    'icon' => 't4p-icon-appbartools',
        )
);
// Show/Hide premium features control field:
Redux::setField($evolve_opt_name, array(
    'section_id' => "evl-SH-custom-section",
    /*
     * Be carefull if you change the item ID,
     * because this ID is referenced by the JS scripts!
     */
    'id' => $evolve_prem_inpt_name,
    'subtitle' => __('Switch if you want to display/hide premium features by default', 'evolve'),
    'compiler' => true,
    'type' => 'switch',
    'on' => __('Show', 'evolve'),
    'off' => __('Hide', 'evolve'),
    'default' => 0,
    'title' => __('Premium features:', 'evolve'),
    'class' => $evolve_prem_class
        )
);
/*
 *  Hack for customizer:
 *  Don't remove!
 *  The folowing field is used in the customizer
 *  to trigger the script that enables the previous field,
 *  it doesn't point to a real option, but is nessesary:
 */
Redux::setField($evolve_opt_name, array(
    'section_id' => "evl-SH-custom-section",
    'id' => 'evl-SH-junk',
    'subtitle' => '',
    'compiler' => true,
    'type' => 'switch',
    'on' => __('Show', 'evolve'),
    'off' => __('Hide', 'evolve'),
    'default' => 0,
    'title' => '.',
    'class' => $evolve_prem_class
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-general-main-tab',
    'title' => __('General', 'evolve'),
    'icon' => 't4p-icon-appbartools',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-general-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'subsection' => true,
    /*
     * Added this class because all the fields under this subsection are premium features,
     * so this tab should be hidden when premium options are hidden too.
     * (Remove if you add new fields to this subsection that aren't premium)
     */
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'desc' => __('Importing demo content will give you sliders, pages, posts, theme options, widgets, sidebars and other settings. This will replicate the live demo. Please make sure you have the Theme4Press Core and WooCommerce plugins installed and activated to receive that portion of the content. WARNING: clicking this button will replace your current theme options, sliders and widgets. It can also take a minute to complete. <br /><br /><b>IMPORTANT: The Revolution Slider, Layer Slider and any other content which is a part of premium plugins as shown on our demo page won\'t be imported as they are not a part of the theme\'s package. This theme is only compatible with them.</b>', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'id' => 'demo_data',
            'type' => 'import_button',
            'title' => __('Import Demo Content', 'evolve'),
            'class' => $evolve_prem_class,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-general-subsec-fav-tab',
    'title' => __('Favicon', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Upload custom favicon.', 'evolve'),
            'id' => 'evl_favicon',
            'type' => 'media',
            'title' => __('Custom Favicon', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Favicon for Apple iPhone (57px x 57px).', 'evolve'),
            'id' => 'evl_iphone_icon',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Apple iPhone Icon Upload', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Favicon for Apple iPhone Retina Version (114px x 114px).', 'evolve'),
            'id' => 'evl_iphone_icon_retina',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Apple iPhone Retina Icon Upload', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Favicon for Apple iPad (72px x 72px).', 'evolve'),
            'id' => 'evl_ipad_icon',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Apple iPad Icon Upload', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Favicon for Apple iPad Retina Version (144px x 144px).', 'evolve'),
            'id' => 'evl_ipad_icon_retina',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Apple iPad Retina Icon Upload', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-general-subsec-lay-tab',
    'title' => __('Layout', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select main content and sidebar alignment.', 'evolve'),
            'id' => 'evl_layout',
            'type' => 'image_select',
            'compiler' => true,
            'options' => array(
                '1c' => $evolve_imagepath . '1c.png',
                '2cl' => $evolve_imagepath . '2cl.png',
                '2cr' => $evolve_imagepath . '2cr.png',
                '3cm' => $evolve_imagepath . '3cm.png',
                '3cr' => $evolve_imagepath . '3cr.png',
                '3cl' => $evolve_imagepath . '3cl.png',
            ),
            'title' => __('Select a layout', 'evolve'),
            'default' => '2cl',
        ),
        array(
            'subtitle' => __('<strong>Boxed version</strong> automatically enables custom background', 'evolve'),
            'id' => 'evl_width_layout',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'fixed' => __('Boxed', 'evolve'),
                'fluid' => __('Wide', 'evolve'),
            ),
            'title' => __('Layout Style', 'evolve'),
            'default' => 'fixed',
        ),
        array(
            'subtitle' => __('Select the width for your website', 'evolve'),
            'id' => 'evl_width_px',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                800 => '800px',
                985 => '985px',
                1200 => '1200px',
                1600 => '1600px',
            ),
            'title' => __('Layout Width', 'evolve'),
            'default' => '1200',
        ),
        array(
            'title' => __('Custom Layout Width', 'evolve'),
            'subtitle' => __('Add the custom width in px (ex: 1024)', 'evolve'),
            'id' => "evl_custom_width_px",
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => "text",
            'default' => '',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Select the left and right padding for the 100% width template main content area. Enter value in px. ex: 20px', 'evolve'),
            'id' => 'evl_hundredp_padding',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'text',
            'title' => __('100% Width Template Left/Right Padding', 'evolve'),
            'default' => '20px',
            'class' => $evolve_prem_class,
        ),
        array(
            'id' => 'evl_info_consid1',
            'type' => 'info',
            'subtitle' => __('<h3>Content and One Sidebar Width</h3>', 'evolve'),
            'class' => $evolve_prem_class
        ),
        array(
            'subtitle' => sprintf(__('These options apply for the following layouts <img style="float:left, display:inline" src="%s2cl.png" /> <img style="float:left, display:inline" src="%s2cr.png" />', 'evolve'), $evolve_imagepath, $evolve_imagepath),
            'id' => 'evl_info_consid1_widths',
            'style' => 'notice',
            'type' => 'info',
            'notice' => false,
            'class' => $evolve_prem_class
        ),
        array(
            'subtitle' => __('Select the width for your content', 'evolve'),
            'id' => 'evl_opt1_width_content',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                1 => '1/12',
                2 => '2/12',
                3 => '3/12',
                4 => '4/12',
                5 => '5/12',
                6 => '6/12',
                7 => '7/12',
                8 => '8/12',
                9 => '9/12',
                10 => '10/12',
                11 => '11/12',
                12 => '12/12',
            ),
            'title' => __('Content Width', 'evolve'),
            'default' => '8',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Select the width for your Sidebar 1', 'evolve'),
            'id' => 'evl_opt1_width_sidebar1',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'class' => $evolve_prem_class,
            'type' => 'select',
            'options' => array(
                1 => '1/12',
                2 => '2/12',
                3 => '3/12',
                4 => '4/12',
                5 => '5/12',
                6 => '6/12',
                7 => '7/12',
                8 => '8/12',
                9 => '9/12',
                10 => '10/12',
                11 => '11/12',
                12 => '12/12',
            ),
            'title' => __('Sidebar 1 Width', 'evolve'),
            'default' => '4',
        ),
        array(
            'id' => 'evl_info_consid2',
            'type' => 'info',
            'subtitle' => __('<h3>Content and Two Sidebars Width</h3>', 'evolve'),
            'class' => $evolve_prem_class
        ),
        array(
            'subtitle' => sprintf(__('These options apply for the following layouts <img style="float:left, display:inline" src="%s3cm.png" /> <img style="float:left, display:inline" src="%s3cr.png" /> <img style="float:left, display:inline" src="%s3cl.png" />', 'evolve'), $evolve_imagepath, $evolve_imagepath, $evolve_imagepath),
            'id' => 'evl_info_consid2_widths',
            'style' => 'notice',
            'type' => 'info',
            'notice' => false,
            'class' => $evolve_prem_class
        ),
        array(
            'subtitle' => __('Select the width for your content', 'evolve'),
            'id' => 'evl_opt2_width_content',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'class' => $evolve_prem_class,
            'type' => 'select',
            'options' => array(
                1 => '1/12',
                2 => '2/12',
                3 => '3/12',
                4 => '4/12',
                5 => '5/12',
                6 => '6/12',
                7 => '7/12',
                8 => '8/12',
                9 => '9/12',
                10 => '10/12',
                11 => '11/12',
                12 => '12/12',
            ),
            'title' => __('Content Width', 'evolve'),
            'default' => '6',
        ),
        array(
            'subtitle' => __('Select the width for your Sidebar 1', 'evolve'),
            'id' => 'evl_opt2_width_sidebar1',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'class' => $evolve_prem_class,
            'type' => 'select',
            'options' => array(
                1 => '1/12',
                2 => '2/12',
                3 => '3/12',
                4 => '4/12',
                5 => '5/12',
                6 => '6/12',
                7 => '7/12',
                8 => '8/12',
                9 => '9/12',
                10 => '10/12',
                11 => '11/12',
                12 => '12/12',
            ),
            'title' => __('Sidebar 1 Width', 'evolve'),
            'default' => '3',
        ),
        array(
            'subtitle' => __('Select the width for your Sidebar 2', 'evolve'),
            'id' => 'evl_opt2_width_sidebar2',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'class' => $evolve_prem_class,
            'type' => 'select',
            'options' => array(
                1 => '1/12',
                2 => '2/12',
                3 => '3/12',
                4 => '4/12',
                5 => '5/12',
                6 => '6/12',
                7 => '7/12',
                8 => '8/12',
                9 => '9/12',
                10 => '10/12',
                11 => '11/12',
                12 => '12/12',
            ),
            'title' => __('Sidebar 2 Width', 'evolve'),
            'default' => '3',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-main-tab',
    'title' => __('Header', 'evolve'),
    'icon' => 't4p-icon-file3',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-header-tab',
    'title' => __('Header', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Enter the header padding.', 'evolve'),
            'id' => 'evl_header_padding',
            'type' => 'spacing',
            'units' => array('px', 'em'),
            'title' => __('Header Padding', 'evolve'),
            'default' => array(
                'padding-top' => '40px',
                'padding-right' => '30px',
                'padding-bottom' => '40px',
                'padding-left' => '30px',
                'units' => 'px',
            ),
        ),
        array(
            'subtitle' => __('Check this box if you want to display searchbox in Header #1 and #3', 'evolve'),
            'id' => 'evl_searchbox',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Searchbox', 'evolve'),
        ),
        array(
            'subtitle' => __('Set the opacity of header menu background for Front Page, <br />0.1 (lowest) to 1 (highest) only for Header #4 and #5.', 'evolve'),
            'id' => 'evl_header_background_opacity',
			'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'slider',
			'class' => $evolve_prem_class,
            'min' => 0.1,
            'max' => 1,
            'step' => 0.1,
            'resolution' => 0.1,
            'title' => __('Header Menu Background Opacity', 'evolve'),
            'default' => '0.8',
        ),
        array(
            'subtitle' => __('Select if the slider shows below or above the header. This only works for the slider assigned in page options, not with shortcodes.', 'evolve'),
            'id' => 'evl_slider_position',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'below' => __('Below', 'evolve'),
                'above' => __('Above', 'evolve'),
            ),
            'title' => __('Slider Position', 'evolve'),
            'default' => 'below',
        ),
        array(
            'subtitle' => __('Choose your Header Type', 'evolve'),
            'id' => 'evl_header_type',
            'compiler' => true,
            'type' => 'image_select',
            'options' => array(
                'none' => $evolve_imagepathfolder . '/header/h0.png',
                'h1' => $evolve_imagepathfolder . '/header/h1.png',
            ),
            'title' => __('Choose Header Type', 'evolve'),
            'default' => 'none',
        ),
        array(
            'subtitle' => '',
            'id' => 'evl_header_type_locked',
            'compiler' => true,
            'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'image_select',
            'class' => $evolve_prem_class,
            'options' => array(
                'h2' => $evolve_imagepathfolder . '/header/h2.png',
                'h3' => $evolve_imagepathfolder . '/header/h3.png',
                'h4' => $evolve_imagepathfolder . '/header/h4.png',
                'h5' => $evolve_imagepathfolder . '/header/h5.png',
            ),
            'title' => '',
            'default' => 'none',
        ),
    ),
        )
);


Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-sticky-header-tab',
    'title' => __('Sticky Header', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to display sticky header', 'evolve'),
            'id' => 'evl_sticky_header',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable sticky header', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to display sticky header logo', 'evolve'),
            'id' => 'evl_sticky_header_logo',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'switch',
            'class' => $evolve_prem_class,
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable sticky header logo', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to display searchbox in sticky header', 'evolve'),
            'id' => 'evl_searchbox_sticky_header',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Searchbox', 'evolve'),
        ),
        array(
            'subtitle' => __('Adjust sticky header logo size', 'evolve'),
            'id' => 'evl_sticky_header_logo_size',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'spinner',
            'title' => __('Sticky header logo size in height', 'evolve'),
            'default' => '100',
            'class' => $evolve_prem_class,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-logo-tab',
    'title' => __('Logo', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Upload a logo for your theme, or specify an image URL directly.', 'evolve'),
            'id' => 'evl_header_logo',
            'type' => 'media',
            'title' => __('Custom logo', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Select an image file for the retina version of the custom logo. It should be exactly 2x the size of main logo.', 'evolve'),
            'id' => 'evl_header_logo_retina',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'media',
            'title' => __('Custom logo (Retina Version @2x)', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('If retina logo is uploaded, enter the standard logo (1x) version width, do not enter the retina logo width.', 'evolve'),
            'id' => 'evl_header_logo_retina_width',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'text',
            'title' => __('Standard Logo Width for Retina Logo', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('If retina logo is uploaded, enter the standard logo (1x) version height, do not enter the retina logo height.', 'evolve'),
            'id' => 'evl_header_logo_retina_height',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'text',
            'title' => __('Standard Logo Height for Retina Logo', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Upload a logo for your sticky header, or specify an image URL directly.', 'evolve'),
            'id' => 'evl_sticky_header_logo_img',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Sticky header logo', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Select an image file for the retina version of the sticky header logo. It should be exactly 2x the size of sticky header logo.', 'evolve'),
            'id' => 'evl_sticky_header_logo_img_retina',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'media',
            'title' => __('Sticky header logo (Retina Version @2x)', 'evolve'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('If retina logo is uploaded, enter the standard sticky header logo (1x) version width, do not enter the retina logo width.', 'evolve'),
            'id' => 'evl_sticky_header_logo_img_retina_width',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'text',
            'title' => __('Standard Sticky Header Logo Width for Retina Logo', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('If retina logo is uploaded, enter the standard sticky header logo (1x) version height, do not enter the retina logo height.', 'evolve'),
            'id' => 'evl_sticky_header_logo_img_retina_height',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'text',
            'title' => __('Standard Sticky Header Logo Height for Retina Logo', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Choose the position of your custom logo for Header #1', 'evolve'),
            'id' => 'evl_pos_logo',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'left' => __('Left', 'evolve'),
                'center' => __('Center', 'evolve'),
                'right' => __('Right', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('Logo position', 'evolve'),
            'default' => 'left',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-title-tagline-tab',
    'title' => __('Title & Tagline', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you don\'t want to display title of your blog', 'evolve'),
            'id' => 'evl_blog_title',
            'type' => 'checkbox',
            'title' => __('Disable Blog Title', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Choose the position of blog tagline', 'evolve'),
            'id' => 'evl_tagline_pos',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'next' => __('Next to blog title', 'evolve'),
                'above' => __('Above blog title', 'evolve'),
                'under' => __('Under blog title', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('Blog Tagline position', 'evolve'),
            'default' => 'next',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-menu-tab',
    'title' => __('Menu', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you don\'t want to display main menu', 'evolve'),
            'id' => 'evl_main_menu',
            'type' => 'checkbox',
            'title' => __('Disable main menu', 'evolve'),
        ),
        array(
            'subtitle' => __('Select the main menu hover effect.', 'evolve'),
            'id' => 'evl_main_menu_hover_effect',
            'type' => 'select',
            'options' => array(
                'rollover' => __('Rollover', 'evolve'),
                'disable' => __('Disabled', 'evolve'),
            ),
            'title' => __('Choose menu item hover effect', 'evolve'),
            'default' => 'rollover',
        ),
        array(
            'subtitle' => __('Padding between menu items.', 'evolve'),
            'id' => 'evl_main_menu_padding',
            'type' => 'spinner',
            'title' => __('Padding Between Menu Items', 'evolve'),
            'default' => '8',
        ),
        array(
            'subtitle' => __('Main menu text transform', 'evolve'),
            'id' => 'evl_menu_text_transform',
            'compiler' => true,
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'select',
            'options' => array(
                'none' => __('none', 'evolve'),
                'lowercase' => __('lowercase', 'evolve'),
                'capitalize' => __('Capitalize', 'evolve'),
                'uppercase' => __('UPPERCASE', 'evolve'),
            ),
            'title' => __('Set the main menu text transform', 'evolve'),
            'default' => 'none',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Menu dropdown icon style', 'evolve'),
            'id' => 'evl_menu_submenu_font_icon',
            'compiler' => true,
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'select',
            'options' => array(
                'regular' => __('Arrow', 'evolve'),
                'plus' => __('Plus', 'evolve')
            ),
            'title' => __('Select the menu dropdown icon style', 'evolve'),
            'default' => 'regular',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Choose the style of responsive menu on smaller screen sizes', 'evolve'),
            'id' => 'evl_responsive_menu',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'select',
            'options' => array(
                'icon' => __('Icon', 'evolve'),
                'text' => __('Text', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('Responsive Menu', 'evolve'),
            'default' => 'icon',
            'class' => $evolve_prem_class,
        ),
        array(
            'title' => __('Responsive Menu Text', 'evolve'),
            'subtitle' => __('Type the text for the responsive menu', 'evolve'),
            'id' => "evl_responsive_menu_text",
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => "text",
            'required' => array(array("evl_responsive_menu", '=', 'text')),
            'default' => 'Menu',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Choose the layout of responsive menu on smaller screen sizes', 'evolve'),
            'id' => 'evl_responsive_menu_layout',
            'type' => 'select',
            'options' => array(
                'basic' => __('Basic Responsive Menu', 'evolve'),
                'dropdown' => __('Clean Dropdown Menu', 'evolve'),
            ),
            'title' => __('Responsive Menu Layout', 'evolve'),
            'default' => 'basic',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-header-subsec-header-widgets-tab',
    'title' => __('Header Widgets', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select how many header widget areas you want to display.', 'evolve'),
            'id' => 'evl_widgets_header',
            'type' => 'image_select',
            'options' => array(
                'disable' => $evolve_imagepath . '1c.png',
                'one' => $evolve_imagepath . 'header-widgets-1.png',
                'two' => $evolve_imagepath . 'header-widgets-2.png',
                'three' => $evolve_imagepath . 'header-widgets-3.png',
                'four' => $evolve_imagepath . 'header-widgets-4.png',
            ),
            'title' => __('Number of widget cols in header', 'evolve'),
            'default' => 'disable',
        ),
        array(
            'subtitle' => __('Choose where to display header widgets', 'evolve'),
            'id' => 'evl_header_widgets_placement',
            'type' => 'select',
            'options' => array(
                'home' => __('Home page', 'evolve'),
                'single' => __('Single Post', 'evolve'),
                'page' => __('Pages', 'evolve'),
                'all' => __('All pages', 'evolve'),
                'custom' => __('Select Per Post/Page', 'evolve'),
            ),
            'title' => __('Header widgets placement', 'evolve'),
            'default' => 'home',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-footer-main-tab',
    'title' => __('Footer', 'evolve'),
    'icon' => 't4p-icon-file4',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-footer-subsec-footer-widgets-tab',
    'title' => __('Footer Widgets', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select how many footer widget areas you want to display.', 'evolve'),
            'id' => 'evl_widgets_num',
            'type' => 'image_select',
            'options' => array(
                'disable' => $evolve_imagepath . '1c.png',
                'one' => $evolve_imagepath . 'footer-widgets-1.png',
                'two' => $evolve_imagepath . 'footer-widgets-2.png',
                'three' => $evolve_imagepath . 'footer-widgets-3.png',
                'four' => $evolve_imagepath . 'footer-widgets-4.png',
            ),
            'title' => __('Number of widget cols in footer', 'evolve'),
            'default' => 'disable',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-footer-subsec-custom-footer-tab',
    'title' => __('Custom Footer', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'desc' => __('Available <strong>HTML</strong> tags and attributes:<br /><br /> <code> &lt;b&gt; &lt;i&gt; &lt;a href="" title=""&gt; &lt;blockquote&gt; &lt;del datetime=""&gt; <br /> &lt;ins datetime=""&gt; &lt;img src="" alt="" /&gt; &lt;ul&gt; &lt;ol&gt; &lt;li&gt; <br /> &lt;code&gt; &lt;em&gt; &lt;strong&gt; &lt;div&gt; &lt;span&gt; &lt;h1&gt; &lt;h2&gt; &lt;h3&gt; &lt;h4&gt; &lt;h5&gt; &lt;h6&gt; <br /> &lt;table&gt; &lt;tbody&gt; &lt;tr&gt; &lt;td&gt; &lt;br /&gt; &lt;hr /&gt;</code>', 'evolve'),
            'id' => 'evl_footer_content',
            'type' => 'textarea',
            'title' => __('Custom footer', 'evolve'),
            'default' => '<p id="copyright"><span class="credits">' . sprintf(__('<a href="%s">evolve</a> theme by Theme4Press&nbsp;&nbsp;&bull;&nbsp;&nbsp;Powered by <a href="http://wordpress.org">WordPress</a>','evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/').'</span></p>',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-main-tab',
    'title' => __('Typography', 'evolve'),
    'icon' => 't4p-icon-appbartextserif',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-custom',
    'title' => __('Custom Fonts', 'evolve'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'raw' => __('<h3 style=\'margin: 0;\'>Custom fonts for all elements.</h3><p style="margin-bottom:0;">This will override the Google / standard font options. All 4 files are required.</h3>', 'evolve'),
            'id' => 'evl_custom_fonts',
            'type' => 'info',
        ),
        array(
            'subtitle' => __('Upload the .woff font file.', 'evolve'),
            'id' => 'evl_custom_font_woff',
            'mode' => 0,
            'type' => 'media',
            'title' => __('Custom Font .woff', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Upload the .ttf font file.', 'evolve'),
            'id' => 'evl_custom_font_ttf',
            'mode' => 0,
            'type' => 'media',
            'title' => __('Custom Font .ttf', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Upload the .svg font file.', 'evolve'),
            'id' => 'evl_custom_font_svg',
            'mode' => 0,
            'type' => 'media',
            'title' => __('Custom Font .svg', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Upload the .eot font file.', 'evolve'),
            'id' => 'evl_custom_font_eot',
            'mode' => 0,
            'type' => 'media',
            'title' => __('Custom Font .eot', 'evolve'),
            'url' => true,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-subsec-title-tagline-tab',
    'title' => __('Title & Tagline', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your blog title. * non web-safe font.', 'evolve'),
            'id' => 'evl_title_font',
            'type' => 'typography',
            'title' => __('Blog Title font', 'evolve'),
            'text-align' => false,
            'line-height' => false,
            'default' => array(
                'font-size' => '39px',
                'color' => '#ffffff',
                'font-family' => 'Roboto',
                'font-style' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your blog tagline. * non web-safe font.', 'evolve'),
            'id' => 'evl_tagline_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Blog tagline font', 'evolve'),
            'default' => array(
                'font-size' => '13px',
                'color' => '#aaaaaa',
                'font-family' => 'Roboto',
                'font-style' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your sticky header blog title. * non web-safe font.', 'evolve'),
            'id' => 'evl_menu_blog_title_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Sticky header blog title font', 'evolve'),
            'default' => array(
                'font-size' => '25px',
                'color' => '#ffffff',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-subsec-menu-tab',
    'title' => __('Menu', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your main menu. * non web-safe font.', 'evolve'),
            'id' => 'evl_menu_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Main menu font', 'evolve'),
            'default' => array(
                'font-size' => '15px',
                'color' => '#c1c1c1',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your top menu. * non web-safe font.', 'evolve'),
            'id' => 'evl_top_menu_font',
            'type' => 'typography',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'text-align' => false,
            'class' => $evolve_prem_class,
            'line-height' => false,
            'title' => __('Top menu font', 'evolve'),
            'default' => array(
                'font-size' => '12px',
                'color' => '#c1c1c1',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Set the font size for mega menu column titles (menu 2nd level labels). In pixels, ex: 15px', 'evolve'),
            'id' => 'evl_megamenu_title_size',
            'type' => 'text',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Mega Menu Column Title Size', 'evolve'),
            'default' => '15px',
            'class' => $evolve_prem_class,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-subsec-widget-tab',
    'title' => __('Widget', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your widget title. * non web-safe font.', 'evolve'),
            'id' => 'evl_widget_title_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Widget title font', 'evolve'),
            'default' => array(
                'font-size' => '19px',
                'color' => '#333',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your widget content. * non web-safe font.', 'evolve'),
            'id' => 'evl_widget_content_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Widget content font', 'evolve'),
            'default' => array(
                'font-size' => '13px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
    ),
        )
);
Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-subsec-post-tab',
    'title' => __('Post Title & Content', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your post titles. * non web-safe font.', 'evolve'),
            'id' => 'evl_post_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Post title font', 'evolve'),
            'default' => array(
                'font-size' => '28px',
                'color' => '#51545C',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Content font', 'evolve'),
            'default' => array(
                'font-size' => '16px',
                'color' => '#333',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-content-boxes',
    'title' => __('Front Page Content Boxes', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your content boxes titles. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_boxes_title_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Content boxes title font', 'evolve'),
            'default' => array(
                'font-size' => '30px',
                'color' => '#6b6b6b',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your content boxes description. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_boxes_description_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('Content boxes description font', 'evolve'),
            'default' => array(
                'font-size' => '22px',
                'color' => '#888',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-typography-subsec-headings-tab',
    'title' => __('Headings', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the typography you want for your H1 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h1_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('H1 font', 'evolve'),
            'default' => array(
                'font-size' => '46px',
                'color' => '#333',
                'font-family' => 'Roboto',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your H2 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h2_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('H2 font', 'evolve'),
            'default' => array(
                'font-size' => '40px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your H3 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h3_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('H3 font', 'evolve'),
            'default' => array(
                'font-size' => '34px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your H4 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h4_font',
            'type' => 'typography',
            'title' => __('H4 font', 'evolve'),
            'text-align' => false,
            'line-height' => false,
            'default' => array(
                'font-size' => '27px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your H5 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h5_font',
            'type' => 'typography',
            'title' => __('H5 font', 'evolve'),
            'text-align' => false,
            'line-height' => false,
            'default' => array(
                'font-size' => '20px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for your H6 tag in blog content. * non web-safe font.', 'evolve'),
            'id' => 'evl_content_h6_font',
            'type' => 'typography',
            'text-align' => false,
            'line-height' => false,
            'title' => __('H6 font', 'evolve'),
            'default' => array(
                'font-size' => '14px',
                'font-family' => 'Roboto',
                'color' => '#333',
                'font-weight' => '400',
            ),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-pagetitlebar-tab',
    'title' => __('Page Title / Breadcrumbs / Page Title Bar', 'evolve'),
    'icon' => 't4p-icon-titlebar',
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to enable breadcrumbs navigation', 'evolve'),
            'id' => 'evl_breadcrumbs',
            'type' => 'checkbox',
            'title' => __('Enable Breadcrumbs Navigation', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Choose the display option to show the page title', 'evolve'),
            'id' => 'evl_display_pagetitlebar',
            'type' => 'select',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'class' => $evolve_prem_class,
            'options' => array(
                'titlebar_breadcrumb' => __('Title + Breadcrumb', 'evolve'),
                'titlebar' => __('Only Title', 'evolve'),
                'breadcrumb' => __('Only Breadcrumb', 'evolve'),
                'none' => __('None', 'evolve'),
            ),
            'title' => __('Page Title & Breadcrumbs', 'evolve'),
            'default' => 'titlebar_breadcrumb',
        ),
        array(
            'subtitle' => __('Check this box if you want to display page titlebar above the content and sidebar area', 'evolve'),
            'id' => 'evl_pagetitlebar_layout',
            'compiler' => true,
            'type' => 'switch',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'on' => __('Enabled', 'evolve'),
            'class' => $evolve_prem_class,
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Page Title Bar', 'evolve'),
        ),
        array(
            'subtitle' => __('Choose your page titlebar layout', 'evolve'),
            'id' => 'evl_pagetitlebar_layout_opt',
            'compiler' => true,
            'type' => 'image_select',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Page Title Bar Layout Type', 'evolve'),
            'options' => array(
                'titlebar_left' => $evolve_imagepathfolder . '/titlebarlayout/titlebar_left.jpg',
                'titlebar_center' => $evolve_imagepathfolder . '/titlebarlayout/titlebar_center.jpg',
                'titlebar_right' => $evolve_imagepathfolder . '/titlebarlayout/titlebar_right.jpg',
            ),
            'default' => 'titlebar_left',
        ),
        array(
            'subtitle' => __('Title bar padding for top and bottom', 'evolve'),
            'id' => 'evl_pagetitlebar_padding',
            'type' => 'spinner',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Page Title Bar Padding', 'evolve'),
            'default' => '25',
        ),
        array(
            'subtitle' => __('Custom background color of page title bar', 'evolve'),
            'id' => 'evl_pagetitlebar_background_color',
            'type' => 'color',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'compiler' => true,
            'title' => __('Page Title Bar Background Color', 'evolve'),
            'default' => '#f9f9f9',
        ),
        array(
            'subtitle' => __('Select an image or insert an image url to use for the page title bar background.', 'evolve'),
            'id' => 'evl_pagetitlebar_background',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Page Title Bar Background', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Select an image or insert an image url to use for the retina page title bar background.', 'evolve'),
            'id' => 'evl_pagetitlebar_background_retina',
            'type' => 'media',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Page Title Bar Background (Retina Version @2x)', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Check this box to have the page title bar background image display at 100% in width and height and scale according to the browser size.', 'evolve'),
            'id' => 'evl_pagetitlebar_background_full',
            'compiler' => true,
            'type' => 'checkbox',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('100% Background Image', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Check to enable parallax background image when scrolling.', 'evolve'),
            'id' => 'evl_pagetitlebar_background_parallax',
            'compiler' => true,
            'type' => 'checkbox',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Parallax Background Image', 'evolve'),
            'default' => '0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-main-tab',
    'title' => __('Styling', 'evolve'),
    'icon' => 't4p-icon-appbardrawpaintbrush',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-header-footer-tab',
    'title' => __('Header & Footer', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('<h3 style=\'margin: 0;\'>Header Styling</h3>', 'evolve'),
            'id' => 'evl_header_styling',
            'type' => 'info',
        ),
        array(
            'subtitle' => sprintf('%s<a href="%s">Header Background</a>', __('Select if the header background image should be displayed in cover or contain size. Change ', 'evolve'), '' . esc_url(admin_url('customize.php?return=&autofocus%5Bcontrol%5D=header_image')) . ''),
            'id' => 'evl_header_image',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'cover' => __('Cover', 'evolve'),
                'contain' => __('Contain', 'evolve'),
                'none' => __('None', 'evolve'),
            ),
            'title' => __('Header Image Background Responsiveness Style', 'evolve'),
            'default' => 'cover',
        ),
        array(
            'id' => 'evl_header_image_background_repeat',
            'type' => 'select',
            'options' => array(
                'no-repeat' => __('no-repeat', 'evolve'),
                'repeat' => __('repeat', 'evolve'),
                'repeat-x' => __('repeat-x', 'evolve'),
                'repeat-y' => __('repeat-y', 'evolve'),
            ),
            'title' => __('Background Repeat', 'evolve'),
            'default' => 'no-repeat',
        ),
        array(
            'id' => 'evl_header_image_background_position',
            'type' => 'select',
            'options' => array(
                'center top' => __('center top', 'evolve'),
                'center center' => __('center center', 'evolve'),
                'center bottom' => __('center bottom', 'evolve'),
                'left top' => __('left top', 'evolve'),
                'left center' => __('left center', 'evolve'),
                'left bottom' => __('left bottom', 'evolve'),
                'right top' => __('right top', 'evolve'),
                'right center' => __('right center', 'evolve'),
                'right bottom' => __('right bottom', 'evolve'),
            ),
            'title' => __('Background Position', 'evolve'),
            'default' => 'center top',
        ),
        array(
            'subtitle' => __('Custom background color of header', 'evolve'),
            'id' => 'evl_header_background_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Header color', 'evolve'),
            'default' => '#313a43',
        ),
        array(
            'subtitle' => __('<h3 style=\'margin: 0;\'>Footer Styling</h3>', 'evolve'),
            'id' => 'evl_footer_styling',
            'type' => 'info',
        ),
        array(
            'subtitle' => __('Upload a footer background image for your theme, or specify an image URL directly.', 'evolve'),
            'id' => 'evl_footer_background_image',
            'type' => 'media',
            'title' => __('Footer Image', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Select if the footer background image should be displayed in cover or contain size.', 'evolve'),
            'id' => 'evl_footer_image',
            'type' => 'select',
            'options' => array(
                'cover' => __('Cover', 'evolve'),
                'contain' => __('Contain', 'evolve'),
                'none' => __('None', 'evolve'),
            ),
            'title' => __('Footer Image Background Responsiveness Style', 'evolve'),
            'default' => 'cover',
        ),
        array(
            'id' => 'evl_footer_image_background_repeat',
            'type' => 'select',
            'options' => array(
                'no-repeat' => __('no-repeat', 'evolve'),
                'repeat' => __('repeat', 'evolve'),
                'repeat-x' => __('repeat-x', 'evolve'),
                'repeat-y' => __('repeat-y', 'evolve'),
            ),
            'title' => __('Background Repeat', 'evolve'),
            'default' => 'no-repeat',
        ),
        array(
            'id' => 'evl_footer_image_background_position',
            'type' => 'select',
            'options' => array(
                'center top' => __('center top', 'evolve'),
                'center center' => __('center center', 'evolve'),
                'center bottom' => __('center bottom', 'evolve'),
                'left top' => __('left top', 'evolve'),
                'left center' => __('left center', 'evolve'),
                'left bottom' => __('left bottom', 'evolve'),
                'right top' => __('right top', 'evolve'),
                'right center' => __('right center', 'evolve'),
                'right bottom' => __('right bottom', 'evolve'),
            ),
            'title' => __('Background Position', 'evolve'),
            'default' => 'center top',
        ),
        array(
            'subtitle' => __('Custom background color of footer', 'evolve'),
            'id' => 'evl_header_footer_back_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Footer color', 'evolve'),
        ),
        array(
            'subtitle' => __('<h3 style=\'margin: 0;\'>Header & Footer Default Pattern</h3>', 'evolve'),
            'id' => 'evl_header_footer',
            'type' => 'info',
        ),
        array(
            'subtitle' => __('Choose the pattern for header and footer background', 'evolve'),
            'id' => 'evl_pattern',
            'compiler' => true,
            'type' => 'image_select',
            'options' => array(
                'none' => $evolve_imagepathfolder . '/header-two/none.jpg',
                'pattern_1_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_1_thumb.png',
                'pattern_2_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_2_thumb.png',
                'pattern_3_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_3_thumb.png',
                'pattern_4_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_4_thumb.png',
                'pattern_5_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_5_thumb.png',
                'pattern_6_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_6_thumb.png',
                'pattern_7_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_7_thumb.png',
                'pattern_8_thumb.png' => $evolve_imagepathfolder . '/pattern/pattern_8_thumb.png',
            ),
            'title' => __('Header and Footer pattern', 'evolve'),
            'default' => 'none',            
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-menu-tab',
    'title' => __('Menu', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Background color of main menu. Only Header #1 and #6 are supported.', 'evolve'),
            'id' => 'evl_menu_back',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'light' => __('Light', 'evolve'),
                'dark' => __('Dark', 'evolve'),
            ),
            'title' => __('Main menu color', 'evolve'),
            'default' => 'light',
        ),
        array(
            'subtitle' => __('Custom background color of main menu.', 'evolve'),
            'id' => 'evl_menu_back_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Or custom main menu color', 'evolve'),
            'default' => '#273039',
        ),
        array(
            'subtitle' => __('Check this box if you want to disable main menu background gradient, shadow effect and borders', 'evolve'),
            'id' => 'evl_disable_menu_back',
            'compiler' => true,
            'type' => 'checkbox',
            'title' => __('Disable main menu background gradient, shadow and borders', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Background color of top menu for Header #2, #3, #4 and #6', 'evolve'),
            'id' => 'evl_top_menu_back',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Top menu color', 'evolve'),
            'default' => '#273039',
        ),
        array(
            'subtitle' => __('Smooth hover effect must be enabled. Works only for Header #1 and #6', 'evolve'),
            'id' => 'evl_top_menu_hover_color',
            'type' => 'color',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'title' => __('Custom menu hover background color', 'evolve'),
            'default' => '#313a43',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Menu hover font color', 'evolve'),
            'id' => 'evl_top_menu_hover_font_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Menu hover font color', 'evolve'),
            'default' => '#fff',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-slideshow-widgets-tab',
    'title' => __('Slideshow & Widgets Area', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Choose the color scheme for the area below header menu', 'evolve'),
            'id' => 'evl_scheme_widgets',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Color scheme of the slideshow and widgets area', 'evolve'),
            'default' => '#273039',
        ),
        array(
            'subtitle' => __('Upload an image for the area below header menu', 'evolve'),
            'id' => 'evl_scheme_background',
            'compiler' => true,
            'type' => 'media',
            'title' => __('Background Image of the slideshow and widgets area', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Have background image always at 100% in width and height and scale according to the browser size.', 'evolve'),
            'id' => 'evl_scheme_background_100',
            'compiler' => true,
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('100% Background Image', 'evolve'),
        ),
        array(
            'id' => 'evl_scheme_background_repeat',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'repeat' => __('repeat', 'evolve'),
                'repeat-x' => __('repeat-x', 'evolve'),
                'repeat-y' => __('repeat-y', 'evolve'),
                'no-repeat' => __('no-repeat', 'evolve'),
            ),
            'title' => __('Background Repeat', 'evolve'),
            'default' => 'no-repeat',
        ),
        array(
            'subtitle' => __('Check this box if you want to enable custom background for widget titles', 'evolve'),
            'compiler' => true,
            'id' => 'evl_widget_background',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'title' => __('Enable Widget Title Custom Background', 'evolve'),
            'default' => 0,
        ),
        array(
            'subtitle' => __('Choose the color scheme for widgets background', 'evolve'),
            'id' => 'evl_widget_bgcolor',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Widget Title Custom Background', 'evolve'),
            'required' => array(
                array('evl_widget_background', '=', '1')
            ),
            'default' => '#273039',
        ),
        array(
            'subtitle' => __('Check this box if you want to disable widget content boxed background', 'evolve'),
            'id' => 'evl_widget_background_image',
            'type' => 'checkbox',
            'compiler' => true,
            'title' => __('Disable Widget Content Boxed Background', 'evolve'),
            'default' => 1,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-content-tab',
    'title' => __('Content', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Upload a content background image for your theme, or specify an image URL directly.', 'evolve'),
            'id' => 'evl_content_background_image',
            'type' => 'media',
            'compiler' => true,
            'title' => __('Content Image', 'evolve'),
            'url' => true,
        ),
        array(
            'subtitle' => __('Select if the content background image should be displayed in cover or contain size.', 'evolve'),
            'id' => 'evl_content_image_responsiveness',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'cover' => __('Cover', 'evolve'),
                'contain' => __('Contain', 'evolve'),
            ),
            'title' => __('Content Image Background Responsiveness Style', 'evolve'),
            'default' => 'cover',
        ),
        array(
            'subtitle' => __('Background color of content', 'evolve'),
            'id' => 'evl_content_back',
            'type' => 'select',
            'options' => array(
                'light' => __('Light', 'evolve'),
                'dark' => __('Dark', 'evolve'),
            ),
            'title' => __('Content color', 'evolve'),
            'default' => 'light',
        ),
        array(
            'subtitle' => __('Custom background color of content area', 'evolve'),
            'id' => 'evl_content_background_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Or Custom content color', 'evolve'),
            'default' => '#ffffff',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-links-buttons-tab',
    'title' => __('Links', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Custom color for content links', 'evolve'),
            'id' => 'evl_general_link',
            'compiler' => true,
            'type' => 'color',
            'title' => __('General Link Color', 'evolve'),
            'default' => '#0bb697',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-styling-subsec-shadows-tab',
    'title' => __('Shadows', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Enables the shadow effect on the elements, enables text shadows', 'evolve'),
            'id' => 'evl_shadow_effect',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'enable' => __('Enabled', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('Shadow Effect', 'evolve'),
            'default' => 'disable',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-element-colors',
    'title' => __('Element Colors', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of form fields.', 'evolve'),
            'id' => 'evl_form_bg_color',
            'type' => 'color',
            'title' => __('Form Background Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the text color for forms.', 'evolve'),
            'id' => 'evl_form_text_color',
            'type' => 'color',
            'title' => __('Form Text Color', 'evolve'),
            'default' => '#888888',
        ),
        array(
            'subtitle' => __('Controls the border color of form fields.', 'evolve'),
            'id' => 'evl_form_border_color',
            'type' => 'color',
            'title' => __('Form Border Color', 'evolve'),
            'default' => '#E0E0E0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-main-tab',
    'title' => __('Shortcodes', 'evolve'),
    'icon' => 't4p-icon-appbardrawbrush',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-accordion-tab',
    'title' => __('Accordion', 'evolve'),
    'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,    
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the inactive boxes behind the \'+\' icons.', 'evolve'),
            'id' => 'evl_shortcode_accordion_inactive_box_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Accordion Inactive Box Color', 'evolve'),
            'default' => '#f2f2f2',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-blog-tab',
    'title' => __('Blog', 'evolve'),
    'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the icon circle in blog alternate and recent posts layouts.', 'evolve'),
            'id' => 'evl_shortcode_blog_icon_circle_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Blog Icon Circle Color', 'evolve'),
            'default' => '#eef0f2',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-button-tab',
    'title' => __('Button', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the default button size.', 'evolve'),
            'id' => 'evl_shortcode_button_size',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'Small' => __('Small', 'evolve'),
                'Medium' => __('Medium', 'evolve'),
                'Large' => __('Large', 'evolve'),
                'XLarge' => __('XLarge', 'evolve'),
            ),
            'title' => __('Button Size', 'evolve'),
			'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'default' => 'Large',
			'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Select the default shape for buttons.', 'evolve'),
            'id' => 'evl_shortcode_button_shape',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'Square' => __('Square', 'evolve'),
                'Round' => __('Round', 'evolve'),
                'Pill' => __('Pill', 'evolve'),
            ),
            'title' => __('Button Shape', 'evolve'),
            'default' => 'Round',
        ),
        array(
            'subtitle' => __('Select the default button type.', 'evolve'),
            'id' => 'evl_shortcode_button_type',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'Flat' => __('Flat', 'evolve'),
                '3d' => __('3d', 'evolve'),
            ),
            'title' => __('Button Type', 'evolve'),
            'default' => '3d',
        ),
        array(
            'subtitle' => __('Controls the top color of the button gradients.', 'evolve'),
            'id' => 'evl_shortcode_button_gradient_top_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Gradient Top Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the bottom color of the button gradients.', 'evolve'),
            'id' => 'evl_shortcode_button_gradient_bottom_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Gradient Bottom Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the top hover color of the button gradients.', 'evolve'),
            'id' => 'evl_shortcode_button_gradient_top_hover_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Gradient Top Hover Color', 'evolve'),
            'default' => '#313a43',
        ),
        array(
            'subtitle' => __('Controls the bottom hover color of the button gradients.', 'evolve'),
            'id' => 'evl_shortcode_button_gradient_bottom_hover_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Gradient Bottom Hover Color', 'evolve'),
            'default' => '#313a43',
        ),
        array(
            'subtitle' => __('This option controls the color of the button text and icon.', 'evolve'),
            'id' => 'evl_shortcode_button_accent_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Accent Color', 'evolve'),
            'default' => '#f4f4f4',
        ),
        array(
            'subtitle' => __('This option controls the hover color of the button text and icon.', 'evolve'),
            'id' => 'evl_shortcode_button_accent_hover_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Accent Hover Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the default bevel color of the buttons.', 'evolve'),
            'id' => 'evl_shortcode_button_bevel_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Bevel Color (3D Mode only)', 'evolve'),
            'default' => '#1d6e72',
        ),
        array(
            'subtitle' => __('Controls the border color of the buttons.', 'evolve'),
            'id' => 'evl_shortcode_button_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Border Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the border hover color of the buttons.', 'evolve'),
            'id' => 'evl_shortcode_button_border_hover_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Button Border Hover Color', 'evolve'),
            'default' => '#313a43',
        ),
        array(
            'subtitle' => __('Select the border width for buttons. Enter value in px. ex: 1px', 'evolve'),
            'id' => 'evl_shortcode_button_border_width',
            'type' => 'text',
            'title' => __('Button Border Width', 'evolve'),
            'default' => '1px',
        ),
        array(
            'subtitle' => __('Select the box to disable the inset shadow and text shadow on the flat button type.', 'evolve'),
            'id' => 'evl_shortcode_button_shadow',
            'type' => 'checkbox',
            'title' => __('Disable Flat Button Shadow', 'evolve'),
            'default' => '1',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-content-box-tab',
    'title' => __('Content Box', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the background for content boxes. Only use for \'icon-boxed\' style. Leave transparent for other styles.', 'evolve'),
            'id' => 'evl_shortcode_content_box_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Content Box Background Color', 'evolve'),
            'default' => 'transparent',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-checklist-tab',
    'title' => __('Checklist', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Check the box if you want to use circles on checklists.', 'evolve'),
            'id' => 'evl_shortcode_checklist_circle',
            'type' => 'checkbox',
            'title' => __('Checklist Circle', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Controls the color of the checklist circle.', 'evolve'),
            'id' => 'evl_shortcode_checklist_circle_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Checklist Circle Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of the checklist icon.', 'evolve'),
            'id' => 'evl_shortcode_checklist_circle_icon_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Checklist Icon Color', 'evolve'),
            'default' => '#747474',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-counter-boxes-tab',
    'title' => __('Counter Boxes', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Check the box if you want to display counter box shadow.', 'evolve'),
            'id' => 'evl_shortcode_counter_boxes_shadow',
            'compiler' => true,
            'title' => __('Counter Box Shadow', 'evolve'),
            'type' => 'checkbox',
            'default' => '0',
        ),
        array(
            'subtitle' => __('Controls the color of the counter text and icon.', 'evolve'),
            'id' => 'evl_shortcode_counter_boxes_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Counter Box Text Color', 'evolve'),
            'default' => '#000000',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-counter-circle-tab',
    'title' => __('Counter Circle', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the counter text and icon.', 'evolve'),
            'id' => 'evl_shortcode_counter_circle_filled_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Counter Circle Filled Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of the counter text and icon.', 'evolve'),
            'id' => 'evl_shortcode_counter_circle_unfilled_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Counter Circle Unfilled Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-dropcap-tab',
    'title' => __('Dropcap', 'evolve'),
    'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the dropcap text, or the dropcap box is a box is used.', 'evolve'),
            'id' => 'evl_shortcode_dropcap_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Dropcap Color', 'evolve'),
            'default' => '#0bb697',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-flip-boxes-tab',
    'title' => __('Flip Boxes', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of frontside background color.', 'evolve'),
            'id' => 'evl_shortcode_flip_boxes_bg_color_frontside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Background Color Frontside', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the color of frontside heading color.', 'evolve'),
            'id' => 'evl_shortcode_flip_boxes_heading_color_frontside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Heading Color Frontside', 'evolve'),
            'default' => '#333333',
        ),
        array(
            'subtitle' => __('Controls the color of frontside text color.', 'evolve'),
            'id' => 'evl_shortcode_flip_text_color_frontside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Text Color Frontside', 'evolve'),
            'default' => '#747474',
        ),
        array(
            'subtitle' => __('Controls the color of backside background color.', 'evolve'),
            'id' => 'evl_shortcode_flip_bg_color_backside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Background Color Backside', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of backside heading color.', 'evolve'),
            'id' => 'evl_shortcode_flip_heading_color_backside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Heading Color Backside', 'evolve'),
            'default' => '#eeeded',
        ),
        array(
            'subtitle' => __('Controls the color of backside text color.', 'evolve'),
            'id' => 'evl_shortcode_flip_text_color_backside',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Text Color Backside', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the border size of flip boxes.', 'evolve'),
            'id' => 'evl_shortcode_flip_border_size',
            'type' => 'text',
            'title' => __('Flip Box Border Size', 'evolve'),
            'default' => '1px',
        ),
        array(
            'subtitle' => __('Controls the border color of flip boxes.', 'evolve'),
            'id' => 'evl_shortcode_flip_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Flip Box Border Color', 'evolve'),
            'default' => 'transparent',
        ),
        array(
            'subtitle' => __('Controls the border radius (roundness) of flip boxes.', 'evolve'),
            'id' => 'evl_shortcode_flip_border_radius',
            'type' => 'text',
            'title' => __('Flip Box Border Radius', 'evolve'),
            'default' => '3px',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-full-width-tab',
    'title' => __('Full Width', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of the full width section.', 'evolve'),
            'id' => 'evl_shortcode_full_width_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Full Width Background Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the border size of the full width section.', 'evolve'),
            'id' => 'evl_shortcode_full_width_border_size',
            'type' => 'text',
            'title' => __('Full Width Border Size', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Controls the border color of the full width section.', 'evolve'),
            'id' => 'evl_shortcode_full_width_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Full Width Border Color', 'evolve'),
            'default' => '#eae9e9',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-icon-tab',
    'title' => __('Icon', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls color of lines next to text titles.', 'evolve'),
            'id' => 'evl_shortcode_icon_border_title_sep_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Border Title Separator Color', 'evolve'),
            'default' => '#F0F0F0',
        ),
        array(
            'subtitle' => __('Controls the color of the circle when used with icons.', 'evolve'),
            'id' => 'evl_shortcode_icon_circle_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Icon Circle Color', 'evolve'),
            'default' => '#f2f2f2',
        ),
        array(
            'subtitle' => __('Controls the color of the circle border when used with icons.', 'evolve'),
            'id' => 'evl_shortcode_icon_circle_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Icon Circle Border Color', 'evolve'),
            'default' => '#f2f2f2',
        ),
        array(
            'subtitle' => __('Controls the color of the icons.', 'evolve'),
            'id' => 'evl_shortcode_icon_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Icon Color', 'evolve'),
            'default' => '#747474',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-image-frame-tab',
    'title' => __('Image Frame', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the border color of the image frame.', 'evolve'),
            'id' => 'evl_shortcode_image_frame_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Image frame Border Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the border size of the image.', 'evolve'),
            'id' => 'evl_shortcode_image_frame_border_size',
            'type' => 'text',
            'title' => __('Image Frame Border Size', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Controls the style color of the image frame. Only works for glow and dropshadow style.', 'evolve'),
            'id' => 'evl_shortcode_image_frame_style_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Image frame Style Color', 'evolve'),
            'default' => '#000000',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-modal-tab',
    'title' => __('Modal', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of the modal popup box', 'evolve'),
            'id' => 'evl_shortcode_modal_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Modal Background Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the border color of the modal popup box', 'evolve'),
            'id' => 'evl_shortcode_modal_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Modal Border Color', 'evolve'),
            'default' => '#ebebeb',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-person-tab',
    'title' => __('Person', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the border size of the image.', 'evolve'),
            'id' => 'evl_shortcode_person_border_size',
            'type' => 'text',
            'title' => __('Person Border Size', 'evolve'),
            'default' => '0px',
        ),
        array(
            'subtitle' => __('Controls the border color of the of the image.', 'evolve'),
            'id' => 'evl_shortcode_person_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Person Border Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('For all style types except border. Controls the style color.', 'evolve'),
            'id' => 'evl_shortcode_person_style_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Person Style Color', 'evolve'),
            'default' => '#000000',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-popover-tab',
    'title' => __('Popover', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of popover heading area.', 'evolve'),
            'id' => 'evl_shortcode_popover_heading_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Popover Heading Background Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the background color of popover content area.', 'evolve'),
            'id' => 'evl_shortcode_popover_content_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Popover Content Background Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the border color of popover box.', 'evolve'),
            'id' => 'evl_shortcode_popover_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Popover Border Color', 'evolve'),
            'default' => '#ebebeb',
        ),
        array(
            'subtitle' => __('Controls the text color inside the popover box.', 'evolve'),
            'id' => 'evl_shortcode_popover_text_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Popover Text Color', 'evolve'),
            'default' => '#000000',
        ),
        array(
            'subtitle' => __('Controls the position of the popover in reference to the triggering text.', 'evolve'),
            'id' => 'evl_shortcode_popover_position',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'Top' => __('Top', 'evolve'),
                'Right' => __('Right', 'evolve'),
                'Bottom' => __('Bottom', 'evolve'),
                'Left' => __('Left', 'evolve'),
            ),
            'title' => __('Popover Position', 'evolve'),
            'default' => 'Top',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-pricing-table-tab',
    'title' => __('Pricing Table', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the heading color of separate pricing boxes.', 'evolve'),
            'id' => 'evl_shortcode_pricing_style_1_heading_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Style 1 Heading Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the heading color of full boxed pricing tables.', 'evolve'),
            'id' => 'evl_shortcode_pricing_style_2_heading_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Style 2 Heading Color', 'evolve'),
            'default' => '#333333',
        ),
        array(
            'subtitle' => __('Controls the color portions of pricing boxes.', 'evolve'),
            'id' => 'evl_shortcode_pricing_box_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of main background and title background.', 'evolve'),
            'id' => 'evl_shortcode_pricing_box_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Bg Color', 'evolve'),
            'default' => '#ffffff',
        ),
        array(
            'subtitle' => __('Controls the color of the outer border, pricing row and footer row backgrounds.', 'evolve'),
            'id' => 'evl_shortcode_pricing_box_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Border Color', 'evolve'),
            'default' => '#dcdcdc',
        ),
        array(
            'subtitle' => __('Controls the color of the dividers in-between pricing rows.', 'evolve'),
            'id' => 'evl_shortcode_pricing_box_divider_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Pricing Box Divider Color', 'evolve'),
            'default' => '#ededed',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-progress-bar-tab',
    'title' => __('Progress Bar', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the filled area in progress bars.', 'evolve'),
            'id' => 'evl_shortcode_progress_filled_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Progress Bar Filled Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of the unfilled area in progress bars.', 'evolve'),
            'id' => 'evl_shortcode_progress_unfilled_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Progress Bar Unfilled Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the color of the text in progress bars.', 'evolve'),
            'id' => 'evl_shortcode_progress_text_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Progress Bar Text Color', 'evolve'),
            'default' => '#ffffff',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-separator-tab',
    'title' => __('Separator', 'evolve'),
    'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of all separators, divider lines and borders for meta, previous & next, filters, category page, boxes around number pagination, sidebar widgets, accordion divider lines, counter boxes and more.', 'evolve'),
            'id' => 'evl_shortcode_separator_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Separators Color', 'evolve'),
            'default' => '#f0f0f0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-section-separator-tab',
    'title' => __('Section Separator', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the border size of the section separator.', 'evolve'),
            'id' => 'evl_shortcode_section_separator_border_size',
            'type' => 'text',
            'title' => __('Section Separator Border Size', 'evolve'),
            'default' => '1px',
        ),
        array(
            'subtitle' => __('Controls the background color of the divider candy.', 'evolve'),
            'id' => 'evl_shortcode_section_separator_bg_color_candy',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Section Separator Background Color of Divider Candy', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the border color of the separator.', 'evolve'),
            'id' => 'evl_shortcode_section_separator_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Section Separator Border Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-sharing-box-tab',
    'title' => __('Sharing Box', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of the sharing box.', 'evolve'),
            'id' => 'evl_shortcode_sharing_box_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Sharing Box Background Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the text color of the tagline text.', 'evolve'),
            'id' => 'evl_shortcode_sharing_box_tagline_text_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Sharing Box Tagline Text Color', 'evolve'),
            'default' => '#333333',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-social-links-tab',
    'title' => __('Social Links', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Select a custom social icon color.', 'evolve'),
            'id' => 'evl_shortcode_social_icon_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Social Links Custom Icons Color', 'evolve'),
            'default' => '#bebdbd',
        ),
        array(
            'subtitle' => __('Controls the color of the social icons in the sharing box.', 'evolve'),
            'id' => 'evl_shortcode_social_icon_boxed',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'No' => __('No', 'evolve'),
                'Yes' => __('Yes', 'evolve'),
            ),
            'title' => __('Social Links Icons Boxed', 'evolve'),
            'default' => 'No',
        ),
        array(
            'subtitle' => __('Select a custom social icon box color.', 'evolve'),
            'id' => 'evl_shortcode_social_icon_box_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Social Links Icons Custom Box Color', 'evolve'),
            'default' => '#e8e8e8',
        ),
        array(
            'subtitle' => __('Box Radius for the social icons. In pixels, ex: 4px.', 'evolve'),
            'id' => 'evl_shortcode_social_icon_box_radius',
            'type' => 'text',
            'title' => __('Social Links Icons Boxed Radius', 'evolve'),
            'default' => '4px',
        ),
        array(
            'subtitle' => __('Controls the tooltip position of the social icons in the sharing box.', 'evolve'),
            'id' => 'evl_shortcode_social_icon_tooltip_position',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'Top' => __('Top', 'evolve'),
                'Right' => __('Right', 'evolve'),
                'Bottom' => __('Bottom', 'evolve'),
                'Left' => __('Left', 'evolve'),
                'None' => __('None', 'evolve'),
            ),
            'title' => __('Social Links Icons Tooltip Position', 'evolve'),
            'default' => 'Top',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-tabs-tab',
    'title' => __('Tabs', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the active tab, content background color and tab hover.', 'evolve'),
            'id' => 'evl_shortcode_tabs_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Tabs Background Color + Hover Color', 'evolve'),
            'default' => '#0bb697',
        ),
        array(
            'subtitle' => __('Controls the color of the inactive tabs and the outer tab border.', 'evolve'),
            'id' => 'evl_shortcode_tabs_inactive_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Tabs Inactive Color', 'evolve'),
            'default' => '#ebeaea',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-tagline-tab',
    'title' => __('Tagline', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of the tagline box.', 'evolve'),
            'id' => 'evl_shortcode_tagline_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Tagline Box Background Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the border color of the tagline box.', 'evolve'),
            'id' => 'evl_shortcode_tagline_border_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Tagline Box Border Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-testimonials-tab',
    'title' => __('Testimonials', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the background color of the testimonial.', 'evolve'),
            'id' => 'evl_shortcode_testimonial_bg_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Testimonial Background Color', 'evolve'),
            'default' => '#f6f6f6',
        ),
        array(
            'subtitle' => __('Controls the text color of the testimonial font.', 'evolve'),
            'id' => 'evl_shortcode_testimonial_text_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Testimonial Text Color', 'evolve'),
            'default' => '#747474',
        ),
        array(
            'subtitle' => __('Select the slideshow speed, 1000 = 1 second.', 'evolve'),
            'id' => 'evl_shortcode_testimonial_speed',
            'type' => 'text',
            'title' => __('Testimonials Speed', 'evolve'),
            'default' => '4000',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-shortcode-subsec-shortcodes-title-tab',
    'title' => __('Title', 'evolve'),
    'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Controls the color of the title separators', 'evolve'),
            'id' => 'evl_shortcode_title_sep_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Title Separator Color', 'evolve'),
            'default' => '#f0f0f0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-blog-main-tab',
    'title' => __('Blog', 'evolve'),
    'icon' => 't4p-icon-appbarclipboardvariantedit',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-blog-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Select the sidebar that will display on the archive/category pages.', 'evolve'),
            'id' => 'evl_blog_archive_sidebar',
            'type' => 'select',
            'options' => $sidebar_options,
            'title' => __('Blog Archive/Category Sidebar', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'default' => 'None',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Grid layout with <strong>3</strong> posts per row is recommended to use with disabled <strong>Sidebar(s)</strong>', 'evolve'),
            'id' => 'evl_post_layout',
            'type' => 'image_select',
            'compiler' => true,
            'options' => array(
                'one' => $evolve_imagepath . 'one-post.png',
                'two' => $evolve_imagepath . 'two-posts.png',
                'three' => $evolve_imagepath . 'three-posts.png',
            ),
            'title' => __('Blog layout', 'evolve'),
            'default' => 'two',
        ),
        array(
            'subtitle' => __('Enable page title in category pages ?', 'evolve'),
            'id' => 'evl_category_page_title',
            'type' => 'select',
            'options' => array(
                1 => __('Enable', 'evolve'),
                0 => __('Disable', 'evolve'),
            ),
            'title' => __('Category Page Title', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Choose placement of the \'Share This\' buttons', 'evolve'),
            'id' => 'evl_share_this',
            'type' => 'select',
            'options' => array(
                'single' => __('Single posts', 'evolve'),
                'single_archive' => __('Single posts + Archive pages', 'evolve'),
                'all' => __('All pages', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('\'Share This\' buttons placement', 'evolve'),
            'default' => 'single',
        ),
        array(
            'subtitle' => __('Select the pagination type for the assigned blog page in Settings > Reading.', 'evolve'),
            'id' => 'evl_pagination_type',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'pagination' => __('Pagination', 'evolve'),
                'number_pagination' => __('Number Pagination', 'evolve'),
                'infinite' => __('Infinite Scroll', 'evolve'),
            ),
            'title' => __('Pagination Type', 'evolve'),
            'default' => 'pagination',
        ),
        array(
            'subtitle' => __('Check this box if you want to display edit post link', 'evolve'),
            'id' => 'evl_edit_post',
            'type' => 'checkbox',
            'title' => __('Enable Edit Post Link', 'evolve'),
            'default' => '0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-blog-subsec-post-tab',
    'title' => __('Posts', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Enter number of characters for Post Title Excerpt. This works only if a grid layout is enabled.', 'evolve'),
            'id' => 'evl_posts_excerpt_title_length',
            'type' => 'spinner',
            'title' => __('Post Title Excerpt Length', 'evolve'),
            'default' => '40',
        ),
        array(
            'subtitle' => __('Check this box if you want to display post excerpts on one column blog layout', 'evolve'),
            'id' => 'evl_excerpt_thumbnail',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Enable post excerpts', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to display post author avatar', 'evolve'),
            'id' => 'evl_author_avatar',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Enable post author avatar', 'evolve'),
        ),
        array(
            'subtitle' => __('Choose placement of the post meta header - Date, Author, Comments', 'evolve'),
            'id' => 'evl_header_meta',
            'type' => 'select',
            'options' => array(
                'single_archive' => __('Single posts + Archive pages', 'evolve'),
                'single' => __('Single posts', 'evolve'),
                'disable' => __('Disable', 'evolve'),
            ),
            'title' => __('Post meta header placement', 'evolve'),
            'default' => 'single_archive',
        ),
        array(
            'subtitle' => __('Choose the position of the <strong>Previous/Next Post</strong> links', 'evolve'),
            'id' => 'evl_post_links',
            'type' => 'select',
            'options' => array(
                'after' => __('After posts', 'evolve'),
                'before' => __('Before posts', 'evolve'),
                'both' => __('Both', 'evolve'),
            ),
            'title' => __('Position of previous/next posts links', 'evolve'),
            'default' => 'after',
        ),
        array(
            'subtitle' => __('Choose if you want to display <strong>Similar posts</strong> in articles', 'evolve'),
            'id' => 'evl_similar_posts',
            'type' => 'select',
            'options' => array(
                'disable' => __('Disable', 'evolve'),
                'category' => __('Match by categories', 'evolve'),
                'tag' => __('Match by tags', 'evolve'),
            ),
            'title' => __('Display Similar posts', 'evolve'),
            'default' => 'disable',
        ),
    ),
        )
);
Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-blog-subsec-featured-tab',
    'title' => __('Featured Image', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to display featured images', 'evolve'),
            'id' => 'evl_featured_images',
            'type' => 'checkbox',
            'title' => __('Enable featured images', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Check this box if you want to display featured image on Single Blog Posts', 'evolve'),
            'id' => 'evl_blog_featured_image',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Enable featured image on Single Blog Posts', 'evolve'),
        ),
        array(
            'subtitle' => __('Turn on if you don\'t want to display default thumbnail images', 'evolve'),
            'id' => 'evl_thumbnail_default_images',
            'type' => 'switch',
            'title' => __('Hide default thumbnail images', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-post-format',
    'title' => __('Post Format', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to enable background color for sticky post format', 'evolve'),
            'id' => 'evl_sticky_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Sticky Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for aside post format', 'evolve'),
            'id' => 'evl_aside_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Aside Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for audio post format', 'evolve'),
            'id' => 'evl_audio_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Audio Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for chat post format', 'evolve'),
            'id' => 'evl_chat_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Chat Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for gallery post format', 'evolve'),
            'id' => 'evl_gallery_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Gallery Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for image post format', 'evolve'),
            'id' => 'evl_image_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Image Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for link post format', 'evolve'),
            'id' => 'evl_link_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Link Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for quote post format', 'evolve'),
            'id' => 'evl_quote_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Quote Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for status post format', 'evolve'),
            'id' => 'evl_status_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Status Post Format Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable background color for video post format', 'evolve'),
            'id' => 'evl_video_post_format',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Video Post Format Background', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-portfolio-main-tab',
    'title' => __('Portfolio', 'evolve'),
    'icon' => 't4p-icon-appbarimagemultiple',
    'class' => $evolve_prem_class,
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-portfolio-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Insert the number of posts to display per page.', 'evolve'),
            'id' => 'evl_portfolio_no_item_per_page',
            'type' => 'text',
            'title' => __('Number of Portfolio Items Per Page', 'evolve'),
            'default' => '10',
        ),
        array(
            'subtitle' => __('Select the layout for only the archive/category pages.', 'evolve'),
            'id' => 'evl_portfolio_layout_archive_category',
            'type' => 'select',
            'options' => array(
                'Portfolio One Column' => __('Portfolio One Column', 'evolve'),
                'Portfolio Two Column' => __('Portfolio Two Column', 'evolve'),
                'Portfolio Three Column' => __('Portfolio Three Column', 'evolve'),
                'Portfolio Four Column' => __('Portfolio Four Column', 'evolve'),
                'Portfolio One Column Text' => __('Portfolio One Column Text', 'evolve'),
                'Portfolio Two Column Text' => __('Portfolio Two Column Text', 'evolve'),
                'Portfolio Three Column Text' => __('Portfolio Three Column Text', 'evolve'),
                'Portfolio Four Column Text' => __('Portfolio Four Column Text', 'evolve'),
                'Portfolio Grid' => __('Portfolio Grid', 'evolve'),
            ),
            'title' => __('Portfolio Archive/Category Layout', 'evolve'),
            'default' => 'Portfolio One Column',
        ),
        array(
            'subtitle' => __('Select the sidebar that will be added to the archive/category portfolio pages.', 'evolve'),
            'id' => 'evl_portfolio_sidebar',
            'type' => 'select',
            'options' => $sidebar_options,
            'title' => __('Portfolio Archive/Category Sidebar', 'evolve'),
            'default' => 'None',
        ),
        array(
            'subtitle' => __('Select the sidebar position for the archive/category portfolio pages', 'evolve'),
            'id' => 'evl_portfolio_sidebar_position',
            'type' => 'select',
            'options' => array(
                'left' => __('Left', 'evolve'),
                'right' => __('Right', 'evolve'),
            ),
            'title' => __('Portfolio Archive/Category Sidebar Position', 'evolve'),
            'default' => 'right',
        ),
        array(
            'subtitle' => __('Choose to display an excerpt or full portfolio content on archive / portfolio pages. Note: The "Full Content" option will override the page excerpt settings.', 'evolve'),
            'id' => 'evl_portfolio_excerpt_full_content',
            'type' => 'select',
            'options' => array(
                'Excerpt' => __('Excerpt', 'evolve'),
                'Full Content' => __('Full Content', 'evolve'),
            ),
            'title' => __('Excerpt or Full Portfolio Content', 'evolve'),
            'default' => 'Excerpt',
        ),
        array(
            'subtitle' => __('Insert the number of words you want to show in the post excerpts.', 'evolve'),
            'id' => 'evl_portfolio_excerpt_length',
            'type' => 'text',
            'title' => __('Excerpt Length', 'evolve'),
            'default' => '55',
        ),
        array(
            'subtitle' => __('Check this if you want to strip HTML from the excerpt content only.', 'evolve'),
            'id' => 'evl_portfolio_strip_html',
            'type' => 'checkbox',
            'title' => __('Strip HTML from Excerpt', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Select the pagination type for Portfolio Grid layouts.', 'evolve'),
            'id' => 'evl_portfolio_pagination_type',
            'compiler' => true,
            'type' => 'select',
            'options' => array(
                'pagination' => __('Pagination', 'evolve'),
                'infinite' => __('Infinite Scroll', 'evolve'),
            ),
            'title' => __('Grid Pagination Type', 'evolve'),
            'default' => 'pagination',
        ),
        array(
            'subtitle' => __('Change/Rewrite the permalink when you use the permalink type as %postname%. <strong>Make sure to regenerate permalinks.</strong>', 'evolve'),
            'id' => 'evl_portfolio_slug',
            'type' => 'text',
            'title' => __('Portfolio Slug', 'evolve'),
            'default' => 'portfolio-items',
        ),
        array(
            'subtitle' => __('Check the box to show the rollover box on images.', 'evolve'),
            'id' => 'evl_portfolio_rollover',
            'type' => 'checkbox',
            'title' => __('Image Rollover', 'evolve'),
            'default' => '1',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-portfolio-subsec-single-post-page-tab',
    'title' => __('Portfolio Single Post Page', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'subsection' => true,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Check the box to display featured images and videos on single post pages.', 'evolve'),
            'id' => 'evl_portfolio_featured_image_video',
            'type' => 'checkbox',
            'title' => __('Featured Image / Video on Single Post Page', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Check the box to disable previous/next pagination.', 'evolve'),
            'id' => 'evl_portfolio_disable_pagination',
            'type' => 'checkbox',
            'title' => __('Disable Previous/Next Pagination', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Check the box to enable comments on portfolio items.', 'evolve'),
            'id' => 'evl_portfolio_comments',
            'type' => 'checkbox',
            'title' => __('Show Comments', 'evolve'),
            'default' => '0',
        ),
        array(
            'subtitle' => __('Check the box to enable Author on portfolio items.', 'evolve'),
            'id' => 'evl_portfolio_author',
            'type' => 'checkbox',
            'title' => __('Show Author', 'evolve'),
            'default' => '0',
        ),
        // array(
        // 'subtitle' => __('Check the box to display the social sharing box.', 'evolve'),
        // 'id' => 'evl_portfolio_sharing_box',
        // 'type' => 'checkbox',
        // 'title' => __('Social Sharing Box', 'evolve'),
        // 'default' => '1',
        // ),
        array(
            'subtitle' => __('Check the box to display related posts.', 'evolve'),
            'id' => 'evl_portfolio_related_posts',
            'type' => 'checkbox',
            'title' => __('Related Posts', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('This option controls the amount of related projects / posts that show up on each single portfolio and blog post. ex: 5', 'evolve'),
            'id' => 'evl_portfolio_related_posts_number',
            'type' => 'text',
            'title' => __('Number of Related Posts / Projects', 'evolve'),
            'default' => '5',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-social-sharing-main-tab',
    'title' => __('Social Sharing Box Shortcode', 'evolve'),
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'icon' => 't4p-icon-appbargroup',
    'class' => $evolve_prem_class,
    'fields' => array(
        // array(
        // 'subtitle' => __('Controls the background color of the social share box.', 'evolve'),
        // 'id' => 'evl_sharing_box_bg_color',
        // 'type' => 'color',
        // 'compiler' => true,
        // 'title' => __('Social Share Box Background Color', 'evolve'),
        // 'default' => '#ffffff',
        // ),
        array(
            'subtitle' => __('Select a custom social icon color.', 'evolve'),
            'id' => 'evl_sharing_box_icon_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Social Sharing Box Custom Icons Color', 'evolve'),
            'default' => '#bbbbbb',
        ),
        array(
            'subtitle' => __('Controls the color of the social icons in the sharing box.', 'evolve'),
            'id' => 'evl_sharing_box_control_color',
            'type' => 'select',
            'options' => array(
                'No' => __('No', 'evolve'),
                'Yes' => __('Yes', 'evolve'),
            ),
            'title' => __('Social Sharing Box Icons Boxed', 'evolve'),
            'default' => 'Yes',
        ),
        array(
            'subtitle' => __('Select a custom social icon box color.', 'evolve'),
            'id' => 'evl_sharing_box_box_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Social Sharing Box Icons Custom Box Color', 'evolve'),
            'default' => '#f0f0f0',
        ),
        array(
            'subtitle' => __('Box radius for the social icons. In pixels, ex: 4px.', 'evolve'),
            'id' => 'evl_sharing_box_radius',
            'type' => 'text',
            'title' => __('Social Sharing Box Icons Boxed Radius', 'evolve'),
            'default' => '4px',
        ),
        array(
            'subtitle' => __('Controls the tooltip position of the social icons in the sharing box.', 'evolve'),
            'id' => 'evl_sharing_box_tooltip_position',
            'type' => 'select',
            'options' => array(
                'Top' => __('Top', 'evolve'),
                'Right' => __('Right', 'evolve'),
                'Bottom' => __('Bottom', 'evolve'),
                'Left' => __('Left', 'evolve'),
                'None' => __('None', 'evolve'),
            ),
            'title' => __('Social Sharing Box Icons Tooltip Position', 'evolve'),
            'default' => 'Top',
        ),
        array(
            'subtitle' => __('Show the facebook sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_facebook',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Facebook', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the twitter sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_twitter',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Twitter', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the reddit sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_reddit',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Reddit', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the linkedin sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_linkedin',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('LinkedIn', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the g+ sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_google',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Google Plus', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the tumblr sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_tumblr',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Tumblr', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the pinterest sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_pinterest',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Pinterest', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the email sharing icon in blog posts.', 'evolve'),
            'id' => 'evl_sharing_email',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 0,
            'title' => __('Email', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-social-links-main-tab',
    'title' => __('Social Media Links', 'evolve'),
    'icon' => 't4p-icon-appbarsocialtwitter',
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to display Subscribe/Social links in header', 'evolve'),
            'id' => 'evl_social_links',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Subscribe/Social links in header', 'evolve'),
        ),
        array(
            'subtitle' => __('Choose the color scheme of subscribe/social icons', 'evolve'),
            'id' => 'evl_social_color_scheme',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Subscribe/Social icons color', 'evolve'),
            'default' => '#999999',
        ),
        array(
            'subtitle' => __('Choose the size of subscribe/social icons', 'evolve'),
            'id' => 'evl_social_icons_size',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'normal' => __('Normal', 'evolve'),
                'small' => __('Small', 'evolve'),
                'large' => __('Large', 'evolve'),
                'x-large' => __('X-Large', 'evolve'),
            ),
            'title' => __('Subscribe/Social icons size', 'evolve'),
            'default' => 'normal',
        ),
        array(
            'title' => __('Enable social media links border/radius', 'evolve'),
            'subtitle' => __('Select if you want to display social links with a border, border radius or disable it.', 'evolve'),
            'id' => "evl_social_box_radius",
            'type' => "select",
            'options' => array(
                'disabled' => __('Disabled', 'evolve'),
                '0' => __('0', 'evolve'),
                '1' => __('1', 'evolve'),
                '2' => __('2', 'evolve'),
                '3' => __('3', 'evolve'),
                '4' => __('4', 'evolve'),
                '5' => __('5', 'evolve'),
                '6' => __('6', 'evolve'),
                '7' => __('7', 'evolve'),
                '8' => __('8', 'evolve'),
                '9' => __('9', 'evolve'),
                '10' => __('10', 'evolve'),
                '11' => __('11', 'evolve'),
                '12' => __('12', 'evolve'),
                '13' => __('13', 'evolve'),
                '14' => __('14', 'evolve'),
                '15' => __('15', 'evolve'),
                '16' => __('16', 'evolve'),
                '17' => __('17', 'evolve'),
                '18' => __('18', 'evolve'),
                '19' => __('19', 'evolve'),
                '20' => __('20', 'evolve'),
                '21' => __('21', 'evolve'),
                '22' => __('22', 'evolve'),
                '23' => __('23', 'evolve'),
                '24' => __('24', 'evolve'),
                '25' => __('25', 'evolve'),
            ),
            'default' => 'disabled',
        ),
        array(
            'id' => 'evl_rss_feed',
            'type' => 'text',
            'title' => __('RSS Feed', 'evolve'),
            'default' => $evolve_rss_url,
            'subtitle' => __('Insert custom RSS Feed URL, e.g. <strong>http://feeds.feedburner.com/Example</strong>', 'evolve'),
        ),
        array(
            'id' => 'evl_newsletter',
            'type' => 'text',
            'title' => __('Newsletter', 'evolve'),
            'subtitle' => __('Insert custom newsletter URL, e.g. <strong>http://feedburner.google.com/fb/a/mailverify?uri=Example&amp;loc=en_US</strong>', 'evolve'),
        ),
        array(
            'id' => 'evl_facebook',
            'type' => 'text',
            'title' => __('Facebook', 'evolve'),
            'subtitle' => __('Insert your Facebook URL', 'evolve'),
        ),
        array(
            'id' => 'evl_twitter_id',
            'type' => 'text',
            'title' => __('Twitter', 'evolve'),
            'subtitle' => __('Insert your Twitter URL', 'evolve'),
        ),
        array(
            'id' => 'evl_instagram',
            'type' => 'text',
            'title' => __('Instagram', 'evolve'),
            'subtitle' => __('Insert your Instagram URL', 'evolve'),
        ),
        array(
            'id' => 'evl_skype',
            'type' => 'text',
            'title' => __('Skype', 'evolve'),
            'subtitle' => __('Insert your Skype URL', 'evolve'),
        ),
        array(
            'id' => 'evl_youtube',
            'type' => 'text',
            'title' => __('Youtube', 'evolve'),
            'subtitle' => __('Insert your Youtube URL', 'evolve'),
        ),
        array(
            'id' => 'evl_flickr',
            'type' => 'text',
            'title' => __('Flickr', 'evolve'),
            'subtitle' => __('Insert your Flickr URL', 'evolve'),
        ),
        array(
            'id' => 'evl_linkedin',
            'type' => 'text',
            'title' => __('Linkedin', 'evolve'),
            'subtitle' => __('Insert your Linkedin profile URL', 'evolve'),
        ),
        array(
            'id' => 'evl_googleplus',
            'type' => 'text',
            'title' => __('Google Plus', 'evolve'),
            'subtitle' => __('Insert your Google Plus profile URL', 'evolve'),
        ),
        array(
            'id' => 'evl_pinterest',
            'type' => 'text',
            'title' => __('Pinterest', 'evolve'),
            'subtitle' => __('Insert your Pinterest profile URL', 'evolve'),
        ),
        array(
            'id' => 'evl_tumblr',
            'type' => 'text',
            'title' => __('Tumblr', 'evolve'),
            'subtitle' => __('Insert your Tumblr profile URL', 'evolve'),
        ),
        array(
            'id' => 'evl_header_social_sort',
            'type' => 'sortable',
            'mode' => 'checkbox',
            'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Social Media Icons Order and Display', 'evolve'),
            'subtitle' => __('Drag up or down to arrange Social Media Icons.', 'evolve'),
            'options' => array(
                'evl_rss_feed' => 'RSS',
                'evl_newsletter' => 'Newsletter',
                'evl_facebook' => 'Facebook',
                'evl_twitter_id' => 'Twitter',
                'evl_instagram' => 'Instagram',
                'evl_skype' => 'Skype',
                'evl_youtube' => 'Youtube',
                'evl_flickr' => 'Flickr',
                'evl_linkedin' => 'Linkedin',
                'evl_googleplus' => 'Google Plus',
                'evl_pinterest' => 'Pinterest',
                'evl_tumblr' => 'Tumblr',
            ),
            'default' => array(
                'evl_rss_feed' => '1',
                'evl_newsletter' => '1',
                'evl_facebook' => '1',
                'evl_twitter_id' => '1',
                'evl_instagram' => '1',
                'evl_skype' => '1',
                'evl_youtube' => '1',
                'evl_flickr' => '1',
                'evl_linkedin' => '1',
                'evl_googleplus' => '1',
                'evl_pinterest' => '1',
                'evl_tumblr' => '1',
            ),
        ),
    )
));

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-main-tab',
    'title' => __('Front Page Content Boxes', 'evolve'),
    'icon' => 't4p-icon-appbarimagebacklight',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box to enable Front Page Content Boxes', 'evolve'),
            'id' => 'evl_content_boxes',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Front Page Content Boxes', 'evolve'),
        ),
        array(
            'id' => 'evl_content_box_background_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Content Boxes Background Color', 'evolve'),
            'default' => '#efefef',
        ),
        array(
            'subtitle' => __('Enter the content boxes padding.', 'evolve'),
            'id' => 'evl_content_boxes_padding',
            'type' => 'spacing',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'units' => array('px', 'em'),
            'class' => $evolve_prem_class,
            'title' => __('Content Boxes Padding', 'evolve'),
            'default' => array(
                'padding-top' => '40px',
                'padding-right' => '30px',
                'padding-bottom' => '40px',
                'padding-left' => '30px',
                'units' => 'px',
            ),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-subsec-box1-tab',
    'title' => __('Content Box 1', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'id' => 'evl_content_box1_enable',
            'title' => __('Enable Content Box 1 ?', 'evolve'),
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
        ),
        array(
            'id' => 'evl_content_box1_title',
            'type' => 'text',
            'title' => __('Content Box 1 Title', 'evolve'),
            'default' => 'Beautifully Simple',
        ),
        array(
            'id' => 'evl_content_box1_icon',
            'type' => 'text',
            'title' => __('Content Box 1 Icon (FontAwesome)', 'evolve'),
            'default' => 'fa-cube',
        ),
        array(
            'id' => 'evl_content_box1_icon_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Content Box 1 Icon Color', 'evolve'),
            'default' => '#afbbc1',
        ),
        array(
            'subtitle' => __('Upload an image as your icon, or specify an image URL directly. <br/> This overwrites the Content Box 1 Icon (FontAwesome) setting', 'evolve'),
            'id' => 'evl_content_box1_icon_upload',
            'type' => 'media',
            'title' => __('Content Box 1 Custom Icon', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'id' => 'evl_content_box1_desc',
            'type' => 'textarea',
            'title' => __('Content Box 1 description', 'evolve'),
            'default' => 'Clean modern theme with smooth and pixel perfect design focused on details',
        ),
        array(
            'id' => 'evl_content_box1_button',
            'type' => 'textarea',
            'title' => __('Content Box 1 Button', 'evolve'),
            'default' => '<a class="read-more btn t4p-button" href="#">Learn more</a>',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-subsec-box2-tab',
    'title' => __('Content Box 2', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'id' => 'evl_content_box2_enable',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Content Box 2 ?', 'evolve'),
        ),
        array(
            'id' => 'evl_content_box2_title',
            'type' => 'text',
            'title' => __('Content Box 2 Title', 'evolve'),
            'default' => 'Easy Customizable',
        ),
        array(
            'id' => 'evl_content_box2_icon',
            'type' => 'text',
            'title' => __('Content Box 2 Icon (FontAwesome)', 'evolve'),
            'default' => 'fa-circle-o-notch',
        ),
        array(
            'id' => 'evl_content_box2_icon_color',
            'compiler' => true,
            'type' => 'color',
            'title' => __('Content Box 2 Icon Color', 'evolve'),
            'default' => '#afbbc1',
        ),
        array(
            'subtitle' => __('Upload an image as your icon, or specify an image URL directly. <br/> This overwrites the Content Box 2 Icon (FontAwesome) setting', 'evolve'),
            'id' => 'evl_content_box2_icon_upload',
            'type' => 'media',
            'title' => __('Content Box 2 Custom Icon', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'id' => 'evl_content_box2_desc',
            'type' => 'textarea',
            'title' => __('Content Box 2 description', 'evolve'),
            'default' => 'Over a hundred theme options ready to make your website unique',
        ),
        array(
            'id' => 'evl_content_box2_button',
            'type' => 'textarea',
            'title' => __('Content Box 2 Button', 'evolve'),
            'default' => '<a class="read-more btn t4p-button" href="#">Learn more</a>',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-subsec-box3-tab',
    'title' => __('Content Box 3', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'id' => 'evl_content_box3_enable',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Content Box 3 ?', 'evolve'),
        ),
        array(
            'id' => 'evl_content_box3_title',
            'type' => 'text',
            'title' => __('Content Box 3 Title', 'evolve'),
            'default' => 'Contact Form Ready',
        ),
        array(
            'id' => 'evl_content_box3_icon',
            'type' => 'text',
            'title' => __('Content Box 3 Icon (FontAwesome)', 'evolve'),
            'default' => 'fa-send',
        ),
        array(
            'id' => 'evl_content_box3_icon_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Content Box 3 Icon Color', 'evolve'),
            'default' => '#afbbc1',
        ),
        array(
            'subtitle' => __('Upload an image as your icon, or specify an image URL directly. <br/> This overwrites the Content Box 3 Icon (FontAwesome) setting', 'evolve'),
            'id' => 'evl_content_box3_icon_upload',
            'type' => 'media',
            'title' => __('Content Box 3 Custom Icon', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'id' => 'evl_content_box3_desc',
            'type' => 'textarea',
            'title' => __('Content Box 3 description', 'evolve'),
            'default' => 'Built-In Contact Page with Google Maps is a standard for this theme',
        ),
        array(
            'id' => 'evl_content_box3_button',
            'type' => 'textarea',
            'title' => __('Content Box 3 Button', 'evolve'),
            'default' => '<a class="read-more btn t4p-button" href="#">Learn more</a>',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-front-page-subsec-box4-tab',
    'title' => __('Content Box 4', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'id' => 'evl_content_box4_enable',
            'type' => 'switch',
            'on' => __('Enabled', 'evolve'),
            'off' => __('Disabled', 'evolve'),
            'default' => 1,
            'title' => __('Enable Content Box 4 ?', 'evolve'),
        ),
        array(
            'id' => 'evl_content_box4_title',
            'type' => 'text',
            'title' => __('Content Box 4 Title', 'evolve'),
            'default' => 'Modern Blog Layouts',
        ),
        array(
            'id' => 'evl_content_box4_icon',
            'type' => 'text',
            'title' => __('Content Box 4 Icon (FontAwesome)', 'evolve'),
            'default' => 'fa-tablet',
        ),
        array(
            'id' => 'evl_content_box4_icon_color',
            'type' => 'color',
            'compiler' => true,
            'title' => __('Content Box 4 Icon Color', 'evolve'),
            'default' => '#afbbc1',
        ),
        array(
            'subtitle' => __('Upload an image as your icon, or specify an image URL directly. <br/> This overwrites the Content Box 4 Icon (FontAwesome) setting', 'evolve'),
            'id' => 'evl_content_box4_icon_upload',
            'type' => 'media',
            'title' => __('Content Box 4 Custom Icon', 'evolve'),
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'url' => true,
            'class' => $evolve_prem_class,
        ),
        array(
            'id' => 'evl_content_box4_desc',
            'type' => 'textarea',
            'title' => __('Content Box 4 description', 'evolve'),
            'default' => 'Up to 3 Blog Layouts, responsive on all media devices',
        ),
        array(
            'id' => 'evl_content_box4_button',
            'type' => 'textarea',
            'title' => __('Content Box 4 Button', 'evolve'),
            'default' => '<a class="read-more btn t4p-button" href="#">Learn more</a>',
        ),
    ),
        )
);


// Dynamic section generation, less human error.  ;)
$slide_defaults = array(
    array(
        'title' => '',
        'description' => __('Absolutely free of cost theme with amazing design and premium features which will impress your visitors', 'evolve'),
    ),
    array(
        'title' => '',
        'description' => __('Built-in Bootstrap Elements and Font Awesome let you do amazing things with your website', 'evolve'),
    ),
    array(
        'title' => '',
        'description' => __('Select of 500+ Google Fonts, choose layout as you need, set up your social links', 'evolve'),
    ),
    array(
        'title' => '',
        'description' => __('Adaptive to any screen depending on the device being used to view the site', 'evolve'),
    ),
    array(
        'title' => '',
        'description' => __('Upload your own logo, change background color or images, select links color which you love - it\'s limitless', 'evolve'),
    )
);

for ($i = 1; $i <= 5; $i ++) {
    $fields[] = array(
        "title" => sprintf(__('Enable Slide %d', 'evolve'), $i),
        "subtitle" => sprintf(__('Enable or Disable Slide %d', 'evolve'), $i),
        "id" => "{$evolve_shortname}_bootstrap_slide{$i}",
        "type" => "switch",
        "default" => "1"
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %d Image', 'evolve'), $i),
        "subtitle" => sprintf(__('Upload an image for the Slide %d, or specify an image URL directly', 'evolve'), $i),
        "id" => "{$evolve_shortname}_bootstrap_slide{$i}_img",
        "type" => "media",
        'url' => true,
        'readonly' => false,
        'required' => array(array("{$evolve_shortname}_bootstrap_slide{$i}", '=', '1')),
        "default" => array('url' => "{$evolve_imagepathfolder}bootstrap-slider/{$i}.jpg")
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %d Title', 'evolve'), $i),
        "id" => "{$evolve_shortname}_bootstrap_slide{$i}_title",
        "type" => "text",
        'required' => array(array("{$evolve_shortname}_bootstrap_slide{$i}", '=', '1')),
        "default" => $slide_defaults[( $i - 1 )]['title']
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %d description', 'evolve'), $i),
        "id" => "{$evolve_shortname}_bootstrap_slide{$i}_desc",
        "type" => "textarea",
        "rows" => 5,
        'required' => array(array("{$evolve_shortname}_bootstrap_slide{$i}", '=', '1')),
        "default" => $slide_defaults[( $i - 1 )]['description']
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %d Button', 'evolve'), $i),
        "id" => "{$evolve_shortname}_bootstrap_slide{$i}_button",
        "type" => "textarea",
        "rows" => 3,
        'required' => array(array("{$evolve_shortname}_bootstrap_slide{$i}", '=', '1')),
        "default" => '<a class="bootstrap-button" href="#">' . __('Learn more', 'evolve') . '</a>',
    );

    $fields[] = array(
        'id' => 'bootstrap_another_slide',
        'type' => 'raw',
        'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
        'class' => $evolve_prem_class,
        'title' => __('Add Another Slide', 'evolve'),
        'subtitle' => __('Add another slide to the Bootstrap Slider.', 'evolve'),
        'content' => __('<a class="button button-primary" href="">Add Slide</a>', 'evolve'),
        'full_width' => false,
    );
}


Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-bootstrap-slider-main-tab',
    'title' => __('Bootstrap Slider', 'evolve'),
    'icon' => 't4p-icon-appbarimageselect',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-bootstrap-slider-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Display Bootstrap Slider on the homepage, all pages or select the slider in the post/page edit mode.', 'evolve'),
            'id' => 'evl_bootstrap_slider',
            'type' => 'select',
            'options' => array(
                'homepage' => __('Homepage only', 'evolve'),
                'post' => __('Manually select in a Post/Page edit mode', 'evolve'),
                'all' => __('All pages', 'evolve'),
            ),
            'title' => __('Bootstrap Slider placement', 'evolve'),
            'default' => 'homepage',
        ),
        array(
            'subtitle' => __('Check this box to disable Bootstrap Slides 100% Background', 'evolve'),
            'id' => 'evl_bootstrap_100',
            'type' => 'checkbox',
            'title' => __('Disable Bootstrap Slides 100% Background', 'evolve'),
        ),
        array(
            'subtitle' => __('Input the time between transitions (Default: 7000);', 'evolve'),
            'id' => 'evl_bootstrap_speed',
            'type' => 'spinner',
            'title' => __('Speed', 'evolve'),
            'step' => 100,
            'default' => '7000',
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide title. * non web-safe font.', 'evolve'),
            'id' => 'evl_bootstrap_slide_title_font',
            'type' => 'typography',
            'title' => __('Slider Title font', 'evolve'),
            'line-height' => false,
            'text-align' => false,
            'default' => array(
                'font-size' => '36px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide description. * non web-safe font.', 'evolve'),
            'id' => 'evl_bootstrap_slide_subtitle_font',
            'type' => 'typography',
            'title' => __('Slider description font', 'evolve'),
            'line-height' => false,
            'text-align' => false,
            'default' => array(
                'font-size' => '18px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
        ),
        array(
            'subtitle' => __('Choose your Bootstrap Slider layout style', 'evolve'),
            'id' => 'evl_bootstrap_layout',
            'compiler' => true,
            'type' => 'image_select',
            'title' => __('Choose Bootstrap Layout Type', 'evolve'),
            'options' => array(
                'bootstrap_left' => $evolve_imagepathfolder . 'bootstrap-slider/bootstrap_1.jpg',
                'bootstrap_center' => $evolve_imagepathfolder . 'bootstrap-slider/bootstrap_2.jpg',
            ),
            'default' => 'bootstrap_left',
        ),
        array(
            'subtitle' => '',
            'id' => 'evl_bootstrap_layout_locked',
            'compiler' => true,
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'image_select',
            'options' => array(
                'bootstrap_right' => $evolve_imagepathfolder . 'bootstrap-slider/bootstrap_3.jpg',
            ),
            'title' => '',
            'default' => '',
            'class' => $evolve_prem_class,
        ),
    ),
        )
);


Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-bootstrap-slider-subsec-slides-tab',
    'title' => __('Slides', 'evolve'),
    'subsection' => true,
    'fields' => $fields
        )
);

// Dynamic section generation, less human error.  ;)
$slide_defaults = array(
    array(
        'image' => "{$evolve_imagepathfolder}parallax/6.png",
        'title' => __('Super Awesome WP Theme', 'evolve'),
        'description' => __('Absolutely free of cost theme with amazing design and premium features which will impress your visitors', 'evolve'),
    ),
    array(
        'image' => "{$evolve_imagepathfolder}parallax/5.png",
        'title' => __('Bootstrap and Font Awesome Ready', 'evolve'),
        'description' => __('Built-in Bootstrap Elements and Font Awesome let you do amazing things with your website', 'evolve'),
    ),
    array(
        'image' => "{$evolve_imagepathfolder}parallax/4.png",
        'title' => __('Easy to use control panel', 'evolve'),
        'description' => __('Select of 500+ Google Fonts, choose layout as you need, set up your social links', 'evolve'),
    ),
    array(
        'image' => "{$evolve_imagepathfolder}parallax/1.png",
        'title' => __('Fully responsive theme', 'evolve'),
        'description' => __('Adaptive to any screen depending on the device being used to view the site', 'evolve'),
    ),
    array(
        'image' => "{$evolve_imagepathfolder}parallax/3.png",
        'title' => __('Unlimited color schemes', 'evolve'),
        'description' => __('Upload your own logo, change background color or images, select links color which you love - it\'s limitless', 'evolve'),
    )
);

$fields = array(
);
for ($i = 1; $i <= 5; $i ++) {
    $fields[] = array(
        "title" => sprintf(__('Enable Slide %d', 'evolve'), $i),
        "subtitle" => sprintf(__('Enable or Disable Slide %d', 'evolve'), $i),
        "id" => "{$evolve_shortname}_show_slide{$i}",
        "type" => "switch",
        "default" => "1"
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %s Image', 'evolve'), $i),
        "subtitle" => sprintf(__('Upload an image for the Slide %d, or specify an image URL directly', 'evolve'), $i),
        "id" => "{$evolve_shortname}_slide{$i}_img",
        "type" => "media",
        'url' => true,
        'readonly' => false,
        'required' => array(array("{$evolve_shortname}_show_slide{$i}", '=', '1')),
        "default" => array('url' => $slide_defaults[( $i - 1 )]['image'])
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %s Title', 'evolve'), $i),
        "subtitle" => "",
        "id" => "{$evolve_shortname}_slide{$i}_title",
        "type" => "text",
        'required' => array(array("{$evolve_shortname}_show_slide{$i}", '=', '1')),
        "default" => $slide_defaults[( $i - 1 )]['title']
    );

    $fields[] = array(
        "title" => sprintf(__('Slide %s description', 'evolve'), $i),
        "subtitle" => "",
        "id" => "{$evolve_shortname}_slide{$i}_desc",
        "type" => "textarea",
        'required' => array(array("{$evolve_shortname}_show_slide{$i}", '=', '1')),
        "default" => $slide_defaults[( $i - 1 )]['description']
    );

    $fields[] = array(
        "name" => sprintf(__('Slide %s Button', 'evolve'), $i),
        "id" => "{$evolve_shortname}_slide{$i}_button",
        "type" => "textarea",
        'required' => array(array("{$evolve_shortname}_show_slide{$i}", '=', '1')),
        "default" => '<a class="da-link" href="#">' . __('Learn more', 'evolve') . '</a>'
    );

    $fields[] = array(
        'id' => 'parallax_another_slide',
        'type' => 'raw',
        'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
        'class' => $evolve_prem_class,
        'title' => __('Add Another Slide', 'evolve'),
        'subtitle' => __('Add another slide to the Parallax Slider.', 'evolve'),
        'content' => __('<a class="button button-primary" href="">Add Slide</a>', 'evolve'),
        'full_width' => false,
    );
}

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-parallax-slider-main-tab',
    'title' => __('Parallax Slider', 'evolve'),
    'icon' => 't4p-icon-appbarmonitor',
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-parallax-slider-subsec-general-tab',
    'title' => __('General', 'evolve'),
    'subsection' => true,
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to enable Parallax Slider', 'evolve'),
            'id' => 'evl_parallax_slider_support',
            'type' => 'checkbox',
            'title' => __('Enable Parallax Slider', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Display Parallax Slider on the homepage, all pages or select the slider in the post/page edit mode.', 'evolve'),
            'id' => 'evl_parallax_slider',
            'type' => 'select',
            'options' => array(
                'homepage' => __('Homepage only', 'evolve'),
                'post' => __('Manually select in a Post/Page edit mode', 'evolve'),
                'all' => __('All pages', 'evolve'),
            ),
            'title' => __('Parallax Slider placement', 'evolve'),
            'default' => 'post',
            'required' => array(
                array('evl_parallax_slider_support', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Input the time between transitions (Default: 4000);', 'evolve'),
            'id' => 'evl_parallax_speed',
            'type' => 'spinner',
            'title' => __('Parallax Speed', 'evolve'),
            'step' => 100,
            'default' => '4000',
            'required' => array(
                array('evl_parallax_slider_support', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide title. * non web-safe font.', 'evolve'),
            'id' => 'evl_parallax_slide_title_font',
            'type' => 'typography',
            'title' => __('Slider Title font', 'evolve'),
            'line-height' => false,
            'text-align' => false,
            'default' => array(
                'font-size' => '36px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
            'required' => array(
                array('evl_parallax_slider_support', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide description. * non web-safe font.', 'evolve'),
            'id' => 'evl_parallax_slide_subtitle_font',
            'type' => 'typography',
            'title' => __('Slider description font', 'evolve'),
            'line-height' => false,
            'text-align' => false,
            'default' => array(
                'font-size' => '18px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
            'required' => array(
                array('evl_parallax_slider_support', '=', '1')
            ),
        ),
    ),
        )
);


Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-parallax-slider-subsec-slides-tab',
    'title' => __('Slides', 'evolve'),
    'subsection' => true,
    'fields' => $fields,
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-posts-slider-main-tab',
    'title' => __('Posts Slider', 'evolve'),
    'icon' => 't4p-icon-appbarvideogallery',
    'fields' => array(
        array(
            'subtitle' => __('Check this box if you want to enable Posts Slider', 'evolve'),
            'id' => 'evl_carousel_slider',
            'type' => 'checkbox',
            'title' => __('Enable Posts Slider', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Display Posts Slider on the homepage, all pages or select the slider in the post/page edit mode.', 'evolve'),
            'id' => 'evl_posts_slider',
            'type' => 'select',
            'options' => array(
                'homepage' => __('Homepage only', 'evolve'),
                'post' => __('Manually select in a Post/Page edit mode', 'evolve'),
                'all' => __('All pages', 'evolve'),
            ),
            'title' => __('Posts Slider placement', 'evolve'),
            'default' => 'post',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'id' => 'evl_posts_number',
            'type' => 'spinner',
            'min' => 1,
            'max' => 10,
            'title' => __('Number of posts to display', 'evolve'),
            'default' => '5',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Choose to display latest posts or posts of a category.', 'evolve'),
            'id' => 'evl_posts_slider_content',
            'type' => 'select',
            'options' => array(
                'recent' => __('Recent posts', 'evolve'),
                'category' => __('Posts in category', 'evolve'),
            ),
            'title' => __('Slideshow content', 'evolve'),
            'default' => 'recent',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Select post categories to pull content for the post slideshow.', 'evolve'),
            'id' => 'evl_posts_slider_id',
            'type' => 'select',
            'multi' => true,
            'data' => 'categories',
            'required' => array(
                array('evl_posts_slider_content', '=', 'category')
            ),
            'title' => __('Category ID(s)', 'evolve'),
        ),
        array(
            'subtitle' => __('Input the time between transitions (Default: 3500);', 'evolve'),
            'id' => 'evl_carousel_speed',
            'type' => 'spinner',
            'title' => __('Slider Speed', 'evolve'),
            'step' => 100,
            'default' => '7000',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Sets the length of Slider Title. Default is 40', 'evolve'),
            'id' => 'evl_posts_slider_title_length',
            'type' => 'spinner',
            'title' => __('Slider Title Length', 'evolve'),
            'default' => '40',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Sets the length of Slider Excerpt. Default is 40', 'evolve'),
            'id' => 'evl_posts_slider_excerpt_length',
            'type' => 'spinner',
            'title' => __('Slider Excerpt Length', 'evolve'),
            'default' => '40',
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide title. * non web-safe font.', 'evolve'),
            'id' => 'evl_carousel_slide_title_font',
            'type' => 'typography',
            'line-height' => false,
            'text-align' => false,
            'title' => __('Slider Title font', 'evolve'),
            'default' => array(
                'font-size' => '36px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
        array(
            'subtitle' => __('Select the typography you want for the slide description. * non web-safe font.', 'evolve'),
            'id' => 'evl_carousel_slide_subtitle_font',
            'type' => 'typography',
            'line-height' => false,
            'text-align' => false,
            'title' => __('Slider description font', 'evolve'),
            'default' => array(
                'font-size' => '18px',
                'font-family' => 'Roboto',
                'color' => '',
                'font-style' => '',
            ),
            'required' => array(
                array('evl_carousel_slider', '=', '1')
            ),
        ),
    ),
        )
);



Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-lightbox-main-tab',
    'title' => __('Lightbox', 'evolve'),
    'icon' => 't4p-icon-appbarwindowmaximize',
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'class' => $evolve_prem_class,
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Set the speed of the animation.', 'evolve'),
            'id' => 'evl_lightbox_animation_speed',
            'type' => 'select',
            'options' => array(
                'fast' => __('Fast', 'evolve'),
                'slow' => __('Slow', 'evolve'),
                'normal' => __('Normal', 'evolve'),
            ),
            'title' => __('Animation Speed', 'evolve'),
            'default' => 'fast',
        ),
        array(
            'subtitle' => __('Show the gallery.', 'evolve'),
            'id' => 'evl_lightbox_gallery',
            'type' => 'switch',
            'title' => __('Show gallery', 'evolve'),
        ),
        array(
            'subtitle' => __('Autoplay the lightbox gallery.', 'evolve'),
            'id' => 'evl_lightbox_autoplay',
            'type' => 'switch',
            'title' => __('Autoplay the Lightbox Gallery', 'evolve'),
        ),
        array(
            'subtitle' => __('If autoplay is enabled, set the slideshow speed, 1000 = 1 second.', 'evolve'),
            'id' => 'evl_lightbox_slideshow_speed',
            'type' => 'spinner',
            'title' => __('Slideshow Speed', 'evolve'),
            'default' => '5000',
        ),
        array(
            'subtitle' => __('Set the opacity of background, <br />0.1 (lowest) to 1 (highest).', 'evolve'),
            'id' => 'evl_lightbox_opacity',
            'type' => 'slider',
            'min' => 0.1,
            'max' => 1,
            'step' => 0.1,
            'resolution' => 0.1,
            'title' => __('Background Opacity', 'evolve'),
            'default' => '0.8',
        ),
        array(
            'subtitle' => __('Show the image caption.', 'evolve'),
            'id' => 'evl_lightbox_title',
            'type' => 'switch',
            'title' => __('Show Caption', 'evolve'),
        ),
        array(
            'subtitle' => __('Show the image description. The Alternative text field is used for the description.', 'evolve'),
            'id' => 'evl_lightbox_subtitle',
            'type' => 'switch',
            'title' => __('Show description', 'evolve'),
        ),
        array(
            'subtitle' => __('Show social sharing buttons on lightbox.', 'evolve'),
            'id' => 'evl_lightbox_social',
            'type' => 'switch',
            'title' => __('Social Sharing', 'evolve'),
        ),
        array(
            'subtitle' => __('Show post images that are inside the post content area in the lightbox.', 'evolve'),
            'id' => 'evl_lightbox_post_images',
            'type' => 'switch',
            'title' => __('Show Post Images in Lightbox', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-contact-main-tab',
    'title' => __('Contact', 'evolve'),
    'icon' => 't4p-icon-appbarlocationcheckin',
    'fields' => array(
        array(
            'desc' => __('Get your Google Maps API key <a href="https://developers.google.com/maps/documentation/javascript/get-api-key" target="_blank">here</>', 'evolve'),
            'id' => 'evl_google_map_api',
            'type' => 'text',
            'title' => __('Google Maps API', 'evolve'),
            'default' => '',
        ),
        array(
            'subtitle' => __('Select the type of google map to show on the contact page.', 'evolve'),
            'id' => 'evl_gmap_type',
            'type' => 'select',
            'options' => array(
                'roadmap' => __('roadmap', 'evolve'),
                'satellite' => __('satellite', 'evolve'),
                'hybrid' => __('hybrid (default)', 'evolve'),
                'terrain' => __('terrain', 'evolve'),
            ),
            'title' => __('Google Map Type', 'evolve'),
            'default' => 'hybrid',
        ),
        array(
            'subtitle' => __('(in pixels or percentage, e.g.:100% or 100px)', 'evolve'),
            'id' => 'evl_gmap_width',
            'compiler' => true,
            'type' => 'text',
            'title' => __('Google Map Width', 'evolve'),
            'default' => '100%',
        ),
        array(
            'subtitle' => __('(in pixels, e.g.: 100px)', 'evolve'),
            'id' => 'evl_gmap_height',
            'compiler' => true,
            'type' => 'text',
            'title' => __('Google Map Height', 'evolve'),
            'default' => '415px',
        ),
        array(
            'subtitle' => __('Example: 775 New York Ave, Brooklyn, Kings, New York 11203.<br /> For multiple markers, separate the addresses with the | symbol. ex: Address 1|Address 2|Address 3.', 'evolve'),
            'id' => 'evl_gmap_address',
            'compiler' => true,
            'type' => 'text',
            'title' => __('Google Map Address', 'evolve'),
            'default' => 'Via dei Fori Imperiali',
        ),
        array(
            'subtitle' => __('Insert name of header which will be in the header of sent email.', 'evolve'),
            'id' => 'evl_sent_email_header',
            'type' => 'text',
            'title' => __('Sent Email Header (From)', 'evolve'),
            'default' => 'Evolve',
        ),
        array(
            'subtitle' => __('Enter the email adress the form will be sent to.', 'evolve'),
            'id' => 'evl_email_address',
            'type' => 'text',
            'title' => __('Email Address', 'evolve'),
        ),
        array(
            'subtitle' => __('Higher number will be more zoomed in.', 'evolve'),
            'id' => 'evl_map_zoom_level',
            'type' => 'slider',
            'min' => 0,
            'max' => 25,
            'title' => __('Map Zoom Level', 'evolve'),
            'default' => '18',
        ),
        array(
            'subtitle' => __('Display the address pin.', 'evolve'),
            'id' => 'evl_map_pin',
            'type' => 'switch',
            'on' => __('Hide', 'evolve'),
            'off' => __('Show', 'evolve'),
            'title' => __('Hide Address Pin', 'evolve'),
        ),
        array(
            'subtitle' => __('Keep the popup graphic with address info hidden when the google map loads. It will only show when the pin on the map is clicked.', 'evolve'),
            'id' => 'evl_map_popup',
            'type' => 'switch',
            'title' => __('Show Map Popup On Click', 'evolve'),
        ),
        array(
            'subtitle' => __('Disable scrollwheel on google maps.', 'evolve'),
            'id' => 'evl_map_scrollwheel',
            'on' => __('Disabled', 'evolve'),
            'off' => __('Enabled', 'evolve'),
            'type' => 'switch',
            'title' => __('Disable Map Scrollwheel', 'evolve'),
        ),
        array(
            'subtitle' => __('Disable scale on google maps.', 'evolve'),
            'id' => 'evl_map_scale',
            'type' => 'switch',
            'on' => __('Disabled', 'evolve'),
            'off' => __('Enabled', 'evolve'),
            'title' => __('Disable Map Scale', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to disable zoom control icon and pan control icon on google maps.', 'evolve'),
            'id' => 'evl_map_zoomcontrol',
            'type' => 'switch',
            'on' => __('Disabled', 'evolve'),
            'off' => __('Enabled', 'evolve'),
            'title' => __('Disable Map Zoom & Pan Control Icons', 'evolve'),
        ),
        array(
            'subtitle' => sprintf(__('Get Google reCAPTCHA keys <a href="%s">here</a>  to enable spam protection on the contact page.', 'evolve'), 'https://www.google.com/recaptcha/admin'),
            'id' => 'evl_captcha_plugin',
            'style' => 'warning',
            'type' => 'info',
            'notice' => false,
        ),
        array(
            'subtitle' => __('Follow the steps in our docs to get your key', 'evolve'),
            'id' => 'evl_recaptcha_public',
            'type' => 'text',
            'title' => __('Google reCAPTCHA Site Key', 'evolve'),
        ),
        array(
            'subtitle' => __('Follow the steps in our docs to get your key', 'evolve'),
            'id' => 'evl_recaptcha_private',
            'type' => 'text',
            'title' => __('Google reCAPTCHA Secret key', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-extra-main-tab',
    'title' => __('Extra', 'evolve'),
    'icon' => 't4p-icon-appbarsettings',
    'fields' => array(
        array(
            'subtitle' => __('Select the slideshow speed, 1000 = 1 second.', 'evolve'),
            'id' => 'evl_testimonials_speed',
            'type' => 'spinner',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Testimonials Speed', 'evolve'),
            'step' => 100,
            'default' => '4000',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Check the box to add rel="nofollow" attribute to social sharing box shortcode.', 'evolve'),
            'id' => 'evl_nofollow_social_links',
            'type' => 'checkbox',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'title' => __('Add rel="nofollow" to social links', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Choose the position of the <strong>Older/Newer Posts</strong> links', 'evolve'),
            'id' => 'evl_nav_links',
            'type' => 'select',
            'options' => array(
                'after' => __('After posts', 'evolve'),
                'before' => __('Before posts', 'evolve'),
                'both' => __('Both', 'evolve'),
            ),
            'title' => __('Position of navigation links', 'evolve'),
            'default' => 'after',
        ),
        array(
            'id' => 'evl_pos_button',
            'type' => 'select',
            'compiler' => true,
            'options' => array(
                'disable' => __('Disable', 'evolve'),
                'left' => __('Left', 'evolve'),
                'right' => __('Right', 'evolve'),
                'middle' => __('Middle', 'evolve'),
            ),
            'title' => __('Position of \'Back to Top\' button', 'evolve'),
            'default' => 'right',
        ),
        array(
            'subtitle' => __('<h3 style=\'margin: 0;\'>BBPress</h3>', 'evolve'),
            'id' => 'evl_bbpress',
            'type' => 'info',
            'class' => $evolve_prem_class
        ),
        array(
            'subtitle' => __('Check the box if you want to use one global sidebar on all forum pages.', 'evolve'),
            'id' => 'evl_bbpress_global_sidebar',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'compiler' => true,
            'type' => 'checkbox',
            'title' => __('BBPress Use Global Sidebar', 'evolve'),
            'default' => '0',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Select the sidebar that will display on forum pages globally.', 'evolve'),
            'id' => 'evl_ppbress_sidebar',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'select',
            'options' => $sidebar_options,
            'title' => __('BBPress Global Sidebar', 'evolve'),
            'default' => 'None',
            'class' => $evolve_prem_class,
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-advanced-main-tab',
    'title' => __('Advanced', 'evolve'),
    'icon' => 't4p-icon-appbarlistcheck',
    'fields' => array(
        array(
            'subtitle' => __('Check to disable the theme\'s mega menu.', 'evolve'),
            'id' => 'evl_disable_megamenu',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'checkbox',
            'title' => __('Disable Mega Menu', 'evolve'),
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Check the box if you are using UberMenu, this option adds UberMenu support without editing any code.', 'evolve'),
            'id' => 'evl_ubermenu',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'type' => 'checkbox',
            'title' => __('UberMenu Plugin Support', 'evolve'),
            'default' => '0',
            'class' => $evolve_prem_class,
        ),
        array(
            'subtitle' => __('Check this box if you want to enable FlexSlider support', 'evolve'),
            'id' => 'evl_flexslider',
            'type' => 'checkbox',
            'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Enable FlexSlider support', 'evolve'),
        ),
        array(
            'subtitle' => __('Check this box if you want to enable Google Map Scripts', 'evolve'),
            'id' => 'evl_status_gmap',
            'compiler' => true,
            'type' => 'checkbox',
            'title' => __('Enable Google Map Scripts', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Check this box if you want to enable Animate.css plugin support - (menu hover effect, featured image hover effect, button hover effect, etc.)', 'evolve'),
            'id' => 'evl_animatecss',
            'compiler' => true,
            'type' => 'checkbox',
            'title' => __('Enable Animate.css plugin support', 'evolve'),
            'default' => '1',
        ),
        array(
            'subtitle' => __('Check the box to disable Youtube API scripts.', 'evolve'),
            'id' => 'evl_status_yt',
            'type' => 'checkbox',
			'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Disable Youtube API Scripts', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to disable Vimeo API scripts.', 'evolve'),
            'id' => 'evl_status_vimeo',
            'type' => 'checkbox',
			'locked' => sprintf(__('This option is only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
            'class' => $evolve_prem_class,
            'title' => __('Disable Vimeo API Scripts', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to disable font awesome', 'evolve'),
            'id' => 'evl_fontawesome',
            'type' => 'checkbox',
            'title' => __('Disable FontAwesome', 'evolve'),
            'default' => '0',
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-woocommerce-main-tab',
    'title' => __('WooCommerce', 'evolve'),
    'icon' => 't4p-icon-appbarcart',
    'locked' => sprintf(__('These options are only available with the <a href="%s" target="_blank">evolve+ Premium</a> version.', 'evolve'), $evolve_t4p_url . 'evolve-multipurpose-wordpress-theme/'),
    'class' => $evolve_prem_class,
    'fields' => array(
        array(
            'subtitle' => __('Insert the number of posts to display per page.', 'evolve'),
            'id' => 'evl_woo_items',
            'type' => 'text',
            'title' => __('Number of Products per Page', 'evolve'),
            'default' => '12',
        ),
        array(
            'subtitle' => __('Check the box to disable the ordering boxes displayed on the shop page.', 'evolve'),
            'id' => 'evl_woocommerce_evolve_ordering',
            'type' => 'checkbox',
            'title' => __('Disable Woocommerce Shop Page Ordering Boxes', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to use evolve\'s one page checkout template.', 'evolve'),
            'id' => 'evl_woocommerce_one_page_checkout',
            'type' => 'checkbox',
            'title' => __('Use Woocommerce One Page Checkout', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to show the order notes on the checkout page.', 'evolve'),
            'id' => 'evl_woocommerce_enable_order_notes',
            'type' => 'checkbox',
            'title' => __('Show Woocommerce Order Notes on Checkout', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to show My Account link, uncheck to disable.', 'evolve'),
            'id' => 'evl_woocommerce_acc_link_main_nav',
            'type' => 'checkbox',
            'title' => __('Show Woocommerce My Account Link in Header', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to show the Cart icon, uncheck to disable.', 'evolve'),
            'id' => 'evl_woocommerce_cart_link_main_nav',
            'type' => 'checkbox',
            'title' => __('Show Woocommerce Cart Link in Header', 'evolve'),
        ),
        array(
            'subtitle' => __('Check the box to show the social icons on product pages, uncheck to disable.', 'evolve'),
            'id' => 'evl_woocommerce_social_links',
            'type' => 'checkbox',
            'title' => __('Show Woocommerce Social Icons', 'evolve'),
        ),
        array(
            'subtitle' => __('Insert your text and it will appear in the first message box on the account page.', 'evolve'),
            'id' => 'evl_woo_acc_msg_1',
            'type' => 'textarea',
            'title' => __('Account Area Message 1', 'evolve'),
            'default' => 'Call us - <i class="t4p-icon-phone"></i> 7438 882 764',
        ),
        array(
            'subtitle' => __('Insert your text and it will appear in the second message box on the account page.', 'evolve'),
            'id' => 'evl_woo_acc_msg_2',
            'type' => 'textarea',
            'title' => __('Account Area Message 2', 'evolve'),
            'default' => 'Email us - <i class="t4p-icon-envelope-o"></i> contact@example.com',
        ),
    ),
        )
);


Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-custom-css-main-tab',
    'title' => __('Custom CSS', 'evolve'),
    'icon' => 't4p-icon-appbarsymbolbraces',
    'fields' => array(
        array(
            'subtitle' => __('Paste your CSS code, do not include any tags or HTML in this field. Any custom CSS entered here will override the theme CSS. In some cases, the !important tag may be needed.', 'evolve'),
            'id' => 'evl_css_content',
            'type' => 'textarea',
            'title' => __('Custom CSS', 'evolve'),
        ),
    ),
        )
);

Redux::setSection($evolve_opt_name, array(
    'id' => 'evl-import-export-main-tab',
    'title' => __('Import / Export', 'evolve'),
    'icon' => 't4p-icon-appbarinbox',
    'customizer' => false,
    'fields' => array(
        array(
            'id' => 'redux_import_export',
            'type' => 'import_export',
            //'class'      => 'redux-field-init redux_remove_th',
            //'title'      => __( '',
            'full_width' => true,
        )
    ),
        )
);

add_action("redux/extension/customizer/control/includes", 'evolve_extend_customizer');

function evolve_extend_customizer() {
    // Extra customizer field types
    if (!class_exists('Redux_Customizer_Control_spinner')) {

        class Redux_Customizer_Control_spinner extends Redux_Customizer_Control {

            public $type = "redux-spinner";

        }

    }
    if (!class_exists('Redux_Customizer_Control_slider')) {

        class Redux_Customizer_Control_slider extends Redux_Customizer_Control {

            public $type = "redux-slider";

        }

    }
    if (!class_exists('Redux_Customizer_Control_typography')) {

        class Redux_Customizer_Control_typography extends Redux_Customizer_Control {

            public $type = "redux-typography";

        }

    }
    if (!class_exists('Redux_Customizer_Control_info')) {

        class Redux_Customizer_Control_info extends Redux_Customizer_Control {

            public $type = "redux-info";

        }

    }
}

/**
 * Removes the demo link and the notice of integrated demo from the redux-framework plugin
 */
if (!function_exists('evolve_remove_redux_demo')) {

    function evolve_remove_redux_demo() {
        // Used to hide the demo mode link from the plugin page. Only used when Redux is a plugin.
        if (class_exists('ReduxFrameworkPlugin')) {
            remove_filter('plugin_row_meta', array(
                ReduxFrameworkPlugin::instance(),
                'plugin_metalinks'
                    ), null, 2);

            // Used to hide the activation notice informing users of the demo panel. Only used when Redux is a plugin.
            remove_action('admin_notices', array(ReduxFrameworkPlugin::instance(), 'admin_notices'));
        }
    }

    add_action('redux/loaded', 'evolve_remove_redux_demo');
}


// Function to test the compiler hook and demo CSS output.
// Above 10 is a priority, but 2 in necessary to include the dynamically generated CSS to be sent to the function.
//add_filter( 'redux/options/' . $evolve_opt_name . '/compiler', 'evolve_compiler_action', 10, 3 );
if (!function_exists('compiler_action')) {

    function evolve_compiler_action($options, $css, $changed_values) {
        $GLOBALS['evl_options'] = $options;
        get_template_part(get_template_directory() . '/custom-css');
    }

}


if (!function_exists('evolve_redux_header_html')) {

    function evolve_redux_header_html() {
        //mod by denzel, to prevent theme check plugin listing out as INFO:
        $url = esc_url("http://theme4press.com/evolve-multipurpose-wordpress-theme/");
        ?>
        <a href="<?php echo $url ?>" target="_blank">
            <img class="evolve-logo" style="margin-bottom:20px;float:left;position:relative;top:10px;" width="1117" height="133" border="0" alt="evolve - Multipurpose WordPress Theme" src="<?php echo get_template_directory_uri(); ?>/assets/images/functions/evolve.jpg">
        </a><div style="clear:both;"></div>
        <div class="updated">
            <p>Happy with this theme? Please rate it <i class="t4p-icon-star-full"></i><i class="t4p-icon-star-full"></i><i class="t4p-icon-star-full"></i><i class="t4p-icon-star-full"></i><i class="t4p-icon-star-full"></i> on <strong><a href="http://wordpress.org/themes/evolve" target="_blank">wordpress.org</a></strong></p>
        </div>		
        <div style="clear:both;"></div>
        <?php
    }

    add_action("redux/evl_options/panel/before", 'evolve_redux_header_html');
}

function evolve_redux_admin_head() {
    ?>
    <style>
        .evolve_expand_options {
            cursor: pointer;
            display: block;
            height: 22px;
            width: 21px;
            float: left;
            font-size: 0;
            text-indent: -9999px;
            margin: 1px 0 0 5px;
            border: 1px solid #bbb;
            border-radius: 2px;
            background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAyCAIAAAAm4OfBAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAQhJREFUeNrslT0KhDAQhTeLR7ATT6IXSKGFYO0lciFrO1N4AU8TLNXKv0CaJbLJRAZxl1hYyJuXN+PoR/Z9fyFdBNNr27Zf8Oq6bhgGSGUYhpTSzyeBNi8hRFVVEK+6rrXaQFOs6yrvTdOYjcqyVEpTLqXI89yaSypBudq2xckF2TipOSvfmmhZFuAGnJV6Licvey5gj7fnwpwXvEfLfqnT0jQ1OBJCQLnUBvZ9b85VFAV076UU8g1ZckVRxBiDzD6OY62WzPOM9i+cpunvvcZxfCQfPWs9a91Ym2UZ5xyHtd/e8hXWng+/zlrD9jmz1tDj7bkw5wXv0Y210itJEs9az9oHsPYQYACveK0/IuB51AAAAABJRU5ErkJggg==) no-repeat -2px -26px;
        }

        .redux-sidebar,
        .redux-main {
            -webkit-transition: all 0.25s;
            transition: all 0.25s;
        }
    </style>
    <script>
        jQuery(document).ready(
                function ($) {
                    $('.expand_options').removeClass('expand_options').addClass('evolve_expand_options').click(
                            function (e) {

                                e.preventDefault();

                                var $this = $(this);

                                var $container = $('.redux-container');
                                if ($container.hasClass('fully-expanded')) {
                                    $container.removeClass('fully-expanded');

                                    var tab = $.cookie("redux_current_tab");

                                    $container.find('#' + tab + '_section_group').css('display', 'block');
                                    if ($container.find('#redux-footer').length !== 0) {
                                        $.redux.stickyInfo(); // race condition fix
                                    }
                                    $.redux.initFields();
                                }

                                // var trigger = parent.find( '.expand_options' );
                                var $reduxMain = $container.find('.redux-main');
                                var $reduxSidebar = $container.find('.redux-sidebar');

                                var width = $reduxSidebar.width() - 1;
                                var id = $reduxSidebar.find('.active a').data('rel');

                                if ($this.hasClass('evolve_expanded')) {
                                    $reduxMain.removeClass('expand').css('margin-left', width);

                                    $reduxSidebar.css('margin-left', 0);
                                    $container.find('.redux-group-tab[data-rel!="' + id + '"]').css('display', 'none');
                                    // Show the only active one
                                } else {
                                    $reduxMain.addClass('expand').css('margin-left', '-1px');

                                    $reduxSidebar.css('margin-left', -width - 113);
                                    $container.find('.redux-group-tab').css('display', 'block');
                                    $.redux.initFields();
                                }

                                $this.toggleClass('evolve_expanded');

                                return false;
                            }
                    );
                }
        );
    </script>
    <?php
}

add_action('admin_head', 'evolve_redux_admin_head');

/* * ************************************************************************************************************
 * Scripts for show/hide premium features:
 * ************************************************************************************************************ */

/**
 * Enqueue script for custom Customizer control:
 */
function evl_customizer_control() {
    wp_enqueue_script(
            'evl_customizer_control_script', get_template_directory_uri() . '/library/media/js/premium-features-customizer.js', array('jquery'), false, true
    );
}

add_action('customize_controls_print_footer_scripts', 'evl_customizer_control');

/**
 * Enqueue script for Theme options panel control:
 */
function evl_theme_options_control() {
    wp_enqueue_script(
            'evl_theme_options_control_script', get_template_directory_uri() . '/library/media/js/premium-features-panel.js', array('jquery'), false, true
    );
}

add_action('redux/' . $evolve_opt_name . '/panel/after', 'evl_theme_options_control');


/* * ************************************************************************************************************
 * Hide premium fields and sections before rendering the options panel
 * (if the 'Hide premium features' option is active):
 * ************************************************************************************************************ */

$evolve_options = get_option($evolve_opt_name, false); // Get saved options
// Check if the 'Hide premium features' option is active:
if (isset($evolve_options[$evolve_prem_inpt_name]) && ($evolve_options[$evolve_prem_inpt_name] == "0")) {
    $evolve_sections = Redux::getSections($evolve_opt_name); // Get all sections
    $field = null;

    foreach ($evolve_options as $option => $value) {
        $field = Redux::getField($evolve_opt_name, $option); // Get all fields
        // Check if the FIELD has "locked" property, wich indicates is a premium feature:
        if (isset($field['locked'])) {            
            Redux::hideField($evolve_opt_name, $field['id'], true); // Hide premium feature
        }
    }

    // Hack for dynamic generated locked options
    Redux::hideField($evolve_opt_name, 'bootstrap_another_slide', true);
    Redux::hideField($evolve_opt_name, 'parallax_another_slide', true);
    Redux::hideField($evolve_opt_name, 'demo_data', true);

    foreach ($evolve_sections as $section => $settings) {
        // Check if the SECTION has "locked" property, wich indicates is a premium section:
        if (isset($settings['locked'])) {
            Redux::hideSection($evolve_opt_name, $section, true); // Hide premium section
        }
    }
}
/* * *********************************************************************************************************** */

function evolve_register_custom_section($wp_customize) {
    if (!class_exists('Evolve_Redux_Customizer_Section')) {
        include_once dirname(__FILE__) . '/evolve-exts/class-evolve-redux-customizer-section.php';
    }
    if (method_exists($wp_customize, 'register_section_type')) {
        $wp_customize->register_section_type('Evolve_Redux_Customizer_Section');
    }
}

add_action('customize_register', 'evolve_register_custom_section');

function evolve_get_custom_redux_section_class() {
    return 'Evolve_Redux_Customizer_Section';
}

add_filter('redux/customizer/section/class_name', 'evolve_get_custom_redux_section_class');
