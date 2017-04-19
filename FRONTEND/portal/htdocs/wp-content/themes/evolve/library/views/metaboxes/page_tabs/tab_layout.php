<div class='t4p_metabox'>
    <?php
    $imagepath = get_template_directory_uri() . '/assets/images/functions/';
    $this->evolve_image_radio_button(
            'sidebar_position', __('Sidebar Position', 'evolve'), array(
        'default' => $imagepath . '1c.png',
        '2cl' => $imagepath . '2cl.png',
        '2cr' => $imagepath . '2cr.png',
        '3cm' => $imagepath . '3cm.png',
        '3cr' => $imagepath . '3cr.png',
        '3cl' => $imagepath . '3cl.png'
            ), '', 'default'
    );
    ?>
    <span class="description"><?php _e('Use this setting to select and set position of sidebar', 'evolve'); ?></span>
    <span class="description"><?php _e('If "No Sidebar" is selected, this layout will follow the settings of Theme Options -> General -> Select a layout.', 'evolve'); ?></span>
    <?php
    $this->evolve_select('full_width', __('Full Width', 'evolve'), array(
        'no' => __('No', 'evolve'),
        'yes' => __('Yes', 'evolve'),
            ), ''
    );
    ?>
    <span class="description" style="position:relative;top:5px"><?php _e('If setting full width, Please set the above Sidebar Position to "No Sidebar".', 'evolve'); ?></span>
</div>