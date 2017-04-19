<?php

/*
Plugin Name: Spacer
Plugin URI: http://www.clevelandwebdeveloper.com/wordpress-plugins/spacer
Description: Adds a spacer button to the WYSIWYG visual editor which allows you to add precise custom spacing between lines in your posts and pages.
Version: 3.0.4
Author: Justin Saad
Author URI: http://www.clevelandwebdeveloper.com
License: GPL2
*/


//begin wysiwyg visual editor custom button plugin

$plugin_label = "Spacer";
$plugin_slug = "motech_spacer";

class motech_spacer {

	public function __construct() {
		
		global $plugin_label, $plugin_slug;
		$this->plugin_slug = $plugin_slug;
		$this->plugin_label = $plugin_label;
		$this->plugin_dir = plugins_url( '' , __FILE__ );
		$checkaddspacers = get_option($this->plugin_slug."_addspacer_id");
		if(!empty($checkaddspacers)){
			$this->key_array = $checkaddspacers;
			$this->has_addspacers = true;
		}else{
			$this->key_array = array(0);
			$this->has_addspacers = false;
		}
		
		//do when class is instantiated	
		add_shortcode('spacer', array($this, 'addShortcodeHandler'));
		add_filter( 'tiny_mce_version', array($this, 'my_refresh_mce'));
		
		//plugin row links
		add_filter( 'plugin_row_meta', array($this,'plugin_row_links'), 10, 2 );
		
        if(is_admin()){
			add_action('admin_init', array($this, 'page_init'));
			add_action('admin_menu', array($this, 'add_plugin_page'));
			//custom image picker css for admin page
			add_action('admin_head', array($this,'motech_imagepicker_admin_css'));
			//custom image picker jquery for admin page
			add_action('admin_footer', array($this,'motech_imagepicker_admin_jquery'));			
			//add Settings link to plugin page
			add_filter( 'plugin_action_links_' . plugin_basename( __FILE__ ), array($this, 'add_plugin_action_links') );
			//image upload script
			add_action('admin_enqueue_scripts', array($this,'spacer_imageupload_script'));
			
			add_action( 'admin_enqueue_scripts', array($this, 'enqueue_color_picker') ); //enqueue color picker
			
			add_action( 'admin_enqueue_scripts', array($this, 'enqueue_motech_javascript'), 50 ); //enqueue color picker
			
			add_action( 'wp_ajax_motech_spacer', array($this,'motech_spacer_callback') );
			
			//admin messages
			add_action('admin_notices', array($this,'admin_show_message'));
			add_action('admin_init', array($this,'adminmessage_init'));
			
			add_action( 'admin_enqueue_scripts', array($this,'load_custom_wp_admin_style'), 50 );
		} else{
			add_action( 'wp_enqueue_scripts', array($this,'load_custom_wp_admin_style') );
		}
		
		//prepare plugin for localization
		load_plugin_textdomain('motech-spacer', false, dirname( plugin_basename( __FILE__ ) ) . '/languages/' );		
	}
	
	function load_custom_wp_admin_style() {
			if ( current_user_can('edit_posts') or current_user_can('edit_pages') ) {
				wp_register_style( 'mspacer_wp_admin_css', plugins_url( 'admin-style.css' , __FILE__ ), false, '1.0.0' );
				wp_enqueue_style( 'mspacer_wp_admin_css' );
			}
			if (isset($_GET['page']) && $_GET['page'] == $this->plugin_slug.'-setting-admin') { //if we are on our admin page
				wp_register_style( 'mspacer_wp_adminpage_css', plugins_url( 'adminpage-style.css' , __FILE__ ), false, '1.0.0' );
				wp_enqueue_style( 'mspacer_wp_adminpage_css' );			
			}
	}
	
	function motech_spacer_callback() {
		$return = array();
		$checkheight = get_option($this->plugin_slug . '_default_height','20');
		$checkunit = get_option($this->plugin_slug . '_default_height_unit','px');		
		$return["useheight"] = $checkheight.$checkunit;
		if($this->has_addspacers){
			$ids = $this->key_array;
			$checkaddheights = get_option($this->plugin_slug . '_default_height_addspacers');
			$checkaddheightunits = get_option($this->plugin_slug . '_default_height_unit_addspacers');
			$checktitles = get_option($this->plugin_slug . '_title_addspacers');
			foreach($ids as $key=>$value){
				$useheight = $checkaddheights[$key];
				$useunit = $checkaddheightunits[$key];
				$usetitle = $checktitles[$key];
				if(empty($usetitle)){
					$usetitle = "Untitled";
				}
				$return["addspacers"][] = array("id"=>$value,"height"=>$useheight.$useunit,"title"=>$usetitle);
			}
		}
		echo json_encode($return);
		wp_die(); // this is required to terminate immediately and return a proper response
	}

	function admin_show_message()
	{
		$user_id = get_current_user_id();
		//there is no default spacer height set, and nag message not ignored...
		//$checkdefault = get_option($this->plugin_slug . '_default_height_mobile','');
		if ( ( ! get_user_meta($user_id, 'spacer2295_nag_ignore') ) && (current_user_can( 'manage_options' )) ) {
			echo '<div id="message" class="updated fade notice"><p>';
			echo "<b>".__("Take more time as you craft article updates. Designate 'draft' content with one-click! Try the new Spacer add-on, Draft It!", "motech-spacer")."</b>";
			echo "</p>";
			echo "<p><strong><a href=\"http://www.clevelandwebdeveloper.com/?p=1269&amp;utm_medium=plugin&amp;utm_source=plugin-notice-msg&amp;utm_campaign=Spacer+Notice+Msg&amp;utm_content=Draftit+Notice\" target=\"_blank\">".__('Start Drafting &raquo;', 'motech-spacer')."</a> | <a class=\"dismiss-notice\" style=\"color:red;\" href=\"".get_bloginfo( 'wpurl' ) . "/wp-admin/options-general.php?page=".$this->plugin_slug."-setting-admin&spacer2295_nag_ignore=0\" target=\"_parent\">".__('I got it. Thanks.', 'motech-spacer')." [X]</a></strong></p></div>";
		}
	}
	 
	function adminmessage_init()
	{
		if ( isset($_GET['spacer2295_nag_ignore']) && '0' == $_GET['spacer2295_nag_ignore'] ) {
			$user_id = get_current_user_id();
			add_user_meta($user_id, 'spacer2295_nag_ignore', 'true', true);
			if (wp_get_referer()) {
				/* Redirects user to where they were before */
				wp_safe_redirect(wp_get_referer());
			} else {
				/* if there is no referrer you redirect to home */
				wp_safe_redirect(home_url());
			}
		}
	}	
	
	function enqueue_color_picker( $hook_suffix ) {
		wp_enqueue_style( 'wp-color-picker' );
		wp_enqueue_script( $this->plugin_slug.'-script-handle', plugins_url('js/motech-color-picker.js', __FILE__ ), array( 'wp-color-picker' ), false, true );
	}
	
	function enqueue_motech_javascript( ) {
		if (isset($_GET['page']) && $_GET['page'] == $this->plugin_slug.'-setting-admin') {
			wp_enqueue_script( $this->plugin_slug.'-motech-javascript', plugins_url('js/motech-javascript.js', __FILE__ ), array('jquery'), false, true );
		}
	}
	
	function spacer_imageupload_script() {
		if (isset($_GET['page']) && $_GET['page'] == $this->plugin_slug.'-setting-admin') {
			if(function_exists('wp_enqueue_media')){
							   wp_enqueue_media();
							   }
			wp_register_script('spacer_imageupload-js', plugins_url( 'js/spacer_imageupload.js' , __FILE__ ), array('jquery'));
			wp_enqueue_script('spacer_imageupload-js');
		}
	}
	
function activespacer($id="") { #return attributes for active spacer based on id. 
	$return = array();
	if($this->has_addspacers && $id!=""){
		$ids = $this->key_array;
		$key = array_search($id, $ids);
		if($key){
			#associated spacer id found so we return those values
			$get = get_option($this->plugin_slug . '_spacer_style_addspacers');
			$return["defaultstyle"] = $get[$key];
			$get = get_option($this->plugin_slug . '_default_height_mobile_addspacers');
			$return["mobile_height_default"] = $get[$key];
			$return["mobile_height"] = $return["mobile_height_default"];			
			$get = get_option($this->plugin_slug . '_default_height_mobile_unit_addspacers');
			$return["mobileunit"] = $get[$key];
			$get = get_option($this->plugin_slug . '_default_height_addspacers');
			$return["checkheight"] = $get[$key];
			$get = get_option($this->plugin_slug . '_default_height_unit_addspacers');
			$return["checkunit"] = $get[$key];
			//$get = get_option($this->plugin_slug.'_custom_background_image_upload_addspacers');
			//$return["bg"] = $get[$key];
			//$get = get_option($this->plugin_slug . '_background_color_addspacers');
			//$return["bgcolor"] = $get[$key];
			$get = get_option($this->plugin_slug . '_spacer_class_addspacers');
			$return["defaultclasses"] = $get[$key];
			if(has_filter('spacer_add_to_extras')) {
				$return = apply_filters('spacer_add_to_extras',$return,$key);
			}
			return $return;
		}
	
	
	}	
	
	#no associated spacer id found so we return default spacer values
	$return["mobile_height_default"] = get_option($this->plugin_slug . '_default_height_mobile','');
	$return["mobile_height"] = get_option($this->plugin_slug . '_default_height_mobile','');
	$return["mobileunit"] = get_option($this->plugin_slug . '_default_height_mobile_unit','px');
	$return["checkheight"] = get_option($this->plugin_slug . '_default_height','20');
	$return["checkunit"] = get_option($this->plugin_slug . '_default_height_unit','px');
	//$return["bg"] = get_option($this->plugin_slug.'_custom_background_image_upload');
	//$return["bgcolor"] = get_option($this->plugin_slug.'_background_color');
	$return["defaultclasses"] = get_option($this->plugin_slug.'_spacer_class','');
	$return["defaultstyle"] = get_option($this->plugin_slug.'_spacer_style','');
	if(has_filter('spacer_add_to_default')) {
		$return = apply_filters('spacer_add_to_default', $return);
	}

	return $return;
}

	// add the shortcode handler 
	function addShortcodeHandler($atts, $content = null) {
			extract(shortcode_atts(array( "height" => '', "mheight" => '', "class" => '', "id" => '', "style" => '' ), $atts));
			$activespacer = $this->activespacer($id);
			
			//prep variables
			$spacer_css = "";
			$classes = "";
			
			//prep mobile height, if it's empty we will use desktop height. if set to 0 we will hide the spacer on mobile devices.
			$mobile_height = "";
			$mobile_height_inline = "";
			$mobile_height_default = $activespacer["mobile_height_default"];
			
			//first check for inline height, then check default mobile height
			if(isset($mheight) && $mheight != ""){
				$mobile_height = $mheight;
				$mobile_height_inline = $mheight;
			}elseif(isset($mobile_height_default) && $mobile_height_default != ""){
				$mobile_height = $activespacer["mobile_height"];
				$mobile_height_default = $mobile_height;
			}
			
			
			//determine the height to use for the spacer. if it's a mobile device and there is a mobile height set, use that. otherwise use desktop height
			if( function_exists('wp_is_mobile') && wp_is_mobile() && (isset($mobile_height) && $mobile_height != "")) {
				$mobileunit = $activespacer["mobileunit"];
				
				
				if(isset($mobile_height_inline) && $mobile_height_inline != "") {
					if ($mobile_height_inline > 0 ) {
						$spacer_css .= "padding-top: " . $mobile_height_inline . ";";
					} elseif($mobile_height_inline < 0) {
						$spacer_css .= "margin-top: " . $mobile_height_inline . ";";
					} elseif($mobile_height_inline == 0){
						$spacer_css .= "display:none;";
					}
				} elseif(isset($mobile_height_default) && $mobile_height_default != ""){
					if($mobile_height_default > 0){
						$spacer_css .= "padding-top: " . $mobile_height_default . $mobileunit.";";
					}elseif($mobile_height_default < 0){
						$spacer_css .= "margin-top: " . $mobile_height_default . $mobileunit. ";";
					}elseif($mobile_height_default == 0){;
						$spacer_css .= "display:none;";
					}
				}
				
			} elseif($height=="default"){ //there is no mobile height set. use the desktop default height
				
				//for now assume positive. in a sec add logic for if negative
				$checkheight = $activespacer["checkheight"];
				$checkunit = $activespacer["checkunit"];
				
				if($checkheight > 0){
					$spacer_css .= "padding-top: " . $checkheight . $checkunit.";";
				}elseif($checkheight < 0){
					$spacer_css .= "margin-top: " . $checkheight . $checkunit. ";";
				}
			} elseif ($height > 0 ) { #no default for desktop, use positive inline height
				$spacer_css .= "padding-top: " . $height . ";";
			} elseif($height < 0) { #no positive inline for desktop, use negative inline height
				$spacer_css .= "margin-top: " . $height . ";";
			}
			
			
			//custom background image
/*			$bg = $activespacer["bg"];
			if(!empty($bg)) {
				$spacer_css .= "background: url(".$bg.");";
			}*/
			
			//custom background image position
			//$spacer_css .= $this->background_position();
			
			//background color
/*			$bgcolor = $activespacer["bgcolor"];
			if(!empty($bgcolor)) {
				$spacer_css .= "background-color:".$bgcolor.";";
			}*/
			
			//classes
			$defaultclasses = $activespacer["defaultclasses"];
			$classes .= $defaultclasses;
			if(!empty($class)){
				$classes .= " ".$class;
			}
			
			if(has_filter('spacer_add_css')) {
				$spacer_css = apply_filters('spacer_add_css', $spacer_css, $activespacer);
			}
			
			//styles
			$defaultstyle = $activespacer["defaultstyle"];
			$spacer_css .= $defaultstyle;
			if(!empty($style)){
				$spacer_css .= " ".$style;
			}			
			
			//create the spacer after all settings have been loaded
			return '<span class="'.$classes.'" style="display:block;clear:both;height: 0px;'.$spacer_css.'"></span>';
	}
	
	function background_position(){
		$bgposition = get_option($this->plugin_slug.'_custom_background_image_position','repeat');
		if($bgposition=="repeat"){
			return "background-repeat:repeat;";
		} elseif($bgposition=="croptofit"){
			return "background-size:cover;background-position:center;";
		} elseif($bgposition=="stretch"){
			return "background-size: 100% 100%;background-repeat: no-repeat;background-position: center;";
		} elseif($bgposition=="propstretch"){
			return "background-size: contain;background-repeat: no-repeat;background-position: center;";
		}
	}
	
	
	function add_custom_button() {
	   if ( ! current_user_can('edit_posts') && ! current_user_can('edit_pages') )
		 return;
	   if ( get_user_option('rich_editing') == 'true') {
		 add_filter('mce_external_plugins', array($this, 'add_custom_tinymce_plugin'),99999999);
		 add_filter('mce_buttons', array($this, 'register_custom_button'),99999999);
		 global $wp_version;
		 //if($wp_version < 3.9){
		   add_action('admin_head', array($this,'motech_spacer_prepjsbuttons'));
		   add_action('wp_head', array($this,'motech_spacer_prepjsbuttons')); 
		 //}
	   }

	}
	
	function register_custom_button($buttons) {
	   array_push($buttons, "|", get_class($this));
	   return $buttons;
	}
	
	function add_custom_tinymce_plugin($plugin_array) {
		global $wp_version;
	   //use this in a plugin
		if($wp_version >= 3.9){
		   $plugin_array[get_class($this)] = plugins_url( 'editor_plugin.js' , __FILE__ );
	   }else {
		  $plugin_array[get_class($this)] = plugins_url( 'editor_plugin_back.js' , __FILE__ ); 
	   }
	   //use this in a theme
	   //$plugin_array[get_class($this)] = get_bloginfo('template_url').'/editor_plugin.js';
	   return $plugin_array;
	}
	
	function my_refresh_mce($ver) {
	  $ver += 5;
	  return $ver;
	}
	
	function plugin_row_links($links, $file) {
		$plugin = plugin_basename(__FILE__); 
		if ($file == $plugin) // only for this plugin
				return array_merge( $links,
			array( '<a target="_blank" href="http://www.clevelandwebdeveloper.com/wordpress-plugins/spacer/">' . __('Project homepage', 'motech-spacer' ) . '</a>' ),
			array( '<a target="_blank" href="http://www.linkedin.com/in/ClevelandWebDeveloper/">' . __('Find me on LinkedIn', 'motech-spacer' ) . '</a>' ),
			array( '<a target="_blank" href="http://twitter.com/ClevelandWebDev">' . __('Follow me on Twitter', 'motech-spacer') . '</a>' )
		);
		return $links;
	}

    public function create_admin_page(){
        ?>
		<div class="wrap" style="position:relative">
		    <?php screen_icon(); ?>
		    <h2 class="aplabel"><?php echo $this->plugin_label ?></h2>
            
            
            <div id="green_ribbon">
                <div class="grwrap visualartist" style="display:none;">
                    <div id="green_ribbon_top">
                        <div id="green_ribbon_left">
                        </div>
                        <div id="green_ribbon_base">
                            <span id="hms_get_premium" addonname="visualartist"><?php _e('NEW! Get Premium &raquo;', 'motech-spacer')?></span>
                            <span class="hms_get_premium_meta"><?php _e('Visual Artist Add-On now available for as low as $20!', 'motech-spacer')?></span>
                        </div>
                        <div id="green_ribbon_right">
                        </div>
                    </div>
                    
                    <div class="motech_premium_box">
                    
                    
                        <div class="motech_premium_box_wrap">
                            <h2><?php _e('Get Visual Artist', 'motech-spacer')?></h2>
                            <div class="updated below-h2" style="margin-bottom: -20px !important;"><p><strong><?php _e('Purchase will be processed via PayPal.', 'motech-spacer')?></strong></p></div>
                            <div class="updated below-h2"><p><strong><?php _e('Every license is valid for the lifetime of the website where it\'s installed.', 'motech-spacer')?></strong></p></div>
                            <div class="motech_purchase_buttons">
    
                                <div class="motech_purchase_button unlimited_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="FK8RLFRUBCL5N" type="hidden"><input type="hidden" name="page_style" value="visual_artist">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy', 'motech-spacer')?> <span><?php _e('Unlimited', 'motech-spacer')?></span></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$50</div>
                                                <div class="purchase_meta"><?php _e('Unlimited sites forever!', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                                        
                                <div class="motech_purchase_button one_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="C59XHASJBCHLQ" type="hidden"><input type="hidden" name="page_style" value="visual_artist">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy 1 Use', 'motech-spacer')?></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$20</div>
                                                <div class="purchase_meta"><?php _e('1 site license', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                
                            </div>
                            
                            <div class="motech_premium_cancel"><span><?php _e('Cancel', 'motech-spacer')?></span></div>
                            
                        </div>
    
                    </div>
                </div>
                
                
                <div class="grwrap lineonsidesheaders" style="display:none;">
                
                    <div id="green_ribbon_top">
                        <div id="green_ribbon_left">
                        </div>
                        <div id="green_ribbon_base">
                            <span id="hms_get_premium" addonname="lineonsidesheaders"><?php _e('NEW! Get Premium &raquo;', 'motech-spacer')?></span>
                            <span class="hms_get_premium_meta"><?php _e('Header Add-On now available for as low as $10!', 'motech-spacer')?></span>
                        </div>
                        <div id="green_ribbon_right">
                        </div>
                    </div>
                    
                    <div class="motech_premium_box">
                    
                    
                        <div class="motech_premium_box_wrap">
                            <h2><?php _e('Get Line-On-Sides Headers', 'motech-spacer')?></h2>
                            <div class="updated below-h2" style="margin-bottom: -20px !important;"><p><strong><?php _e('Purchase will be processed via PayPal.', 'motech-spacer')?></strong></p></div>
                            <div class="updated below-h2"><p><strong><?php _e('Every license is valid for the lifetime of the website where it\'s installed.', 'motech-spacer')?></strong></p></div>
                            <div class="motech_purchase_buttons">
    
                                <div class="motech_purchase_button unlimited_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="D2R9YPYQHK63L" type="hidden">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy', 'motech-spacer')?> <span><?php _e('Unlimited', 'motech-spacer')?></span></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$25</div>
                                                <div class="purchase_meta"><?php _e('Unlimited sites forever!', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                                        
                                <div class="motech_purchase_button one_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="F2CNV7FMSGAN8" type="hidden">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy 1 Use', 'motech-spacer')?></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$10</div>
                                                <div class="purchase_meta"><?php _e('1 site license', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                
                            </div>
                            
                            <div class="motech_premium_cancel"><span><?php _e('Cancel', 'motech-spacer')?></span></div>
                            
                        </div>
    
                    </div>
                </div>
                

                <div class="grwrap panels" style="display:none;">
                
                    <div id="green_ribbon_top">
                        <div id="green_ribbon_left">
                        </div>
                        <div id="green_ribbon_base">
                            <span id="hms_get_premium" addonname="panels"><?php _e('NEW! Get Premium &raquo;', 'motech-spacer')?></span>
                            <span class="hms_get_premium_meta"><?php _e('Panels Add-On now available for as low as $10!', 'motech-spacer')?></span>
                        </div>
                        <div id="green_ribbon_right">
                        </div>
                    </div>
                    
                    <div class="motech_premium_box">
                    
                    
                        <div class="motech_premium_box_wrap">
                            <h2><?php _e('Get Panels', 'motech-spacer')?></h2>
                            <div class="updated below-h2" style="margin-bottom: -20px !important;"><p><strong><?php _e('Purchase will be processed via PayPal.', 'motech-spacer')?></strong></p></div>
                            <div class="updated below-h2"><p><strong><?php _e('Every license is valid for the lifetime of the website where it\'s installed.', 'motech-spacer')?></strong></p></div>
                            <div class="motech_purchase_buttons">
    
                                <div class="motech_purchase_button unlimited_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="ZV77J555HXJTE" type="hidden">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy', 'motech-spacer')?> <span><?php _e('Unlimited', 'motech-spacer')?></span></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$25</div>
                                                <div class="purchase_meta"><?php _e('Unlimited sites forever!', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                                        
                                <div class="motech_purchase_button one_use">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input name="cmd" value="_s-xclick" type="hidden"><input name="hosted_button_id" value="GNBBYMDBN3UUE" type="hidden">
                                        <button name="submit">
                                            <div class="purchase_graphic"><?php _e('Buy 1 Use', 'motech-spacer')?></div>
                                            <div class="purchase_bubble">
                                                <div class="purchase_price">$10</div>
                                                <div class="purchase_meta"><?php _e('1 site license', 'motech-spacer')?></div>
                                            </div>
                                        </button>
                                        <img src="https://www.paypal.com/en_US/i/scr/pixel.gif" alt="" border="0" height="1" width="1">
                                    </form>
                                </div>
                                
                            </div>
                            
                            <div class="motech_premium_cancel"><span><?php _e('Cancel', 'motech-spacer')?></span></div>
                            
                        </div>
    
                    </div>
                </div>                
            
                            
            </div>
            
            <div class="grwrap draftit">
            
                <div id="green_ribbon_top">
                    <div id="green_ribbon_left">
                    </div>
                    <div id="green_ribbon_base">
                        <span id="hms_get_premium" addonname="gotourl" useurl="http://www.clevelandwebdeveloper.com/?p=1269&amp;utm_medium=plugin&amp;utm_source=plugin-notice-msg&amp;utm_campaign=Spacer+Notice+Msg&amp;utm_content=Draftit+Notice"><?php _e('NEW! Get Draft It! &raquo;', 'motech-spacer')?></span>
                        <span class="hms_get_premium_meta"><?php _e('Draft It! Add-On now available for as low as $19!', 'motech-spacer')?></span>
                    </div>
                    <div id="green_ribbon_right">
                    </div>
                </div>
                        
        	</div>
                        
            
	<h2 class="nav-tab-wrapper">
            <a href="#defaultspacer" class="nav-tab nav-tab-active"><?php _e('Default', 'motech-spacer')?></a>
            <a href="#addspacers" class="nav-tab"><span class="dashicons dashicons-plus dashicons-plus-alt"></span> <?php _e('Add Spacers', 'motech-spacer')?></a>
            <?php do_action( 'spacer_sectiontabhook' ); #use this hook to add additional section tabs ?>
            <a href="#suggestionbox" class="nav-tab"><span class="dashicons dashicons-email-alt"></span> <?php _e('Suggestion Box', 'motech-spacer')?></a>
            <a href="#addons" class="nav-tab"><span class="dashicons dashicons-admin-plugins"></span> <?php _e('Add-Ons', 'motech-spacer')?></a>
            <a href="#licenses" class="nav-tab"><span class="dashicons dashicons-admin-network"></span> <?php _e('Licenses', 'motech-spacer')?></a>
<?php /*?>            <a href="#privacy-settings" class="nav-tab">Privacy settings</a>
            <a href="#admin-custom" class="nav-tab">Admin Customizations</a>
            <a href="#smtp" class="nav-tab">Smtp Settings</a><?php */?>
	</h2> 
                
		    <form method="post" action="options.php" class="<?php echo $this->plugin_slug ?>_form">
		        <?php
	            // This prints out all hidden setting fields
			    settings_fields($this->plugin_slug.'_option_group');
				?>
                <div id="defaultspacer" class="metabox-holder mainsection aspacerunit">
                    <div class="motech-spacer-options section general wrap" style="border-bottom: solid 1px #BFBFBF;padding-bottom: 3px;">
                        <?php do_settings_sections($this->plugin_slug.'-setting-admin'); ?>
                    </div>
                    <div class="motech-spacer-options section mobileoptions" style="border-bottom: solid 1px #BFBFBF;padding-bottom: 3px;">
                        <?php do_settings_sections($this->plugin_slug.'-setting-admin_mobileoptions'); ?>
                    </div>
                    <div class="motech-spacer-options section styleoptions">
                        <?php do_settings_sections($this->plugin_slug.'-setting-admin_styleoptions'); ?>
                    </div>
<?php
		if(has_filter('spacer_default_sections')) {
			apply_filters('spacer_default_sections', '',$this);
		}
?>
                    <div class="spacer_preview_area_container">
                        <h2><?php _e('Preview', 'motech-spacer')?></h2>
                        <div class="spacer_preview_area">
                        	<p><?php _e('Sample text before Spacer', 'motech-spacer')?></p>
                            <span class="spacer_preview" style="display:block;clear:both;height: 0px;padding-top: 20px;"></span>
                            <p><?php _e('Sample text after Spacer', 'motech-spacer')?></p>
                        </div>
                    </div>
                    <div class="hidden" style="display:none;"><?php do_settings_sections($this->plugin_slug.'-setting-admin_hdoptions'); ?></div>
                </div>
                <div id="addspacers" class="metabox-holder mainsection hidden wrap">
                	<h2 style="padding-bottom:20px;"><?php _e('Add New Spacers', 'motech-spacer')?></h2>
                    <div class="nothinghere hidden"><div style="font-weight: bold;font-size: 127px;line-height: normal;margin-bottom: 10px;">:-(</div><div style="font-size: 19px;    line-height: normal;margin-bottom: 30px;"><?php _e('You don\'t have any additional Spacers yet', 'motech-spacer')?></div></div>
					<?php
                    $key_array = $this->key_array;
					$getoption = get_option($this->plugin_slug.'_title_addspacers','');
                    foreach($key_array as $key=>$value){
						if(isset($getoption[$key])){
							$gettitle = $getoption[$key];
						}
						if(empty($gettitle)){
							$gettitle = "Untitled";
						}
                        ?>
                        <div class="aspacerunit addspacerunit postbox closed">
                        	<button type="button" class="handlediv button-link" aria-expanded="true"><span class="toggle-indicator" aria-hidden="true"></span></button>
                            <h2 class="hndle ui-sortable-handle"><span><?php echo $gettitle ?></span></h2>
                            <div class="inside">
                                <div class="motech-spacer-options section title" style="border-bottom: solid 1px #eee;padding-bottom: 3px;">
                                    <?php do_settings_sections($this->plugin_slug.'-setting-admin_title_addspacers'.$key); ?>
                                </div>
                                <div class="motech-spacer-options section general" style="border-bottom: solid 1px #eee;padding-bottom: 3px;">
                                    <?php do_settings_sections($this->plugin_slug.'-setting-admin_addspacers'.$key); ?>
                                </div>
                                <div class="motech-spacer-options section mobileoptions" style="border-bottom: solid 1px #eee;padding-bottom: 3px;">
                                    <?php do_settings_sections($this->plugin_slug.'-setting-admin_mobileoptions_addspacers'.$key); ?>
                                </div>  
                                <div class="motech-spacer-options section styleoptions">
                                    <?php do_settings_sections($this->plugin_slug.'-setting-admin_styleoptions_addspacers'.$key); ?>
                                </div>
								<?php
                                        if(has_filter('spacer_addspacer_sections'.$key)) {
                                            apply_filters('spacer_addspacer_sections'.$key, '',$key);
                                        }
                                ?>                                
                                <div class="spacer_preview_area_container">
                                    <h2><?php _e('Preview', 'motech-spacer')?></h2>
                                    <div class="spacer_preview_area">
                                        <p><?php _e('Sample text before Spacer', 'motech-spacer')?></p>
                                        <span class="spacer_preview" style="display:block;clear:both;height: 0px;padding-top: 20px;"></span>
                                        <p><?php _e('Sample text after Spacer', 'motech-spacer')?></p>
                                    </div>
                                </div>
                                <div class="hiddenx" style="display:none;">
                                    <?php do_settings_sections($this->plugin_slug.'-setting-admin_hd_addspacers'.$key); ?>
                                </div>                                 
                                <div class="removebutton"><span class="dashicons dashicons-post-trash"></span> <?php _e('REMOVE', 'motech-spacer') ?></div>
                            </div>
                        </div>
                      <?php } ?>

                      	<div class="newbutton"><span class="dashicons dashicons-plus dashicons-plus-alt"></span> <?php _e('NEW SPACER', 'motech-spacer') ?></div>
                        

                </div>
                <?php do_action( 'spacer_sectionshook' ); #use this hook to add additional sections ?>
                <div id="addons" class="metabox-holder mainsection hidden wrap">
<?php
$actionbutton = '<a href="#" title="'.__('Buy Visual Artist', 'motech-spacer').'" class="button-primary msbutton buynowbutton" addonname="visualartist">'.__('Buy Now', 'motech-spacer').'</a>';
if( is_plugin_active( 'spacer-visual-artist/index.php' ) ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Active', 'motech-spacer').'" class="button-secondary msbutton">'.__('Active', 'motech-spacer').'</a>';
} elseif( file_exists(plugin_dir_path(__FILE__) . '../spacer-visual-artist/index.php') ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Installed', 'motech-spacer').'" class="button-secondary msbutton">'.__('Installed', 'motech-spacer').'</a>';
}
?>
<div class="msaddon mscol"><img src="<?php echo plugins_url( 'images/vart.png' , __FILE__ ) ?>"><h2><?php _e('Visual Artist', 'motech-spacer') ?></h2><div class="msaddon-content"><p><?php _e('Design fancy dividers, horizontal rules, and other ornate section breaks. Incorporate rich colors and images, all without mastering css.', 'motech-spacer') ?></p><div class="msaddon-buttons"><a href="http://www.clevelandwebdeveloper.com/?p=644&amp;utm_medium=plugin&amp;utm_source=plugin-addons-page&amp;utm_campaign=Spacers+Addons+Page&amp;utm_content=Spacer+Learn" target="_blank" class="button-secondary msdbutton"><?php _e('Learn More', 'motech-spacer') ?></a><?php echo $actionbutton ?></div></div></div>   

<?php
$actionbutton = '<a href="#" title="'.__('Buy Line-On-Sides Headers', 'motech-spacer').'" class="button-primary msbutton buynowbutton" addonname="lineonsidesheaders">'.__('Buy Now', 'motech-spacer').'</a>';
if( is_plugin_active( 'spacer-lineonsides-headers/index.php' ) ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Active', 'motech-spacer').'" class="button-secondary msbutton">'.__('Active', 'motech-spacer').'</a>';
} elseif( file_exists(plugin_dir_path(__FILE__) . '../spacer-lineonsides-headers/index.php') ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Installed', 'motech-spacer').'" class="button-secondary msbutton">'.__('Installed', 'motech-spacer').'</a>';
}
?>
<div class="msaddon mscol"><img src="<?php echo plugins_url( 'images/lhart.png' , __FILE__ ) ?>"><h2><?php _e('Line-On-Sides Headers', 'motech-spacer') ?></h2><div class="msaddon-content"><p><?php _e('Create headers that really stand out with lines on the sides.', 'motech-spacer') ?></p><div class="msaddon-buttons"><a href="http://www.clevelandwebdeveloper.com/?p=868&amp;utm_medium=plugin&amp;utm_source=plugin-addons-page&amp;utm_campaign=Spacers+Addons+Page&amp;utm_content=Lineonsides+Learn" target="_blank" class="button-secondary msdbutton"><?php _e('Learn More', 'motech-spacer') ?></a><?php echo $actionbutton ?></div></div></div>

<?php
$actionbutton = '<a href="#" title="'.__('Buy Panels', 'motech-spacer').'" class="button-primary msbutton buynowbutton" addonname="panels">'.__('Buy Now', 'motech-spacer').'</a>';
if( is_plugin_active( 'spacer-panels/index.php' ) ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Active', 'motech-spacer').'" class="button-secondary msbutton">'.__('Active', 'motech-spacer').'</a>';
} elseif( file_exists(plugin_dir_path(__FILE__) . '../spacer-panels/index.php') ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Installed', 'motech-spacer').'" class="button-secondary msbutton">'.__('Installed', 'motech-spacer').'</a>';
}
?>
<div class="msaddon mscol"><img src="<?php echo plugins_url( 'images/part.png' , __FILE__ ) ?>"><h2><?php _e('Panels', 'motech-spacer') ?></h2><div class="msaddon-content"><p><?php _e('Style your own panels (think alerts, info boxes) and use them in your posts and pages whenever they are needed.', 'motech-spacer') ?></p><div class="msaddon-buttons"><a href="http://www.clevelandwebdeveloper.com/?p=931&amp;utm_medium=plugin&amp;utm_source=plugin-addons-page&amp;utm_campaign=Spacers+Addons+Page&amp;utm_content=Panels+Learn" target="_blank" class="button-secondary msdbutton"><?php _e('Learn More', 'motech-spacer') ?></a><?php echo $actionbutton ?></div></div></div>

<?php
$actionbutton = '<a href="http://www.clevelandwebdeveloper.com/?p=1269&amp;utm_medium=plugin&amp;utm_source=plugin-addons-page&amp;utm_campaign=Spacers+Addons+Page&amp;utm_content=Draftit+Learn" target="_blank" title="'.__('Buy Draft It!', 'motech-spacer').'" class="button-primary msbutton">'.__('Buy Now', 'motech-spacer').'</a>';
if( is_plugin_active( 'spacer-draftit/index.php' ) ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Active', 'motech-spacer').'" class="button-secondary msbutton">'.__('Active', 'motech-spacer').'</a>';
} elseif( file_exists(plugin_dir_path(__FILE__) . '../spacer-draftit/index.php') ) {
	$actionbutton = '<a href="javascript:void(0)" title="'.__('Installed', 'motech-spacer').'" class="button-secondary msbutton">'.__('Installed', 'motech-spacer').'</a>';
}
?>
<div class="msaddon mscol"><img src="<?php echo plugins_url( 'images/diart.png' , __FILE__ ) ?>"><h2><?php _e('Draft It!', 'motech-spacer') ?></h2><div class="msaddon-content"><p><?php _e("Take more time as you craft article updates. Designate 'draft' content with one-click!", "motech-spacer") ?></p><div class="msaddon-buttons"><a href="http://www.clevelandwebdeveloper.com/?p=1269&amp;utm_medium=plugin&amp;utm_source=plugin-addons-page&amp;utm_campaign=Spacers+Addons+Page&amp;utm_content=Draftit+Learn" target="_blank" class="button-secondary msdbutton"><?php _e('Learn More', 'motech-spacer') ?></a><?php echo $actionbutton ?></div></div></div>   
        
                </div>
                <div id="licenses" class="metabox-holder mainsection hidden wrap">
                    <div class="motech-spacer-options section general wrap">
                        <?php do_settings_sections($this->plugin_slug.'-setting-admin_licenses'); ?>
                    </div>                
                </div>
                <div id="suggestionbox" class="metabox-holder mainsection hidden wrap">
                    <div class="motech-spacer-options section general wrap">
                    	<h1>Have a good suggestion for a Spacer add-on or a feature request? Let's hear it...</h1>
                        <?php
global $current_user;
wp_get_current_user();
						?>
                        <textarea style="width:100%;min-height:250px;" name="mysuggestion" placeholder="Suggestions go here"></textarea>
                        <div style="font-size:20px;line-height:normal;margin: 25px 0px;margin-bottom: 35px;"><input type="checkbox" name="signmeup" value="yes" checked="checked">Yes, I want to subscribe to the Spacer newsletter and be the first to know of important Spacer news and upcoming releases. I want to stay notified about exclusive discounts and insider deals on premium features. My email address is: <input type="text" name="myemail" value="<?php echo $current_user->user_email ?>" /> <div style="font-size:14px;">(The Spacer newsletter is personally written and sent out about once a month (at most). It's not remotely annoying or spammy. We promise.)</div></div>
                        <div class="sendhook">
                        	<div class="newbutton readysend"><span class="dashicons dashicons-email-alt"></span> <span class="readysendlabel"><?php _e('SEND', 'motech-spacer') ?></span></div>
                            <div class="responsehook" style="margin-top: -20px;padding: 15px;margin-left: 10px;margin-right: 10px;background: rgb(252, 248, 227);    color: rgb(138, 109, 59);border: 1px solid rgb(252, 220, 126);border-radius: 3px;display:none;"></div>
                        </div>
                    </div>                
                </div>                
		        <div class="wrap"><div class="savebutton"><button type="submit"><span class="dashicons dashicons-yes"></span> <?php _e('SAVE CHANGES!', 'motech-spacer') ?></button></div></div>
		    </form>
		</div>
	<?php
    }
	
	public function DisplayAddSpacers(){
		$key_array = $this->key_array;
		foreach($key_array as $key=>$value){
		   add_settings_section(
			$this->plugin_slug.'_setting_section',
			__('', 'motech-spacer'),
			false,
			$this->plugin_slug.'-setting-admin_title_addspacers'.$key
			);
		   
		   add_settings_section(
			$this->plugin_slug.'_setting_section',
			__('', 'motech-spacer'),
			false,
			$this->plugin_slug.'-setting-admin_hd_addspacers'.$key
			);		   
		   
			//add text input field
			$field_slug = "title_addspacers";
			$field_label = __('Spacer Title', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(
				$field_id,
				$field_label, 
				array($this, 'create_a_text_input_array'), //callback function for text input
				$this->plugin_slug.'-setting-admin_title_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"key" => $key,
					"class" => "addingspacer",
					"desc" => __('Give this Spacer a title.', 'motech-spacer'), //description of the field (optional)
					"placeholder" => __('eg: Medium Spacer', 'motech-spacer')
					//"default" => '20' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)			
			);
			
		//add text input field
		$field_slug = "addspacer_id";
		$field_label = "Spacer ID";
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		$desc = "";
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($this, 'create_a_text_input_array'), //callback function for text input
		    $this->plugin_slug.'-setting-admin_hd_addspacers'.$key,
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"key" => $key,
				"class" => "hmshidden addspacer_id",
				"desc" => $desc, //description of the field (optional)
			)
		);				
		   
		   add_settings_section(
			$this->plugin_slug.'_setting_section',
			__('', 'motech-spacer'),
			false,
			$this->plugin_slug.'-setting-admin_addspacers'.$key
			);	
			
			//add text input field
			$field_slug = "default_height_addspacers";
			$field_label = __('Default Height', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(
				$field_id,
				$field_label, 
				array($this, 'create_a_text_input_array'), //callback function for text input
				$this->plugin_slug.'-setting-admin_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"key" => $key,
					"class" => 'sheight',
					"desc" => __('Set a default height. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
					"placeholder" => __('eg: 20', 'motech-spacer'),
					"default" => '20' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)			
			);
			
			//add a select input field
			$field_slug = "default_height_unit_addspacers";
			$field_label = __('Height Unit', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			$this->unit_options = array(
									array("label" => "px", "value" => "px"),
									array("label" => "em", "value" => "em"),
									array("label" => "rem", "value" => "rem"),
									array("label" => "%", "value" => "%"),
			);
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($this, 'create_a_select_input_array'), //callback function for select input
				$this->plugin_slug.'-setting-admin_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'px', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"desc" => __('Select a unit of measurement to use with your default spacer height.', 'motech-spacer'), //description of the field (optional)
					"key" => $key,
					"class" => "msunit",
					"meta" => 'style="max-width:450px;"',
					"select_options" => $this->unit_options //sets select option data
				)				
			);
			
			add_settings_section(
			$this->plugin_slug.'_setting_section',
			__('', 'motech-spacer'),
			false,
			$this->plugin_slug.'-setting-admin_mobileoptions_addspacers'.$key
			);
			
			//add text input field
			$field_slug = "default_height_mobile_addspacers";
			$field_label = __('Default Height On Mobile (Optional)', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(
				$field_id,
				$field_label, 
				array($this, 'create_a_text_input_array'), //callback function for text input
				$this->plugin_slug.'-setting-admin_mobileoptions_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"desc" => __('Set the default height on mobile devices. If left empty, the mobile height will be the same as the desktop height. If set to 0, the spacer will be hidden on mobile.', 'motech-spacer'), //description of the field (optional)
					"key" => $key,
					"placeholder" => __('eg: 10', 'motech-spacer'),
					"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)
			);
			
			//add a select input field
			$field_slug = "default_height_mobile_unit_addspacers";
			$field_label = __('Height Unit On Mobile', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			$this->unit_options = array(
									array("label" => "px", "value" => "px"),
									array("label" => "em", "value" => "em"),
									array("label" => "rem", "value" => "rem"),
									array("label" => "%", "value" => "%"),
			);
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($this, 'create_a_select_input_array'), //callback function for select input
				$this->plugin_slug.'-setting-admin_mobileoptions_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'px', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"desc" => __('Select a unit of measurement to use with your default spacer height on mobile devices. This only applies if you have a default spacer height set for mobile.', 'motech-spacer'), //description of the field (optional)
					"key" => $key,
					"class"=> "msunitmobile",
					"meta" => 'style="max-width:450px;"',
					"select_options" => $this->unit_options //sets select option data
				)				
			);
			
			add_settings_section(
			$this->plugin_slug.'_setting_section',
			__('', 'motech-spacer'),
			false,
			$this->plugin_slug.'-setting-admin_styleoptions_addspacers'.$key
			);
			
			//add text input field
			$field_slug = "spacer_class_addspacers";
			$field_label = __('Default Class (Optional)', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(
				$field_id,
				$field_label, 
				array($this, 'create_a_text_input_array'), //callback function for text input
				$this->plugin_slug.'-setting-admin_styleoptions_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"desc" => __('Enter a custom css class to apply to all of your spacer elements. Multiple classes can be added by putting a blank space between each class name', 'motech-spacer'), //description of the field (optional)
					"key" => $key,
					"placeholder" => __('eg: MyClass1 Class2', 'motech-spacer')
				)			
			);		
			
			//add textarea input field
			$field_slug = "spacer_style_addspacers";
			$field_label = __('Style (Optional)', 'motech-spacer');
			$field_id = $this->plugin_slug.'_'.$field_slug;
			register_setting($this->plugin_slug.'_option_group', $field_id);
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($this, 'create_a_textarea_input_array'), //callback function for textarea input
				$this->plugin_slug.'-setting-admin_styleoptions_addspacers'.$key,
				$this->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"desc" => __('Enter custom css to apply to all of your spacer elements. This is for advanced users. Just leave this empty if you\'re not sure what this means or if you don\'t have a use for it.<br><span style="color:red">NEW:</span> Want to create visually stunning divider elements, without needing to know any CSS? See <a href="http://www.clevelandwebdeveloper.com/wordpress-plugins/visual-artist/?utm_medium=plugin&amp;utm_source=plugin-settings-page&amp;utm_campaign=Spacers+Settings+Page&amp;utm_content=Spacer+Inline" target="_blank">examples of what you can do with the Visual Artist add-on &raquo;</a><br>Ready to make your own? <a href="#" class="buynowbutton" addonname="visualartist">Buy It Now &raquo;</a>', 'motech-spacer'), //description of the field (optional)
					"key" => $key,
					"class" => 'msstyle',
					"placeholder" => __('(for example)', 'motech-spacer').' border-top: solid 2px black; border-bottom: solid 2px black; margin-bottom: 25px;' //sets the field placeholder which appears when the field is empty (optional)
				)				
			);
			
		//add text input field
		$field_slug = "addspacer_index";
		$field_label = "Add Spacer index";
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		$desc = "";
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($this, 'create_a_text_input'), //callback function for text input
		    $this->plugin_slug.'-setting-admin_hdoptions',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"class" => "hmshidden",
				"default" => "1",
				"desc" => $desc, //description of the field (optional)
			)
		);
				
		}
 
	}
	
	public function DisplayMobileOptions(){
        add_settings_section(
	    $this->plugin_slug.'_setting_section',
	    __('', 'motech-spacer'),
	    false,
	    $this->plugin_slug.'-setting-admin_mobileoptions'
		);
		
		//add text input field
		$field_slug = "default_height_mobile";
		$field_label = __('Default Spacer Height On Mobile (Optional)', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($this, 'create_a_text_input'), //callback function for text input
		    $this->plugin_slug.'-setting-admin_mobileoptions',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"desc" => __('Set the default spacer height on mobile devices. If left empty, the spacer mobile height will be the same as the spacer desktop height. If set to 0, the spacer will be hidden on mobile.', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: 10', 'motech-spacer'),
				"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);
		
		//add a select input field
		$field_slug = "default_height_mobile_unit";
		$field_label = __('Spacer Height Unit On Mobile', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		$this->unit_options = array(
								array("label" => "px", "value" => "px"),
								array("label" => "em", "value" => "em"),
								array("label" => "rem", "value" => "rem"),
								array("label" => "%", "value" => "%"),
		);
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($this, 'create_a_select_input'), //callback function for select input
		    $this->plugin_slug.'-setting-admin_mobileoptions',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'px', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"desc" => __('Select a unit of measurement to use with your default spacer height on mobile devices. This only applies if you have a default spacer height set for mobile.', 'motech-spacer'), //description of the field (optional)
				"meta" => 'style="max-width:450px;"',
				"select_options" => $this->unit_options //sets select option data
			)				
		);
	}
	
	public function DisplayStyleOptions(){
        add_settings_section(
	    $this->plugin_slug.'_setting_section',
	    __('', 'motech-spacer'),
	    false,
	    $this->plugin_slug.'-setting-admin_styleoptions'
		);
		
		//add text input field
		$field_slug = "spacer_class";
		$field_label = __('Default Spacer Class (Optional)', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($this, 'create_a_text_input'), //callback function for text input
		    $this->plugin_slug.'-setting-admin_styleoptions',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"desc" => __('Enter a custom css class to apply to all of your spacer elements. Multiple classes can be added by putting a blank space between each class name', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: MyClass1 Class2', 'motech-spacer')
			)			
		);		
		
		//add textarea input field
		$field_slug = "spacer_style";
		$field_label = __('Spacer Style (Optional)', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($this, 'create_a_textarea_input'), //callback function for textarea input
		    $this->plugin_slug.'-setting-admin_styleoptions',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"desc" => __('Enter custom css to apply to all of your spacer elements. This is for advanced users. Just leave this empty if you\'re not sure what this means or if you don\'t have a use for it.<br><span style="color:red">NEW:</span> Want to create visually stunning divider elements, without needing to know any CSS? See <a href="http://www.clevelandwebdeveloper.com/wordpress-plugins/visual-artist/?utm_medium=plugin&amp;utm_source=plugin-settings-page&amp;utm_campaign=Spacers+Settings+Page&amp;utm_content=Spacer+Inline" target="_blank">examples of what you can do with the Visual Artist add-on &raquo;</a><br>Ready to make your own? <a href="#" class="buynowbutton" addonname="visualartist">Buy It Now &raquo;</a>', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('(for example)', 'motech-spacer').' border-top: solid 2px black; border-bottom: solid 2px black; margin-bottom: 25px;' //sets the field placeholder which appears when the field is empty (optional)
			)				
		);
		
		if(has_filter('spacer_default_settings')) {
			apply_filters('spacer_default_settings','',$this);
		}
		
        add_settings_section(
	    $this->plugin_slug.'_setting_section',
	    __('', 'motech-spacer'),
	    false,
	    $this->plugin_slug.'-setting-admin_hdoptions'
		);		
	}		
	
    public function page_init(){

		//register other settings sections
		$this->DisplayMobileOptions();
		$this->DisplayStyleOptions();
		$this->DisplayAddSpacers();
		do_action( 'spacer_sectionfieldhook', $this ); #use this hook to add additional field sections
		
		
        add_settings_section(
	    $this->plugin_slug.'_setting_section',
	    __('Configure Default Spacer', 'motech-spacer'),
	    array($this, 'print_section_info'),
	    $this->plugin_slug.'-setting-admin'
		);
		
        add_settings_section(
	    $this->plugin_slug.'_setting_section',
	    __('Licenses', 'motech-spacer'),
	    array($this, 'print_section_info_licenses'),
	    $this->plugin_slug.'-setting-admin_licenses'
		);
		
		if(has_filter('spacer_licenses_settings')) {
			apply_filters('spacer_licenses_settings','',$this);
		}
		
		//add text input field
		$field_slug = "default_height";
		$field_label = __('Default Spacer Height', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($this, 'create_a_text_input'), //callback function for text input
		    $this->plugin_slug.'-setting-admin',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: 20', 'motech-spacer'),
				"default" => '20' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);
		
		//add a select input field
		$field_slug = "default_height_unit";
		$field_label = __('Spacer Height Unit', 'motech-spacer');
		$field_id = $this->plugin_slug.'_'.$field_slug;
		$this->unit_options = array(
								array("label" => "px", "value" => "px"),
								array("label" => "em", "value" => "em"),
								array("label" => "rem", "value" => "rem"),
								array("label" => "%", "value" => "%"),
		);
		register_setting($this->plugin_slug.'_option_group', $field_id);
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($this, 'create_a_select_input'), //callback function for select input
		    $this->plugin_slug.'-setting-admin',
		    $this->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'px', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"desc" => __('Select a unit of measurement to use with your default spacer height.', 'motech-spacer'), //description of the field (optional)
				"meta" => 'style="max-width:450px;"',
				"select_options" => $this->unit_options //sets select option data
			)				
		);

	
	//add radio option
	//$option_id = "status";
	//add_settings_field($option_id, 'Status', array($this, 'create_radio_field'), 'wordpresshidesite-setting-admin', 'setting_section_id', array("option_id" => $option_id));
			
    }  //end page_init	


	/**
	 * This following set of functions handle all input field creation
	 * 
	 */
	function create_image_upload($args) {
		?>
			<?php
			//set default value if applicable
            if(isset($args["default"])) {
                $default = $args["default"];
            } else {
                $default = false;
            }
            if(isset($args["meta"])) {
                $meta = $args["meta"];
            } else {
                $meta = "";
            }			
            ?>
            <input class="motech_upload_image" type="text" name="<?php echo $args["id"] ?>" value="<?php echo get_option($args["id"], $default) ?>" <?php echo $meta ?> /> 
            <input class="motech_upload_image_button" class="button" type="button" value="<?php _e('Upload Image', 'motech-spacer')?>" />
        	<br />
			<?php
			if(isset($args["desc"])) {
				echo "<span class='description'>".$args["desc"]."</span>";
			} else {
				echo "<span class='description'>".__('Enter a URL or upload an image.', 'motech-spacer')."</span>";	
			}
			?>
<?php /*?>            <?php
				$current_image = get_option($args["id"],$default);
				if(!empty($current_image)) {
					echo "<span class='motech_spacer_preview_image_container'><br><strong>".__('Image Preview', 'motech-spacer')."</strong><br><span class='motech_spacer_preview_image' style='background-size: contain;background-position: 0% 0%;background-repeat: no-repeat;margin-left:20px;display:block; width:75px; height: 75px;background-image:url(".$current_image.");'></span></span>";	
				}
			?><?php */?>
        <?php
	} // end create_image_upload
	
	function create_image_upload_array($args) {
		?>
			<?php
			//set default value if applicable
            if(isset($args["default"])) {
                $default = $args["default"];
            } else {
                $default = false;
            }
			$key = $args["key"];
			$getarray = get_option($args["id"]);
			if(!isset($getarray[$key])){
				$getarray[$key] = "";
			}
            ?>
            <input class="motech_upload_image" type="text" name="<?php echo $args["id"]."[".$key."]" ?>" value="<?php echo $getarray[$key] ?>" /> 
            <input class="motech_upload_image_button" class="button" type="button" value="<?php _e('Upload Image', 'motech-spacer')?>" />
        	<br />
			<?php
			if(isset($args["desc"])) {
				echo "<span class='description'>".$args["desc"]."</span>";
			} else {
				echo "<span class='description'>".__('Enter a URL or upload an image.', 'motech-spacer')."</span>";	
			}
			?>
<?php /*?>            <?php
				$current_image = $getarray[$key];
				if(!empty($current_image)) {
					echo "<span class='motech_spacer_preview_image_container'><br><strong>".__('Image Preview', 'motech-spacer')."</strong><br><span class='motech_spacer_preview_image' style='background-size: contain;background-position: 0% 0%;background-repeat: no-repeat;margin-left:20px;display:block; width:75px; height: 75px;background-image:url(".$current_image.");'></span>";	
				}
			?><?php */?>
        <?php
	} // end create_image_upload	

	function create_a_checkbox($args) {
		$html = '<input type="checkbox" id="'  . $args["id"] . '" name="'  . $args["id"] . '" value="1" ' . checked(1, get_option($args["id"], $args["default"]), false) . '/>'; 
		
		// Here, we will take the desc argument of the array and add it to a label next to the checkbox
		$html .= '<label for="'  . $args["id"] . '">&nbsp;'  . $args["desc"] . '</label>';
		
		echo $html;
		
	} // end create_a_checkbox
	
	function create_a_text_input($args) {
		//grab placeholder if there is one
		if(isset($args["placeholder"])) {
			$placeholder_html = "placeholder=\"".$args["placeholder"]."\"";
		}	else {
			$placeholder_html = "";
		}
		//grab maxlength if there is one
		if(isset($args["maxlength"])) {
			$max_length_html = "maxlength=\"".$args["maxlength"]."\"";
		}	else {
			$max_length_html = "";
		}
		if(isset($args["default"])) {
			$default = $args["default"];
		} else {
			$default = false;
		}
		if(!isset($args["class"])){
			$args["class"] = "";
		}
		// Render the output
		echo '<input type="text" '  . $placeholder_html . $max_length_html . ' id="'  . $args["id"] . '" class="' . $args["class"]. '" name="'  . $args["id"] . '" value="' . get_option($args["id"], $default) . '" />';
		if(isset($args["desc"])) {
			echo "<p class='description'>".$args["desc"]."</p>";
		}
		

	} // end create_a_text_input
	
	function create_a_text_input_array($args) {
		//grab placeholder if there is one
		if(isset($args["placeholder"])) {
			$placeholder_html = "placeholder=\"".$args["placeholder"]."\"";
		}	else {
			$placeholder_html = "";
		}
		//grab maxlength if there is one
		if(isset($args["maxlength"])) {
			$max_length_html = "maxlength=\"".$args["maxlength"]."\"";
		}	else {
			$max_length_html = "";
		}
		if(isset($args["default"])) {
			$usevalue = $args["default"];
		}
		if(!isset($args["class"])){
			$args["class"] = "";
		}
		$key = $args["key"];
		$getarray = get_option($args["id"]);
		if(!isset($getarray[$key])){
			//$getarray[$key] = "";
			$usevalue = "";
		} else {
			$usevalue = $getarray[$key];
		}
		// Render the output
		echo '<input type="text" '  . $placeholder_html . $max_length_html . ' class="' . $args["class"]. '" name="'  . $args["id"] . '['.$key.']"   value="' . $usevalue . '" />';
		//echo '<input type="text" ' . ' name="'  . $args["id"] . '['.$key.']"   value="' . $value . '" />';
		if(isset($args["desc"])) {
			echo "<p class='description'>".$args["desc"]."</p>";
		}
		

	} // end create_a_text_input	
	
	function create_a_textarea_input($args) {
		//grab placeholder if there is one
		if($args["placeholder"]) {
			$placeholder_html = "placeholder=\"".$args["placeholder"]."\"";
		}	else {
			$placeholder_html = "";
		}
		//get default value if there is one
		if(isset($args["default"])) {
			$default = $args["default"];
		} else {
			$default = false;
		}
		// Render the output
		echo '<textarea '  . $placeholder_html . ' id="'  . $args["id"] . '"  name="'  . $args["id"] . '" rows="5" cols="50">' . get_option($args["id"], $default) . '</textarea>';
		if($args["desc"]) {
			echo "<p class='description'>".$args["desc"]."</p>";
		}		
	}
	
	function create_a_textarea_input_array($args) {
		//grab placeholder if there is one
		if($args["placeholder"]) {
			$placeholder_html = "placeholder=\"".$args["placeholder"]."\"";
		}	else {
			$placeholder_html = "";
		}
		//get default value if there is one
		if(isset($args["default"])) {
			$default = $args["default"];
		} else {
			$default = false;
		}
		if(!isset($args["class"])){
			$args["class"] = "";
		}		
		$key = $args["key"];
		$getarray = get_option($args["id"], $default);
		if(!isset($getarray[$key])){
			$getarray[$key] = "";
		}		
		// Render the output
		echo '<textarea '  . $placeholder_html . ' id="'  . $args["id"] . $args["key"] .'" class="' . $args["class"]. '" name="'  . $args["id"] . '['.$key.']" rows="5" cols="50">' . $getarray[$key] . '</textarea>';
		if($args["desc"]) {
			echo "<p class='description'>".$args["desc"]."</p>";
		}		
	}	
	
	function create_a_radio_input($args) {
	
		$radio_options = $args["radio_options"];
		$html = "";
		if($args["desc"]) {
			$html .= $args["desc"] . "<br>";
		}
		//get default value if there is one
		if(isset($args["default"])) {
			$default = $args["default"];
		} else {
			$default = false;
		}
		foreach($radio_options as $radio_option) {
			$html .= '<input type="radio" id="'  . $args["id"] . '_' . $radio_option["value"] . '" name="'  . $args["id"] . '" value="'.$radio_option["value"].'" ' . checked($radio_option["value"], get_option($args['id'], $default), false) . '/>';
			$html .= '<label for="'  . $args["id"] . '_' . $radio_option["value"] . '"> '.$radio_option["label"].'</label><br>';
		}
		
		echo $html;
	
	} // end create_a_radio_input callback

	function create_a_select_input($args) {
	
		$select_options = $args["select_options"];
		$html = "";
		//get default value if there is one
		if(isset($args["default"])) {
			$default = $args["default"];
		} else {
			$default = false;
		}
		if(isset($args["meta"])) {
			$meta = $args["meta"];
		} else {
			$meta = "";
		}
		$html .= '<select id="'  . $args["id"] . '" name="'  . $args["id"] . '" ' . $meta . '" >';
			foreach($select_options as $select_option) {
				$html .= '<option value="'.$select_option["value"].'" ' . selected( $select_option["value"], get_option($args["id"], $default), false) . '>'.$select_option["label"].'</option>';
			}
		$html .= '</select>';
		if(isset($args["desc"])) {
			$html .= "<p class='description'>".$args["desc"]."</p>";
		}		
		echo $html;
	
	} // end create_a_select_input callback
	
	function create_a_select_input_array($args) {
	
		$select_options = $args["select_options"];
		$html = "";
		//get default value if there is one
		if(isset($args["default"])) {
			$usevalue = $args["default"];
		} else {
			//$default = false;
		}
		if(isset($args["meta"])) {
			$meta = $args["meta"];
		} else {
			$meta = "";
		}
		if(!isset($args["class"])){
			$args["class"] = "";
		}		
		$key = $args["key"];
		$getarray = get_option($args["id"]);
		if(!isset($getarray[$key])){
			//$getarray[$key] = "";
		} else {
			$usevalue = $getarray[$key];	
		}
		$html .= '<select id="'  . $args["id"] . $args["key"] . '" class="' . $args["class"]. '" name="'  . $args["id"]. '['.$key.']" ' . $meta . '" >';
			foreach($select_options as $select_option) {
				$html .= '<option value="'.$select_option["value"].'" ' . selected( $select_option["value"], $usevalue, false) . '>'.$select_option["label"].'</option>';
			}
		$html .= '</select>';
		if(isset($args["desc"])) {
			$html .= "<p class='description'>".$args["desc"]."</p>";
		}		
		echo $html;
	
	} // end create_a_select_input callback	
	
    public function print_section_info(){ //section summary info goes here
		//print 'This is the where you set the password for your site.';
    }
	
    public function print_section_info_licenses(){ //section summary info goes here
		if(!has_filter('spacer_licenses_settings')) {
			_e('To activate licenses for Spacer add ons you must first install and activate the chosen add on. License settings will then appear below.', 'motech-spacer');
		}
    }		

    public function add_plugin_page(){
        // This page will be under "Settings"
		add_options_page('Settings Admin', $this->plugin_label, 'manage_options', $this->plugin_slug.'-setting-admin', array($this, 'create_admin_page'));
    }
	
	//add plugin action links logic
	function add_plugin_action_links( $links ) {
	 

		return array_merge(
			array(
				'settings' => '<a href="' . get_bloginfo( 'wpurl' ) . '/wp-admin/options-general.php?page='.$this->plugin_slug.'-setting-admin">'.__('Settings', 'motech-spacer').'</a>'
			),
			$links
		);
	 
	}
	
	function motech_imagepicker_admin_css() {
		if (isset($_GET['page']) && $_GET['page'] == $this->plugin_slug.'-setting-admin') { //if we are on our admin page
			?>
            <style>
			.motech_spacer_preview_image {    -moz-transition: all .5s ease-out;
    -o-transition: all .5s ease-out;
    transition: all .5s ease-out;}
			.spacer_preview_area_container h2 {margin-bottom:3px;}
			.addspacerunit .spacer_preview_area_container h2 {font-size:1.3em;font-weight:bold;    padding-bottom: 0px;    margin-bottom: -3px;}
			.spacer_preview_area {    min-height: 75px;    overflow: hidden;
    background: white;
    padding-left: 25px;
    padding-top: 1px;
    padding-bottom: 11px;
    padding-right: 25px;box-shadow: 0 1px 1px rgba(0,0,0,.04);    border: #e5e5e5 solid 1px;}
	.spacer_preview {-moz-transition: all .5s ease-out;-o-transition: all .5s ease-out;transition: all .5s ease-out;}
	.spacer_preview_area p {
    font-size: 15px;}
.nothinghere {text-align:center;color:#9C9C98;}
.newbutton,.removebutton,.savebutton {
    font-family: Helvetica,Verdana,sans-serif!important;
    margin: 10px;
    background: #3ba0ff;
    color:#fff;
    display:block;
    font-weight:700;
    font-size:14px;
    padding:10px;
    text-shadow:none;
    text-align: center;cursor:pointer;  -webkit-user-select: none;    -moz-user-select: none;   -ms-user-select: none;
  user-select: none;     transition: background 300ms ease-out;
}
.motech-spacer-options.general h3{
    font-size: 23px !important;
    font-weight: normal;
    padding-left: 0px;
}
.newbutton:hover{background:#1E7CD4;}
.newbutton{margin-bottom:50px;}
.removebutton{background:red;margin-top: 27px;    margin-bottom: 26px;}
.removebutton:hover{background:#a00;}
.js .postbox .handlediv {    background: transparent;
    border: 0;
    outline: 0;}
			.js .postbox .handlediv .toggle-indicator:before {
    margin-top: 4px;
    width: 20px;
    -webkit-border-radius: 50%;
    border-radius: 50%;
    text-indent: -1px;
}
.savebutton {padding: 0px;background:#45CE58;margin-top: 40px;}
.savebutton:hover {background:#39b54a;}
.savebutton button{width: 100%;
    border: 0;
    outline: 0;
    padding: 10px;
    background: none;
    cursor: pointer;
    color: white;}
.savebutton .dashicons{
    font-size: 28px;
    position: relative;
    top: -4px;
    left: -2px;
}
.js .postbox .toggle-indicator:before, .js .sidebar-name .sidebar-name-arrow:before {
    content: "\f142";
    display: inline-block;
    font: 400 20px/1 dashicons;
    speak: none;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-decoration: none!important;
}
.js .postbox.closed .handlediv .toggle-indicator:before, .js .widgets-holder-wrap.closed .sidebar-name-arrow:before {
    content: "\f140";
}
.motech_spacer_form .postbox .hndle {cursor:pointer;font-size: 14px;
    font-weight: bold;
    padding: 8px 12px;
    line-height: 1.4;
    border-bottom: 1px solid #eee;}
				.hmshidden {display:none;}
				#wpbody h3 {font-size:20px;}
				#hide_my_site_current_theme {display:none;}
				div.updated.success {background-color: rgb(169, 252, 169);border-color: rgb(85, 151, 85);}
				.mvalid {background-color: rgb(169, 252, 169);border-color: rgb(85, 151, 85);width: 127px;font-weight: bold;padding-left: 10px;border: solid 1px rgb(85, 151, 85);border-radius: 3px;}
				.motech_premium_only {color:red;}
				#green_ribbon_top {position:relative;z-index:2;}
				#green_ribbon_left {background:url(<?php echo $this->plugin_dir ?>/images/green_ribbon_left.png) no-repeat -11px 0px;width: 80px;height: 60px;float: left;}
				#green_ribbon_right {background:url(<?php echo $this->plugin_dir ?>/images/green_ribbon_right.png) no-repeat;width: 80px;height: 60px;position: absolute;top: 0px;right: -10px;}
				#green_ribbon_base {background:url(<?php echo $this->plugin_dir ?>/images/green_ribbon_base.png) repeat-x;height: 60px;margin-left: 49px;margin-right: 70px;}
				#green_ribbon_base span {display: inline-block;color: white;position: relative;top: 11px;height: 35px; line-height:33px;font-size: 17px;font-weight: bold;font-style: italic;text-shadow: 1px 3px 2px #597c2a;}
				#hms_get_premium {background: rgb(58, 80, 27);background: rgba(58, 80, 27, 0.73);cursor:pointer;padding: 0px 12px;margin-left: -17px;font-style: normal !important;margin-right: 12px;text-shadow: 1px 3px 2px #364C18 !important;}
				#hms_get_premium:hover {background:rgb(30, 43, 12);background:rgba(30, 43, 12, 0.73);text-shadow: 1px 3px 2px #21310B !important;}
				.motech_premium_box {background:url(<?php echo $this->plugin_dir ?>/images/premium_back.png); margin-left: 49px;padding-top: 29px;padding-bottom:36px;margin-right: 70px;position:relative;top:-16px;display:none;}
				.motech_premium_box_wrap {margin-left:20px; margin-right:20px;}
				.motech_premium_box h2 {text-align: center;color: #585858;font-size: 36px;text-shadow: 1px 3px 2px #acabab;}
				.motech_premium_box .updated {margin-bottom: 20px !important;margin-top: 29px !important;}
				.motech_premium_box button {background: none;border: none; position:relative;cursor: pointer;overflow: visible;}
				.motech_purchase_button .purchase_graphic {background:url(<?php echo $this->plugin_dir ?>/images/buy_sprite.png) no-repeat;height: 100px;width: 101px;background-position: -17px -24px;color: white;font-size: 22px;padding: 20px 42px;padding-top: 57px;text-shadow: 1px 1px 7px black;position: absolute;top: -80px;left: -80px;line-height:normal;font-family: 'Open Sans', sans-serif;}
				.redeem_info{margin-top:20px;display:none;}
				.motech_purchase_button.unlimited_use .purchase_graphic {width: 115px;padding: 21px 36px;padding-top: 57px;}
				.motech_purchase_button.unlimited_use .purchase_graphic span {font-weight:bold;}
				.motech_purchase_button .purchase_bubble {background: white;border-radius: 9px;width: 350px;height: 123px;margin-bottom: 5px;-webkit-transition: all .2s ease-out;  -moz-transition: all .2s ease-out;-o-transition: all .2s ease-out;transition: all .2s ease-out;}
				.motech_purchase_button:hover .purchase_bubble {  background-color: #99dcf8;box-shadow:2px 3px 2px rgba(0, 0, 0, 0.31);}
				.motech_purchase_button.three_use:hover .purchase_bubble {  background-color: #96f5e4;}
				.motech_purchase_button.unlimited_use:hover .purchase_bubble {  background-color: #f8c4c6;}
				.motech_purchase_buttons {padding-top:90px;text-align:center;}
				.motech_purchase_button {display:inline-block;margin-right: 100px;vertical-align:top;}
				.motech_purchase_button .purchase_price {font-size: 60px;color: #585858;line-height:normal;}
				.motech_purchase_button:last-child {margin-right:0px;}
				.motech_purchase_button.three_use .purchase_graphic {background-position: -208px -24px;}
				.motech_purchase_button.unlimited_use .purchase_graphic {background-position: -397px -24px;}
				.motech_premium_cancel {color:#626262;text-align:center;font-size:22px;margin-top:43px;}
				.motech_premium_cancel span:hover {cursor:pointer;text-decoration:underline;}
				.<?php echo $this->plugin_slug ?>_form > .form-table {max-width:770px;}
				

				/*css for the image picker*/
				.motech_image_picker img {border-radius: 14px;box-shadow: 0px 0px 0px 2px rgba(0, 0, 255, 0.3);}
				.motech_image_picker_wrap:hover img, .motech_image_picker_wrap:focus img {box-shadow: 0px 0px 0px 2px rgba(0, 0, 255, 0.56);}
				.motech_image_picker_wrap.current img, .motech_image_picker_wrap:active img {box-shadow: 0px 0px 0px 4px rgba(0, 0, 255, 0.9);}
				.motech_image_picker_wrap {display:inline-block;cursor: pointer;margin-right:20px;margin-bottom: 30px;}
				.motech_image_picker_wrap div {font-weight:bold;font-size:16px;margin-top:10px;color:rgba(0, 0, 0, 0.47);}
				</style>
				<?php
				if(has_filter('spacer_add_to_admincss')) {
					apply_filters('spacer_add_to_admincss','');
				}
				?>
                <style>

				/* Begin Responsive
				====================================================================== */
				@media only screen and (max-width: 1700px) {
					.motech_purchase_button .purchase_price {font-size: 42px;padding-top: 18px;}
					.motech_purchase_button .purchase_bubble {width: 252px;}
				}
				@media only screen and (max-width: 1535px) {
					.motech_purchase_button .purchase_bubble {width: 131px;padding-top: 69px;}
					.motech_purchase_button .purchase_graphic {left: -23px;}
					.motech_purchase_button {margin-right:70px;}
				}
				@media only screen and (max-width: 1255px) {
					.motechdonate {height: 55px;}
				}
				@media only screen and (max-width: 1025px) {
					.hms_get_premium_meta {display:none !important;}
				}
				@media only screen and (max-width: 980px) {
					.motech_purchase_button {display:block;margin-bottom: 80px;margin-right:0px;}
				}
				@media only screen and (max-width: 445px) {
					.motech_premium_box h2 {font-size:22px;}
				}
				@media only screen and (max-width: 380px) {
					#green_ribbon_base span {font-size: 12px;}
					#hms_get_premium {margin-right:0px;}
				}
				@media only screen and (max-width: 330px) {
					.motech_purchase_button {
						margin-left: -9px;
					}
			</style>
            
            <!--[if lt IE 9]>
                <style>
                    .motech_image_picker_wrap.current img, .motech_image_picker_wrap:active img {
                    	border: 4px solid rgb(0, 0, 255);
                        margin:-4px;
                    }
                    .motech_purchase_button {
                        display: block;
                        padding-bottom: 70px;
                        margin-right: 0px;
                    }
                    .motech_purchase_button.unlimited_use {
                    	padding-bottom: 0px;
                    }
                    .hms_get_premium_meta {display:none !important;}
                </style>
            <![endif]-->            
            <?php
		}
	}

	function po($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}
		if(is_array($input)){
			foreach($input as $val){
				if (!empty($val)) {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}				
			}
		} else {
			if (!empty($input)) {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}			
		}
		
	}
	
	function po_px($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}
		if ($input != "px") {
			add_settings_error('plk_error_id82',esc_attr('settings_updated_82'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
		}
	}
	
	function po_repeat($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}

		if(is_array($input)){
			foreach($input as $val){
				if ($val != "repeat") {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}				
			}
		} else {
			if ((!empty($input))&&($input != "repeat")) {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}			
		}

	}
	
	function po_solid($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}

		if(is_array($input)){
			foreach($input as $val){
				if ($val != "solid") {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}				
			}
		} else {
			if ((!empty($input))&&($input != "solid")) {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}			
		}

	}
	
	function po_none($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}

		if(is_array($input)){
			foreach($input as $val){
				if ($val != "none") {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}				
			}
		} else {
			if ((!empty($input))&&($input != "none")) {
						add_settings_error('plk_error_id81',esc_attr('settings_updated_81'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');		
				}			
		}

	}	
	
	function po_20($input) {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return $input;		
		}
		if ($input != "20") {
			add_settings_error('plk_error_id83',esc_attr('settings_updated_83'),__('A premium option was not saved. You must first enter your license key to unlock this premium feature.', 'motech-spacer'),'error');
		}
		return "20";
	}
	
	function get_premium_warning() {
		if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') {
			return '';
		} else {
			return '<span class="motech_premium_only"> ('.__('Premium Only', 'motech-spacer').')</span>';
		}
	}
	
	function motech_spacer_prepjsbuttons(){
		?>
		<script type="text/javascript">
	<?php
			$checkheight = get_option($this->plugin_slug . '_default_height','20');
			$checkunit = get_option($this->plugin_slug . '_default_height_unit','px');		
			$return["useheight"] = $checkheight.$checkunit;
			if($this->has_addspacers){
				$ids = $this->key_array;
				$checkaddheights = get_option($this->plugin_slug . '_default_height_addspacers');
				$checkaddheightunits = get_option($this->plugin_slug . '_default_height_unit_addspacers');
				$checktitles = get_option($this->plugin_slug . '_title_addspacers');
				foreach($ids as $key=>$value){
					$useheight = $checkaddheights[$key];
					$useunit = $checkaddheightunits[$key];
					$usetitle = $checktitles[$key];
					if(empty($usetitle)){
						$usetitle = "Untitled";
					}
					$return["addspacers"][] = array("id"=>$value,"height"=>$useheight.$useunit,"title"=>$usetitle);
				}
			}
	?>
	
			var motech_spacer_prepjsbuttons = <?php echo json_encode($return); ?>;
		</script>
		<?php
	}	
	
	function motech_imagepicker_admin_jquery() {
		if (isset($_GET['page']) && $_GET['page'] == $this->plugin_slug.'-setting-admin') { //if we are on our admin page
			?>
				<script>
					jQuery(function() {
						
						jQuery("body").on("click",".sendhook .newbutton.readysend", function() {
							buttonelement = jQuery(this);
							jQuery(this).find(".readysendlabel").html("SENDING...");
							jQuery(this).removeClass("readysend").addClass("notreadysend").css("cursor","not-allowed");
							suggestion = jQuery("textarea[name=mysuggestion]").val();
							signmeup = jQuery("input[name=signmeup]:checked").val();
							myemail = jQuery("input[name=myemail]").val();
							
							//user doesn't want to sign up for mailing list, email not sent
							if(typeof signmeup == 'undefined'){
								myemail = "";
							}

							jQuery.ajax({
							   type: "POST",
							   dataType: "json",
							   url: "http://www.justinsaad.com/suggestions/response.php",
							   data: { suggestion : suggestion, signmeup : signmeup, myemail : myemail },
							   success: function(data) { //data is the response from the php page
									 jQuery(".responsehook").text(data['response']).fadeIn('slow');
									 buttonelement.find(".readysendlabel").html("SENT!");
							   }
						   });
	
						});

						//jquery for color picker
						jQuery('tr.motech-color-field').removeClass('motech-color-field');
						
						//jquery for image picker
						jQuery(".motech_image_picker_wrap").click(function(){
							jQuery(this).closest(".motech_image_picker").find(".motech_image_picker_wrap").removeClass("current");
							jQuery(this).addClass("current");
							selectedvalue = jQuery(this).find("img").attr("alt");
							jQuery("#<?php echo $this->plugin_slug ?>_current_theme").val(selectedvalue);
						});
						jQuery("#<?php echo $this->plugin_slug ?>_current_theme").parent().parent().hide();
						<?php if (get_option($this->plugin_slug . '_ihmsa','') == 'hmsia') : ?>
							<?php
								if(get_option('hide_my_site_premium_expansion_plk','') != '') {
									$useval = get_option('hide_my_site_premium_expansion_plk','');
								} elseif(get_option($this->plugin_slug . '_plk','') != '') {
									$useval = get_option('hide_my_site_premium_expansion_plk','');
								}
							?>
							useval = '<?php echo $useval ?>';
							jQuery("#hide_my_site_plk").replaceWith("<div>"+useval+"</div>");
						<?php else : ?>
							jQuery("#hide_my_site_plk").replaceWith("<div></div>");
						<?php endif ?>
						
						jQuery("#hms_get_premium").click(function(){
							//jQuery(".motech_premium_box").slideToggle(200);
						});
						
						jQuery(".motech_premium_cancel span").click(function(){
							jQuery(".motech_premium_box").slideUp(200, function() {
    							// Animation complete.
								//jQuery("#green_ribbon").hide();
  							});
	
						});
						jQuery(".how_to_redeem").click(function(){
							jQuery(".redeem_info").slideToggle(200);
						});

						jQuery("body").on('click', '#hms_get_premium, .hms_get_premium, .buynowbutton', function(e) {
							e.preventDefault();
							jQuery("html, body").animate({ scrollTop: 0 }, 300, function() {
    							// Animation complete.
								jQuery("#green_ribbon").show();
								jQuery(".motech_premium_box").slideDown(200);
								
  							});

							//switch to different add on if set
							var addonname = jQuery(this).attr('addonname');
							console.log(addonname);
							// For some browsers, `attr` is undefined; for others, `attr` is false. Check for both.
							if (typeof addonname !== typeof undefined && addonname !== false) {
							  // Element has this attribute
							  if(addonname=="gotourl"){
								  var useurl = jQuery(this).attr('useurl');
								  window.open(useurl);
							  }else{
								  jQuery(".grwrap").hide();
								  jQuery(".grwrap."+addonname).show();
							  }
							}
								
						});


					});			
				</script>
            <?php
		}
	}


} //end class

function load_sva() {
	if( !class_exists( 'spacer_layout_aid' ) ) {
 
		include 'sva/sva.php';
 
	}
}
add_action( 'plugins_loaded', 'load_sva' );

$class = new motech_spacer();

add_action('init', array($class, 'add_custom_button'));

