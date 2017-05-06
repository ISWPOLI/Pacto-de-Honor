// Tabs
//When page loads...
jQuery('.tabs-wrapper').each(function () {
    jQuery(this).find(".tab_content").hide(); //Hide all content
    if (document.location.hash && jQuery(this).find("ul.tabs li a[href='" + document.location.hash + "']").length >= 1) {
        jQuery(this).find("ul.tabs li a[href='" + document.location.hash + "']").parent().addClass("active").show(); //Activate first tab
        jQuery(this).find(document.location.hash + ".tab_content").show(); //Show first tab content
    } else {
        jQuery(this).find("ul.tabs li:first").addClass("active").show(); //Activate first tab
        jQuery(this).find(".tab_content:first").show(); //Show first tab content
    }
});

//On Click Event
jQuery("ul.tabs li").click(function (e) {
    jQuery(this).parents('.tabs-wrapper').find("ul.tabs li").removeClass("active"); //Remove any "active" class
    jQuery(this).addClass("active"); //Add "active" class to selected tab
    jQuery(this).parents('.tabs-wrapper').find(".tab_content").hide(); //Hide all tab content

    var activeTab = jQuery(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    jQuery(this).parents('.tabs-wrapper').find(activeTab).fadeIn(); //Fade in the active ID content

});

jQuery("ul.tabs li a").click(function (e) {
    e.preventDefault();
})

jQuery('#sidebar .tabset').each(function () {
    var menuWidth = jQuery(this).width();
    var menuItems = jQuery(this).find('li').size();
    var itemWidth = (menuWidth / menuItems) - 1;
    var menuItemsExcludingLast = jQuery(this).find('li:not(:last)');
    var menuItemsExcludingLastSize = jQuery(this).find('li:not(:last)').size();

    jQuery(this).css({'width': menuWidth + 'px'});
    jQuery(this).find('li').css({'width': itemWidth + 'px'});

    var menuItemsExcludingLastWidth = ((menuItemsExcludingLast.width() + 1) * menuItemsExcludingLastSize);
    var lastItemSize = menuWidth - menuItemsExcludingLastWidth;

    //jQuery(this).find('li:last').css({'width': lastItemSize +'px'});
});


jQuery('.footer-area .tabset').each(function () {
    var menuWidth = jQuery(this).width();
    var menuItems = jQuery(this).find('li').size();
    var itemWidth = (menuWidth / menuItems) - 1;
    var menuItemsExcludingLast = jQuery(this).find('li:not(:last)');
    var menuItemsExcludingLastSize = jQuery(this).find('li:not(:last)').size();

    jQuery(this).css({'width': menuWidth + 'px'});
    jQuery(this).find('li').css({'width': itemWidth + 'px'});

    var menuItemsExcludingLastWidth = ((menuItemsExcludingLast.width() + 1) * menuItemsExcludingLastSize);
    var lastItemSize = menuWidth - menuItemsExcludingLastWidth;

    //jQuery(this).find('li:last').css({'width': lastItemSize +'px'});
}); 