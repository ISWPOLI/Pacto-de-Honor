<?php

class evolve_ThemeFrameworkMetaboxes {

    public function __construct() {
        global $smof_data;
        $this->data = $smof_data;

        add_action('add_meta_boxes', array($this, 'evolve_add_meta_boxes'));
        add_action('save_post', array($this, 'evolve_save_meta_boxes'));
        add_action('admin_print_scripts-post.php', array($this, 'evolve_print_metabox_scripts'));
        add_action('admin_print_scripts-post-new.php', array($this, 'evolve_print_metabox_scripts'));
        add_action('admin_enqueue_scripts', array($this, 'evolve_admin_script_loader'));
    }

    // Load backend scripts
    function evolve_admin_script_loader() {
        global $pagenow;
        if (is_admin() && ($pagenow == 'post-new.php' || $pagenow == 'post.php')) {
            wp_register_script('evolve_upload', get_template_directory_uri() . '/library/media/js/upload.js');
            wp_enqueue_script('evolve_upload');
            wp_enqueue_script('media-upload');
            wp_enqueue_script('thickbox');
            wp_enqueue_style('thickbox');
        }
    }

    public function evolve_add_meta_boxes() {
        $this->evolve_add_meta_box('evolve_post_options', 'Post Options', 'post');
        $this->evolve_add_meta_box('evolve_page_options', 'Page Options', 'page');
    }

    public function evolve_add_meta_box($id, $label, $post_type) {
        add_meta_box(
                'evolve_' . $id, $label, array($this, $id), $post_type
        );
    }

    public function evolve_save_meta_boxes($post_id) {
        if (defined('DOING_AUTOSAVE') && DOING_AUTOSAVE) {
            return;
        }

        foreach ($_POST as $key => $value) {
            if (strstr($key, 'evolve_')) {
                update_post_meta($post_id, $key, $value);
            }
        }
    }

    public function evolve_post_options() {
        get_template_part('library/views/metaboxes/style');
        $this->evolve_render_option_tabs(array('layout', 'pagetitlebar', 'widget', 'slider'));
    }

    public function evolve_page_options() {
        get_template_part('library/views/metaboxes/style');
        $this->evolve_render_option_tabs(array('layout', 'pagetitlebar', 'widget', 'slider'));
    }

    public function evolve_print_metabox_scripts() {
        wp_register_style(
                'evolve-icomoon', get_template_directory_uri() . '/library/admin/icomoon-admin/style.css', array(), time(), 'all'
        );
        wp_enqueue_style('evolve-icomoon');
    }

    public function evolve_text($id, $label, $desc = '') {
        global $post;

        $html = '';
        $html .= '<div class="t4p_metabox_field">';
        $html .= '<label for="evolve_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        $html .= '<input type="text" id="evolve_' . $id . '" name="evolve_' . $id . '" value="' . get_post_meta($post->ID, 'evolve_' . $id, true) . '" />';
        if ($desc) {
            $html .= '<p>' . $desc . '</p>';
        }
        $html .= '</div>';
        $html .= '</div>';

        echo $html;
    }

    public function evolve_select($id, $label, $options, $desc = '') {
        global $post;

        $html = '';
        $html .= '<div class="t4p_metabox_field">';
        $html .= '<label for="evolve_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        $html .= '<select id="evolve_' . $id . '" name="evolve_' . $id . '">';
        foreach ($options as $key => $option) {
            if (get_post_meta($post->ID, 'evolve_' . $id, true) == $key) {
                $selected = 'selected="selected"';
            } else {
                $selected = '';
            }

            $html .= '<option ' . $selected . 'value="' . $key . '">' . $option . '</option>';
        }
        $html .= '</select>';
        if ($desc) {
            $html .= '<p>' . $desc . '</p>';
        }
        $html .= '</div>';
        $html .= '</div>';

        echo $html;
    }

    public function evolve_multiple($id, $label, $options, $desc = '') {
        global $post;

        $html = '';
        $html .= '<div class="t4p_metabox_field">';
        $html .= '<label for="t4p_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        $html .= '<select multiple="multiple" id="t4p_' . $id . '" name="evolve_' . $id . '[]">';
        foreach ($options as $key => $option) {
            if (is_array(get_post_meta($post->ID, 'evolve_' . $id, true)) && in_array($key, get_post_meta($post->ID, 'evolve_' . $id, true))) {
                $selected = 'selected="selected"';
            } else {
                $selected = '';
            }

            $html .= '<option ' . $selected . 'value="' . $key . '">' . $option . '</option>';
        }
        $html .= '</select>';
        if ($desc) {
            $html .= '<p>' . $desc . '</p>';
        }
        $html .= '</div>';
        $html .= '</div>';

        echo $html;
    }

    public function evolve_textarea($id, $label, $desc = '', $default = '') {
        global $post;

        $db_value = get_post_meta($post->ID, 'evolve_' . $id, true);

        if ($db_value) {
            $value = $db_value;
        } else {
            $value = $default;
        }

        $html = '';
        $html = '';
        $html .= '<div class="t4p_metabox_field">';
        $html .= '<label for="evolve_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        $html .= '<textarea cols="120" rows="10" id="evolve_' . $id . '" name="evolve_' . $id . '">' . $value . '</textarea>';
        if ($desc) {
            $html .= '<p>' . $desc . '</p>';
        }
        $html .= '</div>';
        $html .= '</div>';

        echo $html;
    }

    //added by denzel, image radio button.
    public function evolve_image_radio_button($id, $label, $options, $desc = '', $default = '') {
        global $post;
        $class = '';
        $checked = '';
        $javascript_ids = '';
        foreach ($options as $k => $v) {
            $javascript_ids .= "#image_{$k},";
        }
        $javascript_ids = rtrim($javascript_ids, ",");

        $html = '';
        $html .= '<div class="t4p_metabox_field">';
        $html .= '<label for="evolve_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        foreach ($options as $key => $option) {
            $html .= '<input type="radio" style="display:none;" id="' . $key . '" name="evolve_' . $id . '" value="' . $key . '" ';
            if (get_post_meta($post->ID, 'evolve_' . $id, true) == $key) {
                $checked = 'checked="checked"';
                $class = 'evolve_img_border_radio evolve_img_selected';
            } elseif (get_post_meta($post->ID, 'evolve_' . $id, true) == '' && $key == $default) {
                $checked = 'checked="checked"';
                $class = 'evolve_img_border_radio evolve_img_selected';
            } else {
                $checked = '';
                $class = 'evolve_img_border_radio';
            }

            $html .= $checked . ">";
            $html .= "<img src='$option' alt='' id='image_$key' class='$class' onclick='document.getElementById(\"$key\").checked=true;jQuery(\"$javascript_ids\").removeClass(\"evolve_img_selected\");jQuery(this).addClass(\"evolve_img_selected\");' />";
        }
        $html .= '</div>';
        $html .= '</div>';

        echo $html;
    }

    public function evolve_upload($id, $label, $desc = '') {
        global $post;

        $evolve_upload_img_id = get_post_meta($post->ID, 'evolve_' . $id, true);
        $evolve_upload_src = wp_get_attachment_image_src($evolve_upload_img_id, 'full');
        $evolve_upload_have_img = is_array($evolve_upload_src);

        $html = '';
        $html .= '<div class="t4p_metabox_field .redux-main">';
        $html .= '<label for="evolve_' . $id . '">';
        $html .= $label;
        $html .= '</label>';
        $html .= '<div class="field">';
        $hide1 = '';
        $hide2 = '';
        if ($evolve_upload_have_img) {
            $hide1 = 'hidden';
        }
        if (!$evolve_upload_have_img) {
            $hide2 = 'hidden';
        }

        $html .= '<input type="text" id="evolve-media-remove-extra-' . $id . '" class="upload_field ' . $hide1 . '" value="" /></br>';

        $html .= '<div id="evolve-media-display-' . $id . '">';
        if ($evolve_upload_have_img) :
            $html .= '<input type="text" class="upload_field" value="' . $evolve_upload_src[0] . '" /></br>';
            $html .= '<img src="' . $evolve_upload_src[0] . '" class="redux-option-image" style="width:60px; height:60px;" />';
        endif;
        $html .= '</div>';

        $html .= '<input class="evolve_upload_button button ' . $hide1 . '" id="evolve-media-upload-' . $id . '" data-media-id="' . $id . '" type="button" value="Upload" />';
        $html .= '<input class="evolve_remove_button button ' . $hide2 . '" id="evolve-media-remove-' . $id . '" data-media-id="' . $id . '" type="button" value="Remove" />';
        if ($desc) {
            $html .= '<p>' . $desc . '</p>';
        }
        $html .= '</div>';
        $html .= '</div>';
        $html .= '<input type="hidden" id="evolve_' . $id . '" name="evolve_' . $id . '" value="' . get_post_meta($post->ID, 'evolve_' . $id, true) . '" />';

        echo $html;
    }

    public function evolve_render_option_tabs($requested_tabs, $post_type = 'default') {
        $tabs_names = array(
            'layout' => __('Layout', 'evolve'),
            'pagetitlebar' => __('Page Title / Breadcrumbs / Page Title Bar', 'evolve'),
            'widget' => __('Widgets', 'evolve'),
            'slider' => __('Slider', 'evolve'),
            'sidebars' => __('Sidebar', 'evolve'),
        );

        $tabs_icons = array(
            'layout' => 't4p-icon-appbartools',
            'pagetitlebar' => 't4p-icon-file2',
            'widget' => 't4p-icon-appbarimagebacklight',
            'slider' => 't4p-icon-appbarmonitor',
            'sidebars' => 't4p-icon-file',
        );

        echo '<ul class="t4p_metabox_tabs">';

        foreach ($requested_tabs as $key => $tab_name) {
            $class_active = '';
            if ($key === 0) {
                $class_active = ' class="active"';
            }

            if ($tab_name == 'page' &&
                    $post_type == 'product'
            ) {
                printf('<li%s><a href="%s">%s</a></li>', $class_active, $tab_name, $tabs_names[$post_type]);
            } else {
                printf('<li%s><a href="%s"><i class="%s"></i>%s</a></li>', $class_active, $tab_name, $tabs_icons[$tab_name], $tabs_names[$tab_name]);
            }
        }

        echo '</ul>';

        echo '<div class="t4p_metabox_main">';

        foreach ($requested_tabs as $key => $tab_name) {
            $class_active = '';
            if ($key === 0) {
                $class_active = 'active';
            }
            printf('<div class="t4p_metabox_tab %s" id="t4p_tab_%s">', $class_active, $tab_name);
            require_once( sprintf('page_tabs/tab_%s.php', $tab_name) );
            echo '</div>';
        }

        echo '</div>';
        echo '<div class="clear"></div>';
    }

}

$metaboxes = new evolve_ThemeFrameworkMetaboxes;
