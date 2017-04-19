<div class="t4p_metabox">
    <?php
    $this->evolve_select('page_title', __('Page Title', 'evolve'), array(
        'yes' => __('Show', 'evolve'),
        'no' => __('Hide', 'evolve'),
            ), ''
    );

    $this->evolve_select('page_breadcrumb', __('Page Breadcrumb', 'evolve'), array(
        'yes' => __('Show', 'evolve'),
        'no' => __('Hide', 'evolve'),
            ), ''
    );
    ?>    
</div>
