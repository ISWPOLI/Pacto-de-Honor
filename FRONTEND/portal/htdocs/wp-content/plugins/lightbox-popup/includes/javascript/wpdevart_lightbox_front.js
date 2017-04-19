wpdevart_lightbox={

	/*######################################  Default Dinamic Variables  ##########################################################*/
	defaults:{	
		elem_array:[],	
		current_img_index:null,
		wordpress_admin_bar_height:0,
		
		// overlay parametrs
		remov_overlay_when_clicked:true,
		remov_overlay_esc_button:true,		
		// popup parametrs
		popup_position:5,		
		popup_outside_margin:0,
		popup_border_width:0,
		popup_border_color:"#000000",
		popup_background_color:"#FFFFFF",
		popup_border_radius:"0",
		popup_fixed_position:true,
		popup_initial_width:300, // initial width
		popup_initial_height:300,// initial height
		
		popup_youtube_width:640, // initial width
		popup_youtube_height:408,// initial height
		
		popup_vimeo_width:500, // initial width
		popup_vimeo_height:409,// initial height
		
		popup_max_width:1900,
		popup_max_height:1900,
		popup_min_width:300,
		popup_min_height:300,
		popup_can_run:true,
		popup_inside_element_ordering:'{"0":"control_buttons","1":"content","2":"information_line"}',
		popup_loading_image:'http://api.ning.com/files/*tHd*uipNJDnOZQFSoRrnHkt2t9HWUPt*0bw5zsEme2gxFWTpf4V1SLn9muc5YYHVUzOFawiDFQUQd8h1v216YMI5kXEkD3L/1064534191.gif',
		broken_icon_img_src:'http://www.wickedauctions.com/Images/img_not_found.gif',
		popup_window_demision:[300,300,300],
		
		// control buttons
		control_buttons_show:true,
		control_buttons_show_in_content:false,
		control_buttons_height:35,
		control_buttons_line_bg_color:'#0073aa',			
		enable_picture_download_link:true,
		enable_picture_open_new_widow:true,
		enable_picture_full_width:true,
		enabled_picture_full_width:false,
		enabled_picture_full_screen:false,

		curent_image_width:null,
		curent_image_height:null,
		
		

		
		control_button_next_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		control_button_next_hover_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		control_button_content_next_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		control_button_window_next_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		
		control_button_prev_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_left_48px-128.png',		
		control_button_prev_hover_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_left_48px-128.png',
		control_button_content_prev_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		control_button_window_prev_img_src:'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_keyboard_arrow_right_48px-128.png',
		
		
		control_button_download_img_src:'https://cdn4.iconfinder.com/data/icons/miu/22/circle_arrow-down_download-128.png',
		control_button_download_hover_img_src:'https://cdn4.iconfinder.com/data/icons/miu/22/circle_arrow-down_download-128.png',
		
		control_button_innewwindow_img_src:'http://www.rcq.gouv.qc.ca/images/design/newWindow.png',
		control_button_innewwindow_hover_img_src:'http://www.rcq.gouv.qc.ca/images/design/newWindow.png',
		
		
		control_button_fullwidth_img_src:"http://stories.kera.org/wp-content/themes/jrny/images/expand.png",
		control_button_fullwidht_hover_img_src:"http://stories.kera.org/wp-content/themes/jrny/images/expand.png",
		
		control_button_fullwidthrest_img_src:"https://cdn0.iconfinder.com/data/icons/pixon-1/24/arrows_extend_full_screen_fullscreen_minimize_resize-128.png",
		control_button_fullwidhtrest_hover_img_src:"https://cdn0.iconfinder.com/data/icons/pixon-1/24/arrows_extend_full_screen_fullscreen_minimize_resize-128.png",
		
		control_button_close_img_src:"https://cdn3.iconfinder.com/data/icons/virtual-notebook/16/button_close-128.png",
		control_button_close_hover_img_src:"https://cdn3.iconfinder.com/data/icons/virtual-notebook/16/button_close-128.png",
		control_button_ordering:'{"left":[[1,"prev"],[1,"next"],[1,"play"],[1,"download"],[1,"innewwindow"],[1,"fullwidth"],[1,"fullscreen"]],"right":[[1,"close"]]}',
		
		keyboard_navigation:true,
		autoplay_ids:[],
		
		///  information line
		
		information_panel_show:true,
		information_panel_show_in_content:true,
		information_panel_heght:30,
		information_panel_bg_color:"#00a0d2",
		
		information_panel_text_for_no_title:'No title',
		information_panel_text_for_no_caption:'no Description',
		
		information_panel_count_image_after_text:"image",
		information_panel_count_image_middle_text:"of",
		information_panel_ordering:'{"count":[1,"count"],"title":[1,"title"],"caption":[1,"caption"]}'
		
	},
	/*######################################  Default Constant Variables  ##########################################################*/
	constant_defaults:{
		
		// this ids  conected in css.. if change anithing please change in css to...
		parent_div_foe_mozilla_full:'parent_div_for_mozila',		
		overlay_id:'wpdevart_lb_overlay',
		popup_window_id:'wpdevart_lb_main_window',
		popup_window_desc_content_id:'wpdevart_lb_main_desc',
		popup_window_information_content_id:'wpdevart_lb_information_content',
		popup_window_pic_content_id:'wpdevart_lb_pic_content_id',
		popup_window_first_elem_id:'wpdevart_lb_content_first_pic',
		popup_window_second_elem_id:'wpdevart_lb_content_second_pic',
		popup_window_loading_pic_id:'wpdevart_lb_loading_img',
		popup_window_loading_first_pic_id:'wpdevart_lb_loading_img_first',
		
		// description buttons
		popup_window_description_next_button_id:'wpdevart_desc_next_img',
		popup_window_next_content_button_id:'wpdevart_content_next_img',
		popup_window_next_window_button_id:'wpdevart_window_next_img',
		popup_window_description_prev_button_id:'wpdevart_desc_prev_img',
		popup_window_prev_content_button_id:'wpdevart_content_prev_img',
		popup_window_prev_window_button_id:'wpdevart_window_prev_img',
		popup_window_description_close_button_id:'wpdevart_desc_close_img',
		popup_window_description_enable_full_width_img_id:'wpdevart_desc_enable_full_img',
		popup_window_description_disable_ful_width_img_id:'wpdevart_desc_disable_full_img',
		
		/////////////////// information div elements
		popup_window_information_count_id:'wpdevart_info_counter_of_imgs',
		popup_window_information_title_id:'wpdevart_info_title',
		popup_window_information_aption_id:'wpdevart_info_caption',
		
		////////////////////////////////
		download_icon_id:'wpdevart_download_img',
		open_img_in_new_window_icon_id:'wpdevart_download_img',
		
		popup_window_alternative_window_next_button_id:'wpdevart_alternativ_next',
		popup_window_alternative_window_previous_button_id:'wpdevart_alternativ_previous',
		
			
	},
	
	
	
	/*######################################  CREATE POPUP  ##########################################################*/
	create_popup:function(element_index){
		
		// disable duble open popup
		this.defaults.popup_can_run=false;
		// var requered elements
		var self=this;		
		var popup_window=jQuery('<div>',{id: this.constant_defaults.popup_window_id}); //  popup window 
		var popup_window_parent=jQuery('<div>',{id: this.constant_defaults.parent_div_foe_mozilla_full}); //  popup window 
		
		
		/*			 POSITION 			*/
		if(this.defaults.popup_fixed_position)
			jQuery(popup_window).css('position','fixed');
		else
			jQuery(popup_window).css('position','absolute');
		
		
		/*            BORDER            */
		jQuery(popup_window).css('border-radius',this.defaults.popup_border_radius+'px');
		self.generete_border(popup_window);
				
		
		/*            Control cantrol buttons           */
		var order_popup_inside_elements=JSON.parse(this.defaults.popup_inside_element_ordering);
		var vertical_mode='top';
		var vertical_pixels=0;
		var position_of_elem=[];
		jQuery.each(order_popup_inside_elements,function(key, value) {
			switch(value){
				case 'control_buttons' :
					if(self.defaults.control_buttons_show){
						position_of_elem[0]=vertical_mode;
						position_of_elem[1]=vertical_pixels;
						self.create_description_panel(popup_window,position_of_elem);
						vertical_pixels=self.defaults.control_buttons_height;
				}
				break; 
				case 'content' :
					self.generete_content_popup(popup_window,position_of_elem);
					vertical_mode='bottom';
					if(vertical_pixels){
						vertical_pixels=0;
					}
					else{
						var revers_ordering
						if(self.defaults.information_panel_show_in_content || self.defaults.control_buttons_show_in_content){
							revers_ordering=order_popup_inside_elements[1];
							order_popup_inside_elements[1]=order_popup_inside_elements[2]
							order_popup_inside_elements[2]=revers_ordering;	
						}
					}
					
				break;
				case 'information_line' :
					if(self.defaults.information_panel_show){
						position_of_elem[0]=vertical_mode;
						position_of_elem[1]=vertical_pixels;
						self.create_information_panel(element_index,popup_window,position_of_elem)
						vertical_pixels=self.defaults.control_buttons_height;
					}
				break; 
			}
        });
		
		jQuery(popup_window_parent).prepend(popup_window);
		jQuery('body').prepend(popup_window_parent);
		// transitiony problem uni 
		this.resize_popup()
		this.load_element_in_content(element_index)
		// append element in popup
		
		
	},
	call_function_when_load_complited:function(){
		var self=this;
	},
	generete_border:function(element){
		
		if(this.get_correct_border(jQuery(window).width(),jQuery(window).height(),this.defaults.popup_border_width)){
			jQuery(element).css('border','solid '+this.defaults.popup_border_width+'px '+this.defaults.popup_border_color);			
		}
		else{
			jQuery(element).css('border','none');			
		}
		
	},
	generete_content_popup:function(popup_element){
		
		var popup_window_pic_content=jQuery('<div>',{id: this.constant_defaults.popup_window_pic_content_id}); // popup picture_content main element	
		
		var popup_window_pic_loading=jQuery('<img>',{id: this.constant_defaults.popup_window_loading_pic_id,src:this.defaults.popup_loading_image}); // loading_image
		
		jQuery(popup_window_pic_content).css('background-color',this.defaults.popup_background_color);
		
		jQuery(popup_window_pic_loading).css('display','none');	
		jQuery(popup_window_pic_loading).css('visibility','hidden');
		jQuery(popup_window_pic_loading).css('max-height','10%');
		jQuery(popup_window_pic_loading).css('max-width','10%');
		jQuery(popup_window_pic_content).append(popup_window_pic_loading);
		
		jQuery(popup_window_pic_loading).load(function(){self.set_loading_image_position();jQuery(popup_window_pic_loading).css('visibility','visible')});
		jQuery(popup_element).append(popup_window_pic_content);	
		
	},
	
	create_first_loading_imge:function(){
		var sef=this;
		var first_loading_image= new Image();

		jQuery(first_loading_image).attr('id',this.constant_defaults.popup_window_loading_first_pic_id);
		first_loading_image.src=this.defaults.popup_loading_image;
		

		// append image whn is alredi is loading
		first_loading_image.onload=function(){		
			// if photos is loacal and loading faster than loading image
			if(jQuery('#'+self.constant_defaults.popup_window_first_elem_id).length<1){
				jQuery('body').append(first_loading_image);
				self.first_image_loading_postion(first_loading_image);
			}
			else{
				if(jQuery('#'+self.constant_defaults.popup_window_first_elem_id ).prop('nodeName')=='IFRAME'){
					jQuery('body').append(first_loading_image);
					self.first_image_loading_postion(first_loading_image);
				}	
			}
		}
	},
	first_image_loading_postion:function(loading_image){
		
		var top=parseInt((jQuery(window).height()-jQuery(loading_image).height())/2);
		
		var left=parseInt((jQuery(window).width()-jQuery(loading_image).width())/2);
		jQuery(loading_image).css('position','fixed');
		jQuery(loading_image).css('z-index','99998');
		jQuery(loading_image).css('max-height','15%');
		jQuery(loading_image).css('max-width','auto');
		jQuery(loading_image).css('left',left+'px');
		jQuery(loading_image).css('top',top+'px');
	},
	remove_first_loading_image:function(loading_element){
		if(jQuery('#'+this.constant_defaults.popup_window_loading_first_pic_id).length>0)
			jQuery('#'+this.constant_defaults.popup_window_loading_first_pic_id).remove();
	},	
	
	/*######################################  Craeate control buttons  ##########################################################*/
	/*######################################  Craeate control buttons  ##########################################################*/
	/*######################################  Craeate control buttons  ##########################################################*/
	/*######################################  Craeate control buttons  ##########################################################*/
	create_description_panel:function(parnet_element,position_of_elem){
		
		var popup_window_desc=jQuery('<div>',{id: this.constant_defaults.popup_window_desc_content_id}); // popup description main element
		
		popup_window_desc.css('height',this.defaults.control_buttons_height);
		popup_window_desc.css('width',this.defaults.window_description_initial_width);
		popup_window_desc.css('background-color',this.defaults.control_buttons_line_bg_color);
		if(this.defaults.control_buttons_show_in_content){
			popup_window_desc.css('position','absolute');
			popup_window_desc.css('z-index','9999999');
			popup_window_desc.css(position_of_elem[0],position_of_elem[1]);
			
			//es momenty botom lineluca mi hat kveranaes information liny naeluc
			//popup_window_desc.css('transform','translate(0px,-'+this.defaults.control_buttons_height+'px)');	
			
		}
		
		jQuery(parnet_element).append(popup_window_desc);
		
		this.create_descriptions_buttons(popup_window_desc);
	
	},
	
	
	create_descriptions_buttons:function(element){
		var self=this;
		
		var next_button=jQuery('<img>',{id: this.constant_defaults.popup_window_description_next_button_id,src:this.defaults.control_button_next_img_src}); // next button
		
		var prev_button=jQuery('<img>',{id: this.constant_defaults.popup_window_description_prev_button_id,src:this.defaults.control_button_prev_img_src}); //  previus button
		
		var download_link=jQuery('<img>',{id: this.constant_defaults.download_icon_id,src:this.defaults.control_button_download_img_src}); // pause button
		var new_window_link=jQuery('<img>',{id: this.constant_defaults.open_img_in_new_window_icon_id,src:this.defaults.control_button_innewwindow_img_src}); // pause button
		
		var enable_full_width=jQuery('<img>',{id: this.constant_defaults.popup_window_description_enable_full_width_img_id,src:this.defaults.control_button_fullwidth_img_src}); // enable_full
		var disable_full_width=jQuery('<img>',{id: this.constant_defaults.popup_window_description_disable_ful_width_img_id,src:this.defaults.control_button_fullwidthrest_img_src}); // disable full
		
		var enable_full_screen=jQuery('<img>',{id: this.constant_defaults.popup_window_description_enable_full_screen_img_id,src:this.defaults.control_button_fullscreen_img_src}); // enable_full
		var disable_full_screen=jQuery('<img>',{id: this.constant_defaults.popup_window_description_disable_full_screen_img_id,src:this.defaults.control_button_fullscreenrest_img_src}); // disable full
		
		var close_button=jQuery('<img>',{id: this.constant_defaults.popup_window_description_close_button_id,src:this.defaults.control_button_close_img_src}); // pause button
		
		jQuery(disable_full_width).css('display','none');
		jQuery(close_button).css('float','right');
		jQuery(next_button).click(function(){
			self.change_to_next_picture();
		})
		jQuery(next_button).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_next_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_next_img_src);
			}		
		)
		jQuery(prev_button).click(function(){
			self.change_to_previus_picture();
		})
		jQuery(prev_button).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_prev_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_prev_img_src);
			}		
		)
		
		jQuery(download_link).click(function(){
			self.download_img();
		})
		jQuery(download_link).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_download_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_download_img_src);
			}		
		)
		
		
		jQuery(new_window_link).click(function(){
			self.open_in_new_window_img();
		})
		jQuery(new_window_link).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_innewwindow_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_innewwindow_img_src);
			}		
		)
		jQuery(enable_full_width).click(function(){
			self.enable_popup_full_width();
		})
		jQuery(enable_full_width).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullwidht_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullwidth_img_src);
			}		
		)
		jQuery(disable_full_width).click(function(){
			self.disable_popup_full_width();
		})
		jQuery(disable_full_width).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullwidhtrest_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullwidthrest_img_src);
			}		
		)
		
		jQuery(enable_full_screen).click(function(){
			self.check_and_set_full_screen(true);
		})
		jQuery(enable_full_screen).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullscreen_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullscreen_img_src);
			}		
		)
		jQuery(disable_full_screen).click(function(){
			self.check_and_set_full_screen(false);
		})
		jQuery(disable_full_screen).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullscreenrest_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_fullscreenrest_img_src);
			}		
		)
		jQuery(close_button).click(function(){
			self.remove_overlay();
		})
		jQuery(close_button).hover(
			function(){
				jQuery(this).attr('src',self.defaults.control_button_close_hover_img_src);
			},
			function(){
				jQuery(this).attr('src',self.defaults.control_button_close_img_src);
			}		
		)
		ordering_object=JSON.parse(this.defaults.control_button_ordering);
		jQuery.each(ordering_object,function(key,value){
			var ordering=key;
			jQuery.each(value,function(key,value){
				if(value[0])
					switch(value[1]){
						case 'prev':
							jQuery(element).append(prev_button)
							if(ordering=='left')
								jQuery(prev_button).css('float',ordering)						
						break
						case 'next':
							jQuery(element).append(next_button)
							if(ordering=='left')
								jQuery(next_button).css('float',ordering)
						break

						case 'download':
							jQuery(element).append(download_link)
							if(ordering=='left')
								jQuery(download_link).css('float',ordering)
						break
						case 'innewwindow':
							jQuery(element).append(new_window_link)
							if(ordering=='left')
								jQuery(new_window_link).css('float',ordering)
						break
						case 'fullwidth':
							jQuery(element).append(enable_full_width)
							jQuery(element).append(disable_full_width)
							if(ordering=='left'){
								jQuery(enable_full_width).css('float',ordering)
								jQuery(disable_full_width).css('float',ordering)
							}
						break
						case 'close':
							jQuery(element).append(close_button)
							if(ordering=='left')
								jQuery(close_button).css('float',ordering)
						break	
					}
			})
		})		
	},

	/// functionality for buttons
	change_to_next_picture:function(){
		var self=this;
		if(jQuery('#'+self.constant_defaults.popup_window_second_elem_id).length){
			return	
		}
		next_pic_index=parseInt((this.defaults.current_img_index+1)%this.defaults.elem_array.length);
		this.load_element_in_content(next_pic_index)
	},
	change_to_previus_picture:function(){
		var self=this;
		if(jQuery('#'+self.constant_defaults.popup_window_second_elem_id).length){
			return	
		}
		prev_pic_index=(this.defaults.current_img_index-1);
		if(prev_pic_index<0)
			prev_pic_index=this.defaults.elem_array.length-1;
		this.load_element_in_content(prev_pic_index)
	},
	download_img:function(){
		 donwloaded_hiperlink = jQuery("<a>").attr("href", jQuery(this.defaults.elem_array[this.defaults.current_img_index][0]).attr('href')).attr("download", ".img").appendTo("body");
		 donwloaded_hiperlink[0].click();
		 donwloaded_hiperlink.remove();
	},
	open_in_new_window_img:function(){
		 donwloaded_hiperlink = jQuery("<a>").attr("href", jQuery(this.defaults.elem_array[this.defaults.current_img_index][0]).attr('href')).attr("target", "_blank").appendTo("body");
		 donwloaded_hiperlink[0].click();
		 donwloaded_hiperlink.remove();
	},
	enable_popup_full_width:function(){
		jQuery('#'+this.constant_defaults.popup_window_description_disable_ful_width_img_id).css('display','inline-block');
		jQuery('#'+this.constant_defaults.popup_window_description_enable_full_width_img_id).css('display','none');
		this.defaults.enabled_picture_full_width=true;
		this.resize_popup();
	},
	disable_popup_full_width:function(){
		jQuery('#'+this.constant_defaults.popup_window_description_enable_full_width_img_id).css('display','inline-block');
		jQuery('#'+this.constant_defaults.popup_window_description_disable_ful_width_img_id).css('display','none');
		this.defaults.enabled_picture_full_width=false;		
		this.resize_popup();

	},
	check_and_set_full_screen:function(enabled){
		if(enabled == true){
			this.defaults.enabled_picture_full_screen=true;
			if(!this.defaults.enabled_picture_full_width);
				this.enable_popup_full_width()
			this.defaults.wordpress_admin_bar_height=0;
			jQuery('#'+this.constant_defaults.popup_window_description_disable_full_screen_img_id).css('display','inline-block');
			jQuery('#'+this.constant_defaults.popup_window_description_enable_full_screen_img_id).css('display','none');
			this.fullscreen(true);
		}
		if(enabled == false){
			this.defaults.enabled_picture_full_screen=false;
			if(this.defaults.enabled_picture_full_width);
				this.disable_popup_full_width()
			this.defaults.wordpress_admin_bar_height=jQuery('#wpadminbar').height();
			
			jQuery('#'+this.constant_defaults.popup_window_description_disable_full_screen_img_id).css('display','none');
			jQuery('#'+this.constant_defaults.popup_window_description_enable_full_screen_img_id).css('display','inline-block');
			this.fullscreen(false);
		}
		if(enabled == 'undefined'){
			var fullScreen_mode =  document.fullscreenEnabled || document.mozFullScreen || document.webkitIsFullScreen ? true : false;
			if(fullScreen_mode){
				if(!this.defaults.enabled_picture_full_width);
					this.enable_popup_full_width()
				this.defaults.wordpress_admin_bar_height=0;
				this.defaults.enabled_picture_full_screen=true;
				jQuery('#'+this.constant_defaults.popup_window_description_disable_full_screen_img_id).css('display','inline-block');
				jQuery('#'+this.constant_defaults.popup_window_description_enable_full_screen_img_id).css('display','none');
			}else{
				if(this.defaults.enabled_picture_full_width);
					this.disable_popup_full_width()
				this.defaults.wordpress_admin_bar_height=jQuery('#wpadminbar').height();
				jQuery('#'+this.constant_defaults.popup_window_description_disable_full_screen_img_id).css('display','none');
				jQuery('#'+this.constant_defaults.popup_window_description_enable_full_screen_img_id).css('display','inline-block');
				this.defaults.enabled_picture_full_screen=false;
				
			}
		}
		this.resize_popup();
	},
	
	fullscreen:function(full){
		var element=document.getElementById(this.constant_defaults.parent_div_foe_mozilla_full)
		if(full){
			if(element.requestFullScreen) {
				element.requestFullScreen();
			} else if(element.mozRequestFullScreen) {
				element.mozRequestFullScreen();
			} else if(element.webkitRequestFullScreen) {
				element.webkitRequestFullScreen();
			}else if(element.msRequestFullscreen) {
				element.msRequestFullscreen();
			}
		}else{
			if(document.cancelFullScreen) {
				document.cancelFullScreen();
			} else if(document.mozCancelFullScreen) {
				document.mozCancelFullScreen();
			} else if(document.webkitCancelFullScreen) {
				document.webkitCancelFullScreen();
			}else if(document.msExitFullscreen) {
				document.msExitFullscreen();
			}
		}
		
		
	},
	keyboard_navigation:function(is_enable){
		var self=this;
		if(is_enable){
			jQuery(document).keyup(function(e) {
				if(e.keyCode ==37)
					self.change_to_previus_picture()
				if(e.keyCode ==39)
					self.change_to_next_picture()
				
			})
		
		}
	},
	
	
	/*######################################  Create Information Panel  ##########################################################*/
	/*######################################  Create Information Panel  ##########################################################*/
	/*######################################  Create Information Panel  ##########################################################*/
	/*######################################  Create Information Panel  ##########################################################*/
	
	create_information_panel:function(element_index,popup_element,position_of_elem){
		if(!this.defaults.information_panel_show) 
			return; //when disabled information panel
		var self=this;
		var information_main=jQuery('<div>',{id: self.constant_defaults.popup_window_information_content_id});
		var count_images=jQuery('<span>',{id: this.constant_defaults.popup_window_information_count_id}); 
		var title_image=jQuery('<span>',{id: this.constant_defaults.popup_window_information_title_id});		
		var caption_image=jQuery('<span>',{id: this.constant_defaults.popup_window_information_aption_id}); 
		if(this.defaults.information_panel_show_in_content){
			information_main.css('position','absolute');
			information_main.css('z-index','9999999');	
			information_main.css(position_of_elem[0],position_of_elem[1]);	
		}
		
		//information_main.css('height',this.defaults.information_panel_heght)
		information_main.css('background-color',this.defaults.information_panel_bg_color)
		
		var text_of_count_images=this.defaults.information_panel_count_image_after_text + ' ' + (element_index+1) + ' ' + this.defaults.information_panel_count_image_middle_text + ' ' + self.defaults.elem_array.length;
		var text_of_title_image=self.defaults.elem_array[element_index][1]
		var text_of_caption_image=self.defaults.elem_array[element_index][2]
		
		if(text_of_caption_image==null){
			text_of_caption_image=self.defaults.information_panel_text_for_no_caption;
		}
		if(text_of_title_image==null){
			text_of_title_image=self.defaults.information_panel_text_for_no_title;
		}
		
		if(self.defaults.elem_array[element_index][1]==null && this.defaults.information_panel_desc_show_if_not==false){
			jQuery(title_image).hide();
		}
		if(self.defaults.elem_array[element_index][2]==null && this.defaults.information_panel_title_show_if_not==false){
			jQuery(title_image).hide();
		}
		ordering_object=JSON.parse(this.defaults.information_panel_ordering);
			jQuery.each(ordering_object,function(key,value){
				if(value[0])
					switch(value[1]){
						case 'count':
							jQuery(count_images).html(text_of_count_images);
							jQuery(information_main).append(count_images);			
						break
						case 'title':
							jQuery(title_image).html(text_of_title_image);
							jQuery(information_main).append(title_image);
						break
						case 'caption':
							jQuery(caption_image).html(text_of_caption_image);
							jQuery(information_main).append(caption_image);		
						break
					}
		})	
		
		
		jQuery(popup_element).append(information_main);
		
		
	},
	change_information_panel_informations:function(element_index){
		
		var text_of_count_images=this.defaults.information_panel_count_image_after_text + ' ' + (element_index+1) + ' ' + this.defaults.information_panel_count_image_middle_text + ' ' + self.defaults.elem_array.length;
		var text_of_title_image=self.defaults.elem_array[element_index][1]
		var text_of_caption_image=self.defaults.elem_array[element_index][2]
		if(text_of_caption_image==null){
			text_of_caption_image=self.defaults.information_panel_text_for_no_caption;
		}
		if(text_of_title_image==null){
			text_of_title_image=self.defaults.information_panel_text_for_no_title;
		}
		if(jQuery('#'+this.constant_defaults.popup_window_information_count_id).length>0){
			jQuery('#'+this.constant_defaults.popup_window_information_count_id).html(text_of_count_images)
		}
		if(jQuery('#'+this.constant_defaults.popup_window_information_title_id).length>0){
			if(this.defaults.information_panel_desc_show_if_not==false){
				if(text_of_title_image==null){
					jQuery('#'+this.constant_defaults.popup_window_information_title_id).hide();
				}
				else{
					jQuery('#'+this.constant_defaults.popup_window_information_title_id).html(text_of_title_image)
					jQuery('#'+this.constant_defaults.popup_window_information_title_id).show();					
				}				
			}
			else{
				jQuery('#'+this.constant_defaults.popup_window_information_title_id).html(text_of_title_image)
			}
		}
		if(jQuery('#'+this.constant_defaults.popup_window_information_aption_id).length>0){
			if(this.defaults.information_panel_desc_show_if_not==false){
				if(text_of_caption_image==null){
					jQuery('#'+this.constant_defaults.popup_window_information_aption_id).hide();
				}
				else{
					jQuery('#'+this.constant_defaults.popup_window_information_aption_id).html(text_of_caption_image)
					jQuery('#'+this.constant_defaults.popup_window_information_aption_id).show();					
				}				
			}
			else{
				jQuery('#'+this.constant_defaults.popup_window_information_aption_id).html(text_of_caption_image)
			}
					
		}
	
	},
	/*######################################  REMOVE POPUP  ##########################################################*/
	remove_popup:function(){
		self=this;		
		jQuery('#'+self.constant_defaults.popup_window_id).remove();self.defaults.popup_can_run=true;		
		self.set_initial_parametrs();
		
	},
	set_initial_parametrs:function(){
		this.defaults.current_img_index=null;
		
	
	},
	/*######################################  LOADING IMAGE INTO CONTENT BY INDEX ##########################################################*/
	load_element_in_content:function(element_index,popup_window){
		self=this;
		if(this.defaults.elem_array[element_index][3]=='iframe'){
			return this.load_iframe_in_content(element_index,popup_window);
		}
		else{
			// worked_cantrol buttons
			this.set_display_control_button(this.constant_defaults.download_icon_id,true);
		}
		// when first image loading
		var is_frst_image=true;
		if(this.defaults.current_img_index!= null)
			is_frst_image=false;
		// set curent image index
		this.defaults.current_img_index=element_index;
		// firs or last image item
		var img_id=this.constant_defaults.popup_window_second_elem_id
		if(is_frst_image)
			var img_id=this.constant_defaults.popup_window_first_elem_id	
					
		// loading image
		jQuery('#'+self.constant_defaults.popup_window_loading_pic_id).css('display','inline-block');	
		jQuery('<img>', {
			src: jQuery(this.defaults.elem_array[element_index][0]).attr('href'),
			id:  img_id,
			load:function(){
				self.change_information_panel_informations(self.defaults.current_img_index)
				// hide loading image		
				jQuery('#'+self.constant_defaults.popup_window_loading_pic_id).css('display','none');
				// open for loading
				
				
				
				self.defaults.curent_img_width=this.width;
				self.defaults.curent_img_height=this.height;
				jQuery('#'+self.constant_defaults.popup_window_pic_content_id).prepend(this);
				if(!is_frst_image){
					jQuery('#'+self.constant_defaults.popup_window_first_elem_id).remove();
					jQuery('#'+self.constant_defaults.popup_window_second_elem_id).attr('id',self.constant_defaults.popup_window_first_elem_id);
				}
				self.resize_popup_by_image(self.defaults.curent_img_width,self.defaults.curent_img_height)// dont use this.width and this.height becouse prepended ement width other			
				self.call_function_when_load_complited();
			},
			//error:function() {
			//	var broken_img= new Image();
		//		jQuery(img).attr('id',self.constant_defaults.popup_window_first_elem_id)
		//		broken_img.src=self.defaults.broken_icon_img_src;
		//		broken_img.onload=function(){
		//		jQuery('#'+self.constant_defaults.popup_window_loading_pic_id).css('display','none')
				
		//			self.defaults.curent_img_width=this.width;
		//			self.defaults.curent_img_height=this.height;				
		//			jQuery('#'+self.constant_defaults.popup_window_pic_content_id).prepend(this);	
		//			self.resize_popup_by_image(self.defaults.curent_img_width,self.defaults.curent_img_height)// dont use this.width and this.height becouse prepended ement width other
		//		}	
		//		self.call_function_when_load_complited();
		//  	}
			
		}); 		
	},
	/*######################################  LOADING IFRAME INTO CONTENT BY INDEX ##########################################################*/
	load_iframe_in_content:function(element_index,popup_window){
		
		self=this;
		
		// for functionality content
		var is_first_element=true;
		if(this.defaults.current_img_index!= null)
			is_first_element=false;		
		this.defaults.current_img_index=element_index;
		
		// worked_cantrol buttons
		this.set_display_control_button(this.constant_defaults.download_icon_id,false);
		
		var iframe= document.createElement("IFRAME");;
		var iframe_id
		if(is_first_element)
			iframe_id=this.constant_defaults.popup_window_first_elem_id
		else
			iframe_id=this.constant_defaults.popup_window_second_elem_id;
		if(!this.get_curent_ordering_element_enabled('fullscreen') && this.defaults.control_buttons_show)
			jQuery(iframe).attr('allowfullscreen','true');
		iframe_src=this.get_video_type_and_url(jQuery(this.defaults.elem_array[element_index][0]).attr('href'))
		if(iframe_src==null){
			this.remove_popup();
			return;
		}
		if(iframe_src[0]=='youtube'){
			self.defaults.curent_img_width=this.defaults.popup_youtube_width;
			self.defaults.curent_img_height=this.defaults.popup_youtube_height;	
		}
		if(iframe_src[0]=='vimeo'){
			self.defaults.curent_img_width=this.defaults.popup_vimeo_width;
			self.defaults.curent_img_height=this.defaults.popup_vimeo_height;	
		}
		iframe_src=iframe_src[1];
		// show loading image
		jQuery('#'+self.constant_defaults.popup_window_loading_pic_id).css('display','inline-block');
		jQuery('<iframe>', {
		   src: iframe_src,
		   id:  iframe_id,
		   load:function(){
			self.change_information_panel_informations(self.defaults.current_img_index)
			   //  hide loading image
			jQuery('#'+self.constant_defaults.popup_window_loading_pic_id).css('display','none');
			if(!is_first_element){
				jQuery('#'+self.constant_defaults.popup_window_first_elem_id).remove();
				jQuery('#'+self.constant_defaults.popup_window_second_elem_id).attr('id',self.constant_defaults.popup_window_first_elem_id);
			}			
			self.resize_popup_by_image(self.defaults.curent_img_width,self.defaults.curent_img_height)// dont use this.width and this.height becouse prepended ement width other	
			self.call_function_when_load_complited();
		
			},
		   }).prependTo('#'+self.constant_defaults.popup_window_pic_content_id);
	},
	
	/*######################################  RESIZE POPUP BY IMAGE  ##########################################################*/
	resize_popup_by_image:function(img_width,img_height){
		
		// outside margin when sizes is small
		var local_outside_margin=this.defaults.popup_outside_margin;
		if(this.defaults.popup_position==5)	
			local_outside_margin=0;
		local_outside_margin=this.get_correct_margin(jQuery(window).width(),(jQuery(window).height()),this.defaults.popup_outside_margin);
		// description panel when it disabled or in content
		loc_description_panel_height=this.get_correct_description_height();
		// outside border when sizes is smoll
		var loc_outside_border=this.get_correct_border(jQuery(window).width(),jQuery(window).height(),this.defaults.popup_border_width);
		
		var window_information_line_height=this.get_correct_information_height();
		var oteher_elements_height=loc_outside_border*2 + loc_description_panel_height + this.defaults.wordpress_admin_bar_height + local_outside_margin*2;
		// en erkarutiuna vori mej nkary piti mna
		var window_width=jQuery(window).width()-loc_outside_border*2-local_outside_margin*2;
		
		// noric nkari erkarutiunna vercum
		var window_height=jQuery(window).height()-loc_outside_border*2-loc_description_panel_height-this.defaults.wordpress_admin_bar_height-local_outside_margin*2-window_information_line_height;
		
		
		// for max width and heght
		window_width=Math.min(window_width,this.defaults.popup_max_width);
		window_height=Math.min(window_height,(this.defaults.popup_max_width-loc_outside_border*2-loc_description_panel_height-this.defaults.wordpress_admin_bar_height-window_information_line_height-local_outside_margin*2));

		// for full width not for full screen
		if(this.defaults.enabled_picture_full_width){
			curent_image_height=window_height;
			curent_image_width=curent_image_height*(img_width/img_height);
			curent_image_width=Math.min(window_width,curent_image_width);
			curent_image_height=curent_image_width*(img_height/img_width);
		}
		else{
			curent_image_width=Math.min(window_width,img_width);
			curent_image_height=curent_image_width*(img_height/img_width);
			curent_image_height=Math.min(window_height,curent_image_height);
			curent_image_width=curent_image_height*(img_width/img_height);
		}
		// get popup and image demisions for using other functiuons
		this.defaults.popup_window_demision[0]=parseInt(curent_image_width);
	
		this.defaults.popup_window_demision[1]=parseInt(curent_image_height)+loc_description_panel_height+window_information_line_height;
		this.defaults.popup_window_demision[2]=parseInt(curent_image_height);
		
		jQuery('#'+this.constant_defaults.popup_window_id).width(this.defaults.popup_window_demision[0]);
		jQuery('#'+this.constant_defaults.popup_window_id).height(this.defaults.popup_window_demision[1]);
		jQuery('#'+this.constant_defaults.popup_window_pic_content_id).height(curent_image_height);
		this.generete_border(jQuery('#'+this.constant_defaults.popup_window_id));
		this.set_popup_position();
		
		
	},
	
	/*######################################  RESIZE POPUP  ##########################################################*/
	resize_popup:function(){
		if(this.defaults.curent_img_width && this.defaults.curent_img_height)
			this.resize_popup_by_image(this.defaults.curent_img_width,this.defaults.curent_img_height)
		else
			this.resize_popup_by_image(this.defaults.popup_initial_width,this.defaults.popup_initial_height)		
	},
	

	/*####################################   LOADING IMAGE POSITION     ###################################################*/
	
	set_loading_image_position:function(){
		var content_width= this.defaults.popup_window_demision[0];// get content width
		var content_height= this.defaults.popup_window_demision[2]; // get content height
		jQuery('#'+this.constant_defaults.popup_window_loading_pic_id).css('left',( content_width-jQuery('#'+this.constant_defaults.popup_window_loading_pic_id).width())/2+'px');
		jQuery('#'+this.constant_defaults.popup_window_loading_pic_id).css('top',( content_height-jQuery('#'+this.constant_defaults.popup_window_loading_pic_id).height())/2+'px');
	},
	
	
	/*####################################   SET POPUP POSITION     ###################################################*/
	set_popup_position:function(){
			
			var window_width=jQuery(window).width();
			var window_height=jQuery(window).height();			
			var window_information_line_height=jQuery('#'+this.constant_defaults.popup_window_information_content_id).height();
			
			// when outside margin is bigger or border
			var loc_outside_margin=this.get_correct_margin(window_width,window_height,this.defaults.popup_outside_margin);
			var loc_outside_border=this.get_correct_border(window_width,window_height,this.defaults.popup_border_width);
			
			var scroll_to_top=0;
			if(!this.defaults.popup_fixed_position)
				scroll_to_top=this.get_top_scroled_pixel();
		

			switch (this.defaults.popup_position) {
				case 1:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(loc_outside_border+loc_outside_margin)+'px');
                    jQuery('#'+this.constant_defaults.popup_window_id).css('top',(this.defaults.wordpress_admin_bar_height+loc_outside_margin)+scroll_to_top+'px');
				break;
				case 2:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(this.defaults.popup_window_demision[0]+loc_outside_border*2) )/2+'px');
                    jQuery('#'+this.constant_defaults.popup_window_id).css('top',(loc_outside_margin+this.defaults.wordpress_admin_bar_height)+scroll_to_top+'px');
				break;
				case 3:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(loc_outside_margin+this.defaults.popup_window_demision[0]+loc_outside_border*2))+'px');
                    jQuery('#'+this.constant_defaults.popup_window_id).css('top',(loc_outside_margin+this.defaults.wordpress_admin_bar_height)+scroll_to_top+'px');
				break;
				case 4:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(loc_outside_border+loc_outside_margin)+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-this.defaults.wordpress_admin_bar_height-loc_outside_border*2-this.defaults.popup_window_demision[1])/2+this.defaults.wordpress_admin_bar_height+scroll_to_top+'px');
				break;
				case 5:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(this.defaults.popup_window_demision[0]+loc_outside_border*2) )/2+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-this.defaults.wordpress_admin_bar_height-loc_outside_border*2-this.defaults.popup_window_demision[1])/2+this.defaults.wordpress_admin_bar_height+scroll_to_top+'px');
				break;
				case 6:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(loc_outside_border*2+loc_outside_margin+this.defaults.popup_window_demision[0]))+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-this.defaults.wordpress_admin_bar_height-loc_outside_border*2-this.defaults.popup_window_demision[1])/2+this.defaults.wordpress_admin_bar_height+scroll_to_top+'px');
				break;
				case 7:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',loc_outside_margin+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-loc_outside_border*2-loc_outside_margin-this.defaults.popup_window_demision[1])+scroll_to_top+'px');
				break;
				case 8:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(this.defaults.popup_window_demision[0]+loc_outside_border*2) )/2+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-loc_outside_border*2-loc_outside_margin-this.defaults.popup_window_demision[1])+scroll_to_top+'px');
				break;
				case 9:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(loc_outside_border*2+loc_outside_margin+this.defaults.popup_window_demision[0]))+'px');
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-loc_outside_border*2-loc_outside_margin-this.defaults.popup_window_demision[1])+scroll_to_top+'px');
				break;
				default:
					jQuery('#'+this.constant_defaults.popup_window_id).css('left',(window_width-(loc_outside_border+this.defaults.popup_window_demision[0]))/2+'px');		
					jQuery('#'+this.constant_defaults.popup_window_id).css('top',(window_height-this.defaults.wordpress_admin_bar_height-loc_outside_border*2-this.defaults.popup_window_demision[1])/2+this.defaults.wordpress_admin_bar_height+scroll_to_top+'px');
				break;
			}
			this.set_loading_image_position();	
	},
	
	
	
	
	
	
	
	
	/*####################################   CREATE OVERLAY     ###################################################*/
	create_overlay:function(){
		var wpdevart_self=this;
		var element_overlay=jQuery('<div>',{id: this.constant_defaults.overlay_id}); //
			
		
		// if element overay // add opaciti animation
		
		jQuery(element_overlay).addClass('wpdevart_opacity');		
		jQuery('body').prepend(element_overlay);
		
		
		// remove overlay when clicked
		if(wpdevart_self.defaults.remov_overlay_when_clicked){
			jQuery(element_overlay).click(function(e){ if(e.target!=document.getElementById(wpdevart_self.constant_defaults.overlay_id)) return; wpdevart_self.remove_overlay()})
		}
		// remove overlay when pressed esc button
		if(wpdevart_self.defaults.remov_overlay_esc_button){
			jQuery(document).keyup(function(e) {
					if(e.keyCode ==27)
						wpdevart_self.remove_overlay()
			})
		}		
	},
	

	/*####################################   REMOVEW OVERLAY     ###################################################*/
	remove_overlay:function(){
		var wpdevart_self=this; //crate self for using in inside section
		if(!jQuery('#'+this.constant_defaults.overlay_id).hasClass('wpdevart_opacity'))
			return;
			
		jQuery('#'+this.constant_defaults.overlay_id).removeClass('wpdevart_opacity'); //remove opacity class 		
		jQuery('#'+wpdevart_self.constant_defaults.overlay_id).remove();
		this.remove_popup();
	},
	
	// conect array ru outside value
	conect_outside_variable:function(defaults,seted){
		self=this;
		jQuery.each(defaults,function(index, element) {
            if(typeof(seted[index])!='undefined'){
				if(seted[index]=='true')
					seted[index]=true;
				if(seted[index]=='false')
					seted[index]=false;				
				if(typeof(seted[index])=='string' && self.isnumeric(seted[index]))
					seted[index]=parseInt(seted[index]);
				defaults[index]=seted[index];
			}
        });
		return defaults;
		
	},
	
	/*####################################   Library Functions    ###################################################*/
	isnumeric:function(x) {
		var anum=/(^\d+$)|(^\d+\.\d+$)/	
		if (anum.test(x)) {
			return true;
		}
		return false;
	},
	get_correct_margin:function(window_width,window_height,demision){
		if( ( window_width-demision*2 ) < 320 || ( window_height-demision*2 ) < 320 ||  this.defaults.popup_position==5)
			demision=0;
		return demision;
	},
	get_correct_description_height:function(){
		if(this.defaults.control_buttons_show && !this.defaults.control_buttons_show_in_content)
			return this.defaults.control_buttons_height;
		return 0;
	},
	get_correct_information_height:function(){
		if(this.defaults.information_panel_show && !this.defaults.information_panel_show_in_content)
			return jQuery('#'+this.constant_defaults.popup_window_information_content_id).height()?jQuery('#'+this.constant_defaults.popup_window_information_content_id).height():0;
		return 0;
	},
	get_correct_border:function(window_width,window_height,border){
		if( ( window_width-border*2*5 ) < 320 || ( window_height-border*2*5 ) < 320 )
			border=0;
		return border;
	},
	get_top_scroled_pixel:function(){
		if(this.defaults.enabled_picture_full_screen)
			return 0;
		var doc = document.documentElement;
		var top = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0);
		return top;		
	},
	set_display_control_button:function(control_button_id,show_hide){
		if(jQuery('#'+control_button_id).length>0){
			if(show_hide){
				jQuery('#'+control_button_id).css('display','inline-block');
				return;
			}
			jQuery('#'+control_button_id).css('display','none');
		}
		
	},
	get_video_type_and_url:function(iframe_link){
		var type='none';
		iframe_src=iframe_link.match(/(?:https?:\/{2})?(?:w{3}\.)?youtu(?:be)?\.(?:com|be)(?:\/watch\?v=|\/)([^\s&]+)/);
		if(iframe_src!=null){
			type='youtube'
			iframe_src='https://www.youtube.com/embed/'+iframe_src[1];
		}else{
			iframe_src=iframe_link.match(/(?:https?:\/{2})?(?:w{3}\.)?vimeo.com(?:.*)/);			
			if(iframe_src!=null){
				type='vimeo';
				var vimeoid = iframe_link.substring(iframe_link.lastIndexOf("/") + 1, iframe_link.length);
				iframe_src='http://player.vimeo.com/video/'+vimeoid;
			}
			else{
				return null;	
			}
		}
		return [type,iframe_src];
	},
	hexToRgbA:function(hex,opasity){
		 var h = "0123456789abcdef";
		 var r = h.indexOf(hex[1])*16+h.indexOf(hex[2]);
		 var g = h.indexOf(hex[3])*16+h.indexOf(hex[4]);
		 var b = h.indexOf(hex[5])*16+h.indexOf(hex[6]);
		 return "rgba("+r+", "+g+", "+b+", "+opasity+")";
		
	},
	get_curent_ordering_element_enabled:function(element){
		ordering_object=JSON.parse(this.defaults.control_button_ordering);
		isset_element=0;
		jQuery.each(ordering_object,function(key,value){
			var ordering=key;
			jQuery.each(value,function(keyy,valuee){
				if(element==valuee[1])
					return isset_element=valuee[0];
			})	
		})	
		return isset_element;	
	},
	/*####################################   MAIN CONSTRUCT FUNCTION     ###################################################*/
	start:function(){
		
		var self=this;
		// get and merge variable by our customer paramntrs
		this.defaults=this.conect_outside_variable(this.defaults,wpdevart_lb_variables);
		// corect some parametrs
		jQuery(document).on("webkitfullscreenchange mozfullscreenchange fullscreenchange",function(){
				setTimeout(function(){self.check_and_set_full_screen('undefined')},500)
		});
		jQuery(window).resize(function(){			
			self.resize_popup();
			self.set_popup_position();
		})
		
		if(jQuery('#wpadminbar').length>0){
			this.defaults.wordpress_admin_bar_height=jQuery('#wpadminbar').height();
		}		
		jQuery('a[rel~="wpdevart_lightbox"],a[rel~="wpdevart_lightbox_video"]').each(function(index, element) {
			var title=null;
			var caption=null;
			var type=(jQuery(element).attr('rel').indexOf('wpdevart_lightbox_video')!=-1)?'iframe':'img';
			
			if(typeof(jQuery(element).find( "img" ).attr('alt'))!='undefined' && jQuery(element).find( "img" ).attr('alt')!=''){
				title=jQuery(element).find( "img" ).attr('alt');
			}
			if(jQuery(element).parent().prop('tagName')=='FIGURE' && jQuery(element).parent().hasClass('wp-caption')){
				if(typeof(jQuery(element).parent().find('figcaption'))!='undefined' && jQuery(element).parent().find('figcaption').html()!=''){
					caption= jQuery(element).parent().find('figcaption').html()
				}
			}
            self.defaults.elem_array.push(new Array(element, title,caption,type));
        });
		jQuery('a[rel^="wpdevart_lightbox"]').click(function(){
			if(self.defaults.popup_can_run){	
				self.create_overlay();		
				self.create_popup(jQuery('a[rel^="wpdevart_lightbox"]').index(this));	
			}
				
			return false;
		});
		this.keyboard_navigation(self.defaults.keyboard_navigation)
	}
	
}




jQuery(document).ready(function(e) {
	wpdevart_lightbox.start();
});