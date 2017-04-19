<div class="t4p_metabox">
    <?php
    $this->evolve_select('slider_position', __('Slider Position', 'evolve'), array(
        'default' => __('Default', 'evolve'),
        'below' => __('Below', 'evolve'),
        'above' => __('Above', 'evolve')
            ), __('Select if the slider shows below or above the header. This only works for the slider assigned in page options, not with shortcodes.', 'evolve')
    );

    $this->evolve_select('slider_type', __('Slider Type', 'evolve'), array(
        'no' => __('No Slider', 'evolve'),
        'parallax' => __('Parallax Slider', 'evolve'),
        'posts' => __('Posts Slider', 'evolve'),
        'bootstrap' => __('Bootstrap Slider', 'evolve')
            ), ''
    );
    ?>
</div>