/*
 *  Force these elements to hide.
 *  Use [.] for classes and [#] for IDs:
 */
var evl_SH_elements = [
    "#accordion-panel-evl-portfolio-main-tab"
];

/*
 *  The following values depend on the html code,
 *  change here if future Redux or theme updates
 *  change the ids and/or classes:
 */
var evl_switchID = "evl_hiden_premium";
var evl_selectedClass = "selected";
var evl_enabledClass = "cb-enable";
var evl_disabledClass = "cb-disable";
var evl_referenceElement = "widgets-right";
var evl_switchContainerTabID = "accordion-section-evl-SH-custom-section";
var evl_switchFieldID = "evl_options-evl_hiden_premium";
var evl_descriptionClass = "description";
var evl_lockedFieldClass = "redux-field-locked";
var evl_lockedSectionClass = "redux-section-locked";
var evl_premiumElementClass = "evl_premium_feature";
var evl_junkFieldID = "evl_options-evl-SH-junk";

jQuery(document).ready(
        function ($) {

            /*
             *  Add a "change event" listener for showing/hiding
             *  premium options and sections when user activates
             *  the switch.
             */
            $('#' + evl_switchID).parent().change(
                    function () {
                        $(this).children("label").each(
                                function () {
                                    if ($(this).hasClass(evl_selectedClass)) {
                                        if ($(this).hasClass(evl_disabledClass)) {
                                            evl_SH_premium_options("hide");
                                        }
                                        if ($(this).hasClass(evl_enabledClass)) {
                                            evl_SH_premium_options("show");
                                        }
                                    }
                                }
                        )
                    }
            );



            /*
             * Hide premium options and sections on load
             * (if the switch state is "Hide").
             */
            jQuery('#' + evl_switchID).siblings("label").each(
                    function () {
                        if (jQuery(this).hasClass(evl_selectedClass)) {
                            if (jQuery(this).hasClass(evl_disabledClass)) {
                                evl_SH_premium_options("hide")
                            }
                        }
                    }
            );

            // Switch code injection into the Customizer top:
            jQuery("#" + evl_junkFieldID).hide();
            if (evl_SH_evaluate()) {
                evl_SH_inject_switch();
                console.log("Switch code injected into Customizer top.");
            } else {
                console.log("Switch code couldn't be injected into Customizer top because there are missing elements.");
            }

        }

);



/*
 *  Show/Hide premium options and sections:
 */
function evl_SH_premium_options(sh) {
    //alert(jQuery("#" + evl_switchContainerTabID).children("ul").children("#" + evl_switchFieldID).length);
    evl_SH_reset_customizer(); // Customizer reset
    // Hide/Show premium options:
    jQuery("." + evl_lockedFieldClass).each(
            function () {
                sh == "hide" ? jQuery(this).parent().addClass("redux-force-hide")
                        : (sh == "show" ? jQuery(this).parent().removeClass("redux-force-hide") : null);
            }
    );
    // Hide/Show special premium fields (Labels, for example)
    jQuery("." + evl_premiumElementClass).each(
            function () {
                sh == "hide" ? jQuery(this).addClass("redux-force-hide")
                        : (sh == "show" ? jQuery(this).removeClass("redux-force-hide") : null);
            }
    );
    // Hide/Show premium sections:
    jQuery("." + evl_lockedSectionClass).each(
            function () {
                sh == "hide" ? jQuery(this).parent().addClass("redux-force-hide")
                         : (sh == "show" ? jQuery(this).parent().removeClass("redux-force-hide") : null);
            }
    );
    // Hack for specific elements:
    for (var i = 0; i < evl_SH_elements.length; i++) {
        sh == "hide" ? jQuery(evl_SH_elements[i]).addClass("redux-force-hide")
                : (sh == "show" ? jQuery(evl_SH_elements[i]).removeClass("redux-force-hide") : null);
    }
}




// Using Customizer's JS API to reset the Customizer:
function evl_SH_reset_customizer() {
    wp.customize.section.each(function (section) {
        section.collapse();
    });
    wp.customize.panel.each(function (panel) {
        panel.collapse();
    });
}


/*
 *  Evaluate if the needed elements exist,
 *  in orther to show the switch on top of the Customizer:
 */
function evl_SH_evaluate() {
    if (
            (jQuery("#" + evl_referenceElement).length > 0) &&
            (jQuery("#" + evl_junkFieldID).length > 0) &&
            // (jQuery("#" + evl_switchContainerTabID).children("ul").children("#" + evl_switchFieldID).length > 0) &&
            (jQuery("#" + evl_switchContainerTabID).length > 0) &&
            (jQuery("#" + evl_switchFieldID).children("div").children("." + evl_descriptionClass).length > 0)
            ) {
        return true;
    } else {
        return false;
    }
}

/*
 *  Injects the switch code into the top of the Customizer:
 */
function evl_SH_inject_switch() {
    // Override some Customizer classes for changing the layout:
    var style = '<style>.wp-full-overlay-sidebar-content{top: 140px !important;}.accordion-section-content{padding: 0 12px 12px 12px !important;}.current-panel .accordion-sub-container.control-panel-content{padding: 95px 0px 0px 0px;}</style>';
    jQuery(style).insertBefore("#" + evl_referenceElement);

    // Inject the switch container into the Customizer top:
    jQuery('<div class="redux-customizer-SH-container" id="evl-SH-container1"></div>').insertBefore("#" + evl_referenceElement);

    // Hide "Premium options visivility" tab:
    jQuery("#" + evl_switchContainerTabID).addClass("redux-force-hide");

    // Change the description look and add help icon:
    jQuery("#" + evl_switchFieldID).children("div").children("." + evl_descriptionClass).each(
            function () {
                jQuery(this).addClass("redux-SH-customizer-info");
                jQuery(
                        '<li id="evl-SH-question" class="redux-SH-question-customizer dashicons dashicons-editor-help">&nbsp</li><br>'
                        ).insertBefore(this);
            }
    );

    // Force the switch code injection to the top of the customizer
    var loop = 1;
    var myVar = setInterval(function () {
        if (loop < 31) {
            // if (jQuery("#" + evl_switchContainerTabID).children("ul").children("#" + evl_switchFieldID).length > 0) {
                jQuery("#evl-SH-container1").append(jQuery("#" + evl_switchFieldID));
                jQuery("#" + evl_junkFieldID).click();
                console.log("Loop " + loop);
            // }
        } else {
            console.log("Loop finished");
            clearInterval(myVar);
        }
        loop++;
    }, 500);

    // Show info text when mouse is over the question mark icon
    jQuery("#evl-SH-question").mouseover(
            function () {
                jQuery("#" + evl_switchFieldID).children("div").children("." + evl_descriptionClass).each(
                        function () {
                            jQuery(this).show();
                        }
                );
            }
    );
    // Hide info text when mouse is out of the question mark icon
    jQuery("#evl-SH-question").mouseout(
            function () {
                jQuery("#" + evl_switchFieldID).children("div").children("." + evl_descriptionClass).each(
                        function () {
                            jQuery(this).hide();
                        }
                );
            }
    );
}












