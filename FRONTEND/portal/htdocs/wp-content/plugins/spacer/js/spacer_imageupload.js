jQuery(document).ready(function($){
 
 
    var custom_uploader;
 
 
    $('.motech_upload_image_button').click(function(e) {
        e.preventDefault();
		
  		//select closest image field so if there is more than one the right one will get changed
		image_field = $(this).siblings('.motech_upload_image');
		
        //If the uploader object has already been created, reopen the dialog
        if (custom_uploader) {
            custom_uploader.open();
            return;
        }
 
        //Extend the wp.media object
        custom_uploader = wp.media.frames.file_frame = wp.media({
            title: 'Choose Image',
            button: {
                text: 'Choose Image'
            },
            multiple: false
        });
 

		
		//When a file is selected, grab the URL and set it as the text field's value
        custom_uploader.on('select', function() {
            attachment = custom_uploader.state().get('selection').first().toJSON();
            image_field.val(attachment.url).trigger("change");
        });
 
        //Open the uploader dialog
        custom_uploader.open();
 
    });
 
 
});