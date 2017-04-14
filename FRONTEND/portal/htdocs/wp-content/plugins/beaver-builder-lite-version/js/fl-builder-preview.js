(function($){

	/**
	 * Helper class for dealing with live previews.
	 *
	 * @class FLBuilderPreview
	 * @since 1.3.3
	 */
	FLBuilderPreview = function(o)
	{
		// Type
		this.type = o.type;
		
		// Save the current state.
		if(o.state != 'undefined' && o.state) {
			this.state = o.state;
		}
		else {
			this._saveState();
		}
		
		// Render an initial preview?
		if(o.layout != 'undefined' && o.layout) {
			FLBuilder._renderLayout(o.layout, $.proxy(this._init, this));
		}
		else {
			this._init();
		}
	};

	/**
	 * Stores all the fonts and weights of all font fields. 
	 * This is used to render the stylesheet with Google Fonts.
	 *
	 * @since 1.6.3
	 * @access private
	 * @property {Array} _fontsList
	 */  
	FLBuilderPreview._fontsList = {};

	/**
	 * Prototype for new instances.
	 *
	 * @since 1.3.3
	 * @property {Object} prototype
	 */ 
	FLBuilderPreview.prototype = {

		/**
		 * The type of node that we are previewing.
		 *
		 * @since 1.3.3
		 * @property {String} type
		 */
		type                : '',

		/**
		 * The ID of node that we are previewing.
		 *
		 * @since 1.3.3
		 * @property {String} nodeId
		 */  
		nodeId              : null,

		/**
		 * An object with data for each CSS class
		 * in the preview.
		 *
		 * @since 1.3.3
		 * @property {Object} classes
		 */  
		classes             : {},
		
		/**
		 * An object with references to each element
		 * in the preview.
		 *
		 * @since 1.3.3
		 * @property {Object} elements
		 */  
		elements            : {},
		
		/**
		 * An object that contains data for the current
		 * state of a layout before changes are made.
		 *
		 * @since 1.3.3
		 * @property {Object} state
		 */  
		state               : null,
		
		/**
		 * Node settings saved when the preview was initalized.
		 *
		 * @since 1.7
		 * @access private
		 * @property {Object} _savedSettings
		 */  
		_savedSettings       : null,
		
		/**
		 * An instance of FLStyleSheet for the current preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @property {FLStyleSheet} _styleSheet
		 */  
		_styleSheet         : null,
		
		/**
		 * An instance of FLStyleSheet for the medium device preview.
		 *
		 * @since 1.9
		 * @access private
		 * @property {FLStyleSheet} _styleSheetMedium
		 */  
		_styleSheetMedium   : null,
		
		/**
		 * An instance of FLStyleSheet for the responsive device preview.
		 *
		 * @since 1.9
		 * @access private
		 * @property {FLStyleSheet} _styleSheet
		 */  
		_styleSheetResponsive : null,
		
		/**
		 * A timeout object for delaying the current preview refresh.
		 *
		 * @since 1.3.3
		 * @access private
		 * @property {Object} _timeout
		 */  
		_timeout            : null,
		
		/**
		 * Stores the last classname for a classname preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @property {String} _lastClassName
		 */  
		_lastClassName      : null,
		
		/**
		 * A reference to the AJAX object for a preview refresh.
		 *
		 * @since 1.3.3
		 * @access private
		 * @property {String} _xhr
		 */  
		_xhr                : null,

		/**
		 * Initializes a builder preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _init
		 */
		_init: function()
		{
			// Node Id
			this.nodeId = $('.fl-builder-settings').data('node');
			
			// Save settings
			this._saveSettings();
	
			// Elements and Class Names
			this._initElementsAndClasses();
			
			// Create the preview stylesheets
			this._createSheets();
			
			// Responsive previews
			this._initResponsivePreviews();
			
			// Default field previews
			this._initDefaultFieldPreviews();
	
			// Init
			switch(this.type) {
					
				case 'row':
				this._initRow();
				break;
				
				case 'col':
				this._initColumn();
				break;
				
				case 'module':
				this._initModule();
				break;
			}
		},

		/**
		 * Saves the current settings to be checked to see if
		 * anything has changed when a preview is canceled.
		 *
		 * @since 1.7
		 * @access private
		 * @method _saveSettings
		 */
		_saveSettings: function()
		{
			var form = $('.fl-builder-settings-lightbox .fl-builder-settings');
			
			this._savedSettings = FLBuilder._getSettings( form );
		},

		/**
		 * Checks to see if the settings have changed.
		 *
		 * @since 1.7
		 * @access private
		 * @method _settingsHaveChanged
		 * @return bool
		 */
		_settingsHaveChanged: function()
		{
			var form 	 = $('.fl-builder-settings-lightbox .fl-builder-settings'),
				settings = FLBuilder._getSettings( form );
			
			return JSON.stringify( this._savedSettings ) != JSON.stringify( settings );
		},
	
		/**
		 * Initializes the classname and element references
		 * for this preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initElementsAndClasses
		 */
		_initElementsAndClasses: function()
		{
			var contentClass;
			
			// Content Class
			if(this.type == 'row') {
				contentClass = '.fl-row-content-wrap';
			}
			else {
				contentClass = '.fl-' + this.type + '-content';
			}
			
			// Class Names
			$.extend(this.classes, {
				settings        : '.fl-builder-' + this.type + '-settings',
				settingsHeader  : '.fl-builder-' + this.type + '-settings .fl-lightbox-header',
				node            : FLBuilder._contentClass + ' .fl-node-' + this.nodeId,
				content         : FLBuilder._contentClass + ' .fl-node-' + this.nodeId + ' > ' + contentClass
			});
			
			// Elements
			$.extend(this.elements, {
				settings        : $(this.classes.settings),
				settingsHeader  : $(this.classes.settingsHeader),
				node            : $(this.classes.node),
				content         : $(this.classes.content)
			});
		},
	
		/**
		 * Creates the stylesheets for default, medium 
		 * and responsive previews.
		 *
		 * @since 1.9
		 * @method _createSheets
		 */
		_createSheets: function()
		{
			if ( ! this._styleSheet ) {
				this._styleSheet = new FLStyleSheet( { id : 'fl-builder-preview' } );          
			}
			if ( ! this._styleSheetMedium ) {
				this._styleSheetMedium = new FLStyleSheet( { id : 'fl-builder-preview-medium' } );          
			}
			if ( ! this._styleSheetResponsive ) {
				this._styleSheetResponsive = new FLStyleSheet( { id : 'fl-builder-preview-responsive' } );          
			}
		},
	
		/**
		 * Destroys all preview sheets.
		 *
		 * @since 1.9
		 * @method _destroySheets
		 */
		_destroySheets: function()
		{
			if ( this._styleSheet ) {
				this._styleSheet.destroy();      
				this._styleSheet = null;
			}
			if ( this._styleSheetMedium ) {
				this._styleSheetMedium.destroy();      
				this._styleSheetMedium = null;        
			}
			if ( this._styleSheetResponsive ) {
				this._styleSheetResponsive.destroy();
				this._styleSheetResponsive = null;
			}
		},
	
		/**
		 * Updates a CSS rule for this preview.
		 *
		 * @since 1.3.3
		 * @method updateCSSRule
		 * @param {String} selector The CSS selector to update.
		 * @param {String} property The CSS property to update.
		 * @param {String} value The CSS value to update.
		 */
		updateCSSRule: function( selector, property, value )
		{
			this._styleSheet.updateRule( selector, property, value );
		},
	
		/**
		 * Runs a delay with a callback.
		 *
		 * @since 1.3.3
		 * @method delay
		 * @param {Number} length How long to wait before running the callback.
		 * @param {Function} callback A function to call when the delay is complete.
		 */
		delay: function(length, callback)
		{
			this._cancelDelay();
			this._timeout = setTimeout(callback, length);
		},
	
		/**
		 * Cancels a preview refresh delay.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _cancelDelay
		 */
		_cancelDelay: function()
		{
			if(this._timeout !== null) {
				clearTimeout(this._timeout);
			}
		},
	
		/**
		 * Converts a hex value to an array of RGB values.
		 *
		 * @since 1.3.3
		 * @method hexToRgb
		 * @param {String} hex
		 * @return {Array}
		 */
		hexToRgb: function(hex) 
		{
			var bigInt  = parseInt(hex, 16),
				r       = (bigInt >> 16) & 255,
				g       = (bigInt >> 8) & 255,
				b       = bigInt & 255;
			
			return [r, g, b];
		},
	
		/**
		 * Parses a float or returns 0 if we don't have a number.
		 *
		 * @since 1.3.3
		 * @method parseFloat
		 * @param {Number} value
		 * @return {Number}
		 */
		parseFloat: function(value) 
		{
			return isNaN(parseFloat(value)) ? 0 : parseFloat(value);
		},
		
		/* Responsive Previews
		----------------------------------------------------------*/
	
		/**
		 * Initializes logic for responsive previews.
		 *
		 * @since 1.9
		 * @method _initResponsivePreviews
		 */
		_initResponsivePreviews: function()
		{
			FLBuilder.addHook( 'responsive-editing-switched', $.proxy( this._responsiveEditingSwitched, this ) );
		},
		
		/**
		 * Destroys responsive preview events.
		 *
		 * @since 1.9
		 * @method _destroyResponsivePreviews
		 */
		_destroyResponsivePreviews: function()
		{
			FLBuilder.removeHook( 'responsive-editing-switched' );
		},
	
		/**
		 * Initializes logic for responsive previews.
		 *
		 * @since 1.9
		 * @method _responsiveEditingSwitched
		 */
		_responsiveEditingSwitched: function( e, mode )
		{
			if ( 'default' == mode ) {
				this._styleSheetMedium.disable();
				this._styleSheetResponsive.disable();
			}
			else if ( 'medium' == mode ) {
				this._styleSheetMedium.enable();
				this._styleSheetResponsive.disable();
			}
			else if ( 'responsive' == mode ) {
				this._styleSheetMedium.disable();
				this._styleSheetResponsive.enable();
			}
		},
	
		/**
		 * Updates a CSS rule for responsive preview.
		 *
		 * @since 1.9
		 * @method updateResponsiveCSSRule
		 * @param {String} selector The CSS selector to update.
		 * @param {String} property The CSS property to update.
		 * @param {String} value The CSS value to update.
		 */
		updateResponsiveCSSRule: function( selector, property, value )
		{
			var mode     = FLBuilderResponsiveEditing._mode,
				sheetKey = 'default' == mode ? '' : mode.charAt(0).toUpperCase() + mode.slice(1);
			
			this[ '_styleSheet' + sheetKey ].updateRule( selector, property, value );
		},
		
		/* States
		----------------------------------------------------------*/
		
		/**
		 * Saves the current state of a layout.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _saveState
		 */
		_saveState: function() 
		{
			var post    = $('#fl-post-id').val(),
				css     = $('link[href*="/cache/' + post + '"]').attr('href'),
				js      = $('script[src*="/cache/' + post + '"]').attr('src'),
				html    = $(FLBuilder._contentClass).html();
				
			this.state = {
				css     : css,
				js      : js,
				html    : html
			};
		},
	
		/**
		 * Runs a preview refresh for the current settings lightbox.
		 *
		 * @since 1.3.3
		 * @method preview
		 */
		preview: function() 
		{
			var form     = $('.fl-builder-settings-lightbox .fl-builder-settings'),
				nodeId   = form.attr('data-node'),
				settings = FLBuilder._getSettings(form);
			
			// Abort an existing preview request. 
			this._cancelPreview();

			// Make a new preview request.
			this._xhr = FLBuilder.ajax({
				action          : 'render_layout',
				node_id         : nodeId,
				node_preview    : settings
			}, $.proxy(this._renderPreview, this));
		},
	
		/**
		 * Runs a preview refresh with a delay.
		 *
		 * @since 1.3.3
		 * @method delayPreview
		 */
		delayPreview: function(e)
		{
			var heading         = typeof e == 'undefined' ? [] : $(e.target).closest('tr').find('th'),
				widgetHeading   = $('.fl-builder-widget-settings .fl-builder-settings-title'),
				lightboxHeading = $('.fl-builder-settings .fl-lightbox-header'),
				loaderSrc       = FLBuilderLayoutConfig.paths.pluginUrl + 'img/ajax-loader-small.gif',
				loader          = $('<img class="fl-builder-preview-loader" src="' + loaderSrc + '" />');
			
			$('.fl-builder-preview-loader').remove();
			
			if(heading.length > 0) {
				heading.append(loader);
			}
			else if(widgetHeading.length > 0) {
				widgetHeading.append(loader);
			}
			else if(lightboxHeading.length > 0) {
				lightboxHeading.append(loader);
			}
			
			this.delay(1000, $.proxy(this.preview, this));  
		},
	
		/**
		 * Cancels a preview refresh.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _cancelPreview
		 */
		_cancelPreview: function() 
		{
			if(this._xhr) {
				this._xhr.abort();
				this._xhr = null;
			}
		},
	
		/**
		 * Renders the response of a preview refresh.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _renderPreview
		 * @param {String} response The JSON encoded response.
		 */
		_renderPreview: function(response) 
		{
			this._xhr = null;
			
			FLBuilder._renderLayout(response, $.proxy(this._renderPreviewComplete, this));
		},
	
		/**
		 * Fires when a preview refresh has finished rendering.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _renderPreviewComplete
		 */
		_renderPreviewComplete: function() 
		{
			// Refresh the elements.
			this._initElementsAndClasses();
			
			// Remove the loading graphic.
			$('.fl-builder-preview-loader').remove();
		   
			// Fire the preview rendered event. 
			$( FLBuilder._contentClass ).trigger( 'fl-builder.preview-rendered' );
		},
	
		/**
		 * Reverts a preview to the state that was saved
		 * before the preview was initialized.
		 *
		 * @since 1.3.3
		 * @method revert
		 */
		revert: function() 
		{
			// Clear the preview.
			this.clear();
			
			// Render the layout.
			if ( this._settingsHaveChanged() ) {
				FLBuilder._renderLayout(this.state);
			}
		},
	
		/**
		 * Cancels a preview refresh and removes 
		 * any stylesheet changes.
		 *
		 * @since 1.3.3
		 * @method clear
		 */
		clear: function() 
		{
			// Canel any preview delays or requests.
			this._cancelDelay();
			this._cancelPreview();
			
			// Destroy the preview stylesheet.
			this._destroySheets();
			
			// Destroy responsive editing previews.
			this._destroyResponsivePreviews();
		},

		/* Node Text Color Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes node text color previews.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initNodeTextColor
		 */
		_initNodeTextColor: function()
		{
			// Elements
			$.extend(this.elements, {
				textColor    : $(this.classes.settings + ' input[name=text_color]'),
				linkColor    : $(this.classes.settings + ' input[name=link_color]'),
				hoverColor 	 : $(this.classes.settings + ' input[name=hover_color]'),
				headingColor : $(this.classes.settings + ' input[name=heading_color]')
			});
			
			// Events
			this.elements.textColor.on('change', $.proxy(this._textColorChange, this));
			this.elements.linkColor.on('change', $.proxy(this._textColorChange, this));
			this.elements.hoverColor.on('change', $.proxy(this._textColorChange, this));
			this.elements.headingColor.on('change', $.proxy(this._textColorChange, this));
		},
		
		/**
		 * Fires when the text color field for a node
		 * is changed.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _textColorChange
		 * @param {Object} e An event object.
		 */
		_textColorChange: function(e)
		{
			var textColor    = this.elements.textColor.val(),
				linkColor    = this.elements.linkColor.val(),
				hoverColor   = this.elements.hoverColor.val(),
				headingColor = this.elements.headingColor.val();
			
			linkColor 	 = linkColor === '' ? textColor : linkColor;
			hoverColor 	 = hoverColor === '' ? textColor : hoverColor;
			headingColor = headingColor === '' ? textColor : headingColor;
			
			this.delay(100, $.proxy(function(){
			
				// Update Text color.
				if(textColor === '') {
					this.updateCSSRule(this.classes.node, 'color', 'inherit');
				}
				else {
					this.updateCSSRule(this.classes.node, 'color', '#' + textColor);
				}
				
				// Update Link Color
				if ( linkColor === '' ) {
					this.updateCSSRule(this.classes.node + ' a', 'color', 'inherit');
				}
				else {
					this.updateCSSRule(this.classes.node + ' a', 'color', '#' + linkColor);
				}
				
				// Hover Color
				if(hoverColor === '') {
					this.updateCSSRule(this.classes.node + ' a:hover', 'color', 'inherit');
				}
				else {
					this.updateCSSRule(this.classes.node + ' a:hover', 'color', '#' + hoverColor);
				}
				
				// Heading Color
				if(headingColor === '') {
					this.updateCSSRule(this.classes.node + ' h1', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h2', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h3', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h4', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h5', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h6', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h1 a', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h2 a', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h3 a', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h4 a', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h5 a', 'color', 'inherit');
					this.updateCSSRule(this.classes.node + ' h6 a', 'color', 'inherit');
				}
				else {
					this.updateCSSRule(this.classes.node + ' h1', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h2', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h3', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h4', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h5', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h6', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h1 a', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h2 a', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h3 a', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h4 a', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h5 a', 'color', '#' + headingColor);
					this.updateCSSRule(this.classes.node + ' h6 a', 'color', '#' + headingColor);
				}
				
			}, this));
		},
		
		/* Node Bg Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes node background previews.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initNodeBg
		 */
		_initNodeBg: function()
		{
			// Elements
			$.extend(this.elements, {
				bgType                      : $(this.classes.settings + ' select[name=bg_type]'),
				bgColor                     : $(this.classes.settings + ' input[name=bg_color]'),
				bgColorPicker               : $(this.classes.settings + ' .fl-picker-bg_color'),
				bgOpacity                   : $(this.classes.settings + ' input[name=bg_opacity]'),
				bgImageSrc                  : $(this.classes.settings + ' select[name=bg_image_src]'),
				bgRepeat                    : $(this.classes.settings + ' select[name=bg_repeat]'),
				bgPosition                  : $(this.classes.settings + ' select[name=bg_position]'),
				bgAttachment                : $(this.classes.settings + ' select[name=bg_attachment]'),
				bgSize                      : $(this.classes.settings + ' select[name=bg_size]'),
				bgVideoSource               : $(this.classes.settings + ' select[name=bg_video_source]'),
				bgVideo                     : $(this.classes.settings + ' input[name=bg_video]'),
				bgVideoServiceUrl           : $(this.classes.settings + ' input[name=bg_video_service_url]'),
				bgVideoFallbackSrc          : $(this.classes.settings + ' select[name=bg_video_fallback_src]'),
				bgSlideshowSource           : $(this.classes.settings + ' select[name=ss_source]'),
				bgSlideshowPhotos           : $(this.classes.settings + ' input[name=ss_photos]'),
				bgSlideshowFeedUrl          : $(this.classes.settings + ' input[name=ss_feed_url]'),
				bgSlideshowSpeed            : $(this.classes.settings + ' input[name=ss_speed]'),
				bgSlideshowTrans            : $(this.classes.settings + ' select[name=ss_transition]'),
				bgSlideshowTransSpeed       : $(this.classes.settings + ' input[name=ss_transitionDuration]'),
				bgParallaxImageSrc          : $(this.classes.settings + ' select[name=bg_parallax_image_src]'),
				bgOverlayColor              : $(this.classes.settings + ' input[name=bg_overlay_color]'),
				bgOverlayOpacity            : $(this.classes.settings + ' input[name=bg_overlay_opacity]')
			});
		
			// Events
			this.elements.bgType.on(                'change', $.proxy(this._bgTypeChange, this));
			this.elements.bgColor.on(               'change', $.proxy(this._bgColorChange, this));
			this.elements.bgOpacity.on(             'keyup',  $.proxy(this._bgOpacityChange, this));
			this.elements.bgImageSrc.on(            'change', $.proxy(this._bgPhotoChange, this));
			this.elements.bgRepeat.on(              'change', $.proxy(this._bgPhotoChange, this));
			this.elements.bgPosition.on(            'change', $.proxy(this._bgPhotoChange, this));
			this.elements.bgAttachment.on(          'change', $.proxy(this._bgPhotoChange, this));
			this.elements.bgSize.on(                'change', $.proxy(this._bgPhotoChange, this));
			this.elements.bgVideoServiceUrl.on(   	'change', $.proxy(this._bgVideoChange, this));
			this.elements.bgSlideshowSource.on(     'change', $.proxy(this._bgSlideshowChange, this));
			this.elements.bgSlideshowPhotos.on(     'change', $.proxy(this._bgSlideshowChange, this));
			this.elements.bgSlideshowFeedUrl.on(    'keyup',  $.proxy(this._bgSlideshowChange, this));
			this.elements.bgSlideshowSpeed.on(      'keyup',  $.proxy(this._bgSlideshowChange, this));
			this.elements.bgSlideshowTrans.on(      'change', $.proxy(this._bgSlideshowChange, this));
			this.elements.bgSlideshowTransSpeed.on( 'keyup',  $.proxy(this._bgSlideshowChange, this));
			this.elements.bgParallaxImageSrc.on(    'change', $.proxy(this._bgParallaxChange, this));
			this.elements.bgOverlayColor.on(        'change', $.proxy(this._bgOverlayChange, this));
			this.elements.bgOverlayOpacity.on(      'keyup',  $.proxy(this._bgOverlayChange, this));
		},
		
		/**
		 * Fires when the background type field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgTypeChange
		 * @param {Object} e An event object.
		 */
		_bgTypeChange: function(e)
		{
			var val = this.elements.bgType.val();
				
			// Clear bg styles first.
			this.elements.node.removeClass('fl-row-bg-video');
			this.elements.node.removeClass('fl-row-bg-slideshow');
			this.elements.node.removeClass('fl-row-bg-parallax');
			this.elements.node.find('.fl-bg-video').remove();
			this.elements.node.find('.fl-bg-slideshow').remove();
			this.elements.content.css('background-image', '');
			
			this.updateCSSRule(this.classes.content, {
				'background-color'  : 'transparent',
				'background-image'  : 'none'
			});
			
			// None
			if(val == 'none') {
				this._bgOverlayClear();
			}

			// Color
			else if(val == 'color') {
				this.elements.bgColor.trigger('change');
				this._bgOverlayClear();
			}
			
			// Photo
			else if(val == 'photo') {
				this.elements.bgColor.trigger('change');
				this.elements.bgImageSrc.trigger('change');
			}
			
			// Video
			else if(val == 'video') {
				this.elements.bgColor.trigger('change');
				this._bgVideoChange();				
			}
			
			// Slideshow
			else if(val == 'slideshow') {
				this.elements.bgColor.trigger('change');
				this._bgSlideshowChange();
			}
			
			// Parallax
			else if(val == 'parallax') {
				this.elements.bgColor.trigger('change');
				this.elements.bgParallaxImageSrc.trigger('change');
			}
		},
		
		/**
		 * Fires when the background color field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgColorChange
		 * @param {Object} e An event object.
		 */
		_bgColorChange: function(e)
		{
			var rgb, alpha, value;
			
			if(this.elements.bgColor.val() === '' || isNaN(this.elements.bgOpacity.val())) {
				this.updateCSSRule(this.classes.content, 'background-color', 'transparent');  
			}
			else {
			
				rgb    = this.hexToRgb( this.elements.bgColor.val() );
				alpha  = this.parseFloat(this.elements.bgOpacity.val())/100;
				value  = 'rgba(' + rgb.join() + ', ' + alpha + ')';
					
				this.delay(100, $.proxy(function(){
					this.updateCSSRule(this.classes.content, 'background-color', value);
				}, this));   
			}
		},
		
		/**
		 * Fires when the background opacity field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgOpacityChange
		 * @param {Object} e An event object.
		 */
		_bgOpacityChange: function(e)
		{
			this.elements.bgColor.trigger('change');
		},
		
		/**
		 * Fires when the background photo field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgPhotoChange
		 * @param {Object} e An event object.
		 */
		_bgPhotoChange: function(e)
		{
			if(this.elements.bgImageSrc.val()) {

				this.updateCSSRule(this.classes.content, {
					'background-image'      : 'url(' + this.elements.bgImageSrc.val() + ')',
					'background-repeat'     : this.elements.bgRepeat.val(),
					'background-position'   : this.elements.bgPosition.val(),
					'background-attachment' : this.elements.bgAttachment.val(),
					'background-size'       : this.elements.bgSize.val()
				});
			}
			else {
				this.updateCSSRule(this.classes.content, {
					'background-image'      : 'none'
				});
			}
		},

		/**
		 * Fires when the background video field of 
		 * a node changes.
		 *
		 * @since 1.9.2
		 * @access private
		 * @method _bgVideoChange
		 * @param {Object} e An event object.
		 */
		_bgVideoChange: function(e)
		{
			var eles        	= this.elements,
				source 			= eles.bgVideoSource.val(),
				video 			= eles.bgVideo.val(),
				videoUrl		= eles.bgVideoServiceUrl.val(),
				youtubePlayer 	= 'https://www.youtube.com/iframe_api',
				vimeoPlayer		= 'https://player.vimeo.com/api/player.js',
				scriptTag  		= $( '<script>' );

			// Only load the required API script library
			if(source == 'video_service' && videoUrl != '') {
				if (/^(?:(?:(?:https?:)?\/\/)?(?:www.)?(?:youtu(?:be.com|.be))\/(?:watch\?v\=|v\/|embed\/)?([\w\-]+))/i.test(videoUrl)
					&& $( 'script[src*="youtube.com"' ).length < 1) {
					scriptTag.attr('src', youtubePlayer);
				}
				else if(/^(http\:\/\/|https\:\/\/)?(www\.)?(vimeo\.com\/)([0-9]+)$/.test(videoUrl) 
					&& $( 'script[src*="vimeo.com"' ).length < 1) {
					scriptTag.attr('src', vimeoPlayer);
				}
				
				scriptTag
					.attr('type', 'text/javascript')
					.appendTo('head');

				this.delay(500, $.proxy(this.preview, this));
			}
			else if(video != '') {
				this.preview();
			}
		},
		
		/**
		 * Fires when the background slideshow field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgSlideshowChange
		 * @param {Object} e An event object.
		 */
		_bgSlideshowChange: function(e)
		{
			var eles        = this.elements,
				source      = eles.bgSlideshowSource.val(),
				photos      = eles.bgSlideshowPhotos.val(),
				feed        = eles.bgSlideshowFeedUrl.val(),
				speed       = eles.bgSlideshowSpeed.val(),
				transSpeed  = eles.bgSlideshowTransSpeed.val();
			
			if(source == 'wordpress' && photos === '') {
				return;
			}
			else if(source == 'smugmug' && feed === '') {
				return;
			}
			else if(isNaN(parseInt(speed))) {
				return;
			}
			else if(isNaN(parseInt(transSpeed))) {
				return;
			}
			
			this.delay(500, $.proxy(this.preview, this));
		},
		
		/**
		 * Fires when the background parallax field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgParallaxChange
		 * @param {Object} e An event object.
		 */
		_bgParallaxChange: function(e)
		{
			if(this.elements.bgParallaxImageSrc.val()) {
			
				this.updateCSSRule(this.classes.content, {
					'background-image'      : 'url(' + this.elements.bgParallaxImageSrc.val() + ')',
					'background-repeat'     : 'no-repeat',
					'background-position'   : 'center center',
					'background-attachment' : 'fixed',
					'background-size'       : 'cover'
				});
			}
		},
		
		/**
		 * Fires when the background overlay field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgOverlayChange
		 * @param {Object} e An event object.
		 */
		_bgOverlayChange: function(e)
		{
			var rgb, alpha, value;
			
			if(this.elements.bgOverlayColor.val() === '' || isNaN(this.elements.bgOverlayOpacity.val())) {
				this.elements.node.removeClass('fl-row-bg-overlay');
				this.elements.node.removeClass('fl-col-bg-overlay');
				this.updateCSSRule(this.classes.content + ':after', 'background-color', 'transparent');  
			}
			else {
			
				rgb    = this.hexToRgb(this.elements.bgOverlayColor.val());
				alpha  = this.parseFloat(this.elements.bgOverlayOpacity.val())/100;
				value  = 'rgba(' + rgb.join() + ', ' + alpha + ')';
					
				this.delay(100, $.proxy(function(){
					
					if ( this.elements.node.hasClass( 'fl-col' ) ) {
						this.elements.node.addClass( 'fl-col-bg-overlay' );
					}
					else {
						this.elements.node.addClass( 'fl-row-bg-overlay' );
					}
					
					this.updateCSSRule( this.classes.content + ':after', 'background-color', value );
					
				}, this));
	
			}
		},
		
		/**
		 * Fires when a background overlay color is cleared.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _bgOverlayClear
		 * @param {Object} e An event object.
		 */
		_bgOverlayClear: function(e)
		{
			this.elements.bgOverlayColor.prev('.fl-color-picker-clear').trigger('click');
		},

		/* Node Border Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes node border previews.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initNodeBorder
		 */
		_initNodeBorder: function()
		{
			// Elements
			$.extend(this.elements, {
				borderType              : $(this.classes.settings + ' select[name=border_type]'),
				borderColor             : $(this.classes.settings + ' input[name=border_color]'),
				borderColorPicker       : $(this.classes.settings + ' .fl-picker-border_color'),
				borderOpacity           : $(this.classes.settings + ' input[name=border_opacity]')
			});
			
			// Events
			this.elements.borderType.on(    'change', $.proxy(this._borderTypeChange, this));
			this.elements.borderColor.on(   'change', $.proxy(this._borderColorChange, this));
			this.elements.borderOpacity.on( 'keyup',  $.proxy(this._borderOpacityChange, this));
		},
		
		/**
		 * Fires when the border type field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _borderTypeChange
		 * @param {Object} e An event object.
		 */
		_borderTypeChange: function(e)
		{
			var val = this.elements.borderType.val();
				
			this.updateCSSRule(this.classes.content, {
				'border-style'  : val === '' ? 'none' : val
			});
			
			this.elements.borderColor.trigger('change');
			this.elements.borderTop.trigger('keyup');
		},
		
		/**
		 * Fires when the border color field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _borderColorChange
		 * @param {Object} e An event object.
		 */
		_borderColorChange: function(e)
		{
			var rgb, alpha, value;
			
			if(this.elements.borderColor.val() === '' || isNaN(this.elements.borderOpacity.val())) {
				this.updateCSSRule(this.classes.content, 'border-color', 'transparent');  
			}
			else {
			
				rgb    = this.hexToRgb(this.elements.borderColor.val());
				alpha  = parseInt(this.elements.borderOpacity.val())/100;
				value  = 'rgba(' + rgb.join() + ', ' + alpha + ')';
					
				this.delay(100, $.proxy(function(){
					this.updateCSSRule(this.classes.content, 'border-color', value);
				}, this));   
			}
		},
		
		/**
		 * Fires when the border opacity field of 
		 * a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _borderOpacityChange
		 * @param {Object} e An event object.
		 */
		_borderOpacityChange: function(e)
		{
			this.elements.borderColor.trigger('change');
		},
		
		/* Node Class Name Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes node classname previews.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initNodeClassName
		 */
		_initNodeClassName: function()
		{
			// Elements
			$.extend(this.elements, {
				className : $(this.classes.settings + ' input[name=class]')
			});
			
			// Events
			this.elements.className.on('keyup', $.proxy(this._classNameChange, this));
			this._lastClassName = this.elements.className.val();
		},
		
		/**
		 * Fires when the classname of a node changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _classNameChange
		 * @param {Object} e An event object.
		 */
		_classNameChange: function(e)
		{
			var className = this.elements.className.val();
			
			if(this._lastClassName !== null) {
				this.elements.node.removeClass(this._lastClassName);
			}
			
			this.elements.node.addClass(className);
			this._lastClassName = className;
		},
		
		/* Node Margin Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes node responsive dimension previews for things
		 * like margins, padding and borders.
		 *
		 * @since 1.9
		 * @access private
		 * @method _initResponsiveDimensions
		 */
		_initResponsiveDimensions: function( property )
		{
			var elements      = {},
				dimensions    = [ 'Top', 'Bottom', 'Left', 'Right' ],
				devices       = [ '', 'Medium', 'Responsive' ],
				settingsClass = this.classes.settings,
				elementKey    = '',
				inputName     = '',
				i             = null,
				k             = null;
				
			for ( i = 0; i < dimensions.length; i++ ) {
				
				for ( k = 0; k < devices.length; k++ ) {
					
					elementKey = property + dimensions[ i ] + devices[ k ];
					inputName  = property + '_' + dimensions[ i ].toLowerCase();
					
					if ( '' != devices[ k ] ) {
						inputName += '_' + devices[ k ].toLowerCase();
					}
					
					elements[ elementKey ] = $( settingsClass + ' input[name=' + inputName + ']');
					elements[ elementKey ].on( 'keyup', $.proxy( this._responsiveDimensionChange, this, property ) );
				}
			}
			
			$.extend( this.elements, elements );
		},
		
		/**
		 * Get all dimensions from a node preview event.
		 *
		 * @since 1.9
		 * @access private
		 * @method _getDimensions
		 * @param {String} property
		 * @return {Object} An object with tblr data.
		 */
		_getDimensions: function( property )
		{
			var mode          = FLBuilderResponsiveEditing._mode,
				dimensions    = [ 'Top', 'Bottom', 'Left', 'Right' ],
				device        = 'default' == mode ? '' : mode.charAt(0).toUpperCase() + mode.slice(1),
				values        = {},
				i             = 0;
				
			for ( ; i < dimensions.length; i++ ) {
				values[ dimensions[ i ].toLowerCase() ] = this.elements[ property + dimensions[ i ] + device ].val();
			}

			return this._normalizeDimensionValues( values, property );
		},
		
		/**
		 * Fires when a dimension field of a node changes.
		 *
		 * @since 1.9
		 * @access private
		 * @method _responsiveDimensionChange
		 * @param {String} property
		 */
		_responsiveDimensionChange: function( property )
		{
			var newDimensions = this._getDimensions( property ),
			    newRules      = {},
			    isBorder      = 'border' == property;

			$.each( newDimensions, function( dir, val ) {
				newRules[ property + '-' + dir + ( isBorder ? '-width' : '' ) ] = val;
			} );

			this.updateResponsiveCSSRule( this.classes.content, newRules );
			this._positionAbsoluteBgs();
		},
		
		/**
		 * Normalize CSS dimension values.
		 *
		 * @since 1.9
		 * @access private
		 * @method _normalizeDimensionValues
		 * @param {Object} values Object of margins/paddings/border widths values.
		 * @param {String} property CSS property to get, can be 'margin', 'padding' or 'border-width'.
		 * @return {Object} An object of normalized margins/paddings/border widths values with units.
		 */
		_normalizeDimensionValues: function( values, property )
		{
			var parent = this,
				mode   = FLBuilderResponsiveEditing._mode,
				device = 'default' == mode ? '' : mode.charAt(0).toUpperCase() + mode.slice(1),

			// Separate property name from property suffix
			property = property.split( '-' );

			// Set correct property suffix
			if ( 'undefined' === typeof property[1] ) {
				property[1] = '';
			} else {
				property[1] = property[1].charAt( 0 ).toUpperCase() + property[1].slice( 1 );
			}

			$.map( values, function( val, key ) {
				val = val.toLowerCase().replace( /[^a-z0-9%.\-]/g, '' );

				// Fall back to placeholder if the value is empty
				if ( '' === val ) {
					var option      = property[0] + key.charAt( 0 ).toUpperCase() + key.slice( 1 ) + property[1] + device,
					    placeholder = parent.elements[ option ].attr( 'placeholder' );

					if ( placeholder ) {
						val = placeholder;
					}
				}

				// Fall back to pixels when numeric value set
				if ( null !== val && '' !== val && ! isNaN( val ) ) {
					val = parseFloat( val ) + 'px';
				}

				values[ key ] = val;
			} );

			return values;
		},
		
		/* Absolutely Positioned Backgrounds
		----------------------------------------------------------*/
		
		/**
		 * Positions the backgrounds of a node that need absolute
		 * positioning such as videos and slideshows.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _positionAbsoluteBgs
		 */
		_positionAbsoluteBgs: function()
		{
			// @todo  Oliver: Why is this actually needed???
			var slideshow = this.elements.node.find('.fl-bg-slideshow'),
			    video     = this.elements.node.find('.fl-bg-video'),
			    margins   = null,
			    borders   = null,
			    position  = {
			    	'top'    : 0,
			    	'bottom' : 0,
			    	'left'   : 0,
			    	'right'  : 0,
			    };

			if ( slideshow.length > 0 || video.length > 0 ) {
				margins = this._getDimensions( 'margin' );
				borders = this._getDimensions( 'border' );

				$.map( position, function( val, key ) {
					if ( margins[ key ] && borders[ key ] ) {
						position[ key ] = 'calc(' + margins[ key ] + '+' + borders[ key ] + ')';
					} else if ( margins[ key ] ) {
						position[ key ] = margins[ key ];
					} else if ( borders[ key ] ) {
						position[ key ] = borders[ key ];
					}
				} );

				if ( slideshow.length > 0 ) {
					this.updateCSSRule( this.classes.node + ' .fl-bg-slideshow', position );
					FLBuilder._resizeLayout();
				}

				if ( video.length > 0 ) {
					this.updateCSSRule( this.classes.node + ' .fl-bg-video', position );
				}
			}
		},
		
		/* Row Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes a row preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initRow
		 */
		_initRow: function()
		{
			// Elements
			$.extend(this.elements, {
				width          : $(this.classes.settings + ' select[name=width]'),
				contentWidth   : $(this.classes.settings + ' select[name=content_width]'),
				height         : $(this.classes.settings + ' select[name=full_height]'),
				align          : $(this.classes.settings + ' select[name=content_alignment]')
			});
			
			// Events
			this.elements.width.on(         'change', $.proxy(this._rowWidthChange, this));
			this.elements.contentWidth.on(  'change', $.proxy(this._rowContentWidthChange, this));
			this.elements.height.on(        'change', $.proxy(this._rowHeightChange, this));
			this.elements.align.on(         'change', $.proxy(this._rowHeightChange, this));
			
			// Common Elements
			this._initNodeTextColor();
			this._initNodeBg();
			this._initNodeClassName();
			this._initNodeBorder();
			this._initResponsiveDimensions( 'border' );
			this._initResponsiveDimensions( 'margin' );
			this._initResponsiveDimensions( 'padding' );
		},
		
		/**
		 * Fires when the width field of a row changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _rowWidthChange
		 * @param {Object} e An event object.
		 */
		_rowWidthChange: function(e)
		{
			var row = this.elements.node;
			
			if(this.elements.width.val() == 'full') {
				row.removeClass('fl-row-fixed-width');
				row.addClass('fl-row-full-width');
			}
			else {
				row.removeClass('fl-row-full-width');
				row.addClass('fl-row-fixed-width');
			}
		},

		/**
		 * Fires when the height field of a row changes.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _rowHeightChange
		 * @param {Object} e An event object.
		 */
		_rowHeightChange: function(e)
		{
			var row = this.elements.node;
			
			row.removeClass('fl-row-align-top');
			row.removeClass('fl-row-align-center');
			
			if(this.elements.height.val() == 'full') {
				row.addClass('fl-row-full-height');
				row.addClass('fl-row-align-' + this.elements.align.val());
			}
			else {
				row.removeClass('fl-row-full-height');
			}
		},
		
		/**
		 * Fires when the content width field of a row changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _rowContentWidthChange
		 * @param {Object} e An event object.
		 */
		_rowContentWidthChange: function(e)
		{
			var content = this.elements.content.find('.fl-row-content');
			
			if(this.elements.contentWidth.val() == 'full') {
				content.removeClass('fl-row-fixed-width');
				content.addClass('fl-row-full-width');
			}
			else {
				content.removeClass('fl-row-full-width');
				content.addClass('fl-row-fixed-width');
			}
		},
		
		/* Columns Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes a column preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initRow
		 */
		_initColumn: function()
		{
			// Elements
			$.extend(this.elements, {
				size         	: $(this.classes.settings + ' input[name=size]'),
				columnHeight 	: $(this.classes.settings + ' select[name=equal_height]'),
				columnAlign     : $(this.classes.settings + ' select[name=content_alignment]'),
				responsiveOrder : $(this.classes.settings + ' select[name=responsive_order]')
			});
			
			// Events
			this.elements.size.on(   		   'keyup', $.proxy( this._colSizeChange, this ) );
			this.elements.columnHeight.on(     'change', $.proxy( this._colHeightChange, this ) );
			this.elements.columnAlign.on(      'change', $.proxy( this._colHeightChange, this ) );
			this.elements.responsiveOrder.on(  'change', $.proxy( this._colResponsiveOrder, this ) );
			
			// Common Elements
			this._initNodeTextColor();
			this._initNodeBg();
			this._initNodeClassName();
			this._initNodeBorder();
			this._initResponsiveDimensions( 'border' );
			this._initResponsiveDimensions( 'margin' );
			this._initResponsiveDimensions( 'padding' );
		},
		
		/**
		 * Fires when the size field of a column changes.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _colSizeChange
		 */
		_colSizeChange: function()
		{
			var preview         = this,
				minWidth        = 8,
				maxWidth        = 100 - minWidth,
				size            = parseFloat(this.elements.size.val()),
				prev            = this.elements.node.prev('.fl-col'),
				next            = this.elements.node.next('.fl-col'),
				sibling         = next.length === 0 ? prev : next,
				siblings        = this.elements.node.siblings('.fl-col'),
				siblingsWidth   = 0;
				
			// Don't resize if we onlt have one column or no size.
			if(siblings.length === 0 || isNaN(size)) {
				return;
			}
			
			// Adjust sizes based on other columns.
			siblings.each(function() {
			
				if($(this).data('node') == sibling.data('node')) {
					return;
				}
				
				maxWidth        -= parseFloat($(this)[0].style.width);
				siblingsWidth   += parseFloat($(this)[0].style.width);
			});
			
			// Make sure the new width isn't too small.
			if(size < minWidth) {
				size = minWidth;
			}
			
			// Make sure the new width isn't too big.
			if(size > maxWidth) {
				size = maxWidth;
			}
		
			// Update the widths.
			sibling.css('width', (100 - siblingsWidth - size) + '%');
			this.elements.node.css('width', size + '%');
		},

		/**
		 * Fires when the equal height field of a column changes.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _colHeightChange
		 */
		_colHeightChange: function()
		{
			var parent = this.elements.node.parent('.fl-col-group');
			
			parent.removeClass('fl-col-group-align-top');
			parent.removeClass('fl-col-group-align-center');
			parent.removeClass('fl-col-group-align-bottom');
			
			if(this.elements.columnHeight.val() == 'yes') {
				parent.addClass('fl-col-group-equal-height');
				parent.addClass('fl-col-group-align-' + this.elements.columnAlign.val());
			}
			else {
				parent.removeClass('fl-col-group-equal-height');
			}
		},

		/**
		 * Fires when the responsive order field of a column changes.
		 *
		 * @since 1.8
		 * @access private
		 * @method _colResponsiveOrder
		 */
		_colResponsiveOrder: function()
		{

			var parent = this.elements.node.parent('.fl-col-group');
			
			if(this.elements.responsiveOrder.val() == 'reversed') {
				parent.addClass('fl-col-group-responsive-reversed');
			}
			else {
				parent.removeClass('fl-col-group-responsive-reversed');
			}
		},
		
		/* Module Settings
		----------------------------------------------------------*/
	
		/**
		 * Initializes a module preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initRow
		 */
		_initModule: function()
		{
			this._initNodeClassName();
			this._initResponsiveDimensions( 'margin' );
		},
		
		/* Default Field Previews
		----------------------------------------------------------*/
		
		/**
		 * Initializes the default preview logic for each
		 * field in a settings form.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initDefaultFieldPreviews
		 */
		_initDefaultFieldPreviews: function()
		{
			var fields      = this.elements.settings.find('.fl-field'),
				field       = null,
				fieldType   = null,
				preview     = null,
				i           = 0;
			
			for( ; i < fields.length; i++) {
			
				field   = fields.eq(i);
				preview = field.data('preview');
				
				if(preview.type == 'refresh') {
					this._initFieldRefreshPreview(field);
				}
				if(preview.type == 'text') {
					this._initFieldTextPreview(field);
				}
				if(preview.type == 'css') {
					this._initFieldCSSPreview(field);
				}
				if(preview.type == 'widget') {
					this._initFieldWidgetPreview(field);
				}
				if(preview.type == 'font') {
					this._initFieldFontPreview(field);
				}
			}
		},
		
		/**
		 * Initializes the refresh preview for a field.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initFieldRefreshPreview
		 * @param {Object} field The field to preview.
		 */
		_initFieldRefreshPreview: function(field)
		{
			var fieldType = field.data('type'),
				preview   = field.data('preview'),
				callback  = $.proxy(this.delayPreview, this);
			
			switch(fieldType) {
						
				case 'text':
					field.find('input[type=text]').on('keyup', callback);
				break;
				
				case 'textarea':
					field.find('textarea').on('keyup', callback);
				break;
				
				case 'select':
					field.find('select').on('change', callback);
				break;
				
				case 'color':
					field.find('.fl-color-picker-value').on('change', callback);
				break;
				
				case 'photo':
					field.find('select').on('change', callback);
				break;
				
				case 'multiple-photos':
					field.find('input').on('change', callback);
				break;
				
				case 'photo-sizes':
					field.find('select').on('change', callback);
				break;
				
				case 'video':
					field.find('input').on('change', callback);
				break;
				
				case 'multiple-audios':
					field.find('input').on('change', callback);
				break;

				case 'icon':
					field.find('input').on('change', callback);
				break;
				
				case 'form':
					field.delegate('input', 'change', callback);
				break;
				
				case 'editor':
					this._addTextEditorCallback(field, preview);
				break;
				
				case 'code':
					field.find('textarea').on('change', callback);
				break;
				
				case 'post-type':
					field.find('select').on('change', callback);
				break;
				
				case 'suggest':
					field.find('.as-values').on('change', callback);
				break;
						
				case 'unit':
					field.find('input[type=number]').on('keyup', callback);
				break;

			}
		},
		
		/**
		 * Initializes a text preview for a field.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initFieldTextPreview
		 * @param {Object} field The field to preview.
		 */
		_initFieldTextPreview: function(field)
		{
			var fieldType = field.data('type'),
				preview   = field.data('preview'),
				callback  = $.proxy(this._previewText, this, preview);
			
			switch(fieldType) {
				
				case 'text':
					field.find('input[type=text]').on('keyup', callback);
				break;
				
				case 'unit':
					field.find('input[type=number]').on('keyup', callback);
				break;
				
				case 'textarea':
					field.find('textarea').on('keyup', callback);
				break;
				
				case 'code':
					field.find('textarea').on('change', callback);
				break;
				
				case 'editor':
					this._addTextEditorCallback(field, preview);
				break;
			}
		},

		/**
		 * Runs a real time preview for text fields.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _previewText
		 * @param {Object} preview A preview object.
		 * @param {Object} e An event object.
		 */
		_previewText: function(preview, e)
		{
			var element = this.elements.node.find(preview.selector),
				text    = $('<div>' + $(e.target).val() + '</div>');
				
			if(element.length > 0) {
				text.find('script').remove();
				element.html(text.html());
			}
		},
		
		/**
		 * Runs a real time preview for text editor fields.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _previewText
		 * @param {Object} preview A preview object.
		 * @param {String} id The ID of the text editor.
		 * @param {Object} e An event object.
		 */
		_previewTextEditor: function(preview, id, e)
		{
			var element  = this.elements.node.find(preview.selector),
				editor   = typeof tinyMCE != 'undefined' ? tinyMCE.get(id) : null,
				textarea = $('#' + id),
				text     = '';

			if(element.length > 0) {
			
				if(editor && textarea.css('display') == 'none') {
					text = $('<div>' + editor.getContent() + '</div>');
				} 
				else {
					if ( 'undefined' == typeof switchEditors || 'undefined' == typeof switchEditors.wpautop ) {
						text = $('<div>' + textarea.val() + '</div>');
					}
					else {
						text = $('<div>' + switchEditors.wpautop( textarea.val() ) + '</div>');
					}
				}
			
				text.find('script').remove();
				element.html(text.html());
			}
		},
		
		/**
		 * Callback for text editor previews.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _previewText
		 * @param {Object} field A field object.
		 * @param {Object} preview A preview object.
		 */
		_addTextEditorCallback: function(field, preview)
		{
			var id       = field.find('textarea.wp-editor-area').attr('id'),
				callback = null;
				
			if(preview.type == 'refresh') {
				callback = $.proxy(this.delayPreview, this);
			}
			else if(preview.type == 'text') {
				callback = $.proxy(this._previewTextEditor, this, preview, id);
			}
			else {
				return;
			}
							
			$('#' + id).on('keyup', callback);
			
			if(typeof tinyMCE != 'undefined') {
				editor = tinyMCE.get(id);
				editor.on('change', callback);
				editor.on('keyup', callback);
			}
		},

		/**
		 * Initializes a font preview for a field.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initFieldFontPreview
		 * @param {Object} field The field to preview.
		 */
		_initFieldFontPreview: function(field)
		{
			var fieldType = field.data('type'),
				preview   = field.data('preview');

			// store field id
			preview.id = field.attr( 'id' );

			var callback  = $.proxy(this._previewFont, this, preview);
			
			if( fieldType == 'font' ){
				field.find('.fl-font-field').on('change', 'select', callback);
			}

		},

		/**
		 * Gets the selected font and weight, and make the necessary updates for live preview.
		 *
		 * @since 1.6.3
		 * @access private
		 * @see _getPreviewSelector
		 * @see _buildFontStylesheet
		 * @see updateCSSRule
		 *
		 * @method _previewFont
		 * @param  {Object} preview An object with data about the current field and css selector.
		 * @param  {[type]} e       The current field.
		 */
		_previewFont: function( preview, e ){
			var parent     = $( e.delegateTarget ),
				font       = parent.find( '.fl-font-field-font' ),
				selected   = $( font ).find( ':selected' ),
				fontGroup  = selected.parent().attr( 'label' ),
				weight     = parent.find( '.fl-font-field-weight' ),
				uniqueID   = preview.id + '-' + this.nodeId,
				selector = this._getPreviewSelector( this.classes.node, preview.selector );

			// If the selected font is a Google Font, build the font stylesheet
			if( fontGroup == 'Google' ){
				this._buildFontStylesheet( uniqueID, font.val(), weight.val() );
			}

			if( font.val() == 'Default' ){
				this.updateCSSRule( selector, 'font-family', '' );
				this.updateCSSRule( selector, 'font-weight', '' );
			} else {
				// Updated CSS rules
				this.updateCSSRule( selector, 'font-family', font.val() );
				this.updateCSSRule( selector, 'font-weight', weight.val() );				
			}

		},

		/**
		 * Gets all fonts store insite FLBuilderPreview._fontsList and renders the respective 
		 * link tag with Google Fonts.
		 *
		 * @since 1.6.3
		 * @access private
		 *
		 * @method _buildFontStylesheet
		 * @param  {String} id     The field unique ID.
		 * @param  {String} font   The selected font.
		 * @param  {String} weight The selected weight.
		 */
		_buildFontStylesheet: function( id, font, weight ){
			var url     = FLBuilderConfig.googleFontsUrl,
				href    = '',
				fontObj = {},
				fontArray = {};

			// build the font family / weight object
			fontObj[ font ] = [ weight ];

			// adds to the list of fonts for this font setting
		    FLBuilderPreview._fontsList[ id ] = fontObj;

			// iterate over the keys of the FLBuilderPreview._fontsList object      
			Object.keys( FLBuilderPreview._fontsList ).forEach( function( fieldFont ) {
			
				var field = FLBuilderPreview._fontsList[ fieldFont ];

				// iterate over the font / weight object
				Object.keys( field ).forEach( function( key ) {

					// get the weights of this font
					var weights = field[ key ];
					fontArray[ key ] = fontArray[ key ] || [];

					// remove duplicates from the values array
					weights = weights.filter( function( weight ) {
				        return fontArray[ key ].indexOf( weight ) < 0;
				    });

					fontArray[ key ] = fontArray[ key ].concat( weights );						
						
				});

			});

			$.each( fontArray, function( font, weight ){
				href += font + ':' + weight.join() + '|';
			} );

			// remove last character and replace spaces with plus signs
			href = url + href.slice( 0, -1 ).replace( ' ', '+' );

			if( $( '#fl-builder-google-fonts-preview' ).length < 1 ){
				$( '<link>' )
					.attr( 'id', 'fl-builder-google-fonts-preview' )
					.attr( 'type', 'text/css' )
					.attr( 'rel', 'stylesheet' )
					.attr( 'href', href )
					.appendTo('head');			
			} else{
				$( '#fl-builder-google-fonts-preview' ).attr( 'href', href );
			}

		},
		
		/**
		 * Initializes CSS previews for a node.
		 *
		 * @since 1.3.3
		 * @since 1.6.1 Reworked to accept a preview.rules array.
		 * @access private
		 * @method _initFieldCSSPreview
		 * @param {Object} field A field object.
		 */
		_initFieldCSSPreview: function( field )
		{
			var preview = field.data( 'preview' ),
				i 		= null;
				
			if ( 'undefined' != typeof preview.rules ) {
				for ( i in preview.rules ) {
					this._initFieldCSSPreviewCallback( field, preview.rules[ i ] );
				}
			}
			else {
				this._initFieldCSSPreviewCallback( field, preview );
			}
		},
		
		/**
		 * Initializes CSS preview callbacks for a field.
		 *
		 * @since 1.6.1
		 * @access private
		 * @method _initFieldCSSPreviewCallback
		 * @param {Object} field A field object.
		 * @param {Object} preview The preview data object.
		 */
		_initFieldCSSPreviewCallback: function( field, preview )
		{
			switch( field.data( 'type' ) ) {
				
				case 'text':
					field.find( 'input[type=text]' ).on( 'keyup', $.proxy( this._previewCSS, this, preview ) );
				break;
				
				case 'unit':
					field.find( 'input[type=number]' ).on( 'keyup', $.proxy( this._previewCSS, this, preview ) );
				break;
				
				case 'select':
					field.find( 'select' ).on( 'change', $.proxy( this._previewCSS, this, preview ) );
				break;
				
				case 'color':
					field.find( '.fl-color-picker-value' ).on( 'change', $.proxy( this._previewColor, this, preview ) );
				break;
			}
		},
		
		/**
		 * Updates the CSS rule for a preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _previewCSS
		 * @param {Object} preview A preview object.
		 * @param {Object} e An event object.
		 */
		_previewCSS: function(preview, e)
		{
			var selector = this._getPreviewSelector( this.classes.node, preview.selector ),
				property = preview.property,
				unit     = typeof preview.unit == 'undefined' ? '' : preview.unit,
				input    = $(e.target),
				value    = input.val();
				
			if(unit == '%') {
				value = parseInt(value)/100;
			}
			else {
				value += unit;
			}
			
			if ( input.closest( '.fl-field-responsive-setting' ).length ) {
				this.updateResponsiveCSSRule( selector, property, value );
			}
			else {
				this.updateCSSRule( selector, property, value );
			}
		},
		
		/**
		 * Updates the CSS rule for a color preview.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _previewColor
		 * @param {Object} preview A preview object.
		 * @param {Object} e An event object.
		 */
		_previewColor: function(preview, e)
		{
			var selector = this._getPreviewSelector( this.classes.node, preview.selector ),
				input    = $(e.target),
				val      = input.val(),
				color    = val === '' ? 'inherit' : '#' + val;
				
			if ( input.closest( '.fl-field-responsive-setting' ).length ) {
				this.updateResponsiveCSSRule( selector, preview.property, color );
			}
			else {
				this.updateCSSRule( selector, preview.property, color );
			}
		},
		
		/**
		 * Initializes the preview for a WordPress widget.
		 *
		 * @since 1.3.3
		 * @access private
		 * @method _initFieldWidgetPreview
		 * @param {Object} field A field object.
		 */
		_initFieldWidgetPreview: function(field)
		{
			var callback = $.proxy(this.delayPreview, this);
			
			field.find('input').on('keyup', callback);
			field.find('input[type=checkbox]').on('click', callback);
			field.find('textarea').on('keyup', callback);
			field.find('select').on('change', callback);
		},
		
		/**
		 * Returns a formatted selector string for a preview.
		 *
		 * @since 1.6.1
		 * @access private
		 * @method _getPreviewSelector
		 * @param {String} selector A CSS selector string.
		 * @return {String}
		 */
		_getPreviewSelector: function( prefix, selector )
		{
			var formatted = '',
				parts 	  = selector.split( ',' ),
				i 	  	  = 0;
			
			for ( ; i < parts.length; i++ ) {
				
				formatted += prefix + ' ' + parts[ i ];
				
				if ( i != parts.length - 1 ) {
					formatted += ', ';
				}
			}
			
			return formatted;
		}
	};

})(jQuery);
