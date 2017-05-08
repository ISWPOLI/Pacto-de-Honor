jQuery(document).ready(function() {

  var counter = jQuery('#counter-count').data('counter');
  if ( counter != '0')  {  
    jQuery('li.eleganto-w-red-tab a').append('<span class="eleganto-actions-count">' + counter + '</span>');
  } else {
    jQuery('.eleganto-tab').removeClass( 'eleganto-w-red-tab' );
  }
	/* Tabs in welcome page */
	function eleganto_welcome_page_tabs(event) {
		jQuery(event).parent().addClass("active");
        jQuery(event).parent().siblings().removeClass("active");
        var tab = jQuery(event).attr("href");
        jQuery(".eleganto-tab-pane").not(tab).css("display", "none");
        jQuery(tab).fadeIn();
	}

	var eleganto_actions_anchor = location.hash;

	if( (typeof eleganto_actions_anchor !== 'undefined') && (eleganto_actions_anchor != '') ) {
		eleganto_welcome_page_tabs('a[href="'+ eleganto_actions_anchor +'"]');
	}

    jQuery(".eleganto-nav-tabs a").click(function(event) {
        event.preventDefault();
		eleganto_welcome_page_tabs(this);
    });

 /* Tab Content height matches admin menu height for scrolling purpouses */
		$tab = jQuery('.eleganto-tab-content > div');
		$admin_menu_height = jQuery('#adminmenu').height();
    if( (typeof $tab !== 'undefined') && (typeof $admin_menu_height !== 'undefined') )
  {
		$newheight = $admin_menu_height - 180;
		$tab.css('min-height',$newheight);
  }
});
