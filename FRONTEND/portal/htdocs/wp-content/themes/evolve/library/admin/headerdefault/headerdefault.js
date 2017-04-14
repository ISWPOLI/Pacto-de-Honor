
var HeaderDefault = {
    baseName: 'evl_options',
    headerFieldName: 'evl_header_type',
    headerValue: {
        'none': [
            {fieldType: 'font-family', fieldName: 'evl_title_font', fieldValue: 'Roboto', isGoogle: true},
            {fieldType: 'font-family', fieldName: 'evl_menu_font', fieldValue: 'Roboto', isGoogle: true},
            {fieldType: 'font-family', fieldName: 'evl_tagline_font', fieldValue: 'Roboto', isGoogle: true},
            {fieldType: 'select', fieldName: 'evl_social_box_radius', fieldValue: 'disabled'},
            {fieldType: 'select', fieldName: 'evl_menu_submenu_font_icon', fieldValue: 'regular'},
            {fieldType: 'color', fieldName: 'evl_top_menu_hover_font_color', fieldValue: '#ffffff'},
            {fieldType: 'select', fieldName: 'evl_menu_text_transform', fieldValue: 'none'},
            {fieldType: 'select', fieldName: 'evl_pos_logo', fieldValue: 'left'},
            {fieldType: 'select', fieldName: 'evl_tagline_pos', fieldValue: 'next'},
            {fieldType: 'select', fieldName: 'evl_social_icons_size', fieldValue: 'normal'},
            {fieldType: 'select', fieldName: 'evl_main_menu_hover_effect', fieldValue: 'rollover'},
        ],
        'h1': [
            {fieldType: 'font-family', fieldName: 'evl_title_font', fieldValue: 'Oswald', isGoogle: true},
            {fieldType: 'font-family', fieldName: 'evl_menu_font', fieldValue: 'PT Sans', isGoogle: true},
            {fieldType: 'font-family', fieldName: 'evl_tagline_font', fieldValue: 'PT Sans', isGoogle: true},
            {fieldType: 'select', fieldName: 'evl_social_box_radius', fieldValue: '3'},
            {fieldType: 'select', fieldName: 'evl_menu_submenu_font_icon', fieldValue: 'regular'},
            {fieldType: 'color', fieldName: 'evl_top_menu_hover_font_color', fieldValue: '#0bb697'},
            {fieldType: 'select', fieldName: 'evl_menu_text_transform', fieldValue: 'none'},
            {fieldType: 'select', fieldName: 'evl_pos_logo', fieldValue: 'left'},
            {fieldType: 'select', fieldName: 'evl_tagline_pos', fieldValue: 'under'},
            {fieldType: 'select', fieldName: 'evl_social_icons_size', fieldValue: 'small'},
            {fieldType: 'select', fieldName: 'evl_main_menu_hover_effect', fieldValue: 'disable'},
        ]
    }
    ,
    bind: function () {

        var t = this;
        //var watchName = 'input[name="'+ t.baseName+ '[' + t.headerFieldName + ']"]';
        var watchName = '#' + t.baseName + '-' + t.headerFieldName + ' input';

        jQuery(document).on('change', watchName, function (event) {
            var currentValue = jQuery(watchName + ":checked").val();

            if (t.headerValue.hasOwnProperty(currentValue)) {
                //console.log('do changes');
                var cgs = t.headerValue[currentValue];
                jQuery.each(cgs, function (i, v) {
                    switch (v.fieldType) {
                        case 'select':
                            jQuery('#' + v.fieldName + '-select').val(v.fieldValue).trigger('change');
                            break;
                        case 'font-family':
                            jQuery('#' + v.fieldName + ' .redux-typography-google').val(v.isGoogle);

                            jQuery('#' + v.fieldName + ' .redux-typography-font-family').val(v.fieldValue);  //c
                            jQuery('#' + v.fieldName + ' .redux-typography-family:first').data('value', v.fieldValue).val(v.fieldValue);

                            if (jQuery('#' + v.fieldName + ' .redux-typography-family').length > 1) {
                                jQuery('#' + v.fieldName + ' .redux-typography-family:last').select2('val', v.fieldValue);
                            }

                            jQuery('#' + v.fieldName + ' .redux-typography ').trigger('change');
                            break;
                        case 'color':
                            //jQuery('input.redux-customizer-input[data-id="'+ t.baseName+ '[' + v.fieldName + ']"]').val(v.fieldValue).trigger('change'); //c
                            jQuery('#' + v.fieldName + '-color').val(v.fieldValue).trigger('change');
                            break;
                        case 'switch':

                            if (v.fieldValue == '1') {
                                jQuery('#' + v.fieldName).val(1).trigger('change');
                                jQuery('#' + v.fieldName).parents('fieldset').find('.cb-enable').addClass('selected').trigger('click');
                                jQuery('#' + v.fieldName).parents('fieldset').find('.cb-disable').removeClass('selected');
                            } else {
                                jQuery('#' + v.fieldName).val(0).trigger('change')
                                jQuery('#' + v.fieldName).parents('fieldset').find('.cb-enable').removeClass('selected');
                                jQuery('#' + v.fieldName).parents('fieldset').find('.cb-disable').addClass('selected').trigger('click');
                            }
                            break;
                        default:
                            //
                            break;
                    }
                })
            }
            ;

        });
    }

};

HeaderDefault.bind();