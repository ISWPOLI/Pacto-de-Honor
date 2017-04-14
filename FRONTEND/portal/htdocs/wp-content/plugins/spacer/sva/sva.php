<?php

$sva_plugin_label = "Spacer - Visual Artist";
$sva_plugin_slug = "spacer_layout_aid_preview";
	
class spacer_layout_aid_preview {
	
    public function __construct(){
    	
		global $sva_plugin_label, $plugin_slug;
		$this->sva_plugin_slug = $plugin_slug;
		$this->sva_plugin_label = $sva_plugin_label;
		
		$checkaddspacers = get_option("motech_spacer_addspacer_id");
		if(!empty($checkaddspacers)){
			$this->key_array = $checkaddspacers;
			$this->has_addspacers = true;
		}else{
			$this->key_array = array(0);
			$this->has_addspacers = false;
		}
		
		$this->ihmsa = 'hmsia';
	

		
		//uncomment the following line to enqueue color picker
		//add_action( 'admin_enqueue_scripts', array($this, 'enqueue_color_picker') );
		
		//uncomment following line to add extra plugin row links under plugin description
		//add_filter( 'plugin_row_meta', array($this,'plugin_row_links'), 10, 2 );
		
		add_filter('spacer_add_css', array($this,'spacer_add_css'),50,2);
		
		add_filter('spacer_add_to_default', array($this,'spacer_add_to_default'),50);
		add_filter('spacer_add_to_extras', array($this,'spacer_add_to_extras'),50,2);
		
        if(is_admin()){
			
			//uncomment following line to add Settings link to plugin page
			//add_filter( 'plugin_action_links_' . plugin_basename( __FILE__ ), array($this, 'add_plugin_action_links') );

			//uncomment following line to add admin notices
			//add_action( 'admin_notices', array($this, 'admin_notices') );
			
		    //add_action('admin_menu', array($this, 'add_plugin_page'));
		    //add_action('admin_init', array($this, 'page_init'));
			//add_filter('spacer_licenses_settings', array($this,'add_layout_licenses_section'),50,2);
			
			add_action( 'admin_enqueue_scripts', array($this, 'enqueue_motech_javascript'), 10 ); //enqueue color picker. set this to a number lower than 50, so it will load before spacer javascript.
			add_filter('spacer_default_settings', array($this,'add_layout_aid_section'),50,2);
			if($this->ihmsa == 'hmsia'){	
				add_filter('spacer_default_sections', array($this,'add_layout_aid_section_container'),50,2);
			}
			add_filter('spacer_add_to_admincss', array($this,'spacer_add_to_admincss'),50);
			if($this->ihmsa == 'hmsia'){
				add_action( 'admin_enqueue_scripts', array($this,'load_custom_wp_admin_style'), 60 );  //set this to a number higher than 50, so it will load after spacer core
			}
			$key_array = $this->key_array;
			$getoption = get_option($this->sva_plugin_slug.'_title_addspacers','');
			if($this->ihmsa == 'hmsia'){			
						foreach($key_array as $key=>$value){
							add_filter('spacer_addspacer_sections'.$key, array($this,'add_layout_aid_addspacer_section_container'),50,2);
						}
			}
		}
		
    }	

	function load_custom_wp_admin_style() {
		
			//wp_register_style( 'mspacerlayout_wp_admin_css', plugins_url( 'admin-style.css' , __FILE__ ), false, '1.0.0' );
			//wp_enqueue_style( 'mspacerlayout_wp_admin_css' );
	}

	function spacer_add_to_admincss($val){
		?>
		<style>
		<?php if ($this->ihmsa == 'hmsia') { ?>  #motech_spacer_visualartist_license{display:none;} <?php } ?>
                    /*css for column box - move to add on css via hook instead */
                    .columnbox {    background: #fff;
        padding: 0 8px;
        margin-bottom: 9px;
        outline: 0;
        margin: 10px 0 0;
        border: 1px solid #e5e5e5;
        -webkit-box-shadow: 0 1px 1px rgba(0,0,0,.04);
        box-shadow: 0 1px 1px rgba(0,0,0,.04);    float: left;    width: 21%;margin-right:16px;overflow:hidden;}
        
        .columnbox h2,.postbox .inside .columnbox h2 {
        background: #fafafa;
        color: #23282d;
        margin: 0;
        padding: 15px;
        font-size: 1em;
        line-height: 1;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        padding-left: 9px;
        margin-left: -10px;
        border-bottom: 1px solid #e5e5e5;
        margin-right: -10px;
        font-weight:600;
        }
        
        .columnbox .form-table th {font-weight: normal; }
        .columnbox .form-table td { padding-left: 0px;}
        .addspacerunit .columnbox {    background: #fafafa;}
        .addspacerunit .columnbox h2, .addspacerunit .postbox .inside .columnbox h2 {background:white;}
        .motech_spacer_preview_image_container {display:none;}
        .wp-picker-holder {position:absolute;}
        
                    @media only screen and (max-width: 1370px) {
                        .columnbox input[type="text"], .columnbox select {max-width:50%;}
						.columnbox {width:auto;float:none;margin-right:0px;}
                    }	
                    
                    @media only screen and (max-width: 1050px) {
                        .columnbox {width:auto;float:none;margin-right:0px;}
                    }
        </style>
        <?php
	}

	function spacer_add_to_default($return) {
		//return is an array like $return["checkheight"], we want to add elements to it
		$return["bgcolor"] = get_option('motech_spacer_default_bg_color');
		$return["bgimage"] = get_option('motech_spacer_default_background_image_upload');	
		$return["bordertopwidth"] = get_option('motech_spacer_default_border_top_width');
		$return["bordertopstyle"] = get_option('motech_spacer_default_border_top_style');
		$return["bordertopcolor"] = get_option('motech_spacer_default_border_top_color');
		$return["borderbottomwidth"] = get_option('motech_spacer_default_border_bottom_width');
		$return["borderbottomstyle"] = get_option('motech_spacer_default_border_bottom_style');
		$return["borderbottomcolor"] = get_option('motech_spacer_default_border_bottom_color');
		$return["bottommargin"] = get_option('motech_spacer_default_bottom_margin');
		$return["shadow"] = get_option('motech_spacer_default_shadow');
		$return["bgimageposition"] = get_option('motech_spacer_custom_background_image_position');
		
		//$spacer_css .= "background:red;";
		return $return;
	}
	
	function spacer_add_to_extras($return,$key) {
		$get = get_option('motech_spacer_default_bg_color_addspacers');
		$return["bgcolor"] = $get[$key];
		
		$get = get_option('motech_spacer_default_background_image_upload_addspacers');
		$return["bgimage"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_top_width_addspacers');
		$return["bordertopwidth"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_top_style_addspacers');
		$return["bordertopstyle"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_top_color_addspacers');
		$return["bordertopcolor"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_bottom_width_addspacers');
		$return["borderbottomwidth"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_bottom_style_addspacers');
		$return["borderbottomstyle"] = $get[$key];
		
		$get = get_option('motech_spacer_default_border_bottom_color_addspacers');
		$return["borderbottomcolor"] = $get[$key];
		
		$get = get_option('motech_spacer_default_bottom_margin_addspacers');
		$return["bottommargin"] = $get[$key];
		
		$get = get_option('motech_spacer_default_shadow_addspacers');
		$return["shadow"] = $get[$key];
		
		$get = get_option('motech_spacer_custom_background_image_position_addspacers');
		$return["bgimageposition"] = $get[$key];
		
		//$spacer_css .= "background:red;";
		return $return;
	}	


	function use_shadow($shadow){
		if($shadow=="light"){
			return "box-shadow:0px 2px 3px rgba(119, 119, 119,0.5);";
		}elseif($shadow=="medium"){
			return "box-shadow:0px 2px 4px #777;";
		}elseif($shadow=="heavy"){
			return "box-shadow:0px 2px 10px #888;";
		}
	
	}
	
	function use_bgimageposition($bgimageposition){
		if($bgimageposition=="repeat"){
			return "background-repeat:repeat;";
		}elseif($bgimageposition=="croptofit"){
			return "background-size:cover;background-position:center;";
		}elseif($bgimageposition=="stretch"){
			return "background-size:100% 100%;background-repeat:no-repeat;background-position:center;";
		}elseif($bgimageposition=="propstretch"){
			return "background-size:contain;background-repeat:no-repeat;background-position:center;";
		}elseif($bgimageposition=="proprepeat"){
			return "background-size:contain;background-repeat:repeat;background-position:center;";
		}
	
	}
	
	function spacer_add_css($spacer_css,$activespacer) {

		extract($activespacer);
		
		if(!empty($bgcolor)) {
			$spacer_css .= "background-color:".$bgcolor.";";
		}
		if(!empty($bgimage)) {
			$spacer_css .= "background-image:url(".$bgimage.");";
		}
		if(!empty($bordertopstyle)) {
			$spacer_css .= "border-top-style:".$bordertopstyle.";";
		}
		if(!empty($bordertopwidth)) {
			$spacer_css .= "border-top-width:".$bordertopwidth."px;";
		} else{
			$spacer_css .= "border-top-width:0px;";
		}
		if(!empty($bordertopcolor)) {
			$spacer_css .= "border-top-color:".$bordertopcolor.";";
		}
		if(!empty($borderbottomwidth)) {
			$spacer_css .= "border-bottom-width:".$borderbottomwidth."px;";
		}else{
			$spacer_css .= "border-bottom-width:0px;";
		}
		if(!empty($borderbottomstyle)) {
			$spacer_css .= "border-bottom-style:".$borderbottomstyle.";";
		}
		if(!empty($borderbottomcolor)) {
			$spacer_css .= "border-bottom-color:".$borderbottomcolor.";";
		}
		if(!empty($bottommargin)) {
			$spacer_css .= "margin-bottom:".$bottommargin."px;";
		}
		if(!empty($shadow)) {
			$spacer_css .= $this->use_shadow($shadow);
		}
		if(!empty($bgimageposition)) {
			$spacer_css .= $this->use_bgimageposition($bgimageposition);
		}
		
		//imaqe position
		
		return $spacer_css;
	}

	function enqueue_motech_javascript( ) {
		if (isset($_GET['page']) && $_GET['page'] == 'motech_spacer-setting-admin') {
			wp_enqueue_script( $this->sva_plugin_slug.'-motech-javascript2', plugins_url('js/motech-javascript.js', __FILE__ ), array('jquery'), false, true );
		}
	}		
		

	function add_layout_aid_section_container($val,$object){
	?>
		<div class="motech-spacer-options section layoutaid" style="border-top: solid 1px #BFBFBF;margin-top: 3px;">
        	<div class="postbox closed" style="margin-top:20px;margin-bottom:12px;">
            	<button type="button" class="handlediv button-link" aria-expanded="true"><span class="toggle-indicator" aria-hidden="true"></span></button>
                <h2 class="hndle ui-sortable-handle" style="font-size: 1.3em;font-weight: bold;padding-left: 51px;position: relative;"><img style="position: absolute;top: -1px;width: 42px;left: 7px;" src="<?php echo plugins_url('images/palette.png', __FILE__ ) ?>" /><span><?php _e('Visual Artist', 'spacer-layout-aid') ?><?php echo $object->get_premium_warning() ?></span></h2>
                <div class="inside">
                    <div class="columnbox"><h2><?php _e('Background', 'spacer-layout-aid') ?></h2><?php do_settings_sections($object->plugin_slug.'-setting-admin_layoutaidbg'); ?></div>
                    <div class="columnbox"><h2><?php _e('Top Border', 'spacer-layout-aid') ?></h2><?php do_settings_sections($object->plugin_slug.'-setting-admin_layoutaidtb'); ?></div>
                    <div class="columnbox"><h2><?php _e('Bottom Border', 'spacer-layout-aid') ?></h2><?php do_settings_sections($object->plugin_slug.'-setting-admin_layoutaidbb'); ?></div>
                    <div class="columnbox" style="margin-right:0px;"><h2><?php _e('Other', 'spacer-layout-aid') ?></h2><?php do_settings_sections($object->plugin_slug.'-setting-admin_layoutaidother'); ?></div>
                    <div style="clear:both;"></div>
                </div>
            </div>
		</div>
	<?php
	}
	
	function add_layout_aid_addspacer_section_container($val,$key){
	?>
		<div class="motech-spacer-options section layoutaid aslayoutaid" style="border-top: solid 1px #eee;margin-top: 3px;">
			<?php /*?><?php do_settings_sections('motech_spacer-setting-admin_layoutaid_addspacer'.$key); ?><?php */?>
        	<div class="postbox closed" style="margin-top:20px;margin-bottom:12px;background: #fafafa;">
            	<button type="button" class="handlediv button-link" aria-expanded="true"><span class="toggle-indicator" aria-hidden="true"></span></button>
                <h2 class="hndle ui-sortable-handle" style="font-size: 1.3em;font-weight: bold;padding-left: 51px;position: relative;"><img style="position: absolute;top: -1px;width: 42px;left: 7px;" src="<?php echo plugins_url('images/palette.png', __FILE__ ) ?>" /><span><?php _e('Visual Artist', 'spacer-layout-aid') ?><?php echo '<span class="motech_premium_only"> ('.__('Premium Only', 'motech-spacer').')</span>'?></span></h2>
                <div class="inside">
                    <div class="columnbox"><h2><?php _e('Background', 'spacer-layout-aid') ?></h2><?php do_settings_sections('motech_spacer-setting-admin_layoutaidbg_addspacer'.$key); ?></div>
                    <div class="columnbox"><h2><?php _e('Top Border', 'spacer-layout-aid') ?></h2><?php do_settings_sections('motech_spacer-setting-admin_layoutaidtb_addspacer'.$key); ?></div>
                    <div class="columnbox"><h2><?php _e('Bottom Border', 'spacer-layout-aid') ?></h2><?php do_settings_sections('motech_spacer-setting-admin_layoutaidbb_addspacer'.$key); ?></div>
                    <div class="columnbox" style="margin-right:0px;"><h2><?php _e('Other', 'spacer-layout-aid') ?></h2><?php do_settings_sections('motech_spacer-setting-admin_layoutaidother_addspacer'.$key); ?></div>
                    <div style="clear:both;"></div>
                </div>
            </div>            
		</div>
	<?php
	}



	function add_layout_licenses_section($val,$object){
		//update_option('motech_spacer_visualartist_license','');
		//update_option('motech_spacer_visualartist_ihmsa','');
		//add text input field
		$field_slug = "visualartist_license";
		$field_label = __('Visual Artist Key', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		//register_setting($object->plugin_slug.'_option_group', $field_id);
		register_setting($object->plugin_slug.'_option_group', $field_id, array($this, 'license_v'));
		if ($this->ihmsa == 'hmsia') {
			$desc = "<div class='mvalid'>".__('Valid', 'spacer-layout-aid')."</div>";
		} else {
			//$desc = "Enter your license key to unlock premium features. <a href='#' class='hms_validate_alt'>Alernative Method</a>";
			$desc = __("You will find this included with your purchase email. If this doesn't work, try the <a href='#' class='motech_spacer_visualartist_validate_alt'>Alternative Method</a>", "spacer-layout-aid");
		}		
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_licenses',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
				//"placeholder" => __('5', 'spacer-layout-aid'),
				"desc" => $desc,
				"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);		
	}

	function add_layout_aid_section($val,$object){
		
        add_settings_section( 
	    $object->plugin_slug.'_setting_section',
	    __('', 'spacer-layout-aid'),
	    false,
	    $object->plugin_slug.'-setting-admin_layoutaidbg'
		);
		
		add_settings_section(
	    $object->plugin_slug.'_setting_section',
	    __('', 'spacer-layout-aid'),
	    false,
	    $object->plugin_slug.'-setting-admin_layoutaidtb'
		);
		
		add_settings_section(
	    $object->plugin_slug.'_setting_section',
	    __('', 'spacer-layout-aid'),
	    false,
	    $object->plugin_slug.'-setting-admin_layoutaidbb'
		);
		
		add_settings_section(
	    $object->plugin_slug.'_setting_section',
	    __('', 'spacer-layout-aid'),
	    false,
	    $object->plugin_slug.'-setting-admin_layoutaidother'
		);
		
		//add color picker text input field
		$field_slug = "default_bg_color";
		$field_label = __('Color', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidbg',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
				"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
			)			
		);
		
		//add image upload field
		$field_slug = "default_background_image_upload";
		$field_label = "Image";
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		  $field_id,            // ID of the option
		  $field_label,                      // Title of the option
		  array($object, 'create_image_upload'),  // Callback used to render the input field
		  $object->plugin_slug.'-setting-admin_layoutaidbg',               // Page to associate this option with
		  $object->plugin_slug.'_setting_section',       // Section to associate this option with
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id //sends field id to callback
			)
		);

		//add an image select input field
		$field_slug = "custom_background_image_position";
		$field_label = "Image Position";
		$field_id = $object->plugin_slug.'_'.$field_slug;
		$object->back_options = array(
								array("label" => "Repeat", "value" => "repeat"),
								array("label" => "Proportional Stretch", "value" => "propstretch"),
								array("label" => "Proportional Repeat", "value" => "proprepeat"),
								array("label" => "Crop to Fit", "value" => "croptofit"),
								array("label" => "Stretch", "value" => "stretch")
		);
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_repeat'));
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($object, 'create_a_select_input'), //callback function for select input
		    $object->plugin_slug.'-setting-admin_layoutaidbg',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'repeat', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"select_options" => $object->back_options //sets select option data
			)				
		);	
		
		//add text input field
		$field_slug = "default_border_top_width";
		$field_label = __('Width (px)', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidtb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: 5', 'spacer-layout-aid'),
				"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);
		
		//add a select input field
		$field_slug = "default_border_top_style";
		$field_label = __('Style', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		$object->unit_options = array(
								array("label" => "Solid", "value" => "solid"),
								array("label" => "Dotted", "value" => "dotted"),
								array("label" => "Dashed", "value" => "dashed"),
								array("label" => "Double", "value" => "double"),
								array("label" => "Groove", "value" => "groove"),
								array("label" => "Inset", "value" => "inset"),
								array("label" => "Outset", "value" => "outset"),
		);
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_solid'));
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($object, 'create_a_select_input'), //callback function for select input
		    $object->plugin_slug.'-setting-admin_layoutaidtb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"meta" => 'style="max-width:450px;"',
				"select_options" => $object->unit_options //sets select option data
			)				
		);
		
		//add color picker text input field
		$field_slug = "default_border_top_color";
		$field_label = __('Color', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidtb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
				"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
			)			
		);
		
		//add text input field
		$field_slug = "default_border_bottom_width";
		$field_label = __('Width (px)', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidbb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: 5', 'spacer-layout-aid'),
				"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);
		
		//add a select input field
		$field_slug = "default_border_bottom_style";
		$field_label = __('Style', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		$object->unit_options = array(
								array("label" => "Solid", "value" => "solid"),
								array("label" => "Dotted", "value" => "dotted"),
								array("label" => "Dashed", "value" => "dashed"),
								array("label" => "Double", "value" => "double"),
								array("label" => "Groove", "value" => "groove"),
								array("label" => "Inset", "value" => "inset"),
								array("label" => "Outset", "value" => "outset"),
		);
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_solid'));
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($object, 'create_a_select_input'), //callback function for select input
		    $object->plugin_slug.'-setting-admin_layoutaidbb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"meta" => 'style="max-width:450px;"',
				"select_options" => $object->unit_options //sets select option data
			)				
		);
		
		//add color picker text input field
		$field_slug = "default_border_bottom_color";
		$field_label = __('Color', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidbb',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
				"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
			)			
		);
		
		//add text input field
		$field_slug = "default_bottom_margin";
		$field_label = __('Bottom Margin (px)', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
		add_settings_field(
		    $field_id,
		    $field_label, 
		    array($object, 'create_a_text_input'), //callback function for text input
		    $object->plugin_slug.'-setting-admin_layoutaidother',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends field id to callback
				//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
				"placeholder" => __('eg: 5', 'spacer-layout-aid'),
				"default" => '' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
			)			
		);
		
		//add a select input field
		$field_slug = "default_shadow";
		$field_label = __('Shadow', 'spacer-layout-aid');
		$field_id = $object->plugin_slug.'_'.$field_slug;
		$object->unit_options = array(
								array("label" => "None", "value" => "none"),
								array("label" => "Light", "value" => "light"),
								array("label" => "Medium", "value" => "medium"),
								array("label" => "Heavy", "value" => "heavy")
		);
		register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_none'));
		add_settings_field(	
			$field_id,						
			$field_label,							
			array($object, 'create_a_select_input'), //callback function for select input
		    $object->plugin_slug.'-setting-admin_layoutaidother',
		    $object->plugin_slug.'_setting_section',
		    array(								// The array of arguments to pass to the callback.
				"id" => $field_id, //sends select field id to callback
				"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				"meta" => 'style="max-width:450px;"',
				"select_options" => $object->unit_options //sets select option data
			)				
		);
		
		
		
		//BEGIN ADD SPACER LAYOUT FIELDS
		
		$key_array = $object->key_array;
		foreach($key_array as $key=>$value){
			add_settings_section(
			$object->plugin_slug.'_setting_section',
			__('', 'spacer-layout-aid'),
			false,
			$object->plugin_slug.'-setting-admin_layoutaidbg_addspacer'.$key
			);	
			
			add_settings_section(
			$object->plugin_slug.'_setting_section',
			__('', 'spacer-layout-aid'),
			false,
			$object->plugin_slug.'-setting-admin_layoutaidtb_addspacer'.$key
			);
			
			add_settings_section(
			$object->plugin_slug.'_setting_section',
			__('', 'spacer-layout-aid'),
			false,
			$object->plugin_slug.'-setting-admin_layoutaidbb_addspacer'.$key
			);
			
			add_settings_section(
			$object->plugin_slug.'_setting_section',
			__('', 'spacer-layout-aid'),
			false,
			$object->plugin_slug.'-setting-admin_layoutaidother_addspacer'.$key
			);			

			//add color picker text input field
			$field_slug = "default_bg_color_addspacers";
			$field_label = __('Color', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidbg_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
					"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"key" => $key,
					"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
				)			
			);
			
			//add image upload field
			$field_slug = "default_background_image_upload_addspacers";
			$field_label = "Image";
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
			  $field_id,            // ID of the option
			  $field_label,                      // Title of the option
			  array($object, 'create_image_upload_array'),  // Callback used to render the input field
			  $object->plugin_slug.'-setting-admin_layoutaidbg_addspacer'.$key,               // Page to associate this option with
			  $object->plugin_slug.'_setting_section',       // Section to associate this option with
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					"key" => $key
				)
			);
	
			//add an image select input field
			$field_slug = "custom_background_image_position_addspacers";
			$field_label = "Image Position";
			$field_id = $object->plugin_slug.'_'.$field_slug;
			$object->back_options = array(
									array("label" => "Repeat", "value" => "repeat"),
									array("label" => "Proportional Stretch", "value" => "propstretch"),
									array("label" => "Proportional Repeat", "value" => "proprepeat"),
									array("label" => "Crop to Fit", "value" => "croptofit"),
									array("label" => "Stretch", "value" => "stretch")
			);
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_repeat'));
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($object, 'create_a_select_input_array'), //callback function for select input
				$object->plugin_slug.'-setting-admin_layoutaidbg_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'repeat', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"key" => $key,
					"select_options" => $object->back_options //sets select option data
				)				
			);	
			
			//add text input field
			$field_slug = "default_border_top_width_addspacers";
			$field_label = __('Width (px)', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidtb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
					"placeholder" => __('eg: 5', 'spacer-layout-aid'),
					"key" => $key,
					"default" => '0' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)			
			);
			
			//add a select input field
			$field_slug = "default_border_top_style_addspacers";
			$field_label = __('Style', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			$object->unit_options = array(
									array("label" => "Solid", "value" => "solid"),
									array("label" => "Dotted", "value" => "dotted"),
									array("label" => "Dashed", "value" => "dashed"),
									array("label" => "Double", "value" => "double"),
									array("label" => "Groove", "value" => "groove"),
									array("label" => "Inset", "value" => "inset"),
									array("label" => "Outset", "value" => "outset"),
			);
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_solid'));
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($object, 'create_a_select_input_array'), //callback function for select input
				$object->plugin_slug.'-setting-admin_layoutaidtb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"meta" => 'style="max-width:450px;"',
					"key" => $key,
					"select_options" => $object->unit_options //sets select option data
				)				
			);
			
			//add color picker text input field
			$field_slug = "default_border_top_color_addspacers";
			$field_label = __('Color', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidtb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
					"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"key" => $key,
					"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
				)			
			);
			
			//add text input field
			$field_slug = "default_border_bottom_width_addspacers";
			$field_label = __('Width (px)', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidbb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
					"placeholder" => __('eg: 5', 'spacer-layout-aid'),
					"key" => $key,
					"default" => '0' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)			
			);
			
			//add a select input field
			$field_slug = "default_border_bottom_style_addspacers";
			$field_label = __('Style', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			$object->unit_options = array(
									array("label" => "Solid", "value" => "solid"),
									array("label" => "Dotted", "value" => "dotted"),
									array("label" => "Dashed", "value" => "dashed"),
									array("label" => "Double", "value" => "double"),
									array("label" => "Groove", "value" => "groove"),
									array("label" => "Inset", "value" => "inset"),
									array("label" => "Outset", "value" => "outset"),
			);
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_solid'));
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($object, 'create_a_select_input_array'), //callback function for select input
				$object->plugin_slug.'-setting-admin_layoutaidbb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"meta" => 'style="max-width:450px;"',
					"key" => $key,
					"select_options" => $object->unit_options //sets select option data
				)				
			);
			
			//add color picker text input field
			$field_slug = "default_border_bottom_color_addspacers";
			$field_label = __('Color', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidbb_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => 'Choose a background color to appear behind your custom image. If left empty, default background color will be used', //description of the field (optional)
					"default" => '', //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"key" => $key,
					"class" => "motech-color-field" //designate this as color field. remember to uncomment js enqueue in class construct
				)			
			);
			
			//add text input field
			$field_slug = "default_bottom_margin_addspacers";
			$field_label = __('Bottom Margin (px)', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po'));
			add_settings_field(
				$field_id,
				$field_label, 
				array($object, 'create_a_text_input_array'), //callback function for text input
				$object->plugin_slug.'-setting-admin_layoutaidother_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends field id to callback
					//"desc" => __('Speed up your workflow by setting a default height to apply to your spacers. Note that you can also enter negative spacing to shift the following content upwards.', 'motech-spacer'), //description of the field (optional)
					"placeholder" => __('eg: 5', 'spacer-layout-aid'),
					"key" => $key,
					"default" => '0' //sets the default field value (optional), when grabbing this option value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
				)			
			);
			
			//add a select input field
			$field_slug = "default_shadow_addspacers";
			$field_label = __('Shadow', 'spacer-layout-aid');
			$field_id = $object->plugin_slug.'_'.$field_slug;
			$object->unit_options = array(
									array("label" => "None", "value" => "none"),
									array("label" => "Light", "value" => "light"),
									array("label" => "Medium", "value" => "medium"),
									array("label" => "Heavy", "value" => "heavy")
			);
			register_setting($object->plugin_slug.'_option_group', $field_id, array($object, 'po_none'));
			add_settings_field(	
				$field_id,						
				$field_label,							
				array($object, 'create_a_select_input_array'), //callback function for select input
				$object->plugin_slug.'-setting-admin_layoutaidother_addspacer'.$key,
				$object->plugin_slug.'_setting_section',
				array(								// The array of arguments to pass to the callback.
					"id" => $field_id, //sends select field id to callback
					"default" => 'solid', //sets the default field value (optional), when grabbing this field value later on remember to use get_option(option_name, default_value) so it will return default value if no value exists yet
					"meta" => 'style="max-width:450px;"',
					"key" => $key,
					"select_options" => $object->unit_options //sets select option data
				)				
			);
		
		}
		
	}
	


	
	//add plugin action links logic
	function add_plugin_action_links( $links ) {
	 
		return array_merge(
			array(
				'settings' => '<a href="' . get_bloginfo( 'wpurl' ) . '/wp-admin/options-general.php?page='.$this->sva_plugin_slug.'-setting-admin">Settings</a>'
			),
			$links
		);
	 
	}
	
	public function plugin_row_links($links, $file) {
		$plugin = plugin_basename(__FILE__); 
		if ($file == $plugin) // only for this plugin
				return array_merge( $links,
			array( '<a target="_blank" href="http://www.linkedin.com/in/ClevelandWebDeveloper/">' . __('Find me on LinkedIn' ) . '</a>' ),
			array( '<a target="_blank" href="http://twitter.com/ClevelandWebDev">' . __('Follow me on Twitter') . '</a>' )
		);
		return $links;
	}
	
} //end of plugin class

$custom_plugin = new $sva_plugin_slug();