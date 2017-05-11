<?php 

/// Var class
// Variables and default values

class wpdevart_lightbox_database_params{
	
	public $installed_options; // All standard options for Lightbox Popup

	/*################################## Construct function #########################################*/
		
	function __construct(){
		
		$this->installed_options=array(
			
			"main_settings"=>array(
				"eneble_lightbox_content"			=> "enable",
			),
			"overlay_parametrs"=>array(
				"overlay_transparency_prancent"				=> "80",
			),
			"popup_parametrs"=>array(
				"popup_background_color"					=>'#ffffff',
				"popup_loading_image"						=> wpdevart_lightbox_plugin_url."images/popup_loading.png",
				"popup_initial_width"						=> "300",
				"popup_initial_height"						=> "300",
				
				"popup_youtube_width"						=> "640",
				"popup_youtube_height"						=> "410",
				
				"popup_vimeo_width"							=> "500",
				"popup_vimeo_height"						=> "410",
				
				"popup_max_width"							=>'5000',
				"popup_max_height"							=>'5000',
				
				"popup_position"							=>'5',
				"popup_fixed_position"						=>'true',
				"popup_outside_margin"						=>'0',
				
				"popup_border_width"						=>'2',
				"popup_border_color"						=>'#000000',
				"popup_border_radius"						=>'10',				

				
			),
			'control_buttons'=>array(
				"control_buttons_show"						=> "true",
				"control_buttons_show_in_content"			=> "true",
				
				"control_buttons_height"					=> "40",
				"control_buttons_line_bg_color"				=> "#000000",
				"control_button_prev_img_src"				=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/prev.png",
				"control_button_prev_hover_img_src"			=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/prev_hover.png",
				"control_button_next_img_src"				=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/next.png",
				"control_button_next_hover_img_src"			=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/next_hover.png",
				"control_button_download_img_src"			=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/download.png",
				"control_button_download_hover_img_src"		=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/download_hover.png",
				"control_button_innewwindow_img_src"		=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/innewwindow.png",
				"control_button_innewwindow_hover_img_src"	=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/innewwindow_hover.png",
				
				"control_button_fullwidth_img_src"			=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/fullwidth.png",
				"control_button_fullwidht_hover_img_src"	=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/fullwidth_hover.png",
				"control_button_fullwidthrest_img_src"		=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/fullwidthreset.png",
				"control_button_fullwidhtrest_hover_img_src"=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/fullwidthreset_hover.png",
				
				
				"control_button_close_img_src"				=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/close.png",
				"control_button_close_hover_img_src"		=>  wpdevart_lightbox_plugin_url."images/contorl_buttons/close_hover.png",
				
	
				
			),
			"information_panel"=>array(
				"information_panel_show"					=> "true",
				"information_panel_show_in_content"			=> "true",
				"information_panel_bg_color"				=> "#000000",
				"information_panel_default_transparency"	=> "75",
				"information_panel_hover_trancparency"		=> "100",
				"information_panel_count_image_after_text"	=> "Image",
				"information_panel_count_image_middle_text"	=> "of",
				
				"information_panel_count_padding_left"		=> "15",
				"information_panel_count_padding_right"		=> "4",
				"information_panel_count_font_size"			=> "20",

				
				"information_panel_desc_padding_left"		=> "15",
				"information_panel_desc_padding_right"		=> "4",
				"information_panel_desc_font_size"			=> "20",
				"information_panel_desc_show_if_not"		=> "true",
				"information_panel_text_for_no_caption"		=> "No Caption",
				
				"information_panel_title_padding_left"		=> "5",
				"information_panel_title_padding_right"		=> "5",
				"information_panel_title_font_size"			=> "15",
				"information_panel_title_show_if_not"		=> "true",
				"information_panel_text_for_no_title"		=> "No Title",
				
				"information_panel_ordering"				=> '{"count":[1,"count"],"title":[0,"title"],"caption":[0,"caption"]}'
				
			),
			
		);
		
		
	}

    /*############ Install database function ################*/	
	
	public function install_databese(){
		foreach( $this->installed_options as $key => $option ){
			if( get_option($key,FALSE) === FALSE ){
				add_option($key,$option);
			}
		}		
	}
}