// menu sticky
jQuery( document ).ready( function ( $ ) {
// grab the initial top offset of the navigation 
    var sticky_navigation_offset_top = $( '.rsrc-main-menu' ).offset().top;
    // our function that decides weather the navigation bar should have "fixed" css position or not.
    var sticky_navigation = function () {
        var scroll_top = $( window ).scrollTop(); // our current vertical position from the top
        var $admin_bar = $( '#wpadminbar' ); // check the admin bar
        if ( $admin_bar.length ){ 
            $top = 32;
        } else {
            $top = 0;
        }
        // if we've scrolled more than the navigation, change its position to fixed to stick to top, otherwise change it back to relative
        if ( scroll_top > sticky_navigation_offset_top ) {
            $( '.rsrc-main-menu' ).css( { 'position': 'fixed', 'top': $top, 'z-index': '500', 'width': '100%' } );
        } else {
            $( '.rsrc-main-menu' ).css( { 'position': 'relative', 'top': 0 } );
        }
    };
    // run our function on load
    sticky_navigation();
    // and run it again every time you scroll
    $( window ).scroll( function () {
        sticky_navigation();
    } );
} );