jQuery(document).ready(function($){

	//perform function when element is clicked
	$('body').on('click', '.wp-picker-clear', function() {
		$(this).closest(".aspacerunit").find("input[name^='motech_spacer_default_border_top_width']").trigger("change");
	});
	
	jQuery("#motech_spacer_visualartist_license").after("<input type='hidden' name='motech_spacer_visualartist_license_av' id='motech_spacer_visualartist_license_av' value=0>");
		//perform function when element is clicked
		jQuery(".motech_spacer_visualartist_validate_alt").click(function(e){
			e.preventDefault();
			//console.log('hi');
			var hmsp = prompt("Please enter your Visual Artist license", "");
			if (hmsp!=null && hmsp!='') {
				jQuery.ajax({
					url: 'http://www.clevelandwebdeveloper.com/spacerl/vl_ajax.php',
					data: {k: hmsp, w: window.location.href},
					dataType: 'jsonp',
					jsonp: 'callback',
					jsonpCallback: 'jsonpCallback_motech_spacer_visualartist_license',
					success: function(){
						//
					}
				});
			}

	});
	






	
	//make sure this runs within jquery on dom ready. javascript file should be loaded before spacer core javascript file.
	motechSpacerPreview.hooks.push(
		function(spacerElement){
			useImagePreviewElement = spacerElement.find("input[name^='motech_spacer_default_background_image_upload']");
			if (typeof useImagePreviewElement !== 'undefined') {
				useImagePreviewValue = useImagePreviewElement.first().val();
				useImagePreviewElement.closest("tr").find(".motech_spacer_preview_image").css("background-image","url("+useImagePreviewValue+")");
			}
			useTopBorderWidth = spacerElement.find("input[name^='motech_spacer_default_border_top_width']").first().val();
			useTopBorderStyle = spacerElement.find("select[name^='motech_spacer_default_border_top_style']").val();
			useTopBorderColor = spacerElement.find("input[name^='motech_spacer_default_border_top_color']").val();
			if ((typeof useTopBorderStyle !== 'undefined')) {
				spacerElement.find(".spacer_preview").css( 'border-top-style',useTopBorderStyle );
			}
			if (typeof useTopBorderWidth !== 'undefined') {
				if(!((typeof parseFloat(useTopBorderWidth) === 'number') && (parseFloat(useTopBorderWidth) >= 0))){
					useTopBorderWidth = 0;
				}
				spacerElement.find(".spacer_preview").css( 'border-top-width',useTopBorderWidth+'px' );
			}
			if ((typeof useTopBorderColor !== 'undefined')) {
				if(useTopBorderColor==""){
					useTopBorderColor = "transparent";
				}
				spacerElement.find(".spacer_preview").css( 'border-top-color',useTopBorderColor );
			}
			
			useBottomBorderWidth = spacerElement.find("input[name^='motech_spacer_default_border_bottom_width']").first().val();
			useBottomBorderStyle = spacerElement.find("select[name^='motech_spacer_default_border_bottom_style']").val();
			useBottomBorderColor = spacerElement.find("input[name^='motech_spacer_default_border_bottom_color']").val();
			if ((typeof useBottomBorderStyle !== 'undefined')) {
				spacerElement.find(".spacer_preview").css( 'border-bottom-style',useBottomBorderStyle );
			}			
			if (typeof useBottomBorderWidth !== 'undefined') {
				if(!((typeof parseFloat(useBottomBorderWidth) === 'number') && (parseFloat(useBottomBorderWidth) >= 0))){
					useBottomBorderWidth = 0;
				}
				spacerElement.find(".spacer_preview").css( 'border-bottom-width',useBottomBorderWidth+'px' );
			}
			if ((typeof useBottomBorderColor !== 'undefined')) {
				if(useBottomBorderColor==""){
					useBottomBorderColor = "transparent";
				}
				spacerElement.find(".spacer_preview").css( 'border-bottom-color',useBottomBorderColor );
			}
			
			useBgColor = spacerElement.find("input[name^='motech_spacer_default_bg_color']").val();
			if ((typeof useBgColor !== 'undefined')&&(useBgColor!="")) {
				spacerElement.find(".spacer_preview").css( 'background-color',useBgColor );
			}
			
			useBgImage = spacerElement.find("input[name^='motech_spacer_default_background_image_upload']").val();
			if ((typeof useBgImage !== 'undefined')&&(useBgImage!="")) {
				spacerElement.find(".spacer_preview").css( 'background-image','url("'+useBgImage+'")' );
			}
			
			useBgPosition = spacerElement.find("select[name^='motech_spacer_custom_background_image_position']").val();
			if (typeof useBgPosition !== 'undefined') {
				if(useBgPosition=="repeat"){
					useBgPosition = {"background-repeat":"repeat"};
				} else if(useBgPosition=="croptofit"){
					useBgPosition = {"background-size":"cover","background-position":"center"};
				} else if(useBgPosition=="stretch"){
					useBgPosition = {"background-size":"100% 100%","background-repeat":"no-repeat","background-position":"center"};
				} else if(useBgPosition=="propstretch"){
					useBgPosition = {"background-size":"contain","background-repeat":"no-repeat","background-position":"center"};
				}else if(useBgPosition=="proprepeat"){
					useBgPosition = {"background-size":"contain","background-repeat":"repeat","background-position":"center"};
				}
				spacerElement.find(".spacer_preview").css( useBgPosition );
			}
			
			useBottomMargin = spacerElement.find("input[name^='motech_spacer_default_bottom_margin']").first().val();
			if (typeof useBottomMargin !== 'undefined') {
				if(((typeof parseFloat(useBottomMargin) === 'number'))){
					spacerElement.find(".spacer_preview").css( 'margin-bottom',useBottomMargin+'px' );
				}				
			}
			
			useShadow = spacerElement.find("select[name^='motech_spacer_default_shadow']").val();
			if ((typeof useShadow !== 'undefined')&&(useShadow!="none")) {
				if(useShadow=="light"){
					useShadow = {"box-shadow":"0px 2px 3px rgba(119, 119, 119,0.5)"};
				} else if(useShadow=="medium"){
					useShadow = {"box-shadow":"0px 2px 4px #777"};
				} else if(useShadow=="heavy"){
					useShadow = {"box-shadow":"0px 2px 10px #888"};
				}
				spacerElement.find(".spacer_preview").css( useShadow );
			}			
			
			
			
		}
	);
	
});

function jsonpCallback_motech_spacer_visualartist_license(data){
	if(data.r == "vle"){
		jQuery("#motech_spacer_visualartist_license_av").val(1);
		jQuery(".savebutton button").click();
	} else {
		alert(data.error);
	}
}	

