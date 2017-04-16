<?php
/*
 * 
 * Template: Searchform.php
 *
 */
?>
<!--BEGIN #searchform-->
<form action="<?php echo home_url(); ?>" method="get" class="searchform">
    <div id="search-text-box">
        <label class="searchfield" id="search_label" for="search-text">
            <input id="search-text" type="text" tabindex="3" name="s" class="search" placeholder="<?php _e('Type your search', 'evolve'); ?>" />
        </label>
    </div>
    <div id="search-button-box">
        <button id="search-button" tabindex="4" type="submit" class="search-btn"></button>
    </div>
</form>
<div class="clearfix"></div>
<!--END #searchform-->