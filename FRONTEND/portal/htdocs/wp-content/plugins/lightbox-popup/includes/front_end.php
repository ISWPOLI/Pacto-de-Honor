<?php 

    /*############ Lightbox Front-end Class ################*/

class wpdevart_lightbox_front_end{
	private $menu_name;
	private $plugin_url;
	private $databese_parametrs;
	private $params;
	private $list_of_animations;

	/*###################### Constract params function ##################*/		
	
	function __construct($params){
		

		$this->databese_parametrs=$params['databese_parametrs'];
		$this->params=$this->generete_params();
		if($this->params['eneble_lightbox_content']=='enable'){
			add_filter( 'the_content', array($this,'add_class_to_content_image'),10 );
			add_action( 'wp_head', array($this,'include_js_and_css') );
			add_action( 'wp_head', array($this,'generete_custom_css') );
		
		}
		
	}
	
    /*############ Generate parameters function ################*/		
	
	private function generete_params(){
		
		foreach($this->databese_parametrs as $param_array_key => $param_value){
			foreach($this->databese_parametrs[$param_array_key] as $key => $value){
				$front_end_parametrs[$key]=stripslashes(wpdevart_lightbox_setting::get_option($key,$value));
			}
		}			
		return $front_end_parametrs;
	}
	
    /*############  JS and CSS function  ################*/
	
	public function include_js_and_css(){		
		wp_localize_script('wpdevart_lightbox_front_end_js','wpdevart_lb_variables',$this->params);
		wp_enqueue_script('wpdevart_lightbox_front_end_js');
		wp_enqueue_style('wpdevart_lightbox_front_end_css');
		wp_enqueue_style('wpdevart_lightbox_effects');
		
	}
	
	/*############ Generate Custom CSS Function ################*/
	
	public function generete_custom_css(){
		echo '<style>#wpdevart_lb_overlay{';
		echo 'background-color:#000000;';
		echo '}';
       	echo ' #wpdevart_lb_overlay.wpdevart_opacity{';
		echo 'opacity:'.($this->params["overlay_transparency_prancent"]/100).' !important;';
	   	echo '}';
	   	echo ' #wpdevart_lb_main_desc{
				 -webkit-transition: opacity 0.3s ease;
				 -moz-transition: opacity 0.3s ease;
				 -o-transition: opacity 0.3s ease;
				 transition: opacity 0.3s ease;';
	   	echo '}';
	   	echo ' #wpdevart_lb_information_content{
				 -webkit-transition: opacity 0.3s ease;
				 -moz-transition: opacity 0.3s ease;
				 -o-transition: opacity 0.3s ease;
				 transition: opacity 0.3s ease;';
	   	echo '}
		#wpdevart_lb_information_content{
			width:100%;	
		}
		#wpdevart_info_counter_of_imgs{
			    display: inline-block;
				padding-left:'.$this->params["information_panel_count_padding_left"].'px;
				padding-right:'.$this->params["information_panel_count_padding_right"].'px;
				font-size:'.$this->params["information_panel_count_font_size"].'px;
				color:#000000;
		}
		#wpdevart_info_caption{
			    display: inline-block;
				padding-left:'.$this->params["information_panel_desc_padding_left"].'px;
				padding-right:'.$this->params["information_panel_desc_padding_right"].'px;
				font-size:'.$this->params["information_panel_desc_font_size"].'px;
				color:#000000;
		}
		#wpdevart_info_title{
			    display: inline-block;
				padding-left:'.$this->params["information_panel_title_padding_left"].'px;
				padding-right:'.$this->params["information_panel_title_padding_right"].'px;
				font-size:'.$this->params["information_panel_title_font_size"].'px;
				color:#000000;
		}
		@-webkit-keyframes rotate {
			to   {-webkit-transform: rotate(360deg);}
			from  {-webkit-transform: rotate(0deg);}
		}
		@keyframes rotate {
			to   {transform: rotate(360deg);}
			from  {transform: rotate(0deg);}
		}
		#wpdevart_lb_loading_img,#wpdevart_lb_loading_img_first{
			-webkit-animation: rotate 2s linear  infinite;
    		animation: rotate 2s linear infinite;
		}
	  </style>';
	  ?>
      <?php
	}

	/*###################### Add class to content images function ##################*/		
	
	public function add_class_to_content_image($content){
		global $post;
		if(isset( $post->ID ) &&  $post->ID)
			$id=$post->ID;
			//Adding url attribute for Lightbox Popup plugin
			$pattern = "/(<a(?![^>]*?rel=['\"]wpdevart_lightbox.*)[^>]*?href=['\"][^'\"]+?\.(?:bmp|gif|jpg|jpeg|png)\?{0,1}\S{0,}['\"][^\>]*)>/i";			
			$content=preg_replace_callback($pattern, function($all){
				$loc_pattern="/(.*)?rel=['\"](.*?)['\"](.*)/i";
				$loc_content=$all[1];
				if(preg_match($loc_pattern,$loc_content)){
					return preg_replace_callback($loc_pattern,function($matches){
						return $matches[1]." rel=\"wpdevart_lightbox ".$matches[2]."\" ".$matches[3].">";	
					},$loc_content);
				}
				return $all[1].' rel="wpdevart_lightbox">';
			}, $content);
			$pattern = "/(<a(?![^>]*?rel=['\"]wpdevart_lightbox_video.*)[^>]*?href=['\"][^'\"]*?(?:http:\/\/|https:\/\/)(?:www\.){0,1}(?:youtube\.com|youtu\.be|vimeo\.com)[^'\"]*['\"][^\>]*)>/i";
			$content=preg_replace_callback($pattern, function($all){
				$loc_pattern="/(.*)?rel=['\"](.*?)['\"](.*)/i";
				$loc_content=$all[1];
				if(preg_match($loc_pattern,$loc_content)){
					return preg_replace_callback($loc_pattern,function($matches){
						return $matches[1]." rel=\"wpdevart_lightbox_video ".$matches[2]."\" ".$matches[3].">";	
					},$loc_content);
				}
				return $all[1].' rel="wpdevart_lightbox_video">';
			}, $content);
		
		return $content;		
	}
}




?>