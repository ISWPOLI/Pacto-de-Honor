(function( $ ) {
	/* dismiss the unbranding notice box for 3 days */
	$( document ).on( 'click', '#dismiss-unbranding, #unbranding-plugin-notice .notice-dismiss', function() {
		$.post( ajaxurl, {action: 'dismiss_unbranding'}, function() {
			/* remove the unbranding notice box */
			$( '#unbranding-plugin-notice' ).fadeOut();
		});
	});
	$( document ).on( 'click', '#dismiss-tesseractplus, #tesseractplus-plugin-notice .notice-dismiss', function() {
		$.post( ajaxurl, {action: 'dismiss_tesseractpls'}, function() {
			/* remove the unbranding notice box */
			$( '#tesseractplus-plugin-notice' ).fadeOut();
		});
	});
})(jQuery)