jQuery(document).ready(function($) {



		var button_name = 'motech_spacer'; //set button name
		var msdata = motech_spacer_prepjsbuttons;
	tinymce.create('tinymce.plugins.'+button_name, {
		init : function(ed, url) {
			ed.addButton(button_name, {
				title : 'Add a Spacer', //set button label
				//image : url+'/icon.png', //set icon filename (20 X 20px). put icon in same folder
				icon: 'icon motech_spacer_icon',
				onclick : function() {

						ed.execCommand('mceInsertContent', false, '[spacer height="'+msdata["useheight"]+'"]');
				},
				
			});
		},

		createControl: function(n, cm) {

                switch (n) {
                        case button_name:
                                var c = cm.createMenuButton(button_name, {
                                        title : 'Add a Spacer',
                                	//image : '/example_data/example.gif',
                                        icons : false
                                });

                                c.onRenderMenu.add(function(c, m) {
m.add({title:"Default",onclick : function(){																		   
								tinyMCE.activeEditor.execCommand('mceInsertContent', false, '[spacer height="'+msdata["useheight"]+'"]' );
							}});
if(msdata.hasOwnProperty("addspacers")){
var index;
	for	(index = 0; index < msdata["addspacers"].length; index++) {
	
		useval = msdata["addspacers"][index]["height"];
		useid = msdata["addspacers"][index]["id"];
		m.add({title:msdata["addspacers"][index]["title"],value:'[spacer height="'+useval+'" id="'+useid+'"]',onclick : function(){
																				//console.log(my_shortcodes);
																				//console.log(this.value);
																				//console.log(msdata.addspacers.index);
																				tinyMCE.activeEditor.execCommand('mceInsertContent', false, this.value );
																			}});
	}
}

                                });
                                      
                                // Return the new menu button instance
                                return c;
                }

                return null;
        },
		getInfo : function() {
			return {
				longname : button_name,
				author : 'Justin Saad',
				authorurl : 'http://clevelandwebdeveloper.com/',
				infourl : 'http://clevelandwebdeveloper.com/',
				version : "1.0"
			};
		}
	});
			tinymce.PluginManager.add(button_name, tinymce.plugins[button_name]);
	

	
});