( function( $ ) {

	/**
	 * @since 1.8
	 * @class FLBuilderExport
	 */
	FLBuilderExport = {
		
		/**
		 * Initializes custom exports for the builder.
		 *
		 * @since 1.8
		 * @access private
		 * @method _init
		 */
		_init: function()
		{
			var templateRadio = $( '#export-filters input[value=fl-builder-template]' );
			
			// Add the template filters after the template radio.
			templateRadio.closest( 'p' ).after( $( '#fl-builder-template-filters' ) );
			
			// Events
			templateRadio.on( 'change', FLBuilderExport._showTemplateFilters );
			$( '#fl-builder-template-export-select' ).on( 'change', FLBuilderExport._templateSelectChange );
		},
		
		/**
		 * Shows the template filters when the template radio
		 * button is clicked.
		 *
		 * @since 1.8
		 * @access private
		 * @method _showTemplateFilters
		 */
		_showTemplateFilters: function()
		{
			$( '#fl-builder-template-filters' ).slideDown();
		},
		
		/**
		 * Called when the template select is changed and shows
		 * all templates to select from when the value is set
		 * to selected.
		 *
		 * @since 1.8
		 * @access private
		 * @method _templateSelectChange
		 */
		_templateSelectChange: function()
		{
			var filter  = $( '#fl-builder-template-filters' ),
				posts   = $( '#fl-builder-template-export-posts' ),
				spinner = filter.find( '.spinner' );
			
			if ( 'all' == $( this ).val() ) {
				spinner.removeClass( 'is-active' );
				posts.hide();
			}
			else {
				
				posts.show();
				
				if ( 0 === posts.find( 'input' ).length ) {	
					
					spinner.addClass( 'is-active' );
								
					$.post( ajaxurl, {
						action: 'fl_builder_export_templates_data'
					}, FLBuilderExport._templateDataLoaded );
				}
			}
		},
		
		/**
		 * Called when the template data is loaded.
		 *
		 * @since 1.8
		 * @access private
		 * @method _templateDataLoaded
		 */
		_templateDataLoaded: function( response )
		{
			var filter  	= $( '#fl-builder-template-filters' ),
				posts   	= $( '#fl-builder-template-export-posts' ),
				spinner 	= filter.find( '.spinner' ),
				data 		= JSON.parse( response ),
				i			= 0;
				
			for ( i in data ) {
				posts.append( '<p><label><input type="checkbox" name="fl-builder-export-template[]" value="' + data[ i ].id + '" /> ' + data[ i ].title + '</label></p>' );
			}
				
			spinner.removeClass( 'is-active' );
		}
	};

	$( FLBuilderExport._init );

} )( jQuery );