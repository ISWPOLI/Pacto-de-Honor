<?php if($settings->link_type == 'lightbox') : ?>
jQuery(function($) {
if (typeof $.fn.magnificPopup !== 'undefined') {
	$('.fl-node-<?php echo $id; ?> a').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		closeBtnInside: false,
		tLoading: '',
		preloader: true,
		callbacks: {
		    open: function() {
		    	$('.mfp-preloader').html('<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>');
		    }
	  	}
	});
}
});
<?php endif; ?>