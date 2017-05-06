/*for pro feature*/
jQuery(document).ready(function(e) {
    jQuery('.pro_select,.pro_input,.disabled_picker').click(function(){alert("If you want to use this feature upgrade to Pro Version")});
	  jQuery('li.ui-state-default').not('#wpdevart_lightbox_information_sortable li').mousedown(function(){alert("If you want to use this feature upgrade to Pro Version")})
});
/*ADMIN CUSTOMIZE SETTINGS OPEN OR HIDE*/
function get_array_of_opened_elements(){
	var kk=0;
	var array_of_activ_elements=new Array();
	jQuery('#wpdevart_lightbox_page .main_parametrs_group_div').each(function(index, element) {		
        if(!jQuery(this).hasClass('closed_params')){			
			array_of_activ_elements[kk]=jQuery('#wpdevart_lightbox_page .main_parametrs_group_div').index(this);
			kk++;
		}
    });
	return array_of_activ_elements;
}
/*countdown*/
function refresh_countdown(){
	var countdown={}
	countdown['days']=jQuery('#wpdevart_lightbox_page_countdownday').val();
	countdown['hours']=jQuery('#wpdevart_lightbox_page_countdownhour').val();
	countdown['start_day']=jQuery('#wpdevart_lightbox_page_countdownstart_day').val();

	jQuery('#wpdevart_lightbox_page_countdown').val(JSON.stringify(countdown))
}

jQuery(document).ready(function(e) {
	/*countdown*/
	var currentTime = new Date();
	var month = currentTime.getMonth();
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	jQuery("#wpdevart_lightbox_page_countdownstart_day").datepicker({
		inline: true,
		nextText: '&rarr;',
		prevText: '&larr;',
		showOtherMonths: true,
		dateFormat: 'dd/mm/yy',
		dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		maxDate: new Date(year,month,day)
	});
	/* SECTION OPEN HIDE AND SEAVE*/
    if (typeof(localStorage) != 'undefined' ) {
			active_coming_sections = localStorage.getItem("wpdevart_lightbox_array_of_activ_section");
			active_coming_sections=JSON.parse(active_coming_sections)
			if(active_coming_sections!=null)
			for(ii=0; ii<active_coming_sections.length;ii++){
				jQuery(jQuery('#wpdevart_lightbox_page .main_parametrs_group_div').eq(active_coming_sections[ii])).removeClass('closed_params');
			}
	}	
	jQuery('.main_parametrs_group_div > .head_panel_div').click(function(){
		
		if(jQuery(this).parent().hasClass('closed_params')){
			jQuery(this).parent().find('.inside_information_div').slideDown( "normal" )
			jQuery(this).parent().removeClass('closed_params');
			localStorage.setItem("wpdevart_lightbox_array_of_activ_section", JSON.stringify(get_array_of_opened_elements()));
		}
		else{
			jQuery(this).parent().find('.inside_information_div').slideUp( "normal",function(){jQuery(this).parent().addClass('closed_params'); localStorage.setItem("wpdevart_lightbox_array_of_activ_section", JSON.stringify(get_array_of_opened_elements()));} )
		}
		
	})
	/*SET CLOR PICKERS*/
	jQuery('.color_option').wpColorPicker()
	
	/*radio Enable Disable*/
	wpdevart_lightbox_clickable=1;
	jQuery(".cb-enable").click(function(){
		if(!wpdevart_lightbox_clickable || jQuery(this).hasClass('selected'))
		return;
		wpdevart_lightbox_clickable=0;
		jQuery('#wpdevart_lightbox_enable .saving_in_progress').css('display','inline-block');
		jQuery.ajax({
					type:'POST',
					url: wpdevart_lightbox_ajaxurl+'?action=wpdevart_lightbox_page_save',
					data: {curent_page:'main_settings',wpdevart_lightbox_options_nonce:jQuery('#wpdevart_lightbox_options_nonce').val(),eneble_lightbox_content:'enable'},
				}).done(function(date) {
					jQuery('#wpdevart_lightbox_enable .saving_in_progress').css('display','none');
					if(date==wpdevart_lightbox_parametrs_sucsses_saved){							
						jQuery('#wpdevart_lightbox_enable .sucsses_save').css('display','inline-block');
						setTimeout(function(){wpdevart_lightbox_clickable=1;jQuery('#wpdevart_lightbox_enable .sucsses_save').hide('fast');jQuery('#save_button').removeClass('padding_loading');jQuery("#save_button").prop('disabled', false);},500);
						
					}
					else{
						jQuery('#wpdevart_lightbox_enable .error_in_saving').css('display','inline-block');
						jQuery('#wpdevart_lightbox_enable .error_massage').html(date);							
						
					}
		});
		var parent = jQuery(this).parents('.switch');
		jQuery('.cb-disable',parent).removeClass('selected');
		jQuery(this).addClass('selected');		
	});
	jQuery(".cb-disable").click(function(){
		if(!wpdevart_lightbox_clickable || jQuery(this).hasClass('selected'))
		return;
		wpdevart_lightbox_clickable=0;
		jQuery('#wpdevart_lightbox_enable .saving_in_progress').css('display','inline-block');
		jQuery.ajax({
					type:'POST',
					url: wpdevart_lightbox_ajaxurl+'?action=wpdevart_lightbox_page_save',
					data: {curent_page:'main_settings',wpdevart_lightbox_options_nonce:jQuery('#wpdevart_lightbox_options_nonce').val(),eneble_lightbox_content:'disable'},
				}).done(function(date) {
					jQuery('#wpdevart_lightbox_enable .saving_in_progress').css('display','none');
					if(date==wpdevart_lightbox_parametrs_sucsses_saved){							
						jQuery('#wpdevart_lightbox_enable .sucsses_save').css('display','inline-block');
						setTimeout(function(){wpdevart_lightbox_clickable=1;jQuery('#wpdevart_lightbox_enable .sucsses_save').hide('fast');jQuery('#save_button').removeClass('padding_loading');jQuery("#save_button").prop('disabled', false);},500);
						
					}
					else{
						jQuery('#wpdevart_lightbox_enable .error_in_saving').css('display','inline-block');
						jQuery('#wpdevart_lightbox_enable .error_massage').html(date);
						
					}
		});
		var parent = jQuery(this).parents('.switch');
		jQuery('.cb-enable',parent).removeClass('selected');
		jQuery(this).addClass('selected');
					
	});
	
	/*Upload button single click*/
	jQuery('.upload-button').click(function () {
		window.parent.uploadID = jQuery(this).prev('input');
		/*grab the specific input*/
		formfield = jQuery('.upload').attr('name');
		tb_show('', 'media-upload.php?type=image&height=640&width=1000&TB_iframe=true');
		return false;
	});
	window.send_to_editor = function (html) {
		imgurl = jQuery('img', html).attr('src');
		window.parent.uploadID.val(imgurl);
		jQuery(window.parent.uploadID.parent()).remove('.cont_button_uploaded_img');
		jQuery(window.parent.uploadID.parent()).find('img').remove()
		jQuery(window.parent.uploadID.parent()).append('<img src="'+imgurl+'" class="cont_button_uploaded_img">');
		/*assign the value to the input*/
		tb_remove();
	};
	
	
	/* MANY UPLOADS FOR BACKGROUND*/
	jQuery('.add_upload_image_button').click(function(){
		 
		jQuery('.slider_images_div').eq(jQuery('.slider_images_div').length-1).after(jQuery('<div class="slider_images_div"><input type="text" class="upload_many_images" value=""/><input class="upload-button  button" type="button" value="Upload"/><img src="'+comig_soon_plugin_url+'images/remove_element.png" title="remove" class="remove_upload_image"/></div>'))
			initial_last_element_functions(this);
		})
		jQuery('.remove_upload_image').click(function(){
			if(jQuery('.remove_upload_image').length>1)
				jQuery(this).parent().remove()	
	})
 	function initial_last_element_functions(element_of_add){
		jQuery('.remove_upload_image').eq(jQuery('.remove_upload_image').length-1).click(function(){
			if(jQuery('.remove_upload_image').length>1)
				jQuery(this).parent().remove()	
		})
		jQuery(element_of_add).parent().find('.upload-button').eq(jQuery(element_of_add).parent().find('.upload-button').length-1).click(function () {
				window.parent.uploadID = jQuery(this).prev('input');
				/*grab the specific input*/
				formfield = jQuery('.upload').attr('name');
				tb_show('', 'media-upload.php?type=image&height=640&width=1000&TB_iframe=true');
				
				return false;
			});
	}

	
	/*SELECT BACKGROUND OTHER TRS HIDDEN*/
	jQuery('.coming_set_hiddens').change(function(){
		jQuery(this).find('option').each(function(index, element) {
            jQuery('.tr_'+jQuery(this).val()).hide();
        });
		 jQuery('.tr_'+jQuery(this).val()).show();
	})
	jQuery('.coming_set_hiddens option').each(function(index, element) {
            jQuery('.tr_'+jQuery(this).val()).hide();
        });
		jQuery('.coming_set_hiddens').each(function(index, element) {
            jQuery('.tr_'+jQuery(this).val()).show();
        });
	
	
	/*slider options*/
	
	jQuery('.lightbox_number_slider').each(function(index, element) { 
		var loc_this=this;
		var curent_value=jQuery(this).val(); 
		var min_value=jQuery(this).attr('data-min-val');		
		var max_value=jQuery(this).attr('data-max-val');		
		jQuery( jQuery(this).parent().find('.slider_div') ).slider({
			orientation: "horizontal",
			range: "min",
			value: curent_value,
			min: parseInt(min_value),
			max: parseInt(max_value),
			slide: function( event, ui ) {
				if(jQuery(loc_this).hasClass('pro_input')){
					alert("If you want to use this feature upgrade to Pro Version");
					jQuery(this).mouseup();
					return false;
				}
				jQuery( loc_this ).val( ui.value );
			}
		});
	});
	
	function set_information_ordering_to_input(element){
		var set_input_value={};
		jQuery('#wpdevart_lightbox_information_sortable').find('li').each(function() {
			var loc_array=[];
			if(jQuery(this).hasClass('control_active'))
				loc_array[0]=1;
			else
				loc_array[0]=0;
			loc_array[1]=jQuery( this ).attr('date-value');
			set_input_value[jQuery( this ).attr('date-value')]=loc_array;
		
		});			
		jQuery(element).val(JSON.stringify(set_input_value))	
	}
	/*sortable content*/
	var askofen=0;
	

	//// sortable information line
	jQuery( "#wpdevart_lightbox_information_sortable" ).sortable({placeholder: "ui-state-highlight"});
    jQuery( "#wpdevart_lightbox_information_sortable" ).disableSelection();
	
	jQuery( "#wpdevart_lightbox_information_sortable li" ).click(function(){
		if(jQuery(this).hasClass('control_deactive')){
			jQuery(this).removeClass('control_deactive')
			jQuery(this).addClass('control_active')
		}else{
			jQuery(this).removeClass('control_active')
			jQuery(this).addClass('control_deactive')
		}
	});
	
	
	jQuery(".save_all_section_parametrs").click(function(){
		
		jQuery('.save_all_section_parametrs').addClass('padding_loading');
		jQuery('.save_all_section_parametrs').prop('disabled', true);		
		jQuery('.save_all_section_parametrs .saving_in_progress').css('display','inline-block');
		section_saved_complite(0);	
	})
	function section_saved_complite(section_index){
		if(askofen==0){
			if(section_index>jQuery(".save_section_parametrs").length-1){
				jQuery('.save_all_section_parametrs .saving_in_progress').css('display','none');
				jQuery('.save_all_section_parametrs .sucsses_save').css('display','inline-block');
				setTimeout(function(){jQuery('.save_all_section_parametrs .sucsses_save').hide('fast');jQuery('.save_all_section_parametrs').removeClass('padding_loading');jQuery('.save_all_section_parametrs').prop('disabled', false);},1800);
				return true;
			}
			jQuery(".save_section_parametrs").eq(section_index).trigger('click')
			return  setTimeout(function(){section_saved_complite(section_index+1);},'200');
		}
		else{
			return setTimeout(function(){section_saved_complite(section_index);},'200');
		}
	}
	
	/*############ Other section Save click ################*/
	jQuery(".save_section_parametrs").click(function(){
		set_information_ordering_to_input(jQuery( "#information_panel_ordering" ))			
			
		var wpdevart_lightbox_curent_section=jQuery(this).attr('id');
		jQuery.each( wpdevart_lightbox_all_parametrs[wpdevart_lightbox_curent_section], function( key, value ) {
		   wpdevart_lightbox_all_parametrs[wpdevart_lightbox_curent_section][key] =jQuery('#'+key).val() 
		});		
		var wpdevart_lightbox_date_for_post=wpdevart_lightbox_all_parametrs;
		wpdevart_lightbox_all_parametrs[wpdevart_lightbox_curent_section]['curent_page']=wpdevart_lightbox_curent_section;
		wpdevart_lightbox_all_parametrs[wpdevart_lightbox_curent_section]['wpdevart_lightbox_options_nonce']=jQuery('#wpdevart_lightbox_options_nonce').val();
		
		
		jQuery('#'+wpdevart_lightbox_curent_section).addClass('padding_loading');
		jQuery('#'+wpdevart_lightbox_curent_section).prop('disabled', true);		
		jQuery('#'+wpdevart_lightbox_curent_section+' .saving_in_progress').css('display','inline-block');
		
		askofen++;
		
		jQuery.ajax({
					type:'POST',
					url: wpdevart_lightbox_ajaxurl+'?action=wpdevart_lightbox_page_save',
					data: wpdevart_lightbox_all_parametrs[wpdevart_lightbox_curent_section],
				}).done(function(date) {
					console.log(date)
					jQuery('#'+wpdevart_lightbox_curent_section+' .saving_in_progress').css('display','none');
					if(date==wpdevart_lightbox_parametrs_sucsses_saved){							
						jQuery('#'+wpdevart_lightbox_curent_section+' .sucsses_save').css('display','inline-block');
						setTimeout(function(){wpdevart_lightbox_clickable=1;jQuery('#'+wpdevart_lightbox_curent_section+' .sucsses_save').hide('fast');jQuery('#'+wpdevart_lightbox_curent_section+'.save_section_parametrs').removeClass('padding_loading');jQuery('#'+wpdevart_lightbox_curent_section).prop('disabled', false);},1800);
						askofen--;
					}
					else{
						jQuery('#'+wpdevart_lightbox_curent_section+' .error_in_saving').css('display','inline-block');
						jQuery('#'+wpdevart_lightbox_curent_section).parent().find('.error_massage').eq(0).html(date);
						
					}
		});
	});

});