jQuery(function ( $ ) {
	// Create a "Content Blocks" button in the header of the Page Builder
	$( '.fl-builder-bar-actions .fl-builder-tools-button' ).after(
		'<span class="fl-builder-tesseract-blocks-button fl-builder-button">Content Blocks</span>'
	);
	if(FLBuilderConfig) FLBuilderConfig.upgradeUrl = 'https://www.wpbeaverbuilder.com/pricing/?fla=50&campaign=tesseracttheme';
	//if(FLBuilderConfig) FLBuilderConfig.upgradeUrl = 'http://tesseracttheme.com/plus/';
	
	// Set up the popup/modal using Beaver Builder's UI
	var contentBlocksLightbox = new FLLightbox({
		className: 'fl-builder-tesseract-blocks-lightbox'
	});

	// When the user clicks the "Content Blocks" button...
	$( document ).on( 'click', '.fl-builder-tesseract-blocks-button', function() {
		// Open the modal
		contentBlocksLightbox.open( $( '#tesseract-content-blocks-wrapper' ).html() );

		// Hook the cancel button to close the modal
		$( document ).on( 'click', '.fl-builder-tesseract-blocks-lightbox .fl-builder-cancel-button', function ( e ) {
			e.preventDefault();
			contentBlocksLightbox.close();
		} );

		// Hook the content appending buttons up
		$( document ).one( 'click', '.fl-builder-tesseract-blocks-lightbox .append-content-button', function ( e ) {
			e.preventDefault();

			contentBlocksLightbox.close();
			FLBuilder._applyTemplate( $( this ).data( 'template-id' ), true, 'user' );
		} );
	} );

	// check for content blocks updates
	$( document ).on( 'click', '.fl-builder-blocks-update', function() {
		var $icon = $( this ).find( '.fa.fa-refresh' );
		var data = {
			action: 'tesseract_content_blocks_update'
		};

		$icon.addClass( 'fa-spin' ).css( 'animation-duration', '1s' );

		$.post( ajaxurl, data, function() {
			$icon.removeClass( 'fa-spin' );

			$.post( ajaxurl, {action: 'tesseract_add_button_to_page_builder'}, function( blocksHtml ) {
				$( '.fl-lightbox-content' ).html( $( blocksHtml ).html() );
			});
		});
	});
	
	if($(".fl-builder-modules-cta a").length){ 
		stronclick = $(".fl-builder-modules-cta a").attr("onclick");		
		if(typeof stronclick != "undefined" && stronclick.toLowerCase().indexOf("wpbeaverbuilder.com") >= 0){
			$(".fl-builder-modules-cta a").prop('onclick', null) .off('click');		 
		}
	};		
   $(document.body).on("click",".fl-builder-upgrade-button,.fl-builder-modules-cta a",function(e){
		strhref = $(this).attr("href");
		if(typeof strhref != "undefined" && strhref.toLowerCase().indexOf("wpbeaverbuilder.com") >= 0){
			$(this).attr('href','https://www.wpbeaverbuilder.com/pricing/?fla=50&campaign=tesseracttheme');			 
		}else{		
			stronclick = $(this).attr("onclick");			
			if(typeof stronclick != "undefined" && stronclick.toLowerCase().indexOf("wpbeaverbuilder.com") >= 0){
				e.preventDefault();e.stopPropagation();
				window.open('https://www.wpbeaverbuilder.com/pricing/?fla=50&campaign=tesseracttheme');				 
			}
		}
	});		
});
