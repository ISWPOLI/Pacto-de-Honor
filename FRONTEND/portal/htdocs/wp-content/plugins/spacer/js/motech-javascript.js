jQuery(document).ready(function($){
		
		//console.log(hash);
	 	//Tabs on click
	 	$('.nav-tab-wrapper').on('click', 'a', function(e){
			e.preventDefault();
			tabContent = $(this).attr('href');
			$('.nav-tab').removeClass('nav-tab-active');
			//$tabBoxes.addClass('hidden');
			//$currentTab = $($tabContent).toggleClass('hidden');
			$(".mainsection").addClass("hidden");
			$(tabContent+".mainsection").removeClass("hidden");
			$(this).addClass('nav-tab-active');
			if(window.location.hash != tabContent){
				if(history.pushState) {
					history.pushState(null, null, tabContent);
				}
				else {
					location.hash = tabContent;
				}				
				//window.location.replace(tabContent);
			}
			if($(this).attr("href")=="#addons" || $(this).attr("href")=="#suggestionbox"){
				$(".savebutton").hide();
			}else{
				$(".savebutton").show();
			}
/*			 if(history.pushState) {
				history.pushState(null, null, $tabContent);
			}
			else {
				location.hash = $tabContent;
			}*/
		})
		
		var hash = window.location.hash;
		$('.nav-tab-wrapper a[href="'+hash+'"]').click();

		$("body").on('click', '.aspacerunit .removebutton', function(e) {
			e.preventDefault();
			element = $(this).closest(".addspacerunit.postbox");
			element.fadeOut("fast", function() {
        		element.remove();
				if($(".addspacerunit.postbox").length == 0){
					$("#addspacers .nothinghere").hide().removeClass(".hidden").fadeIn("fast");
				}
    		});
		});
	
		//perform function when element is clicked
		$('body').on('click', '.motech_spacer_form .postbox .hndle, .motech_spacer_form .postbox .handlediv', function(e) {
			e.preventDefault();
			$(this).closest(".postbox").toggleClass("closed");
		});
		
		$('body').on('input change', 'input.addingspacer, input.addingheader, input.addingpanel', function() {
			var newval = jQuery(this).val();
			if(newval==""){
				newval = "Untitled";
			}
			jQuery(this).closest(".addspacerunit.postbox, .aheaderunit.postbox, .apanelunit.postbox").find(".hndle span").first().text(newval);
		});
		
		$('body').on('.aspacerunit input change', '.aspacerunit input, .aspacerunit textarea, .aspacerunit select', function() {
			spacerunit = $(this).closest(".aspacerunit");
		 	motechSpacerPreview.core(spacerunit);
		});
		
		
	
		
		//perform function when element is clicked
		jQuery("#addspacers .newbutton").click(function(){
			$("#addspacers .nothinghere").fadeOut("fast", function() {
				if($(".addspacerunit").length != 0){
					newspacer = $(".addspacerunit").last().clone();
				}else{
					newspacer = lastspacer.clone();
				}
				newspacer.hide().insertBefore("#addspacers .newbutton").fadeIn("fast");
				newspacer.find(":input:not(select):not([type=button])").val("").trigger("change");
				newspacer.find(":input").removeAttr("id");
				newspacer.find("input.sheight").val("20");
				newspacer.find("select option").attr('selected', false);
				newspacer.find(".motech_spacer_preview_image_container").remove();
				
				newspacer.removeClass("closed");
				
				indexelement = $("#motech_spacer_addspacer_index");
				getindex = indexelement.val();
				//console.log(getindex);
				newindex = parseInt(getindex)+1;
				indexelement.val(newindex);
				newspacer.find(".addspacer_id").val(newindex);
				//newspacer.find(".msunit,.msunitmobile").val("px");
				newspacer.find("select").each(
				function() {
					$(this).val($(this).find("option:first").val());
				});
				//$("#target").val($("#target option:first").val());

				
				//set new image pickers to work
				newspacer.find('.wp-picker-input-wrap').each(function(){
					targetinput = $(this).find(".motech-color-field");
					$(this).closest(".wp-picker-container").before(targetinput).remove();
					targetinput.wpColorPicker({
						change: function(event, ui) {
							if($(event.target).attr("name").indexOf("motech_spacer_default_bg_color") >= 0){
								$(event.target).closest(".aspacerunit").find(".spacer_preview").css('background-color',ui.color.toString());
							}else if($(event.target).attr("name").indexOf("motech_spacer_default_border_top_color") >= 0){
								$(event.target).closest(".aspacerunit").find(".spacer_preview").css('border-top-color',ui.color.toString());
							}else if($(event.target).attr("name").indexOf("motech_spacer_default_border_bottom_color") >= 0){
								$(event.target).closest(".aspacerunit").find(".spacer_preview").css('border-bottom-color',ui.color.toString());
							}
						}
					});;
				});
				 
				//set new custom upload to work
				var custom_uploader;
			 
				newspacer.find('.motech_upload_image_button').click(function(e) {
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
				
				
				
				motechSpacerPreview.core(newspacer);
				var titlename = newspacer.find("input.addingspacer").attr("name");
				var arraykey = titlename.slice(titlename.indexOf('[') +1,titlename.indexOf(']'));
				newkey = parseInt(arraykey)+1;
				//console.log(newkey);
				newspacer.find(":input").each(function () {
					oldname = $(this).attr("name");
					if (typeof oldname !== typeof undefined && oldname !== false) {
						newname = oldname.replace("["+arraykey+"]", "["+newkey+"]");
						$(this).attr("name",newname);
						//console.log($(this).attr("name"));
					}
				});
	

			});
		});
		
		lastspacer = $(".addspacerunit").last().clone(); //create a clone of the last spacer during initial load, store it for later...
		if(lastspacer.find("input.addspacer_id").val()==""){ //delete initial add spacer if none exist...
			$(".addspacerunit").last().remove();
			$("#addspacers .nothinghere").hide().removeClass(".hidden").fadeIn("fast");
		}
		
		$(".aspacerunit").each(function () {
			motechSpacerPreview.core($(this));			
		});	
		


});

var motechSpacerPreview = {
		hooks : [],
		core : function(spacerElement){
			//spacerElement.css("opacity",".5");
			useheight = spacerElement.find("input[name='motech_spacer_default_height'], input.sheight").first().val();
			useunit = spacerElement.find("select[name='motech_spacer_default_height_unit'], select.msunit").val();
			spacerElement.find(".spacer_preview").attr("style","display: block; clear: both; height: 0px;");
			if(useheight > 0) {
				spacerElement.find(".spacer_preview").css({ 'padding-top' : useheight+useunit, 'margin-top' : '' });
			}else if(useheight < 0){
				spacerElement.find(".spacer_preview").css({ 'margin-top' : useheight+useunit, 'padding-top' : '' });
			}else{
				spacerElement.find(".spacer_preview").css({ 'margin-top' : '', 'padding-top' : '' });
			}
			for (i = 0; i < this.hooks.length; i++) {
				this.hooks[i](spacerElement); //send the spacer preview element to the callback function.
			}
			usestyle = spacerElement.find("textarea[name='motech_spacer_spacer_style'], textarea.msstyle").val();
			currentstyle = spacerElement.find(".spacer_preview").attr("style");
			spacerElement.find(".spacer_preview").attr("style",currentstyle+usestyle);			

		}		
}