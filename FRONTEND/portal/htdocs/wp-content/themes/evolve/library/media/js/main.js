//
// Responsive Primary Menu
//

if (js_responsive_menu.responsive_menu_layout == 'dropdown') {

    jQuery(document).ready(function () {
        if (js_responsive_menu.responsive_menu == '') {
            jQuery('.primary-menu .nav-holder .evolve_mobile_menu').meanmenu();
        } else {
            jQuery('.primary-menu .nav-holder .evolve_mobile_menu').meanmenu({
                meanMenuClose: "<label class='dd-selected-text'>" + js_responsive_menu.responsive_menu + "</label>",
                meanMenuOpen: "<label class='dd-selected-text'>" + js_responsive_menu.responsive_menu + "</label>"
            });
        }
    });

} else {

    // Create the dropdown base
    jQuery('<select />').appendTo('.primary-menu .nav-holder');

    // Create default option 'Menu'
    jQuery('<option />', {
        'selected': 'selected',
        'value': '',
        'text': js_responsive_menu.responsive_menu
    }).appendTo('.primary-menu .nav-holder select');

    // Populate dropdown with menu items
    jQuery('.primary-menu .nav-holder a').each(function () {
        var el = jQuery(this);

        if (jQuery(el).parents('.sub-menu .sub-menu').length >= 1) {
            jQuery('<option />', {
                'value': el.attr('href'),
                'text': '-- ' + el.text()
            }).appendTo('.primary-menu .nav-holder select');
        } else if (jQuery(el).parents('.sub-menu').length >= 1) {
            jQuery('<option />', {
                'value': el.attr('href'),
                'text': '- ' + el.text()
            }).appendTo('.primary-menu .nav-holder select');
        } else {
            jQuery('<option />', {
                'value': el.attr('href'),
                'text': el.text()
            }).appendTo('.primary-menu .nav-holder select');
        }
    });

    jQuery('.primary-menu .nav-holder select').ddslick({
        width: '100%',
        onSelected: function (selectedData) {
            if (selectedData.selectedData.value != '') {
                window.location = selectedData.selectedData.value;
            }
        }
    });
}

//
//
// 
// Responsive Images
//
//
//

var $addmenueffect = jQuery.noConflict();
$addmenueffect("#primary img").addClass("img-responsive");


//
//
// 
// Carousel Slider Arrows
//
//
//

var $jx = jQuery.noConflict();
$jx(document).ready(function () {
    $jx('div#slide_holder').hover(function () {
        $jx(this).find('.arrow span').stop(true, true).fadeIn(200).show(10);
    }, function () {
        $jx(this).find('.arrow span').stop(true, true).fadeOut(200).hide(10);
    });
});


//
//
// 
// Tipsy
//
//
//


var $j = jQuery.noConflict();
$j(document).ready(function () {
    $j('.tipsytext').tipsy({gravity: 'n', fade: true, offset: 0, opacity: 1});
});

//
//
// 
// Sticky Header Logo Margin
//
//
//   

/*! Copyright 2012, Ben Lin (http://dreamerslab.com/)
 * Licensed under the MIT License (LICENSE.txt).
 *
 * Version: 1.0.15
 *
 * Requires: jQuery >= 1.2.3
 */
;
(function ($) {
    $.fn.addBack = $.fn.addBack || $.fn.andSelf;

    $.fn.extend({
        actual: function (method, options) {
            // check if the jQuery method exist
            if (!this[ method ]) {
                throw '$.actual => The jQuery method "' + method + '" you called does not exist';
            }

            var defaults = {
                absolute: false,
                clone: false,
                includeMargin: false
            };

            var configs = $.extend(defaults, options);

            var $target = this.eq(0);
            var fix, restore;

            if (configs.clone === true) {
                fix = function () {
                    var style = 'position: absolute !important; top: -1000 !important; ';

                    // this is useful with css3pie
                    $target = $target.
                            clone().
                            attr('style', style).
                            appendTo('body');
                };

                restore = function () {
                    // remove DOM element after getting the width
                    $target.remove();
                };
            } else {
                var tmp = [];
                var style = '';
                var $hidden;

                fix = function () {
                    // get all hidden parents
                    $hidden = $target.parents().addBack().filter(':hidden');
                    style += 'visibility: hidden !important; display: block !important; ';

                    if (configs.absolute === true)
                        style += 'position: absolute !important; ';

                    // save the origin style props
                    // set the hidden el css to be got the actual value later
                    $hidden.each(function () {
                        var $this = $(this);

                        // Save original style. If no style was set, attr() returns undefined
                        tmp.push($this.attr('style'));
                        $this.attr('style', style);
                    });
                };

                restore = function () {
                    // restore origin style values
                    $hidden.each(function (i) {
                        var $this = $(this);
                        var _tmp = tmp[ i ];

                        if (_tmp === undefined) {
                            $this.removeAttr('style');
                        } else {
                            $this.attr('style', _tmp);
                        }
                    });
                };
            }

            fix();
            // get the actual value with user specific methed
            // it can be 'width', 'height', 'outerWidth', 'innerWidth'... etc
            // configs.includeMargin only works for 'outerWidth' and 'outerHeight'
            var actual = /(outer)/.test(method) ?
                    $target[ method ](configs.includeMargin) :
                    $target[ method ]();

            restore();
            // IMPORTANT, this plugin only return the value of the first element
            return actual;
        }
    });
})(jQuery);

jQuery(document).ready(function ($) {
    // sticky menu logo vertical alignment center
    var parentHeight = jQuery('header.sticky-header').actual('height');
    var childHeight = jQuery('#sticky-logo').actual('height');
    jQuery('#sticky-logo').css('margin-top', (parentHeight - childHeight) / 2);
});

// **********************  home content box style for mac and iphone  ****************************

if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1) {
    jQuery(".content-box .cntbox_btn").css({'display': 'block', 'position': 'relative', 'top': '0'});
}

var is_OSX = navigator.platform.match(/(Mac|iPhone|iPod|iPad)/i) ? true : false;
var is_iOS = navigator.platform.match(/(iPhone|iPod|iPad)/i) ? true : false;

var is_Mac = navigator.platform.toUpperCase().indexOf('MAC') >= 0;
var is_iPhone = navigator.platform == "iPhone";
var is_iPod = navigator.platform == "iPod";
var is_iPad = navigator.platform == "iPad";

//var oscheck= "Platform: " + navigator.platform;

if (is_OSX) {
    jQuery(".home-content-boxes .col-md-3.content-box, .home-content-boxes .col-md-4.content-box, .home-content-boxes .col-md-6.content-box").addClass('osmac');
}

// **********************  home content box button style for mac and iphone  ****************************
jQuery(window).load(function () {
    if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1) {


        function setHeight() {
            var heights1 = jQuery(".content-box p").map(function () {
                return jQuery(this).outerHeight();
            }).get();

            var heights2 = jQuery(".content-box h2").map(function () {
                return jQuery(this).outerHeight();
            }).get();

            var totalheights = [];
            for (var i = 0; i < heights1.length; i++)
            {
                totalheights.push(heights1[i] + heights2[i]);
            }

            maxHeight = Math.max.apply(null, totalheights);

            var btnpadding = jQuery.map(totalheights, function (value) {
                return maxHeight - value;
            });

            jQuery(".sbtn1").css('padding-top', btnpadding[0]);
            jQuery(".sbtn2").css('padding-top', btnpadding[1]);
            jQuery(".sbtn3").css('padding-top', btnpadding[2]);
            jQuery(".sbtn4").css('padding-top', btnpadding[3]);
        }
        ;
        setHeight();

        jQuery(window).resize(function () {
            var width = jQuery(window).width();
            if (width > '768') {
                setHeight();
            } else {
                jQuery(".sbtn1").css('padding-top', '0px');
                jQuery(".sbtn2").css('padding-top', '0px');
                jQuery(".sbtn3").css('padding-top', '0px');
                jQuery(".sbtn4").css('padding-top', '0px');
            }
        });
    }
});

/* add menu effect to WPML menu items */
jQuery(document).ready(function () {
    jQuery('.primary-menu .menu-item-language a,.sticky-header .menu-item-language a').each(function () {
        var el = jQuery(this);
        plan_text = el.text();
        if (jQuery(this).find('img').length) {
            img_src = jQuery(this).find('img').attr('src');
            jQuery(this).find('img').remove();
            el.html('<img src="' + img_src + '"> <span data-hover=" ' + plan_text + '"> ' + plan_text + '</span>');
        } else {
            el.html('<span data-hover="' + plan_text + '">' + plan_text + '</span>');
        }
    });
});