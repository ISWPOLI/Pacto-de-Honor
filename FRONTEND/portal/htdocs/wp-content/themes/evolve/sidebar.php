<?php
/*
 * 
 * Template: Sidebar.php
 *
 */
$evolve_layout = evolve_get_option('evl_layout', '2cl');
?>
<!--BEGIN #secondary .aside-->
<div id="secondary" class="aside <?php evolve_sidebar_class(); ?>">
    <?php
    /* Widgetized Area */
    if (!dynamic_sidebar('sidebar-1')) :
    endif; /* (!function_exists('dynamic_sidebar') */
    ?>
</div><!--END #secondary .aside-->