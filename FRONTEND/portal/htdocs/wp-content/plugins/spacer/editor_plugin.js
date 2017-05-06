(function() {
	var msdata = motech_spacer_prepjsbuttons;
    tinymce.PluginManager.add('motech_spacer', function( editor, url ) {
		var menu_array = [];
		
		menu_array.push({
				text:"Default",
				value:'[spacer height="'+msdata["useheight"]+'"]',
				onclick:function() {
									 editor.insertContent(this.value());
								}
		});
		
		if(msdata.hasOwnProperty("addspacers")){
		var index;
			for	(index = 0; index < msdata["addspacers"].length; index++) {
			
				useval = msdata["addspacers"][index]["height"];
				useid = msdata["addspacers"][index]["id"];
				menu_array.push({text:msdata["addspacers"][index]["title"],value:'[spacer height="'+useval+'" id="'+useid+'"]',onclick : function(){
																						editor.insertContent(this.value());
																					}});
			}
		}	
				
        editor.addButton( 'motech_spacer', {
            title: 'Add a Spacer',
            type: 'menubutton',
            icon: 'icon motech_spacer_icon',
            menu: menu_array
        });
    });
})();