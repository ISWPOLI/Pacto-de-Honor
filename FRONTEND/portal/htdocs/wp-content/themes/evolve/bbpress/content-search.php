<?php
/**
 * Search Content Part
 *
 * @package bbPress
 * @subpackage Theme
 */
?>

<div id="bbpress-forums">

    <?php
    $evolve_breadcrumbs = evolve_get_option('evl_breadcrumbs', '1');
    if ($evolve_breadcrumbs == "1"):
        bbp_breadcrumb();
    endif;
    ?>

    <div class="search-page-search-form">
        <h2><?php _e('Need a new search?', 'evolve'); ?></h2>
        <p><?php _e('If you didn\'t find what you were looking for, try a new search!', 'evolve'); ?></p>

        <form role="search" method="get" class="bbp-search-form" id="searchform" action="<?php bbp_search_url(); ?>">
            <div>
                <label class="screen-reader-text hidden" for="bbp_search"><?php _e('Search for:', 'evolve'); ?></label>
                <input type="hidden" name="action" value="bbp-search-request" />
                <input tabindex="<?php bbp_tab_index(); ?>" type="text" value="<?php echo esc_attr(bbp_get_search_terms()); ?>" placeholder="<?php _e('Search the Forum...', 'evolve'); ?>" name="bbp_search" id="bbp_search" />
                <input tabindex="<?php bbp_tab_index(); ?>" class="button" type="submit" id="bbp_search_submit" value="&#xe91e;" />
                <div class="clearfix"></div>
            </div>
        </form>
    </div>            
    <?php
    bbp_set_query_name('bbp_search');

    do_action('bbp_template_before_search');

    if (bbp_has_search_results()) :

        bbp_get_template_part('pagination', 'search');

        bbp_get_template_part('loop', 'search');

        bbp_get_template_part('pagination', 'search');

    elseif (bbp_get_search_terms()) :

        bbp_get_template_part('feedback', 'no-search');

    else :

        bbp_get_template_part('form', 'search');

    endif;

    do_action('bbp_template_after_search_results');
    ?>
</div>