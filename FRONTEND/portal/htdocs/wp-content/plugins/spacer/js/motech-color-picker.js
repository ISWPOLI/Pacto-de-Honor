jQuery(document).ready(function($){
    jQuery('.motech-color-field').wpColorPicker({
		change: function(event, ui) {
			if($(event.target).attr("name").indexOf("motech_spacer_default_bg_color") >= 0){
				$(event.target).closest(".aspacerunit").find(".spacer_preview").css('background-color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_default_border_top_color") >= 0){
				$(event.target).closest(".aspacerunit").find(".spacer_preview").css('border-top-color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_default_border_bottom_color") >= 0){
				$(event.target).closest(".aspacerunit").find(".spacer_preview").css('border-bottom-color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_linecolor_addheaders") >= 0){
				spacerElement = $(event.target).closest(".aheaderunit");
				headerid = spacerElement.find("input[type=text].addheader_id").val();
				spacerElement.find(".lineonsides_style_hook").append("<style>.spacer_lineonsides.spacer_lineonsides_"+headerid+":before,.spacer_lineonsides.spacer_lineonsides_"+headerid+":after {border-top-color:"+ui.color.toString()+";}</style>");				
			}else if($(event.target).attr("name").indexOf("motech_spacer_panelbgcolor_addpanels") >= 0){
				spacerElement = $(event.target).closest(".apanelunit");
				$(event.target).closest(".apanelunit").find(".spacer_panel").css('background-color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_paneltxtcolor_addpanels") >= 0){
				spacerElement = $(event.target).closest(".apanelunit");
				$(event.target).closest(".apanelunit").find(".spacer_panel").css('color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_panelbordercolor_addpanels") >= 0){
				spacerElement = $(event.target).closest(".apanelunit");
				$(event.target).closest(".apanelunit").find(".spacer_panel").css('border-color',ui.color.toString());
				$(event.target).closest(".apanelunit").find(".spacer_panel_heading").css('background-color',ui.color.toString());
			}else if($(event.target).attr("name").indexOf("motech_spacer_panelheadingtextcolor_addpanels") >= 0){
				spacerElement = $(event.target).closest(".apanelunit");
				$(event.target).closest(".apanelunit").find(".spacer_panel_heading").css('color',ui.color.toString());
			}
		}
	});
});