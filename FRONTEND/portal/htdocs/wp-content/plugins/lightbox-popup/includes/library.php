<?php

    /*############ Settings class ################*/

class wpdevart_lightbox_setting{
	
	const databese_initial_name = 'wpdevart_lightbox';
	
	public static function get_variables(){	}
	public static function generete_iframe_by_array($params){}
	public static function generete_animation_select($select_id='',$curent_effect='none'){}

    /*############ Get option function ################*/
	
	public static function get_option($option_name,$default_value=NULL){
			$all_options=get_option(self::databese_initial_name);
			if(!is_array($all_options)) $all_options=array();
			if(isset($all_options[$option_name])){
				return $all_options[$option_name];
			}
			if(isset($default_value))
				return $default_value;
			return NULL;
	}
	
    /*############ Update options function ################*/	
	
	public static function update_option($option_name,$option_value){
		global $wpdb;
		$wpdb->show_errors();
		$all_options=get_option(self::databese_initial_name);
		if(!is_array($all_options)) $all_options=array();
		if(isset($all_options[$option_name]))
			unset($all_options[$option_name]);
		$all_options[$option_name]=$option_value;
		update_option(self::databese_initial_name,$all_options);
		unset($all_options);
	}

	/*###################### Delete options function ##################*/	
	
	public static function delete_option($option_name){
		$all_options=get_option(self::databese_initial_name);
		if(isset($all_options[$option_name])){ 
			unset($all_options[$option_name]);
			pdate_option(self::databese_initial_name,$all_options);
		}
	}

	/*###################### Generate Fonts function ##################*/
	
	public static function generete_fonts($select_id='',$curent_font='none'){
	?>
   <select class="pro_select" id="<?php echo $select_id; ?>" name="<?php echo $select_id; ?>">
   
        <option <?php selected('Arial,Helvetica Neue,Helvetica,sans-serif',$curent_font); ?> value="Arial,Helvetica Neue,Helvetica,sans-serif">Arial *</option>
        <option <?php selected('Arial Black,Arial Bold,Arial,sans-serif',$curent_font); ?> value="Arial Black,Arial Bold,Arial,sans-serif">Arial Black *</option>
        <option <?php selected('Arial Narrow,Arial,Helvetica Neue,Helvetica,sans-serif',$curent_font); ?> value="Arial Narrow,Arial,Helvetica Neue,Helvetica,sans-serif">Arial Narrow *</option>
        <option <?php selected('Courier,Verdana,sans-serif',$curent_font); ?> value="Courier,Verdana,sans-serif">Courier *</option>
        <option <?php selected('Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Georgia,Times New Roman,Times,serif">Georgia *</option>
        <option <?php selected('Times New Roman,Times,Georgia,serif',$curent_font); ?> value="Times New Roman,Times,Georgia,serif">Times New Roman *</option>
        <option <?php selected('Trebuchet MS,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Arial,sans-serif',$curent_font); ?> value="Trebuchet MS,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Arial,sans-serif">Trebuchet MS *</option>
        <option <?php selected('Verdana,sans-serif',$curent_font); ?> value="Verdana,sans-serif">Verdana *</option>
        <option <?php selected('American Typewriter,Georgia,serif',$curent_font); ?> value="American Typewriter,Georgia,serif">American Typewriter</option>
        <option <?php selected('Andale Mono,Consolas,Monaco,Courier,Courier New,Verdana,sans-serif',$curent_font); ?> value="Andale Mono,Consolas,Monaco,Courier,Courier New,Verdana,sans-serif">Andale Mono</option>
        <option <?php selected('Baskerville,Times New Roman,Times,serif',$curent_font); ?> value="Baskerville,Times New Roman,Times,serif">Baskerville</option>
        <option <?php selected('Bookman Old Style,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Bookman Old Style,Georgia,Times New Roman,Times,serif">Bookman Old Style</option>
        <option <?php selected('Calibri,Helvetica Neue,Helvetica,Arial,Verdana,sans-serif',$curent_font); ?> value="Calibri,Helvetica Neue,Helvetica,Arial,Verdana,sans-serif">Calibri</option>
        <option <?php selected('Cambria,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Cambria,Georgia,Times New Roman,Times,serif">Cambria</option>
        <option <?php selected('Candara,Verdana,sans-serif',$curent_font); ?> value="Candara,Verdana,sans-serif">Candara</option>
        <option <?php selected('Century Gothic,Apple Gothic,Verdana,sans-serif',$curent_font); ?> value="Century Gothic,Apple Gothic,Verdana,sans-serif">Century Gothic</option>
        <option <?php selected('Century Schoolbook,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Century Schoolbook,Georgia,Times New Roman,Times,serif">Century Schoolbook</option>
        <option <?php selected('Consolas,Andale Mono,Monaco,Courier,Courier New,Verdana,sans-serif',$curent_font); ?> value="Consolas,Andale Mono,Monaco,Courier,Courier New,Verdana,sans-serif">Consolas</option>
        <option <?php selected('Constantia,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Constantia,Georgia,Times New Roman,Times,serif">Constantia</option>
        <option <?php selected('Corbel,Lucida Grande,Lucida Sans Unicode,Arial,sans-serif',$curent_font); ?> value="Corbel,Lucida Grande,Lucida Sans Unicode,Arial,sans-serif">Corbel</option>
        <option <?php selected('Franklin Gothic Medium,Arial,sans-serif',$curent_font); ?> value="Franklin Gothic Medium,Arial,sans-serif">Franklin Gothic Medium</option>
        <option <?php selected('Garamond,Hoefler Text,Times New Roman,Times,serif',$curent_font); ?> value="Garamond,Hoefler Text,Times New Roman,Times,serif">Garamond</option>
        <option <?php selected('Gill Sans MT,Gill Sans,Calibri,Trebuchet MS,sans-serif',$curent_font); ?> value="Gill Sans MT,Gill Sans,Calibri,Trebuchet MS,sans-serif">Gill Sans MT</option>
        <option <?php selected('Helvetica Neue,Helvetica,Arial,sans-serif',$curent_font); ?> value="Helvetica Neue,Helvetica,Arial,sans-serif">Helvetica Neue</option>
        <option <?php selected('Hoefler Text,Garamond,Times New Roman,Times,sans-serif',$curent_font); ?> value="Hoefler Text,Garamond,Times New Roman,Times,sans-serif">Hoefler Text</option>
        <option <?php selected('Lucida Bright,Cambria,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Lucida Bright,Cambria,Georgia,Times New Roman,Times,serif">Lucida Bright</option>
        <option <?php selected('Lucida Grande,Lucida Sans,Lucida Sans Unicode,sans-serif',$curent_font); ?> value="Lucida Grande,Lucida Sans,Lucida Sans Unicode,sans-serif">Lucida Grande</option>
        <option <?php selected('monospace',$curent_font); ?> value="monospace">monospace</option>
        <option <?php selected('Palatino Linotype,Palatino,Georgia,Times New Roman,Times,serif',$curent_font); ?> value="Palatino Linotype,Palatino,Georgia,Times New Roman,Times,serif">Palatino Linotype</option>
        <option <?php selected('Tahoma,Geneva,Verdana,sans-serif',$curent_font); ?> value="Tahoma,Geneva,Verdana,sans-serif">Tahoma</option>
        <option <?php selected('Rockwell, Arial Black, Arial Bold, Arial, sans-serif',$curent_font); ?> value="Rockwell, Arial Black, Arial Bold, Arial, sans-serif">Rockwell</option>
    </select>
    <?php

	}
	
	
}

 ?>