(function($){

	/**
	 * Custom lightbox for builder popups.
	 *
	 * @class FLLightbox
	 * @since 1.0
	 */
	FLLightbox = function(settings)
	{
		this._init(settings);
		this._render();
		this._bind();
	};
	
	/**
	 * Closes the lightbox of a child element that
	 * is passed to this method.
	 *
	 * @since 1.0
	 * @static
	 * @method closeParent
	 * @param {Object} child An HTML element or jQuery reference to an element.
	 */ 
	FLLightbox.closeParent = function(child)
	{
		var instanceId = $(child).closest('.fl-lightbox-wrap').attr('data-instance-id');
			
		FLLightbox._instances[instanceId].close();
	};
	
	/**
	 * An object that stores a reference to each
	 * lightbox instance that is created.
	 *
	 * @since 1.0
	 * @static
	 * @access private
	 * @property {Object} _instances
	 */  
	FLLightbox._instances = {};

	/**
	 * Prototype for new instances.
	 *
	 * @since 1.0
	 * @property {Object} prototype
	 */  
	FLLightbox.prototype = {

		/**
		 * A unique ID for this instance that's used to store
		 * it in the static _instances object.
		 *
		 * @since 1.0
		 * @access private
		 * @property {String} _id
		 */  
		_id: null,
		
		/**
		 * A jQuery reference to the main wrapper div.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Object} _node
		 */ 
		_node: null,
		
		/**
		 * Flag for whether the lightbox is visible or not.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _visible
		 */ 
		_visible: false,
		
		/**
		 * A timeout used to throttle the resize event.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Object} _resizeTimer
		 */
		_resizeTimer: null,
		
		/**
		 * A flag for whether this instance should be 
		 * draggable or not.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _draggable
		 */
		_draggable: false,
		
		/**
		 * Default config object.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Object}  _defaults
		 * @property {String}  _defaults.className 		- A custom classname to add to the wrapper div.
		 * @property {Boolean} _defaults.destroyOnClose - Flag for whether the instance should be destroyed when closed.
		 */
		_defaults: {
			className: '',
			destroyOnClose: false
		},
		
		/**
		 * Opens the lightbox. You can pass new content to this method. 
		 * If no content is passed, the previous content will be shown.
		 *
		 * @since 1.0
		 * @method open
		 * @param {String} content HTML content to add to the lightbox.
		 */
		open: function(content)
		{
			this._node.find('.fl-lightbox').attr( 'style', '' );
			this._node.show();
			this._visible = true;
			
			if(typeof content !== 'undefined') {
				this.setContent(content);
			}
			else {
				this._resize();
			}
			
			this.trigger('open');
		},
		
		/**
		 * Closes the lightbox.
		 *
		 * @since 1.0
		 * @method close
		 */
		close: function()
		{
			this._node.hide();
			this._visible = false;
			this.trigger('close');
			
			if(this._defaults.destroyOnClose) {
				this.destroy();
			}
		},
		
		/**
		 * Adds HTML content to the lightbox replacing any
		 * previously added content.
		 *
		 * @since 1.0
		 * @method setContent
		 * @param {String} content HTML content to add to the lightbox.
		 */
		setContent: function(content)
		{
			this._node.find('.fl-lightbox-content').html(content);
			this._resize();
		},
		
		/**
		 * Uses the jQuery empty function to remove lightbox
		 * content and any related events.
		 *
		 * @since 1.0
		 * @method empty
		 */
		empty: function()
		{
			this._node.find('.fl-lightbox-content').empty();
			this._node.find('.fl-lightbox').removeClass('fl-lightbox-expanded');
		},
		
		/**
		 * Bind an event to the lightbox.
		 *
		 * @since 1.0
		 * @method on
		 * @param {String} event The type of event to bind.
		 * @param {Function} callback A callback to fire when the event is triggered.
		 */
		on: function(event, callback)
		{
			this._node.on(event, callback);
		},
		
		/**
		 * Unbind an event from the lightbox.
		 *
		 * @since 1.0
		 * @method off
		 * @param {String} event The type of event to unbind.
		 */
		off: function(event)
		{
			this._node.off(event);
		},
		
		/**
		 * Trigger an event on the lightbox.
		 *
		 * @since 1.0
		 * @method trigger
		 * @param {String} event The type of event to trigger.
		 * @param {Object} params Additional parameters to pass to the event.
		 */
		trigger: function(event, params)
		{
			this._node.trigger(event, params);
		},
		
		/**
		 * Enable or disable dragging for the lightbox.
		 *
		 * @since 1.0
		 * @method draggable
		 * @param {Boolean} toggle Whether the lightbox should be draggable or not.
		 */
		draggable: function(toggle)
		{
			var mask     = this._node.find('.fl-lightbox-mask'),
				lightbox = this._node.find('.fl-lightbox');
				
			toggle = typeof toggle === 'undefined' ? false : toggle;
			
			if(this._draggable) {
				lightbox.draggable('destroy');
			}

			if(toggle) {
			
				this._unbind();
				this._draggable = true;
				mask.hide();
			
				lightbox.draggable({
					cursor: 'move',
					handle: toggle.handle || ''
				});
			}
			else {
				mask.show();
				this._bind();
				this._draggable = false;
			}

			this._resize();
		},
		
		/**
		 * Destroy the lightbox by removing all elements, events
		 * and object references.
		 *
		 * @since 1.0
		 * @method destroy
		 */
		destroy: function()
		{
			$(window).off('resize.fl-lightbox-' + this._id);
			
			this._node.empty();
			this._node.remove();
			
			FLLightbox._instances[this._id] = 'undefined';
			try{ delete FLLightbox._instances[this._id]; } catch(e){}
		},

		/**
		 * Render the expand/contract of lightbox
		 * 
		 * @method renderResize
		 * @param {String}		 
		 */
		renderResize: function(method)
		{	
			if(typeof method !== 'undefined') {
				var	activeNode 		= this._getActiveNode();
					lightbox  		= activeNode.find('.fl-lightbox'),
					boxFields 		= lightbox.find('.fl-builder-settings-fields'),
					win       		= $(window),
					winHeight 		= win.height(),
					winWidth  		= win.width(),
					boxHeaderHeight = lightbox.find('.fl-lightbox-header').height(),
					boxTabsHeight 	= lightbox.find('.fl-builder-settings-tabs').height(),
					boxFooterHeight = lightbox.find('.fl-lightbox-footer').height(),
					boxFieldHeight  = (winHeight - (boxHeaderHeight + boxTabsHeight + boxFooterHeight + 103)),
					editor          = typeof tinymce !== 'undefined' && tinymce.EditorManager.activeEditor ? tinymce : null,
					editorId 		= editor ? editor.EditorManager.activeEditor.id : 'flhiddeneditor',
					editorIframeEl 	= lightbox.find('#'+ editorId +'_ifr'),
					editorTextarea 	= lightbox.find('#'+ editorId),
					codeField 		= lightbox.find('.fl-code-field .ace_editor');

				if(method == 'expand' || method == 'window_resize') {
					if(method == 'window_resize' && !lightbox.hasClass('fl-lightbox-expanded')) {
						return false;
					}
					
					boxFields.css('height', boxFieldHeight + 'px');
					
					if(method == 'expand') {
						lightbox.addClass('fl-lightbox-expanded');	
						lightbox.draggable('disable');
					}					

					if(editorIframeEl.length > 0) {
						editorIframeEl.css('height', (boxFieldHeight - 145) + 'px');
					}

					if(editorTextarea.length > 0) {
						editorTextarea.css('height', (boxFieldHeight - 145) + 'px');
					}

					if(codeField.length > 0) {
						codeField.css('height', (boxFieldHeight - 30) + 'px');
					}
					
				}
				else {
					// Contract lightbox
					setTimeout($.proxy(this._resize, this), 250);

					lightbox.removeClass('fl-lightbox-expanded');
					boxFields.removeAttr('style');
					
					if(editorId !== null) {
						editorIframeEl.css('height', '232px');
						editorTextarea.css('height', '232px');
					}

					if(codeField.length > 0) {
						codeField.css('height', '380px');
					}

					lightbox.draggable('enable');
				}			
			}		
		},
		
		/**
		 * Initialize this lightbox instance.
		 *
		 * @since 1.0
		 * @access private
		 * @method _init
		 * @param {Object} settings A setting object for this instance.
		 */
		_init: function(settings)
		{
			var i    = 0,
				prop = null;
			
			for(prop in FLLightbox._instances) {
				i++;
			}
			
			this._defaults = $.extend({}, this._defaults, settings);
			this._id = new Date().getTime() + i;
			FLLightbox._instances[this._id] = this;
		},
		
		/**
		 * Renders the main wrapper.
		 *
		 * @since 1.0
		 * @access private
		 * @method _render
		 */
		_render: function()
		{
			this._node = $('<div class="fl-lightbox-wrap" data-instance-id="'+ this._id +'"><div class="fl-lightbox-mask"></div><div class="fl-lightbox"><div class="fl-lightbox-content-wrap"><div class="fl-lightbox-content"></div></div></div></div>');
			
			this._node.addClass(this._defaults.className);
			
			$('body').append(this._node);
		},
		
		/**
		 * Binds events for this instance.
		 *
		 * @since 1.0
		 * @access private
		 * @method _bind
		 */
		_bind: function()
		{
			$(window).on('resize.fl-lightbox-' + this._id, $.proxy(this._delayedResize, this));
		},
		
		/**
		 * Unbinds events for this instance.
		 *
		 * @since 1.0
		 * @access private
		 * @method _unbind
		 */
		_unbind: function()
		{
			$(window).off('resize.fl-lightbox-' + this._id);
		},
		
		/**
		 * Resizes the lightbox after a delay.
		 *
		 * @since 1.0
		 * @access private
		 * @method _delayedResize
		 */
		_delayedResize: function()
		{
			clearTimeout(this._resizeTimer);
			
			this._resizeTimer = setTimeout($.proxy(this._resize, this), 250);
			
			this.renderResize('window_resize');
		},
		
		/**
		 * Resizes the lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _resize
		 */
		_resize: function()
		{
			if(this._visible) {
			
				var lightbox  = this._node.find('.fl-lightbox'),
					boxHeight = lightbox.height(),
					boxWidth  = lightbox.width(),
					win       = $(window),
					winHeight = win.height(),
					winWidth  = win.width(),
					top       = '0px',
					left      = ((winWidth - boxWidth)/2 - 30) + 'px';
				
				// Zero out margins and position.
				lightbox.css({
					'margin' : '0px',
					'top'    : 'auto',
					'left'   : 'auto'
				});
				
				// Get the top position. 
				if(winHeight - 80 > boxHeight) {
					top = ((winHeight - boxHeight)/2 - 40) + 'px';
				}
				
				// Set the positions.
				if(this._draggable) {
					lightbox.css('top', top);
					lightbox.css('left', FLBuilderConfig.isRtl ? '-' + left : left);
				}
				else {
					lightbox.css('margin-top', top);
					lightbox.css('margin-left', 'auto');
					lightbox.css('margin-right', 'auto');
				}
			}
		},
		
		/**
		 * Closes the lightbox when the esc key is pressed. 
		 * Currently not in use.
		 *
		 * @since 1.0
		 * @access private
		 * @method _onKeypress
		 * @param {Object} e An event object.
		 */
		_onKeypress: function(e)
		{
			if(e.which == 27 && this._visible) {
				this.close();
			}
		},

		/**
		 * Get the current active lightbox from multiple instances.
		 *
		 * @since 1.0
		 * @access private
		 * @method _getActiveNode
		 * @return {object} Current node
		 */
		_getActiveNode: function()
		{
			var activeNode = this._node;

			$.each(FLLightbox._instances, function(i, obj){
				if($(obj._node).is(':visible')) {
					activeNode = $(obj._node);
				}
			});

			return activeNode;
		}
	};

})(jQuery);