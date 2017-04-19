jQuery(document).ready(function () {

    /*
     The following values depend on the html code,
     change here if future Redux or theme updates
     change the ids and/or classes:
     */
    var evl_switchID = "evl_hiden_premium";
    var evl_enabledClass = "cb-enable";
    var evl_disabledClass = "cb-disable";
    var evl_selectedClass = "selected";
    var evl_fieldsetID1 = "evl_options-evl_hiden_premium";
    var evl_fieldsetID2 = "evl_options-evl_hiden_premium2";
    var evl_switchContainerClass = "switch-options";
    var evl_groupTabClass = "redux-group-tab-link-a";
    var evl_menuClass = "redux-group-menu";
    var evl_hiddenSubtabClass = "hidden";

    // Show/hide premium options switch (change event trigger):
    jQuery('#' + evl_switchID).parent().change(
            function () {
                jQuery(this).children("label").each(
                        function () {
                            if (jQuery(this).hasClass(evl_selectedClass)) {
                                if (jQuery(this).hasClass(evl_disabledClass)) {
                                    jQuery("#evl-premium-switch2-on").removeClass(evl_selectedClass);
                                    jQuery("#evl-premium-switch2-off").addClass(evl_selectedClass);
                                    evl_SH_premium_options("hide");
                                }
                                if (jQuery(this).hasClass(evl_enabledClass)) {
                                    jQuery("#evl-premium-switch2-off").removeClass(evl_selectedClass);
                                    jQuery("#evl-premium-switch2-on").addClass(evl_selectedClass);
                                    evl_SH_premium_options("show");
                                }
                            }
                        }
                )
            }
    );

    // Hide premium tabs if "Hide" option is active:
    jQuery('#' + evl_switchID).siblings("label").each(
            function () {
                if (jQuery(this).hasClass(evl_selectedClass)) {
                    if (jQuery(this).hasClass(evl_disabledClass)) {
                        jQuery("#evl-premium-switch2-off").addClass(evl_selectedClass);
                        evl_SH_premium_options("hide")
                    } else {
                        jQuery("#evl-premium-switch2-on").addClass(evl_selectedClass);
                    }
                }
            }
    );

    // Show/Hide switch info triggers:
    jQuery("#evl-SH-question-img1").mouseover(
            function () {
                jQuery('#evl-SH-info1').css('display', 'inline');
            }
    );
    jQuery("#evl-SH-question-img1").mouseout(
            function () {
                jQuery('#evl-SH-info1').css('display', 'none');
            }
    );

    jQuery("#evl-SH-question-img2").mouseover(
            function () {
                jQuery('#evl-SH-info2').css('display', 'inline');
            }
    );
    jQuery("#evl-SH-question-img2").mouseout(
            function () {
                jQuery('#evl-SH-info2').css('display', 'none');
            }
    );

    jQuery("#evl-premium-switch2-on").click(
            function () {
                jQuery("#" + evl_fieldsetID1).children("." + evl_switchContainerClass).children("." + evl_enabledClass)[0].click();
            }
    );
    jQuery("#evl-premium-switch2-off").click(
            function () {
                jQuery("#" + evl_fieldsetID1).children("." + evl_switchContainerClass).children("." + evl_disabledClass)[0].click();
            }
    );


    /*
     *	Bind every Menu Tab click()  event
     */
    var selectedTab = false;
    jQuery("." + evl_groupTabClass).each(
            function () {
                if (jQuery(this).parent().parent("." + evl_menuClass).length > 0) {
                    jQuery(this).click(
                            function () {
                                jQuery(this).parent().children("ul").children("li").each(
                                        function () {
                                            if (!jQuery(this).hasClass(evl_hiddenSubtabClass) && (selectedTab == false)) {
                                                jQuery(this).children("a").each(
                                                        function () {
                                                            var link = this;
                                                            setTimeout(
                                                                    function () {
                                                                        jQuery(link).click();
                                                                        console.log("Subtab selected...");
                                                                    },
                                                                    500
                                                                    );
                                                        }
                                                );
                                                selectedTab = true;
                                            }
                                        }
                                );
                                selectedTab = false;
                            }
                    );
                }
            }
    );


});

function evl_SH_premium_options(sh) {
    /*
     The following values depend on the html code,
     change here if future Redux or theme updates
     change the classes:
     */
    var lockedFieldClass = "redux-field-locked";
    var requiredClass = "fold";
    var tabClass = "redux-group-tab-link-li";
    var hiddenClass = "hidden";
    var premiumClass = "evl_premium_feature";
    var premium = false;


    jQuery("tr").each(
            function () {
                premium = false;
                jQuery(this).children("td").children("fieldset").children("div").each(
                        function () {
                            if (jQuery(this).hasClass(lockedFieldClass)) {
                                premium = true;
                            }
                        }
                );
                if (premium && !(jQuery(this).hasClass(requiredClass))) {
                    sh == "show" ? jQuery(this).show() : jQuery(this).hide();
                }
            }
    );

    if (sh == "show") {
        jQuery("." + tabClass).each(
                function () {
                    if (jQuery(this).hasClass(hiddenClass)) {
                        jQuery(this).removeClass(hiddenClass);
                    }
                }
        );
        jQuery("." + premiumClass).each(
                function () {
                    jQuery(this).removeClass("redux-force-hide");
                }
        );
    }

    if (sh == "hide") {
        var menuID;
        jQuery("." + premiumClass).each(
                function () {
                    jQuery(this).addClass("redux-force-hide");
                    menuID = jQuery(this).attr("data-rel");
                    jQuery("#" + menuID + "_section_group_li").addClass(hiddenClass);
                }
        );
    }
}