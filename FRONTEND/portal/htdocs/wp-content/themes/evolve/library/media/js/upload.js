/* Add Mega Menu set-thumbnail js */
jQuery(document).ready(function ($) {

    var frame;
    jQuery('.evolve_upload_button').on('click', function (event) {

        event.preventDefault();
        var item_id = jQuery(this).attr('data-media-id');

        frame = wp.media({
            title: '',
            button: {
                text: 'Select'
            },
            multiple: false,
            //item_id: jQuery(this).attr('data-media-id')
        });

        frame.on('select', function () {

            //item_id = frame.options.item_id;

            var attachment = frame.state().get('selection').first().toJSON();

            jQuery('#evolve-media-display-' + item_id).append('<input type="text" class="upload_field" value="' + attachment.url + '" /></br><img src="' + attachment.url + '" alt="' + attachment.name + '" class="redux-option-image" style="width:60px; height:60px;"/>');
            jQuery('#evolve_' + item_id).val(attachment.id);
            jQuery('#evolve-media-upload-' + item_id).addClass('hidden');
            jQuery('#evolve-media-remove-' + item_id).removeClass('hidden');
            jQuery('#evolve-media-remove-extra-' + item_id).addClass('hidden');
        });

        frame.open();
    });

    jQuery('.evolve_remove_button').on('click', function (event) {

        event.preventDefault();
        var item_id = jQuery(this).attr('data-media-id');
        jQuery('#evolve-media-display-' + item_id).html('');
        jQuery('#evolve_' + item_id).val('');
        jQuery('#evolve-media-upload-' + item_id).removeClass('hidden');
        jQuery('#evolve-media-remove-' + item_id).addClass('hidden');
        jQuery('#evolve-media-remove-extra-' + item_id).removeClass('hidden');
    });

});

// Change tab on click in page/post option
jQuery(document).ready(function ($) {

    jQuery('.t4p_metabox_tabs li a').click(function (e) {
        e.preventDefault();

        var id = jQuery(this).attr('href');

        jQuery(this).parents('ul').find('li').removeClass('active');
        jQuery(this).parent().addClass('active');

        jQuery(this).parents('.inside').find('.t4p_metabox_tab').removeClass('active').hide();
        jQuery(this).parents('.inside').find('#t4p_tab_' + id).addClass('active').fadeIn();

    });

});