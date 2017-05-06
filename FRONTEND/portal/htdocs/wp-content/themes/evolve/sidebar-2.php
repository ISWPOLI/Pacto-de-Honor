<?php
/*
 * 
 * Template: Sidebar.php
 *
 */
$evolve_layout = evolve_get_option('evl_layout', '2cl');
?>
<!--BEGIN #secondary-2 .aside-->
<div id="secondary-2" class="aside <?php evolve_sidebar_class(); ?>">
    <?php
    /* Widgetized Area */
    if (dynamic_sidebar('sidebar-2')) :
    endif; /* (!function_exists('dynamic_sidebar') */
    ?>
</div><!--END #secondary-2 .aside-->