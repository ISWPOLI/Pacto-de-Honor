(function($){

	/**
	 * The main builder interface class.
	 * 
	 * @since 1.0
	 * @class FLBuilder
	 */
	FLBuilder = {
	
		/**
		 * An instance of FLBuilderPreview for working
		 * with the current live preview.
		 *
		 * @since 1.3.3
		 * @property {FLBuilderPreview} preview
		 */
		preview                     : null,
	
		/**
		 * An instance of FLLightbox for displaying a list
		 * of actions a user can take such as publish or cancel.
		 *
		 * @since 1.0
		 * @access private
		 * @property {FLLightbox} _actionsLightbox
		 */
		_actionsLightbox            : null,
		
		/**
		 * A jQuery reference to a module element that should be
		 * added to a new node after it has been rendered.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Object} _addModuleAfterNodeRender
		 */
		_addModuleAfterNodeRender   : null,
		
		/**
		 * An object that holds data for column resizing.
		 *
		 * @since 1.6.4
		 * @access private
		 * @property {Object} _colResizeData
		 */
		_colResizeData              : null,
		
		/**
		 * A flag for whether a column is being resized or not.
		 *
		 * @since 1.6.4
		 * @access private
		 * @property {Boolean} _colResizing
		 */
		_colResizing              	: false,
		
		/**
		 * The CSS class of the main content wrapper for the
		 * current layout that is being worked on.
		 *
		 * @since 1.0
		 * @access private
		 * @property {String} _contentClass
		 */
		_contentClass               : false,
		
		/**
		 * Whether dragging has been enabled or not.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _dragEnabled
		 */
		_dragEnabled                : false,
		
		/**
		 * Whether an element is currently being dragged or not.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _dragging
		 */
		_dragging                   : false,
		
		/**
		 * The initial scroll top of the window when a drag starts.
		 * Used to reset the scroll top when a drag is cancelled.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _dragging
		 */
		_dragInitialScrollTop       : 0,
		
		/**
		 * The URL to redirect to when a user leaves the builder.
		 *
		 * @since 1.0
		 * @access private
		 * @property {String} _exitUrl
		 */
		_exitUrl                    : null,
	
		/**
		 * An instance of FLBuilderAJAXLayout for rendering
		 * the layout via AJAX.
		 *
		 * @since 1.7
		 * @property {FLBuilderAJAXLayout} _layout
		 */
		_layout                     : null,
	
		/**
		 * A cached copy of custom layout CSS that is used to 
		 * revert changes if the cancel button is clicked.
		 *
		 * @since 1.7
		 * @property {String} _layoutSettingsCSSCache
		 */
		_layoutSettingsCSSCache     : null,
	
		/**
		 * A timeout for throttling custom layout CSS changes.
		 *
		 * @since 1.7
		 * @property {Object} _layoutSettingsCSSTimeout
		 */
		_layoutSettingsCSSTimeout   : null,
		
		/**
		 * An instance of FLLightbox for displaying settings.
		 *
		 * @since 1.0
		 * @access private
		 * @property {FLLightbox} _lightbox
		 */
		_lightbox                   : null,
		
		/**
		 * A timeout for refreshing the height of lightbox scrollbars
		 * in case the content changes from dynamic settings.
		 *
		 * @since 1.0
		 * @access private
		 * @property {Object} _lightboxScrollbarTimeout
		 */
		_lightboxScrollbarTimeout   : null,
		
		/**
		 * An array that's used to cache which module settings
		 * CSS and JS assets have already been loaded so they
		 * are only loaded once.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Array} _loadedModuleAssets
		 */
		_loadedModuleAssets         : [],
		
		/**
		 * An object used to store module settings helpers.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _moduleHelpers
		 */
		_moduleHelpers              : {},
		
		/**
		 * An instance of wp.media used to select multiple photos.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _multiplePhotoSelector
		 */
		_multiplePhotoSelector      : null,
		
		/**
		 * A jQuery reference to a row that a new column group
		 * should be added to once it's finished rendering.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _newColGroupParent
		 */
		_newColGroupParent          : null,
		
		/**
		 * The position a column group should be added to within
		 * a row once it finishes rendering.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Number} _newColGroupPosition
		 */
		_newColGroupPosition        : 0,
		
		/**
		 * A jQuery reference to a new module's parent.
		 * 
		 * @since 1.7
		 * @access private
		 * @property {Object} _newModuleParent
		 */
		_newModuleParent          	: null,
		
		/**
		 * The position a new module should be added at once 
		 * it finishes rendering.
		 * 
		 * @since 1.7
		 * @access private
		 * @property {Number} _newModulePosition
		 */
		_newModulePosition        	: 0,
		
		/**
		 * The position a row should be added to within
		 * the layout once it finishes rendering.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Number} _newRowPosition
		 */
		_newRowPosition             : 0,
		
		/**
		 * The ID of a template that the user has selected.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Number} _selectedTemplateId
		 */
		_selectedTemplateId         : null,
		
		/**
		 * The type of template that the user has selected.
		 * Possible values are "core" or "user".
		 * 
		 * @since 1.0
		 * @access private
		 * @property {String} _selectedTemplateType
		 */ 
		_selectedTemplateType       : null,
		
		/**
		 * An instance of wp.media used to select a single photo.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _singlePhotoSelector
		 */ 
		_singlePhotoSelector        : null,
		
		/**
		 * An instance of wp.media used to select a single video.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _singleVideoSelector
		 */ 
		_singleVideoSelector        : null,

		/**
		 * An instance of wp.media used to select a multiple audio.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _multipleAudiosSelector
		 */ 
		_multipleAudiosSelector        : null,
		
		/**
		 * Whether the current AJAX update is silent or not. Silent
		 * updates occur without blocking the page with the loading
		 * overlay. If another AJAX request is made during a silent 
		 * update, the loading overlay will be shown and the data for
		 * the second request will be stored so it can be made when 
		 * the silent update completes.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Boolean} _silentUpdate
		 */ 
		_silentUpdate               : false,
		
		/**
		 * Data for an AJAX request that should be made once a silent
		 * update has completed.
		 * 
		 * @since 1.0
		 * @access private
		 * @property {Object} _silentUpdateCallbackData
		 */ 
		_silentUpdateCallbackData   : null,
	
		/**
		 * Initializes the builder interface.
		 *
		 * @since 1.0
		 * @access private
		 * @method _init
		 */
		_init: function()
		{
			FLBuilder._initJQueryReadyFix();
			FLBuilder._initGlobalErrorHandling();
			FLBuilder._initPostLock();
			FLBuilder._initClassNames();
			FLBuilder._initMediaUploader();
			FLBuilder._initOverflowFix();
			FLBuilder._initScrollbars();
			FLBuilder._initLightboxes();
			FLBuilder._initDropTargets();
			FLBuilder._initSortables();
			FLBuilder._initStrings();
			FLBuilder._initTipTips();
			FLBuilder._bindEvents();
			FLBuilder._bindOverlayEvents();
			FLBuilder._setupEmptyLayout();
			FLBuilder._highlightEmptyCols();
			FLBuilder._showTourOrTemplates();
		},
		
		/**
		 * Prevent errors thrown in jQuery's ready function
		 * from breaking subsequent ready calls. 
		 *
		 * @since 1.4.6
		 * @access private
		 * @method _initJQueryReadyFix
		 */
		_initJQueryReadyFix: function()
		{
			if ( FLBuilderConfig.debug ) {
				return;
			}
			
			jQuery.fn.oldReady = jQuery.fn.ready;
			
			jQuery.fn.ready = function( fn ) {
				return jQuery.fn.oldReady( function() {
					try {
						if ( 'function' == typeof fn ) {
							fn();
						}
					}
					catch ( e ){
						FLBuilder.logError( e );
					}
				});
			};
		},
		
		/**
		 * Try to prevent errors from third party plugins
		 * from breaking the builder.
		 *
		 * @since 1.4.6
		 * @access private
		 * @method _initGlobalErrorHandling
		 */
		_initGlobalErrorHandling: function()
		{
			if ( FLBuilderConfig.debug ) {
				return;
			}
			
			window.onerror = function( message, file, line, col, error ) {
				FLBuilder.logGlobalError( message, file, line, col, error );
				return true;
			};
		},
		
		/**
		 * Send a wp.heartbeat request to lock editing of this
		 * post so it can only be edited by the current user.
		 *
		 * @since 1.0.6
		 * @access private
		 * @method _initPostLock
		 */
		_initPostLock: function()
		{
			if(typeof wp.heartbeat != 'undefined') {
			
				wp.heartbeat.interval(30);
				
				wp.heartbeat.enqueue('fl_builder_post_lock', {
					post_id: $('#fl-post-id').val()
				});
			}
		},
		
		/**
		 * Initializes html and body classes as well as the
		 * builder content class for this post.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initClassNames
		 */
		_initClassNames: function()
		{
			$('html').addClass('fl-builder-edit');
			$('body').addClass('fl-builder');
			
			if(FLBuilderConfig.simpleUi) {
				$('body').addClass('fl-builder-simple');
			}
			
			FLBuilder._contentClass = '.fl-builder-content-' + FLBuilderConfig.postId;
		},
		
		/**
		 * Initializes the WordPress media uploader so any files
		 * uploaded will be attached to the current post.
		 *
		 * @since 1.2.2
		 * @access private
		 * @method _initMediaUploader
		 */
		_initMediaUploader: function()
		{
			wp.media.model.settings.post.id = $('#fl-post-id').val();
		},
		
		/**
		 * Third party themes that set their content wrappers to
		 * overflow:hidden break builder overlays. We set them
		 * to overflow:visible while editing.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initOverflowFix
		 */
		_initOverflowFix: function()
		{
			$(FLBuilder._contentClass).parents().css('overflow', 'visible');
		},
		
		/**
		 * Initializes Nano Scroller scrollbars for the 
		 * builder interface.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initScrollbars
		 */
		_initScrollbars: function()
		{
			$('.fl-nanoscroller').nanoScroller({
				alwaysVisible: true,
				preventPageScrolling: true,
				paneClass: 'fl-nanoscroller-pane',
				sliderClass: 'fl-nanoscroller-slider',
				contentClass: 'fl-nanoscroller-content'
			});
		},
		
		/**
		 * Initializes the lightboxes for the builder interface.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initLightboxes
		 */
		_initLightboxes: function()
		{
			/* Main builder lightbox */
			FLBuilder._lightbox = new FLLightbox({
				className: 'fl-builder-lightbox fl-builder-settings-lightbox'
			});
			
			FLBuilder._lightbox.on('close', FLBuilder._lightboxClosed);
			
			/* Actions lightbox */
			FLBuilder._actionsLightbox = new FLLightbox({
				className: 'fl-builder-actions-lightbox'
			});
		},
		
		/**
		 * Initializes jQuery sortables for drag and drop.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initSortables
		 */
		_initSortables: function()
		{
			var defaults = {
				appendTo: 'body',
				cursor: 'move',
				cursorAt: {
					left: 60, 
					top: 20
				},
				distance: 1,
				helper: FLBuilder._blockDragHelper,
				start : FLBuilder._blockDragStart,
				sort: FLBuilder._blockDragSort,
				change: FLBuilder._blockDragChange,
				stop: FLBuilder._blockDragStop,
				placeholder: 'fl-builder-drop-zone',
				tolerance: 'intersect'
			},
			rowConnections 	  = '',
			moduleConnections = '';
			
			// Module Connections.
			if ( 'row' == FLBuilderConfig.userTemplateType )  {
				moduleConnections = FLBuilder._contentClass + ' .fl-col-group-drop-target, ' +
									FLBuilder._contentClass + ' .fl-col-drop-target, ' + 
							  		FLBuilder._contentClass + ' .fl-col-content';
			}
			else {
				moduleConnections = FLBuilder._contentClass + ' .fl-row-drop-target, ' + 
									FLBuilder._contentClass + ' .fl-col-group-drop-target, ' + 
									FLBuilder._contentClass + ' .fl-col-drop-target, ' + 
							  		FLBuilder._contentClass + ' .fl-row:not(.fl-node-global) .fl-col-content';
			}
			
			// Row Connections.
			if ( FLBuilderConfig.nestedColumns ) {
				rowConnections = moduleConnections;
			}
			else if ( 'row' == FLBuilderConfig.userTemplateType )  {
				rowConnections = FLBuilder._contentClass + ' .fl-col-group-drop-target, ' +
								 FLBuilder._contentClass + ' .fl-col-drop-target';
			}
			else {
				rowConnections = FLBuilder._contentClass + ' .fl-row-drop-target, ' + 
								 FLBuilder._contentClass + ' .fl-col-group-drop-target, ' + 
								 FLBuilder._contentClass + ' .fl-col-drop-target';
			}
			
			// Row layouts from the builder panel.
			$('.fl-builder-rows').sortable($.extend({}, defaults, {
				connectWith: rowConnections,
				items: '.fl-builder-block-row',
				stop: FLBuilder._rowDragStop
			}));
			
			// Row templates from the builder panel.
			$('.fl-builder-row-templates').sortable($.extend({}, defaults, {
				connectWith: FLBuilder._contentClass + ' .fl-row-drop-target',
				items: '.fl-builder-block-row-template',
				stop: FLBuilder._nodeTemplateDragStop
			}));
			
			// Saved rows from the builder panel.
			$('.fl-builder-saved-rows').sortable($.extend({}, defaults, {
				cancel: '.fl-builder-node-template-actions, .fl-builder-node-template-edit, .fl-builder-node-template-delete',
				connectWith: FLBuilder._contentClass + ' .fl-row-drop-target',
				items: '.fl-builder-block-saved-row',
				stop: FLBuilder._nodeTemplateDragStop
			}));
			
			// Modules from the builder panel.
			$('.fl-builder-modules, .fl-builder-widgets').sortable($.extend({}, defaults, {
				connectWith: moduleConnections,
				items: '.fl-builder-block-module',
				stop: FLBuilder._moduleDragStop
			}));
			
			// Module templates from the builder panel.
			$('.fl-builder-module-templates').sortable($.extend({}, defaults, {
				connectWith: moduleConnections,
				items: '.fl-builder-block-module-template',
				stop: FLBuilder._nodeTemplateDragStop
			}));
			
			// Saved modules from the builder panel.
			$('.fl-builder-saved-modules').sortable($.extend({}, defaults, {
				cancel: '.fl-builder-node-template-actions, .fl-builder-node-template-edit, .fl-builder-node-template-delete',
				connectWith: moduleConnections,
				items: '.fl-builder-block-saved-module',
				stop: FLBuilder._nodeTemplateDragStop
			}));
			
			// Rows
			$('.fl-row-sortable-proxy').sortable($.extend({}, defaults, {
				connectWith: FLBuilder._contentClass + ' .fl-row-drop-target',
				helper: FLBuilder._rowDragHelper,
				start: FLBuilder._rowDragStart,
				stop: FLBuilder._rowDragStop
			}));
			
			// Columns
			$('.fl-col-sortable-proxy').sortable($.extend({}, defaults, {
				connectWith: moduleConnections,
				helper: FLBuilder._colDragHelper,
				start: FLBuilder._colDragStart,
				stop: FLBuilder._colDragStop
			}));
			
			// Modules
			$(FLBuilder._contentClass + ' .fl-col-content').sortable($.extend({}, defaults, {
				connectWith: moduleConnections,
				handle: '.fl-module-overlay .fl-block-overlay-actions .fl-block-move',
				helper: FLBuilder._moduleDragHelper,
				items: '.fl-module, .fl-col-group',
				start: FLBuilder._moduleDragStart,
				stop: FLBuilder._moduleDragStop
			}));
			
			// Drop targets
			$(FLBuilder._contentClass + ' .fl-row-drop-target').sortable( defaults );
			$(FLBuilder._contentClass + ' .fl-col-group-drop-target').sortable( defaults );
			$(FLBuilder._contentClass + ' .fl-col-drop-target').sortable( defaults );
		},
		
		/**
		 * Initializes text translation
		 *
		 * @since 1.0
		 * @access private
		 * @method _initStrings
		 */
		_initStrings: function()
		{
			$.validator.messages.required = FLBuilderStrings.validateRequiredMessage;
		},

		/**
		 * Binds most of the events for the builder interface.
		 *
		 * @since 1.0
		 * @access private
		 * @method _bindEvents
		 */
		_bindEvents: function()
		{
			/* Links */
			$('a').on('click', FLBuilder._preventDefault);
			$('.fl-page-nav .nav a').on('click', FLBuilder._headerLinkClicked);
			
			/* Heartbeat */
			$(document).on('heartbeat-tick', FLBuilder._initPostLock);
			
			/* Unload Warning */
			$(window).on('beforeunload', FLBuilder._warnBeforeUnload);
			
			/* Submenus */
			$('body').delegate('.fl-builder-has-submenu', 'click', FLBuilder._submenuParentClicked);
			$('body').delegate('.fl-builder-has-submenu a', 'click', FLBuilder._submenuChildClicked);
			$('body').delegate('.fl-builder-submenu', 'mouseenter', FLBuilder._submenuMouseenter);
			$('body').delegate('.fl-builder-submenu', 'mouseleave', FLBuilder._submenuMouseleave);
			$('body').delegate('.fl-builder-submenu .fl-builder-has-submenu', 'mouseenter', FLBuilder._submenuNestedParentMouseenter);
			
			/* Bar */
			$('.fl-builder-tools-button').on('click', FLBuilder._toolsClicked);
			$('.fl-builder-done-button').on('click', FLBuilder._doneClicked);
			$('.fl-builder-add-content-button').on('click', FLBuilder._showPanel);
			$('.fl-builder-templates-button').on('click', FLBuilder._changeTemplateClicked);
			$('.fl-builder-buy-button').on('click', FLBuilder._upgradeClicked);
			$('.fl-builder-upgrade-button').on('click', FLBuilder._upgradeClicked);
			$('.fl-builder-help-button').on('click', FLBuilder._helpButtonClicked);
			
			/* Panel */
			$('.fl-builder-panel-actions .fl-builder-panel-close').on('click', FLBuilder._closePanel);
			$('.fl-builder-blocks-section-title').on('click', FLBuilder._blockSectionTitleClicked);
			$('body').delegate('.fl-builder-node-template-actions', 'mousedown', FLBuilder._stopPropagation);
			$('body').delegate('.fl-builder-node-template-edit', 'mousedown', FLBuilder._stopPropagation);
			$('body').delegate('.fl-builder-node-template-delete', 'mousedown', FLBuilder._stopPropagation);
			$('body').delegate('.fl-builder-node-template-edit', 'click', FLBuilder._editNodeTemplateClicked);
			$('body').delegate('.fl-builder-node-template-delete', 'click', FLBuilder._deleteNodeTemplateClicked);
			
			/* Drag and Drop */
			$('body').delegate('.fl-builder-block', 'mousedown', FLBuilder._blockDragInit);
			$('body').on('mouseup', FLBuilder._blockDragCancel);
			
			/* Actions Lightbox */
			$('body').delegate('.fl-builder-actions .fl-builder-cancel-button', 'click', FLBuilder._cancelButtonClicked);

			/* Expand/Contract Lightbox */
			$('body').delegate('.fl-lightbox-controls .fa', 'click', FLBuilder._resizeLightbox);			
			
			/* Save Actions */
			$('body').delegate('.fl-builder-save-actions .fl-builder-publish-button', 'click', FLBuilder._publishButtonClicked);
			$('body').delegate('.fl-builder-save-actions .fl-builder-draft-button', 'click', FLBuilder._draftButtonClicked);
			$('body').delegate('.fl-builder-save-actions .fl-builder-discard-button', 'click', FLBuilder._discardButtonClicked);
			
			/* Tools Actions */
			$('body').delegate('.fl-builder-save-user-template-button', 'click', FLBuilder._saveUserTemplateClicked);
			$('body').delegate('.fl-builder-duplicate-layout-button', 'click', FLBuilder._duplicateLayoutClicked);
			$('body').delegate('.fl-builder-layout-settings-button', 'click', FLBuilder._layoutSettingsClicked);
			$('body').delegate('.fl-builder-layout-settings .fl-builder-settings-save', 'click', FLBuilder._saveLayoutSettingsClicked);
			$('body').delegate('.fl-builder-layout-settings .fl-builder-settings-cancel', 'click', FLBuilder._cancelLayoutSettingsClicked);
			$('body').delegate('.fl-builder-global-settings-button', 'click', FLBuilder._globalSettingsClicked);
			$('body').delegate('.fl-builder-global-settings .fl-builder-settings-save', 'click', FLBuilder._saveGlobalSettingsClicked);
			$('body').delegate('.fl-builder-global-settings .fl-builder-settings-cancel', 'click', FLBuilder._cancelLayoutSettingsClicked);
			
			/* Template Selector */
			$('body').delegate('.fl-template-category-select', 'change', FLBuilder._templateCategoryChanged);
			$('body').delegate('.fl-template-preview', 'click', FLBuilder._templateClicked);
			$('body').delegate('.fl-user-template', 'click', FLBuilder._userTemplateClicked);
			$('body').delegate('.fl-user-template-edit', 'click', FLBuilder._editUserTemplateClicked);
			$('body').delegate('.fl-user-template-delete', 'click', FLBuilder._deleteUserTemplateClicked);
			$('body').delegate('.fl-builder-template-replace-button', 'click', FLBuilder._templateReplaceClicked);
			$('body').delegate('.fl-builder-template-append-button', 'click', FLBuilder._templateAppendClicked);
			$('body').delegate('.fl-builder-template-actions .fl-builder-cancel-button', 'click', FLBuilder._templateCancelClicked);
			
			/* User Template Settings */
			$('body').delegate('.fl-builder-user-template-settings .fl-builder-settings-save', 'click', FLBuilder._saveUserTemplateSettings);
			
			/* Help Actions */
			$('body').delegate('.fl-builder-help-tour-button', 'click', FLBuilder._startHelpTour);
			$('body').delegate('.fl-builder-help-video-button', 'click', FLBuilder._watchVideoClicked);
			$('body').delegate('.fl-builder-knowledge-base-button', 'click', FLBuilder._viewKnowledgeBaseClicked);
			$('body').delegate('.fl-builder-forums-button', 'click', FLBuilder._visitForumsClicked);
			
			/* Welcome Actions */
			$('body').delegate('.fl-builder-no-tour-button', 'click', FLBuilder._noTourButtonClicked);
			$('body').delegate('.fl-builder-yes-tour-button', 'click', FLBuilder._yesTourButtonClicked);
			
			/* Alert Lightbox */
			$('body').delegate('.fl-builder-alert-close', 'click', FLBuilder._alertClose);
			
			/* Rows */
			$('body').delegate('.fl-row-overlay .fl-block-remove', 'click', FLBuilder._deleteRowClicked);
			$('body').delegate('.fl-row-overlay .fl-block-copy', 'click', FLBuilder._rowCopyClicked);
			$('body').delegate('.fl-row-overlay .fl-block-move', 'mousedown', FLBuilder._rowDragInit);
			$('body').delegate('.fl-row-overlay .fl-block-settings', 'click', FLBuilder._rowSettingsClicked);
			$('body').delegate('.fl-row-overlay', 'click', FLBuilder._rowSettingsClicked);
			$('body').delegate('.fl-builder-row-settings .fl-builder-settings-save', 'click', FLBuilder._saveSettings);
			
			/* Columns */
			$('body').delegate('.fl-col-overlay .fl-block-move', 'mousedown', FLBuilder._colDragInit);
			$('body').delegate('.fl-col-overlay .fl-block-remove', 'click', FLBuilder._deleteColClicked);
			$('body').delegate('.fl-col-overlay', 'click', FLBuilder._colSettingsClicked);
			$('body').delegate('.fl-builder-col-settings .fl-builder-settings-save', 'click', FLBuilder._saveSettings);
			
			/* Columns Submenu */
			$('body').delegate('.fl-block-col-submenu .fl-block-col-move', 'mousedown', FLBuilder._colDragInit);
			$('body').delegate('.fl-block-col-submenu .fl-block-col-edit', 'click', FLBuilder._colSettingsClicked);
			$('body').delegate('.fl-block-col-submenu .fl-block-col-delete', 'click', FLBuilder._deleteColClicked);
			$('body').delegate('.fl-block-col-submenu .fl-block-col-reset', 'click', FLBuilder._resetColumnWidthsClicked);
			$('body').delegate('.fl-block-col-submenu li', 'mouseenter', FLBuilder._showColHighlightGuide);
			$('body').delegate('.fl-block-col-submenu li', 'mouseleave', FLBuilder._removeColHighlightGuides);
			
			/* Columns Submenu (Parent Column) */
			$('body').delegate('.fl-block-col-submenu .fl-block-col-move-parent', 'mousedown', FLBuilder._colDragInit);
			$('body').delegate('.fl-block-col-submenu .fl-block-col-edit-parent', 'click', FLBuilder._colSettingsClicked);
			
			/* Modules */
			$('body').delegate('.fl-module-overlay .fl-block-remove', 'click', FLBuilder._deleteModuleClicked);
			$('body').delegate('.fl-module-overlay .fl-block-copy', 'click', FLBuilder._moduleCopyClicked);
			$('body').delegate('.fl-module-overlay .fl-block-move', 'mousedown', FLBuilder._blockDragInit);
			$('body').delegate('.fl-module-overlay .fl-block-settings', 'click', FLBuilder._moduleSettingsClicked);
			$('body').delegate('.fl-module-overlay', 'click', FLBuilder._moduleSettingsClicked);
			$('body').delegate('.fl-builder-module-settings .fl-builder-settings-save', 'click', FLBuilder._saveModuleClicked);
			
			/* Node Templates */
			$('body').delegate('.fl-builder-settings-save-as', 'click', FLBuilder._showNodeTemplateSettings);
			$('body').delegate('.fl-builder-node-template-settings .fl-builder-settings-save', 'click', FLBuilder._saveNodeTemplate);
			
			/* Settings */
			$('body').delegate('.fl-builder-settings-tabs a', 'click', FLBuilder._settingsTabClicked);
			$('body').delegate('.fl-builder-settings-cancel', 'click', FLBuilder._settingsCancelClicked);
			
			/* Tooltips */
			$('body').delegate('.fl-help-tooltip-icon', 'mouseover', FLBuilder._showHelpTooltip);
			$('body').delegate('.fl-help-tooltip-icon', 'mouseout', FLBuilder._hideHelpTooltip);
			
			/* Multiple Fields */
			$('body').delegate('.fl-builder-field-add', 'click', FLBuilder._addFieldClicked);
			$('body').delegate('.fl-builder-field-copy', 'click', FLBuilder._copyFieldClicked);
			$('body').delegate('.fl-builder-field-delete', 'click', FLBuilder._deleteFieldClicked);
			
			/* Select Fields */
			$('body').delegate('.fl-builder-settings-fields select', 'change', FLBuilder._settingsSelectChanged);
			
			/* Photo Fields */
			$('body').delegate('.fl-photo-field .fl-photo-select', 'click', FLBuilder._selectSinglePhoto);
			$('body').delegate('.fl-photo-field .fl-photo-edit', 'click', FLBuilder._selectSinglePhoto);
			$('body').delegate('.fl-photo-field .fl-photo-replace', 'click', FLBuilder._selectSinglePhoto);
			$('body').delegate('.fl-photo-field .fl-photo-remove', 'click', FLBuilder._singlePhotoRemoved);
			
			/* Multiple Photo Fields */
			$('body').delegate('.fl-multiple-photos-field .fl-multiple-photos-select', 'click', FLBuilder._selectMultiplePhotos);
			$('body').delegate('.fl-multiple-photos-field .fl-multiple-photos-edit', 'click', FLBuilder._selectMultiplePhotos);
			$('body').delegate('.fl-multiple-photos-field .fl-multiple-photos-add', 'click', FLBuilder._selectMultiplePhotos);
			
			/* Video Fields */
			$('body').delegate('.fl-video-field .fl-video-select', 'click', FLBuilder._selectSingleVideo);
			$('body').delegate('.fl-video-field .fl-video-replace', 'click', FLBuilder._selectSingleVideo);

			/* Multiple Audio Fields */
			$('body').delegate('.fl-multiple-audios-field .fl-multiple-audios-select', 'click', FLBuilder._selectMultipleAudios);
			$('body').delegate('.fl-multiple-audios-field .fl-multiple-audios-edit', 'click', FLBuilder._selectMultipleAudios);
			$('body').delegate('.fl-multiple-audios-field .fl-multiple-audios-add', 'click', FLBuilder._selectMultipleAudios);
			
			/* Icon Fields */
			$('body').delegate('.fl-icon-field .fl-icon-select', 'click', FLBuilder._selectIcon);
			$('body').delegate('.fl-icon-field .fl-icon-replace', 'click', FLBuilder._selectIcon);
			$('body').delegate('.fl-icon-field .fl-icon-remove', 'click', FLBuilder._removeIcon);
			
			/* Settings Form Fields */
			$('body').delegate('.fl-form-field .fl-form-field-edit', 'click', FLBuilder._formFieldClicked);
			$('body').delegate('.fl-form-field-settings .fl-builder-settings-save', 'click', FLBuilder._saveFormFieldClicked);
			
			/* Layout Fields */
			$('body').delegate('.fl-layout-field-option', 'click', FLBuilder._layoutFieldClicked);
			
			/* Links Fields */
			$('body').delegate('.fl-link-field-select', 'click', FLBuilder._linkFieldSelectClicked);
			$('body').delegate('.fl-link-field-search-cancel', 'click', FLBuilder._linkFieldSelectCancelClicked);
			
			/* Loop Builder Fields */
			$('body').delegate('.fl-loop-builder select[name=post_type]', 'change', FLBuilder._loopBuilderPostTypeChange);

			/* Text Fields - Add Value Selector */
			$('body').delegate('.fl-select-add-value', 'change', FLBuilder._textFieldAddValueSelectChange);
		},
		
		/**
		 * Binds the events for overlays that appear when 
		 * mousing over a row, column or module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _bindOverlayEvents
		 */
		_bindOverlayEvents: function()
		{
			var content = $(FLBuilder._contentClass);
			
			content.delegate('.fl-row', 'mouseenter', FLBuilder._rowMouseenter);
			content.delegate('.fl-row', 'mouseleave', FLBuilder._rowMouseleave);
			content.delegate('.fl-row-overlay', 'mouseleave', FLBuilder._rowMouseleave);
			content.delegate('.fl-col', 'mouseenter', FLBuilder._colMouseenter);
			content.delegate('.fl-col', 'mouseleave', FLBuilder._colMouseleave);
			content.delegate('.fl-module', 'mouseenter', FLBuilder._moduleMouseenter);
			content.delegate('.fl-module', 'mouseleave', FLBuilder._moduleMouseleave);
		},
		
		/**
		 * Unbinds the events for overlays that appear when 
		 * mousing over a row, column or module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _destroyOverlayEvents
		 */
		_destroyOverlayEvents: function()
		{
			var content = $(FLBuilder._contentClass);
			
			content.undelegate('.fl-row', 'mouseenter', FLBuilder._rowMouseenter);
			content.undelegate('.fl-row', 'mouseleave', FLBuilder._rowMouseleave);
			content.undelegate('.fl-row-overlay', 'mouseleave', FLBuilder._rowMouseleave);
			content.undelegate('.fl-col', 'mouseenter', FLBuilder._colMouseenter);
			content.undelegate('.fl-col', 'mouseleave', FLBuilder._colMouseleave);
			content.undelegate('.fl-module', 'mouseenter', FLBuilder._moduleMouseenter);
			content.undelegate('.fl-module', 'mouseleave', FLBuilder._moduleMouseleave);
		},
		
		/**
		 * Prevents the default action for an event.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _preventDefault
		 * @param {Object} e The event object.
		 */
		_preventDefault: function( e )
		{
			e.preventDefault();
		},
		
		/**
		 * Prevents propagation of an event.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _stopPropagation
		 * @param {Object} e The event object.
		 */
		_stopPropagation: function( e )
		{
			e.stopPropagation();
		},
		
		/**
		 * Launches the builder for another page if a link in the
		 * builder theme header is clicked.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _headerLinkClicked
		 * @param {Object} e The event object.
		 */
		_headerLinkClicked: function(e)
		{
			var link = $(this),
				href = link.attr('href');
			
			e.preventDefault();
			
			if ( FLBuilderConfig.isUserTemplate )  {
				return;
			}
			
			FLBuilder._exitUrl = href.indexOf('?') > -1 ? href : href + '?fl_builder';
			FLBuilder._doneClicked();
		},
		
		/**
		 * Warns the user that their changes won't be saved if
		 * they leave the page while editing settings.
		 *
		 * @since 1.0.6
		 * @access private
		 * @method _warnBeforeUnload
		 * @return {String} The warning message.
		 */ 
		_warnBeforeUnload: function()
		{
			var rowSettings     = $('.fl-builder-row-settings').length > 0,
				colSettings     = $('.fl-builder-col-settings').length > 0,
				moduleSettings  = $('.fl-builder-module-settings').length > 0;
			
			if(rowSettings || colSettings || moduleSettings) {
				return FLBuilderStrings.unloadWarning;
			}
		},
		
		/* TipTips
		----------------------------------------------------------*/
		
		/**
		 * Initializes tooltip help messages.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _initTipTips
		 */
		_initTipTips: function()
		{
			$('.fl-tip:not(.fl-has-tip)').each( function(){
				var ele = $( this );
				ele.addClass( 'fl-has-tip' );
				if ( undefined == ele.attr( 'data-title' ) ) {
					ele.attr( 'data-title', ele.attr( 'title' ) );
				}
			} ).tipTip( {
				defaultPosition : 'top',
				delay           : 1500
			} );
		},
		
		/**
		 * Removes all tooltip help messages from the screen.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _hideTipTips
		 */
		_hideTipTips: function()
		{
			$('#tiptip_holder').stop().remove();
		},
		
		/* Submenus
		----------------------------------------------------------*/
		
		/**
		 * Callback for when the parent of a submenu is clicked.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _submenuParentClicked
		 * @param {Object} e The event object.
		 */
		_submenuParentClicked: function( e )
		{
			var parent 	 = $( this ),
				submenu  = parent.find( '.fl-builder-submenu' );
				
			if ( parent.hasClass( 'fl-builder-submenu-open' ) ) {
				parent.removeClass( 'fl-builder-submenu-open' );
				parent.removeClass( 'fl-builder-submenu-right' );
			}
			else {
				
				if( parent.offset().left + submenu.width() > $( window ).width() ) {
					parent.addClass( 'fl-builder-submenu-right' );
				}
				
				parent.addClass( 'fl-builder-submenu-open' );
			}
			
			FLBuilder._hideTipTips();
			e.preventDefault();
			e.stopPropagation();
		},
		
		/**
		 * Callback for when the child of a submenu is clicked.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _submenuChildClicked
		 * @param {Object} e The event object.
		 */
		_submenuChildClicked: function( e )
		{
			var parent = $( this ).parents( '.fl-builder-has-submenu' );
			
			if ( ! parent.parents( '.fl-builder-has-submenu' ).length ) {
				parent.removeClass( 'fl-builder-submenu-open' );	
			}
		},
		
		/**
		 * Callback for when the mouse enters a submenu.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _submenuMouseenter
		 * @param {Object} e The event object.
		 */
		_submenuMouseenter: function( e )
		{
			var menu 	= $( this ),
				timeout = menu.data( 'timeout' );
				
			if ( 'undefined' != typeof timeout ) {
				clearTimeout( timeout );
			}
		},
		
		/**
		 * Callback for when the mouse leaves a submenu.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _submenuMouseleave
		 * @param {Object} e The event object.
		 */
		_submenuMouseleave: function( e )
		{
			var menu 	= $( this ),
				timeout = setTimeout( function() {
					menu.closest( '.fl-builder-has-submenu' ).removeClass( 'fl-builder-submenu-open' );
				}, 500 );
			
			menu.data( 'timeout', timeout );
		},
		
		/**
		 * Callback for when the mouse enters the parent
		 * of a nested submenu.
		 *
		 * @since 1.9
		 * @access private
		 * @method _submenuNestedParentMouseenter
		 * @param {Object} e The event object.
		 */
		_submenuNestedParentMouseenter: function( e )
		{
			var parent 	 = $( this ),
				submenu  = parent.find( '.fl-builder-submenu' );
				
			if( parent.width() + parent.offset().left + submenu.width() > $( window ).width() ) {
				parent.addClass( 'fl-builder-submenu-right' );
			}
		},
		
		/**
		 * Closes all open submenus.
		 *
		 * @since 1.9
		 * @access private
		 * @method _closeAllSubmenus
		 */
		_closeAllSubmenus: function()
		{
			$( '.fl-builder-submenu-open' ).removeClass( 'fl-builder-submenu-open' );
		},
		
		/* Bar
		----------------------------------------------------------*/
		
		/**
		 * Shows the actions lightbox when the tools button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _toolsClicked
		 */
		_toolsClicked: function()
		{
			var buttons             = [],
				lite                = FLBuilderConfig.lite,
				enabledTemplates    = FLBuilderConfig.enabledTemplates;
			
			// Template buttons
			if(!lite && !FLBuilderConfig.isUserTemplate && (enabledTemplates == 'enabled' || enabledTemplates == 'user')) {
				buttons[ 10 ] = {
					'key': 'save-user-template',
					'label': FLBuilderStrings.saveTemplate
				};
			}
				
			// Duplicate button
			if(FLBuilderConfig.isUserTemplate) {
				if ( typeof window.opener == 'undefined' || ! window.opener ) {
					buttons[ 20 ] = {
						'key': 'duplicate-layout',
						'label': FLBuilderStrings.duplicateLayout
					};
				}
			}
			else {
				buttons[ 20 ] = {
					'key': 'duplicate-layout',
					'label': FLBuilderStrings.duplicateLayout
				};
			}
			
			// Layout settings button 
			buttons[ 30 ] = {
				'key': 'layout-settings',
				'label': FLBuilderStrings.editLayoutSettings
			};
			
			// Global settings button 
			buttons[ 40 ] = {
				'key': 'global-settings',
				'label': FLBuilderStrings.editGlobalSettings
			};
				
			// Show the lightbox.
			FLBuilder._showActionsLightbox({
				'className' : 'fl-builder-tools-actions',
				'title'     : FLBuilderStrings.actionsLightboxTitle,
				'buttons'   : buttons
			});
		},
		
		/**
		 * Shows the actions lightbox when the done button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _doneClicked
		 */
		_doneClicked: function()
		{
			var buttons           = [],
				publishButtonText = FLBuilderStrings.publish;

			if(FLBuilderConfig.postStatus != 'publish' && !FLBuilderConfig.userCanPublish) {
				publishButtonText = FLBuilderStrings.submitForReview;
			}
			
			buttons[ 10 ] = {
				'key': 'publish',
				'label': publishButtonText
			};
			
			buttons[ 20 ] = {
				'key': 'draft',
				'label': FLBuilderStrings.draft
			};
			
			buttons[ 30 ] = {
				'key': 'discard',
				'label': FLBuilderStrings.discard
			};
			
			FLBuilder._showActionsLightbox({
				'className': 'fl-builder-save-actions',
				'title': FLBuilderStrings.actionsLightboxTitle,
				'buttons': buttons
			});
		},
		
		/**
		 * Opens a new window with the upgrade URL when the 
		 * upgrade button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _upgradeClicked
		 */
		_upgradeClicked: function()
		{
			window.open(FLBuilderConfig.upgradeUrl);
		},
		
		/**
		 * Shows the actions lightbox when the help button is clicked.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _helpButtonClicked
		 */
		_helpButtonClicked: function()
		{
			var buttons = {};
			
			if ( FLBuilderConfig.help.tour ) {
				buttons[ 10 ] = {
					'key': 'help-tour',
					'label': FLBuilderStrings.takeHelpTour
				};
			}
			if ( FLBuilderConfig.help.video ) {
				buttons[ 20 ] = {
					'key': 'help-video',
					'label': FLBuilderStrings.watchHelpVideo
				};
			}
			if ( FLBuilderConfig.help.knowledge_base ) {
				buttons[ 30 ] = {
					'key': 'knowledge-base',
					'label': FLBuilderStrings.viewKnowledgeBase
				};
			}
			if ( FLBuilderConfig.help.forums ) {
				buttons[ 40 ] = {
					'key': 'forums',
					'label': FLBuilderStrings.visitForums
				};
			}
			
			FLBuilder._showActionsLightbox({
				'className': 'fl-builder-help-actions',
				'title': FLBuilderStrings.actionsLightboxTitle,
				'buttons': buttons
			});
		},
		
		/* Panel
		----------------------------------------------------------*/
		
		/**
		 * Closes the builder's content panel.
		 *
		 * @since 1.0
		 * @access private
		 * @method _closePanel
		 */
		_closePanel: function()
		{
			$('.fl-builder-panel').stop(true, true).animate({ right: '-350px' }, 500, function(){ $(this).hide(); });
			$('.fl-builder-bar .fl-builder-add-content-button').stop(true, true).fadeIn();
		},
		
		/**
		 * Opens the builder's content panel.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showPanel
		 */
		_showPanel: function()
		{
			$('.fl-builder-bar .fl-builder-add-content-button').stop(true, true).fadeOut();
			$('.fl-builder-panel').stop(true, true).show().animate({ right: '0' }, 500);
		},
		
		/**
		 * Opens or closes a section in the builder's content panel
		 * when a section title is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockSectionTitleClicked
		 */
		_blockSectionTitleClicked: function()
		{
			var title   = $(this),
				section = title.parent();
				
			if(section.hasClass('fl-active')) {
				section.removeClass('fl-active');
			}
			else {
				$('.fl-builder-blocks-section').removeClass('fl-active');
				section.addClass('fl-active');
			}
			
			FLBuilder._initScrollbars();
		},
		
		/* Save Actions
		----------------------------------------------------------*/
		
		/**
		 * Publishes the layout when the publish button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _publishButtonClicked
		 */
		_publishButtonClicked: function()
		{
			FLBuilder.showAjaxLoader();
			
			FLBuilder.ajax({
				action: 'save_layout'
			}, FLBuilder._exit);
				
			FLBuilder._actionsLightbox.close();
		},
		
		/**
		 * Exits the builder when the save draft button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _draftButtonClicked
		 */
		_draftButtonClicked: function()
		{
			FLBuilder.showAjaxLoader();
			
			FLBuilder.ajax({
				action: 'save_draft'
			}, FLBuilder._exit);
			
			FLBuilder._actionsLightbox.close();
		},
		
		/**
		 * Clears changes to the layout when the discard draft button
		 * is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _discardButtonClicked
		 */
		_discardButtonClicked: function()
		{
			var result = confirm(FLBuilderStrings.discardMessage);
			
			if(result) {
			
				FLBuilder.showAjaxLoader();
				
				FLBuilder.ajax({
					action: 'clear_draft_layout'
				}, FLBuilder._exit);
					
				FLBuilder._actionsLightbox.close();
			}
		},
		
		/**
		 * Closes the actions lightbox when the cancel button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _cancelButtonClicked
		 */
		_cancelButtonClicked: function()
		{
			FLBuilder._exitUrl = null;
			FLBuilder._actionsLightbox.close();
		},
		
		/**
		 * Redirects the user to the _exitUrl if defined, otherwise 
		 * it redirects the user to the current post without the 
		 * builder active. 
		 *
		 * @since 1.0
		 * @since 1.5.7 Closes the window if we're in a child window.
		 * @access private
		 * @method _exit
		 */
		_exit: function()
		{
			var href = window.location.href;
			
			if ( FLBuilderConfig.isUserTemplate && typeof window.opener != 'undefined' && window.opener ) {
				
				if ( typeof window.opener.FLBuilder != 'undefined' ) {
					window.opener.FLBuilder._updateLayout();
				}
				
				window.close();
			}
			else {
				
				if ( FLBuilder._exitUrl ) {
					href = FLBuilder._exitUrl;
				}
				else {
					href = href.replace( '?fl_builder&', '?' );
					href = href.replace( '?fl_builder', '' );
					href = href.replace( '&fl_builder', '' );
				}
				
				window.location.href = href;
			}
		},
		
		/* Tools Actions
		----------------------------------------------------------*/
		
		/**
		 * Duplicates the current post and builder layout.
		 *
		 * @since 1.0
		 * @access private
		 * @method _duplicateLayoutClicked
		 */
		_duplicateLayoutClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder.showAjaxLoader();
			
			FLBuilder.ajax({
				action: 'duplicate_post'
			}, FLBuilder._duplicateLayoutComplete);
		},
		
		/**
		 * Redirects the user to the post edit screen of a
		 * duplicated post when duplication is complete.
		 *
		 * @since 1.0
		 * @access private
		 * @method _duplicatePageComplete
		 * @param {Number} The ID of the duplicated post.
		 */
		_duplicateLayoutComplete: function(response)
		{
			var adminUrl = $('#fl-admin-url').val();
			
			window.location.href = adminUrl + 'post.php?post='+ response +'&action=edit';
		},
		
		/* Layout Settings
		----------------------------------------------------------*/
		
		/**
		 * Shows the layout settings lightbox when the layout
		 * settings button is clicked.
		 *
		 * @since 1.7
		 * @access private
		 * @method _layoutSettingsClicked
		 */       
		_layoutSettingsClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._showLightbox();
			FLBuilder._closePanel();
			
			FLBuilder.ajax({
				action: 'render_layout_settings'
			}, FLBuilder._layoutSettingsLoaded);
		},

		/**
		 * Sets the lightbox content when the layout settings have loaded.
		 *
		 * @since 1.7
		 * @access private
		 * @method _layoutSettingsLoaded
		 * @param {String} response The JSON with the HTML for the layout settings form.
		 */  
		_layoutSettingsLoaded: function( response )
		{
			var data = JSON.parse( response );
			
			FLBuilder._setSettingsFormContent( data.html );
			FLBuilder._layoutSettingsInitCSS();
		},

		/**
		 * Initializes custom layout CSS for live preview.
		 *
		 * @since 1.7
		 * @access private
		 * @method _layoutSettingsInitCSS
		 */  
		_layoutSettingsInitCSS: function()
		{
			var css = $( '.fl-builder-settings #fl-field-css textarea:not(.ace_text-input)' );
				
			css.on( 'change', FLBuilder._layoutSettingsCSSChanged );
			
			FLBuilder._layoutSettingsCSSCache = css.val();
		},

		/**
		 * Sets a timeout for throttling custom layout CSS changes.
		 *
		 * @since 1.7
		 * @access private
		 * @method _layoutSettingsCSSChanged
		 */  
		_layoutSettingsCSSChanged: function()
		{
			if ( FLBuilder._layoutSettingsCSSTimeout ) {
				clearTimeout( FLBuilder._layoutSettingsCSSTimeout );
			}
			
			FLBuilder._layoutSettingsCSSTimeout = setTimeout( $.proxy( FLBuilder._layoutSettingsCSSDoChange, this ), 600 );
		},

		/**
		 * Updates the custom layout CSS when changes are made in the editor.
		 *
		 * @since 1.7
		 * @access private
		 * @method _layoutSettingsCSSDoChange
		 */  
		_layoutSettingsCSSDoChange: function()
		{
			var form	 = $( '.fl-builder-settings' ),
				textarea = $( this ),
				field    = textarea.parents( '#fl-field-css' );
				
			if ( field.find( '.ace_error' ).length > 0 ) {
				return;
			}
			else if ( form.hasClass( 'fl-builder-layout-settings' ) ) {
				$( '#fl-builder-layout-css' ).html( textarea.val() );
			}
			else {
				$( '#fl-builder-global-css' ).html( textarea.val() );
			}
			
			FLBuilder._layoutSettingsCSSTimeout = null;
		},
		
		/**
		 * Saves the layout settings when the save button is clicked.
		 *
		 * @since 1.7
		 * @access private
		 * @method _saveLayoutSettingsClicked
		 */       
		_saveLayoutSettingsClicked: function()
		{
			var form     = $( this ).closest( '.fl-builder-settings' ),
				data     = form.serializeArray(),
				settings = {},
				i        = 0;
					 
			for( ; i < data.length; i++) {
				settings[ data[ i ].name ] = data[ i ].value;
			}
			
			FLBuilder.showAjaxLoader();
			FLBuilder._lightbox.close();
			FLBuilder._layoutSettingsCSSCache = null;
			
			FLBuilder.ajax( {
				action: 'save_layout_settings',
				settings: settings
			}, FLBuilder._updateLayout );
		},
		
		/**
		 * Reverts changes made when the cancel button for the layout
		 * settings has been clicked.
		 *
		 * @since 1.7
		 * @access private
		 * @method _cancelLayoutSettingsClicked
		 */       
		_cancelLayoutSettingsClicked: function()
		{
			var form = $( '.fl-builder-settings' );
			
			if ( form.hasClass( 'fl-builder-layout-settings' ) ) {
				$( '#fl-builder-layout-css' ).html( FLBuilder._layoutSettingsCSSCache );
			}
			else {
				$( '#fl-builder-global-css' ).html( FLBuilder._layoutSettingsCSSCache );
			}
			
			FLBuilder._layoutSettingsCSSCache = null;
		},
		
		/* Global Settings
		----------------------------------------------------------*/
		
		/**
		 * Shows the global builder settings lightbox when the global
		 * settings button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _globalSettingsClicked
		 */       
		_globalSettingsClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._showLightbox();
			
			FLBuilder.ajax({
				action: 'render_global_settings'
			}, FLBuilder._globalSettingsLoaded);
		},

		/**
		 * Sets the lightbox content when the global settings have loaded.
		 *
		 * @since 1.0
		 * @access private
		 * @method _globalSettingsLoaded
		 * @param {String} response The JSON with the HTML for the global settings form.
		 */  
		_globalSettingsLoaded: function(response)
		{
			var data = JSON.parse(response);
			
			FLBuilder._setSettingsFormContent(data.html);
			FLBuilder._layoutSettingsInitCSS();
					  
			FLBuilder._initSettingsValidation({
				row_width: {
					required: true,
					number: true
				},
				responsive_breakpoint: {
					required: true,
					number: true
				}
			});
		},

		/**
		 * Saves the global settings when the save button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveGlobalSettingsClicked
		 */       
		_saveGlobalSettingsClicked: function()
		{
			var form     = $(this).closest('.fl-builder-settings'),
				valid    = form.validate().form(),
				data     = form.serializeArray(),
				settings = {},
				i        = 0;
				
			if(valid) {
					 
				for( ; i < data.length; i++) {
					settings[data[i].name] = data[i].value;
				}
				
				FLBuilder.showAjaxLoader();
				FLBuilder._layoutSettingsCSSCache = null;
				
				FLBuilder.ajax({
					action: 'save_global_settings',
					settings: settings
				}, FLBuilder._saveGlobalSettingsComplete);
					
				FLBuilder._lightbox.close();
			}
		},

		/**
		 * Saves the global settings when the save button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveGlobalSettingsComplete
		 * @param {String} response
		 */       
		_saveGlobalSettingsComplete: function( response )
		{
			FLBuilderConfig.global = JSON.parse( response );
			
			FLBuilder._updateLayout();
		},
		
		/* Template Selector
		----------------------------------------------------------*/
		
		/**
		 * Shows the template selector when the builder is launched
		 * if the current layout is empty.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initTemplateSelector
		 */
		_initTemplateSelector: function()
		{
			var rows = $(FLBuilder._contentClass).find('.fl-row');
			
			if(rows.length === 0) {
				FLBuilder._showTemplateSelector();
			}
		},
		
		/**
		 * Shows the template selector when the templates button
		 * has been clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _changeTemplateClicked
		 */
		_changeTemplateClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._showTemplateSelector();
		},
		
		/**
		 * Shows the template selector lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showTemplateSelector
		 */
		_showTemplateSelector: function()
		{
			if ( FLBuilderConfig.simpleUi ) {
				return;
			}
			if ( FLBuilderConfig.isUserTemplate ) {
				return;   
			}
			if ( 'disabled' == FLBuilderConfig.enabledTemplates ) {
				return;
			}
			if ( 0 === $( '.fl-builder-templates-button' ).length ) {
				return;    
			}
			
			FLBuilder._showLightbox( false );
			
			FLBuilder.ajax({
				action: 'render_template_selector'
			}, FLBuilder._templateSelectorLoaded );
		},
		
		/**
		 * Sets the lightbox content when the template selector has loaded.
		 *
		 * @since 1.0
		 * @access private
		 * @method _templateSelectorLoaded
		 * @param {String} response The JSON with the HTML for the template selector.
		 */
		_templateSelectorLoaded: function( response )
		{
			var data 			= JSON.parse( response ),
				select 			= null,
				userTemplates 	= null;
			
			// Set the lightbox content.
			FLBuilder._setLightboxContent( data.html );
			
			// Set the vars.
			select 			 = $( '.fl-template-category-select' );
			tabs             = $( '.fl-builder-settings-tab' );
			userTemplatesTab = $( '#fl-builder-settings-tab-yours' );
			userTemplates 	 = $( '.fl-user-template' );
			
			// Default to the user templates tab?
			if ( 'user' == FLBuilderConfig.enabledTemplates || userTemplates.length > 0 || ( userTemplatesTab.length > 0 && tabs.length == 1 ) ) {
				select.val( 'fl-builder-settings-tab-yours' );
				$( '.fl-builder-settings-tab' ).removeClass( 'fl-active' );
				$( '#fl-builder-settings-tab-yours' ).addClass( 'fl-active' );
			}
			
			// Show the no templates message?
			if ( 0 === userTemplates.length ) {
				$( '.fl-user-templates-message' ).show();
			}
			
			$( 'body' ).trigger( 'fl-builder.template-selector-loaded' );
		},
		
		/**
		 * Callback to show a template category when the 
		 * select is changed.
		 *
		 * @since 1.5.7
		 * @access private
		 * @method _templateCategoryChanged
		 */
		_templateCategoryChanged: function()
		{
			$( '.fl-template-selector .fl-builder-settings-tab' ).hide();
			$( '#' + $( this ).val() ).show();
		},
		
		/**
		 * Callback for when a user clicks a core template in 
		 * the template selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _templateClicked
		 */
		_templateClicked: function()
		{
			var template = $(this),
				index    = template.closest('.fl-template-preview').attr('data-id');
			
			if($(FLBuilder._contentClass).children('.fl-row').length > 0) {
				
				if(index == 0) {
					if(confirm(FLBuilderStrings.changeTemplateMessage)) {
						FLBuilder._lightbox._node.hide();
						FLBuilder._applyTemplate(0, false, 'core');
					}
				}
				else {
					FLBuilder._selectedTemplateId = index;
					FLBuilder._selectedTemplateType = 'core';
					FLBuilder._showTemplateActions();
					FLBuilder._lightbox._node.hide();
				}                
			}
			else {
				FLBuilder._applyTemplate(index, false, 'core');
			}
		},
		
		/**
		 * Shows the actions lightbox for replacing and appending templates.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _showTemplateActions
		 */
		_showTemplateActions: function()
		{
			var buttons = [];
			
			buttons[ 10 ] = {
				'key': 'template-replace',
				'label': FLBuilderStrings.templateReplace
			};
			
			buttons[ 20 ] = {
				'key': 'template-append',
				'label': FLBuilderStrings.templateAppend
			};
			
			FLBuilder._showActionsLightbox({
				'className': 'fl-builder-template-actions',
				'title': FLBuilderStrings.actionsLightboxTitle,
				'buttons': buttons
			});
		},
		
		/**
		 * Replaces the current layout with a template when the replace
		 * button is clicked.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _templateReplaceClicked
		 */
		_templateReplaceClicked: function()
		{
			if(confirm(FLBuilderStrings.changeTemplateMessage)) {
				FLBuilder._actionsLightbox.close();
				FLBuilder._applyTemplate(FLBuilder._selectedTemplateId, false, FLBuilder._selectedTemplateType);
			}
		},
		
		/**
		 * Append a template to the current layout when the append
		 * button is clicked.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _templateAppendClicked
		 */
		_templateAppendClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._applyTemplate(FLBuilder._selectedTemplateId, true, FLBuilder._selectedTemplateType);
		},
		
		/**
		 * Shows the template selector when the cancel button of
		 * the template actions lightbox is clicked.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _templateCancelClicked
		 */
		_templateCancelClicked: function()
		{
			FLBuilder._lightbox._node.show();
		},
		
		/**
		 * Applys a template to the current layout by either appending
		 * it or replacing the current layout with it.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _applyTemplate
		 * @param {Number} id The template id.
		 * @param {Boolean} append Whether the new template should be appended or not.
		 * @param {String} type The type of template. Either core or user.
		 */
		_applyTemplate: function(id, append, type)
		{
			append  = typeof append === 'undefined' || !append ? '0' : '1';
			type    = typeof type === 'undefined' ? 'core' : type;
			
			FLBuilder._lightbox.close();
			FLBuilder.showAjaxLoader();
		
			if(type == 'core') {
		
				FLBuilder.ajax({
					action: 'apply_template',
					template_id: id,
					append: append
				}, FLBuilder._updateLayout);
			}
			else {
			
				FLBuilder.ajax({
					action: 'apply_user_template',
					template_id: id,
					append: append
				}, FLBuilder._updateTemplateLayout);
			}
		},

		/**
		 * Callback method when applying user template to the current layout
		 
		 * @since 1.9.5
		 * @access private
		 * @method _updateTemplateLayout
		 * @param  {string} response The JSON with the new layout settings
		 */
		_updateTemplateLayout:  function(response)
		{
			var data = JSON.parse(response);
			if( data !== null ) {
				$( '#fl-builder-layout-css' ).html( data.layout_css );
			}
						
			FLBuilder._updateLayout();
		},
		
		/* User Template Settings
		----------------------------------------------------------*/
		
		/**
		 * Shows the settings for saving a user defined template 
		 * when the save template button is clicked.
		 *
		 * @since 1.1.3
		 * @access private
		 * @method _saveUserTemplateClicked
		 */
		_saveUserTemplateClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._showLightbox(false);
			
			FLBuilder.ajax({
				action: 'render_user_template_settings'
			}, FLBuilder._userTemplateSettingsLoaded);
		},
		
		/**
		 * Sets the lightbox content when the user template settings are loaded.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _userTemplateSettingsLoaded
		 * @param {String} response The JSON with the HTML for the user template settings form.
		 */  
		_userTemplateSettingsLoaded: function(response)
		{
			var data = JSON.parse(response);
			
			FLBuilder._setSettingsFormContent(data.html);  
					  
			FLBuilder._initSettingsValidation({
				name: {
					required: true
				}
			});
		},
		
		/**
		 * Saves user template settings when the save button is clicked.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _saveUserTemplateSettings
		 */
		_saveUserTemplateSettings: function()
		{
			var form     = $(this).closest('.fl-builder-settings'),
				valid    = form.validate().form(),
				settings = FLBuilder._getSettings(form);
				
			if(valid) {
					 
				FLBuilder.showAjaxLoader();
				
				FLBuilder.ajax({
					action: 'save_user_template',
					settings: settings
				}, FLBuilder._saveUserTemplateSettingsComplete);
					
				FLBuilder._lightbox.close();
			}
		},
		
		/**
		 * Shows a success alert when user template settings have saved.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _saveUserTemplateSettingsComplete
		 */
		_saveUserTemplateSettingsComplete: function()
		{
			FLBuilder.alert(FLBuilderStrings.templateSaved);
		},
		
		/**
		 * Callback for when a user clicks a user defined template in 
		 * the template selector.
		 *
		 * @since 1.1.3
		 * @access private
		 * @method _userTemplateClicked
		 */
		_userTemplateClicked: function()
		{
			var id = $(this).attr('data-id');
				
			if($(FLBuilder._contentClass).children('.fl-row').length > 0) {
			
				if(id == 'blank') {
					if(confirm(FLBuilderStrings.changeTemplateMessage)) {
						FLBuilder._lightbox._node.hide();
						FLBuilder._applyTemplate('blank', false, 'user');
					}
				}
				else {            
					FLBuilder._selectedTemplateId = id;
					FLBuilder._selectedTemplateType = 'user';
					FLBuilder._showTemplateActions();
					FLBuilder._lightbox._node.hide();
				}
			}
			else {
				FLBuilder._applyTemplate(id, false, 'user');
			}
		},
		
		/**
		 * Launches the builder in a new tab to edit a user
		 * defined template when the edit link is clicked.
		 *
		 * @since 1.1.3
		 * @access private
		 * @method _editUserTemplateClicked
		 * @param {Object} e The event object.
		 */
		_editUserTemplateClicked: function(e)
		{
			e.preventDefault();
			e.stopPropagation();
			
			window.open($(this).attr('href'));
		},
		
		/**
		 * Deletes a user defined template when the delete link is clicked.
		 *
		 * @since 1.1.3
		 * @access private
		 * @method _deleteUserTemplateClicked
		 * @param {Object} e The event object.
		 */
		_deleteUserTemplateClicked: function(e)
		{
			var template = $( this ).closest( '.fl-user-template' ),
				id		 = template.attr( 'data-id' ),
				all		 = $( '.fl-user-template[data-id=' + id + ']' ),
				parent   = null;
			
			if ( confirm( FLBuilderStrings.deleteTemplate ) ) {
				
				FLBuilder.ajax( {
					action: 'delete_user_template',
					template_id: id
				} );
			
				all.fadeOut( function() {
					
					template = $( this );
					parent 	 = template.closest( '.fl-user-template-category' );
					
					template.remove(); 
					
					if ( 0 === parent.find( '.fl-user-template' ).length ) {
						parent.remove();
					}
					if ( 1 === $( '.fl-user-template' ).length ) {
						$( '.fl-user-templates').hide();
						$( '.fl-user-templates-message').show();
					}
				});
			}
			
			e.stopPropagation();
		},
		
		/* Help Actions
		----------------------------------------------------------*/
		
		/**
		 * Shows the getting started video when the watch video button
		 * is clicked.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _watchVideoClicked
		 */
		_watchVideoClicked: function()
		{
			var template = wp.template( 'fl-video-lightbox' );

			FLBuilder._actionsLightbox.close();
			FLBuilder._lightbox.open( template( { video : FLBuilderConfig.help.video_embed } ) );
		},
		
		/**
		 * Opens a new window with the knowledge base URL when the 
		 * view knowledge base button is clicked.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _viewKnowledgeBaseClicked
		 */
		_viewKnowledgeBaseClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			
			window.open( FLBuilderConfig.help.knowledge_base_url );
		},
		
		/**
		 * Opens a new window with the forums URL when the 
		 * visit forums button is clicked.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _visitForumsClicked
		 */
		_visitForumsClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			
			window.open( FLBuilderConfig.help.forums_url );
		},
		
		/* Help Tour
		----------------------------------------------------------*/
		
		/**
		 * Shows the help tour or template selector when the builder
		 * is launched.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _showTourOrTemplates
		 */
		_showTourOrTemplates: function()
		{
			if ( ! FLBuilderConfig.simpleUi && ! FLBuilderConfig.isUserTemplate ) {
				if ( FLBuilderConfig.help.tour && FLBuilderConfig.newUser ) {
					FLBuilder._showTourLightbox();
				}
				else {
					FLBuilder._initTemplateSelector();
				}
			}
		},
		
		/**
		 * Shows the actions lightbox with a welcome message for new 
		 * users asking if they would like to take the tour.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _showTourLightbox
		 */
		_showTourLightbox: function()
		{
			var template = wp.template( 'fl-tour-lightbox' );

			FLBuilder._actionsLightbox.open( template() );
		},
		
		/**
		 * Closes the actions lightbox and shows the template selector 
		 * if a new user declines the tour.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _noTourButtonClicked
		 */
		_noTourButtonClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilder._initTemplateSelector();
		},
		
		/**
		 * Closes the actions lightbox and starts the tour when a new user
		 * decides to take the tour.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _yesTourButtonClicked
		 */
		_yesTourButtonClicked: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilderTour.start();
		},
		
		/**
		 * Starts the help tour.
		 *
		 * @since 1.4.9
		 * @access private
		 * @method _startHelpTour
		 */
		_startHelpTour: function()
		{
			FLBuilder._actionsLightbox.close();
			FLBuilderTour.start();
		},
		
		/* Layout
		----------------------------------------------------------*/
		
		/**
		 * Shows a message to drop a row or module to get started 
		 * if the layout is empty.
		 *
		 * @since 1.0
		 * @access private
		 * @method _setupEmptyLayout
		 */
		_setupEmptyLayout: function()
		{
			var content = $(FLBuilder._contentClass);
			
			if ( FLBuilderConfig.isUserTemplate && 'module' == FLBuilderConfig.userTemplateType ) {
				return;
			}
			else {
				content.removeClass('fl-builder-empty');
				content.find('.fl-builder-empty-message').remove();
				
				if(content.children('.fl-row').length === 0) {
					content.addClass('fl-builder-empty');
					content.append('<span class="fl-builder-empty-message">'+ FLBuilderStrings.emptyMessage +'</span>');
					FLBuilder._initSortables();
				}
			}
		},
		
		/**
		 * Sends an AJAX request to render the layout and is typically
		 * used as a callback to many of the builder's save operations.
		 *
		 * @since 1.0
		 * @access private
		 * @method _updateLayout
		 */
		_updateLayout: function()
		{
			FLBuilder.showAjaxLoader();
			
			FLBuilder.ajax({
				action: 'render_layout'
			}, FLBuilder._renderLayout);
		},
		
		/**
		 * Removes the current layout and renders a new layout using
		 * the provided data. Will render a node instead of the layout
		 * if data.partial is true.
		 *
		 * @since 1.0
		 * @access private
		 * @method _renderLayout
		 * @param {Object} data The layout data. May also be a JSON encoded string.
		 * @param {Function} callback A function to call when the layout has finished rendering.
		 */
		_renderLayout: function( data, callback )
		{
			FLBuilder._layout = new FLBuilderAJAXLayout( data, callback );
		},
		
		/**
		 * Called by the layout's JavaScript file once it's loaded 
		 * to finish rendering the layout.
		 *
		 * @since 1.0
		 * @access private
		 * @method _renderLayoutComplete
		 */
		_renderLayoutComplete: function()
		{
			if ( FLBuilder._layout ) {
				FLBuilder._layout._complete();
				FLBuilder._layout = null;
			}
		},
		
		/**
		 * Trigger the resize event on the window so elements
		 * in the layout that rely on JavaScript know to resize.
		 *
		 * @since 1.0
		 * @access private
		 * @method _resizeLayout
		 */
		_resizeLayout: function()
		{
			$(window).trigger('resize'); 
				
			if(typeof YUI !== 'undefined') {
				YUI().use('node-event-simulate', function(Y) {
					Y.one(window).simulate("resize");
				});
			}
		},

		/**
		 * Initializes MediaElements.js audio and video players.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initMediaElements
		 */
		_initMediaElements: function()
		{
			var settings = {};
			
			if(typeof $.fn.mediaelementplayer != 'undefined') {
			
				if(typeof _wpmejsSettings !== 'undefined') {
					settings.pluginPath = _wpmejsSettings.pluginPath;
				}
				
				$('.wp-audio-shortcode, .wp-video-shortcode').not('.mejs-container').mediaelementplayer(settings);                
			}
		},
		
		/* Generic Drag and Drop
		----------------------------------------------------------*/
		
		/**
		 * Inserts drop targets for nodes such as rows, columns
		 * and column groups since making those all sortables
		 * makes sorting really jumpy.
		 *
		 * @since 1.9
		 * @access private
		 * @method _initDropTargets
		 */
		_initDropTargets: function()
		{
			var notGlobal = 'row' == FLBuilderConfig.userTemplateType ? '' : ':not(.fl-node-global)',
				rows      = $( FLBuilder._contentClass + ' .fl-row' ),
				row       = null,
				groups    = $( FLBuilder._contentClass + ' .fl-row' + notGlobal ).find( '.fl-col-group' ),
				group     = null,
				cols      = null,
				i         = 0;
			
			// Remove old drop targets.
			$( '.fl-col-drop-target' ).remove();
			$( '.fl-col-group-drop-target' ).remove();
			$( '.fl-row-drop-target' ).remove();
			
			// Row drop targets.
			$( FLBuilder._contentClass ).append( '<div class="fl-drop-target fl-row-drop-target"></div>' );
			rows.prepend( '<div class="fl-drop-target fl-row-drop-target"></div>' );
			rows.append( '<div class="fl-drop-target fl-drop-target-last fl-row-drop-target fl-row-drop-target-last"></div>' );
			
			// Add group drop targets to empty rows.
			for ( ; i < rows.length; i++ ) {
				
				row = rows.eq( i );
				
				if ( 0 === row.find( '.fl-col-group' ).length ) {
					row.find( '.fl-row-content' ).append( '<div class="fl-drop-target fl-col-group-drop-target"></div>' );
				}
			}
			
			// Loop through the column groups.
			for ( i = 0; i < groups.length; i++ ) {
				
				group = groups.eq( i );
				cols  = group.find( '> .fl-col' );
				
				// Column group drop targets.
				if ( ! group.hasClass( 'fl-col-group-nested' ) ) {
					group.append( '<div class="fl-drop-target fl-col-group-drop-target"></div>' );
					group.append( '<div class="fl-drop-target fl-drop-target-last fl-col-group-drop-target fl-col-group-drop-target-last"></div>' );
				}
				
				// Column drop targets.
				cols.append( '<div class="fl-drop-target fl-col-drop-target"></div>' );
				cols.append( '<div class="fl-drop-target fl-drop-target-last fl-col-drop-target fl-col-drop-target-last"></div>' );
			}
		},
		
		/**
		 * Returns a helper element for a drag operation.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragHelper
		 * @param {Object} e The event object.
		 * @param {Object} item The item being dragged.
		 * @return {Object} The helper element.
		 */
		_blockDragHelper: function (e, item) 
		{
			var helper = item.clone();
			
			item.clone().insertAfter(item);
			helper.addClass('fl-builder-block-drag-helper');
			
			return helper;
		},
		
		/**
		 * Initializes a drag operation.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragInit
		 * @param {Object} e The event object.
		 */
		_blockDragInit: function( e )
		{
			var target        = $( e.currentTarget ),
				node          = null,
				scrollTop     = $( window ).scrollTop(),
				initialPos    = 0;
				
			// Set the _dragEnabled flag.
			FLBuilder._dragEnabled = true;
			
			// Save the initial scroll position.
			FLBuilder._dragInitialScrollTop = scrollTop;
			
			// Get the node to scroll to once the node highlights have affected the body height.
			if ( target.closest( '[data-node]' ).length > 0 ) {
				
				// Set the node to a node instance being dragged.  
				node = target.closest( '[data-node]' );
				
				// Mark this node as initialized for dragging.
				node.addClass( 'fl-node-drag-init' );
			}
			else if ( target.hasClass( 'fl-builder-block' ) ) {
				
				// Set the node to the first visible row instance.
				$( '.fl-row' ).each( function() {
					if ( node === null && $( this ).offset().top - scrollTop > 0 ) {
						node = $( this );
					}
				} );
			}
			
			// Get the initial scroll position of the node.
			if ( node !== null ) {
				initialPos = node.offset().top - scrollTop;
			}
			
			// Setup the UI for dragging.
			FLBuilder._highlightRowsAndColsForDrag( target );
			FLBuilder._adjustColHeightsForDrag();
			FLBuilder._disableGlobalRows();
			FLBuilder._closePanel();
			FLBuilder._destroyOverlayEvents();
			FLBuilder._removeAllOverlays();
			FLBuilder._initSortables();
			$( 'body' ).addClass( 'fl-builder-dragging' );
			$( '.fl-builder-empty-message' ).hide();
			$( '.fl-sortable-disabled' ).removeClass( 'fl-sortable-disabled' );
			
			// Scroll to the node that is dragging.            
			if ( initialPos > 0 ) {
				scrollTo( 0, node.offset().top - initialPos );
			}
		},
		
		/**
		 * Callback that fires when dragging starts.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragStart
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_blockDragStart: function(e, ui)
		{
			// Let the builder know dragging has started.
			FLBuilder._dragging = true;
			
			// Removed the drag init class as we're done with that.
			$( '.fl-node-drag-init' ).removeClass( 'fl-node-drag-init' );
		},
		
		/**
		 * Callback that fires when an element that is being
		 * dragged is sorted.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragSort
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_blockDragSort: function(e, ui)
		{
			var parent = ui.placeholder.parent(),
				title  = FLBuilderStrings.insert;
			
			// Prevent sorting?
			if ( FLBuilder._blockPreventSort( ui.item, parent ) ) {
				return;
			}
			
			// Find the placeholder title.
			if(parent.hasClass('fl-col-content')) {
				if(ui.item.hasClass('fl-builder-block-row')) {
					title = ui.item.find('.fl-builder-block-title').text();
				}
				else if(ui.item.hasClass('fl-col-sortable-proxy-item')) {
					title = FLBuilderStrings.column;
				}
				else if(ui.item.hasClass('fl-builder-block-module')) {
					title = ui.item.find('.fl-builder-block-title').text();
				}
				else if(ui.item.hasClass('fl-builder-block-saved-module') || ui.item.hasClass('fl-builder-block-module-template')) {
					title = ui.item.find('.fl-builder-block-title').text();
				}
				else {
					title = ui.item.attr('data-name');
				}
			}
			else if(parent.hasClass('fl-col-drop-target')) {
				title = '';
			}
			else if (parent.hasClass('fl-col-group-drop-target')) {
				title = '';
			}
			else if(parent.hasClass('fl-row-drop-target')) {
				if(ui.item.hasClass('fl-builder-block-row')) {
					title = ui.item.find('.fl-builder-block-title').text();
				}
				else if(ui.item.hasClass('fl-builder-block-saved-row')) {
					title = ui.item.find('.fl-builder-block-title').text();
				}
				else if(ui.item.hasClass('fl-row-sortable-proxy-item')) {
					title = FLBuilderStrings.row;
				}
				else {
					title = FLBuilderStrings.newRow;
				}
			}
			
			// Set the placeholder title.
			ui.placeholder.html(title);
			
			// Add the global class?
			if ( ui.item.hasClass( 'fl-node-global' ) || 
				 ui.item.hasClass( 'fl-builder-block-global' ) || 
				 $( '.fl-node-dragging' ).hasClass( 'fl-node-global' ) 
			) {
				ui.placeholder.addClass( 'fl-builder-drop-zone-global' );
			}
			else {
				ui.placeholder.removeClass( 'fl-builder-drop-zone-global' );
			}
		},
		
		/**
		 * Callback that fires when an element that is being
		 * dragged position changes.
		 *
		 * @since 1.9
		 * @access private
		 * @method _blockDragChange
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_blockDragChange: function( e, ui )
		{
			ui.placeholder.hide(); 
			ui.placeholder.fadeIn( 100 ); 
		},
		
		/**
		 * Prevents sorting of items that shouldn't be sorted into
		 * specific areas.
		 *
		 * @since 1.9
		 * @access private
		 * @method _blockPreventSort
		 * @param {Object} item The item being sorted.
		 * @param {Object} parent The new parent.
		 */
		_blockPreventSort: function( item, parent )
		{
			var prevent     = false,
				isRowBlock  = item.hasClass( 'fl-builder-block-row' ),
				isCol       = item.hasClass( 'fl-col-sortable-proxy-item' ),
				isParentCol = parent.hasClass( 'fl-col-content' ),
				isColTarget = parent.hasClass( 'fl-col-drop-target' ),
				group       = parent.parents( '.fl-col-group:not(.fl-col-group-nested)' ),
				nestedGroup = parent.parents( '.fl-col-group-nested' );
				
			// Prevent columns in nested columns.
			if ( ( isRowBlock || isCol ) && isParentCol && nestedGroup.length > 0 ) {
				prevent = true;
			}
			
			// Prevent 1 column from being nested in an empty column.
			if ( isParentCol && ! parent.find( '.fl-module, .fl-col' ).length ) {
			
				if ( isRowBlock && '1-col' == item.data( 'cols' ) ) {
					prevent = true;
				}
				else if ( isCol ) {
					prevent = true;
				}
			}
			
			// Prevent 5 or 6 columns from being nested.
			if ( isRowBlock && isParentCol && $.inArray( item.data( 'cols' ), [ '5-cols', '6-cols' ] ) > -1 ) {
				prevent = true;
			}
			
			// Prevent columns with nested columns from being dropped in nested columns.
			if ( isCol && $( '.fl-node-dragging' ).find( '.fl-col-group-nested' ).length > 0 ) {
				
				if ( isParentCol || ( isColTarget && nestedGroup.length > 0 ) ) {
					prevent = true;
				}
			}
			
			// Prevent more than 12 columns.
			if ( isColTarget && group.length > 0 && 0 === nestedGroup.length && group.find( '> .fl-col:visible' ).length > 11 ) {
				prevent = true;
			}
			
			// Prevent more than 4 nested columns.
			if ( isColTarget && nestedGroup.length > 0 && nestedGroup.find( '.fl-col:visible' ).length > 3 ) {
				prevent = true;
			}
			
			// Add the disabled class if we are preventing a sort.
			if ( prevent ) {
				parent.addClass( 'fl-sortable-disabled' );
			}
			
			return prevent;
		},
		
		/**
		 * Cleans up when a drag operation has stopped.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_blockDragStop: function( e, ui )
		{
			var scrollTop  = $( window ).scrollTop(),
				parent     = ui.item.parent(),
				initialPos = null;
			
			// Get the node to scroll to once removing the node highlights affects the body height.
			if ( parent.hasClass( 'fl-drop-target' ) && parent.closest( '[data-node]' ).length ) {
				parent = parent.closest( '[data-node]' );
				initialPos = parent.offset().top - scrollTop;
			}
			else {
				initialPos = parent.offset().top - scrollTop;
			}

			// Show the panel if a block was dropped back in.
			if ( parent.hasClass( 'fl-builder-blocks-section-content' ) ) {
				FLBuilder._showPanel();
			}
			
			// Finish dragging. 
			FLBuilder._dragEnabled = false;
			FLBuilder._dragging = false;
			FLBuilder._bindOverlayEvents();
			FLBuilder._highlightEmptyCols();
			FLBuilder._enableGlobalRows();
			FLBuilder._setupEmptyLayout();
			$( 'body' ).removeClass( 'fl-builder-dragging' );
			
			// Scroll the page back to where it was. 
			scrollTo( 0, parent.offset().top - initialPos );
		},
		
		/**
		 * Cleans up when a drag operation has canceled.
		 *
		 * @since 1.0
		 * @access private
		 * @method _blockDragCancel
		 */
		_blockDragCancel: function()
		{
			if ( FLBuilder._dragEnabled && ! FLBuilder._dragging ) {
				FLBuilder._dragEnabled = false;
				FLBuilder._dragging = false;
				FLBuilder._bindOverlayEvents();
				FLBuilder._highlightEmptyCols();
				FLBuilder._enableGlobalRows();
				FLBuilder._setupEmptyLayout();
				$( 'body' ).removeClass( 'fl-builder-dragging' );
				$( '.fl-node-drag-init' ).removeClass( 'fl-node-drag-init' );
				$( '.fl-node-dragging' ).removeClass( 'fl-node-dragging' );
				scrollTo( 0, FLBuilder._dragInitialScrollTop );
			}
		},
		
		/**
		 * Reorders a node within its parent.
		 *
		 * @since 1.9
		 * @access private
		 * @method _reorderNode
		 * @param {String} nodeId The node ID of the node.
		 * @param {Number} position The new position.
		 */     
		_reorderNode: function( nodeId, position )
		{
			FLBuilder.ajax( {
				action: 'reorder_node',
				node_id: nodeId,
				position: position,
				silent: true
			} ); 
		},
		
		/**
		 * Moves a node to a new parent.
		 *
		 * @since 1.9
		 * @access private
		 * @method _moveNode
		 * @param {String} newParent The node ID of the new parent.
		 * @param {String} nodeId The node ID of the node.
		 * @param {Number} position The new position.
		 */     
		_moveNode: function( newParent, nodeId, position )
		{
			FLBuilder.ajax({
				action: 'move_node',
				new_parent: newParent,
				node_id: nodeId,
				position: position,
				silent: true
			});
		},
		
		/**
		 * Removes all node overlays and hides any tooltip helpies.
		 *
		 * @since 1.0
		 * @access private
		 * @method _removeAllOverlays
		 */
		_removeAllOverlays: function()
		{
			FLBuilder._removeRowOverlays();
			FLBuilder._removeColOverlays();
			FLBuilder._removeColHighlightGuides();
			FLBuilder._removeModuleOverlays();
			FLBuilder._hideTipTips();
		},
		
		/**
		 * Appends a node action overlay to the layout.
		 *
		 * @since 1.6.3.3
		 * @access private
		 * @method _appendOverlay
		 * @param {Object} node A jQuery reference to the node this overlay is associated with.
		 * @param {Object} template A rendered wp.template.
		 * @return {Object} The overlay element.
		 */
		_appendOverlay: function( node, template )
		{
			var overlayPos 	= 0,
				overlay 	= null,
				isRow		= node.hasClass( 'fl-row' ),
				content		= isRow ? node.find( '> .fl-row-content-wrap' ) : node.find( '> .fl-node-content' ),
				margins 	= {
					'top' 		: parseInt( content.css( 'margin-top' ), 10 ),
					'bottom' 	: parseInt( content.css( 'margin-bottom' ), 10 )
				};
				
			// Append the template.
			node.append( template );
			
			// Add the active class to the node.
			node.addClass( 'fl-block-overlay-active' );
			
			// Init TipTips
			FLBuilder._initTipTips();
			
			// Get a reference to the overlay.
			overlay = node.find( '> .fl-block-overlay' );
			
			// Adjust the overlay positions to account for negative margins.
			if ( margins.top < 0 ) {
				overlayPos = parseInt( overlay.css( 'top' ), 10 );
				overlayPos = isNaN( overlayPos ) ? 0 : overlayPos;
				overlay.css( 'top', ( margins.top + overlayPos ) + 'px' );
			}
			if ( margins.bottom < 0 ) {
				overlayPos = parseInt( overlay.css( 'bottom' ), 10 );
				overlayPos = isNaN( overlayPos ) ? 0 : overlayPos;
				overlay.css( 'bottom', ( margins.bottom + overlayPos ) + 'px' );
			}

			return overlay;
		},
		
		/**
		 * Builds the overflow menu for an overlay if necessary.
		 *
		 * @since 1.9
		 * @access private
		 * @method _buildOverlayOverflowMenu
		 * @param {Object} overlay The overlay object.
		 */
		_buildOverlayOverflowMenu: function( overlay )
		{
			var actions       = overlay.find( '.fl-block-overlay-actions' ),
				original      = actions.data( 'original' ),
				actionsWidth  = 0,
				items         = null,
				itemsWidth    = 0,
				item          = null,
				i             = 0,
				visibleItems  = [],
				overflowItems = [],
				menuData      = [],
				template	  = wp.template( 'fl-overlay-overflow-menu' );
			
			// Use the original copy if we have one.
			if ( undefined != original ) {
				actions.after( original );
				actions.remove();
				actions = original;
			}
			
			// Save a copy of the original actions.
			actions.data( 'original', actions.clone() );

			// Get the actions width and items.
			actionsWidth  = actions[0].getBoundingClientRect().width;
			items         = actions.find( ' > i, > span.fl-builder-has-submenu' );
			
			// Find visible and overflow items.
			for( ; i < items.length; i++ ) {
				
				item        = items.eq( i );
				itemsWidth += item.outerWidth();
				
				if ( itemsWidth > actionsWidth ) {
					overflowItems.push( item );
					item.remove();
				}
				else {
					visibleItems.push( item );
				}
			}
			
			// Build the menu if we have overflow items.
			if ( overflowItems.length > 0 ) {
				
				overflowItems.unshift( visibleItems.pop().remove() );
				
				for( i = 0; i < overflowItems.length; i++ ) {
					
					if ( overflowItems[ i ].is( '.fl-builder-has-submenu' ) ) {
						menuData.push( {
							type    : 'submenu',
							label   : overflowItems[ i ].find( '.fa' ).data( 'title' ),
							submenu : overflowItems[ i ].find( '.fl-builder-submenu' )[0].outerHTML
						} );
					}
					else {
						menuData.push( {
							type      : 'action',
							label     : overflowItems[ i ].data( 'title' ),
							className : overflowItems[ i ].removeClass( function( i, c ) { 
											return c.replace( /fl-block-([^\s]+)/, '' ); 
										} ).attr( 'class' )
						} );
					}
				}
				
				actions.append( template( menuData ) );
				FLBuilder._initTipTips();
			}
		},
		
		/* Rows
		----------------------------------------------------------*/
		
		/**
		 * Removes all row overlays from the page.
		 *
		 * @since 1.0
		 * @access private
		 * @method _removeRowOverlays
		 */
		_removeRowOverlays: function()
		{
			$('.fl-row').removeClass('fl-block-overlay-active');
			$('.fl-row-overlay').remove();
			$('.fl-module').removeClass('fl-module-adjust-height');
		},
		
		/**
		 * Removes all row overlays from the page.
		 *
		 * @since 1.0
		 * @access private
		 * @method _removeRowOverlays
		 */
		_disableGlobalRows: function()
		{
			if ( 'row' == FLBuilderConfig.userTemplateType ) {
				return;
			}
			
			$('.fl-row.fl-node-global').addClass( 'fl-node-disabled' );
		},
		
		/**
		 * Removes all row overlays from the page.
		 *
		 * @since 1.0
		 * @access private
		 * @method _removeRowOverlays
		 */
		_enableGlobalRows: function()
		{
			if ( 'row' == FLBuilderConfig.userTemplateType ) {
				return;
			}
			
			$( '.fl-node-disabled' ).removeClass( 'fl-node-disabled' );
		},
		
		/**
		 * Shows an overlay with actions when the mouse enters a row.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowMouseenter
		 */
		_rowMouseenter: function()
		{
			var row        = $( this ),
                rowTop     = row.offset().top,
                childTop   = null,
                overlay    = null,
                template   = wp.template( 'fl-row-overlay' );

            if ( ! row.hasClass( 'fl-block-overlay-active' ) ) {

                // Append the overlay.
                overlay = FLBuilder._appendOverlay( row, template( {
                    global : row.hasClass( 'fl-node-global' ),
                    node   : row.attr('data-node')
                } ) );

                // Adjust the overlay position if covered by negative margin content.
                row.find( '.fl-node-content:visible' ).each( function(){
                    var top = $( this ).offset().top;
                    childTop = ( null === childTop || childTop > top ) ? top : childTop;
                } );

                if ( null !== childTop && childTop < rowTop ) {
	                overlay.css( 'top', ( childTop - rowTop - 30 ) + 'px' );
                }

                // Put action headers on the bottom if they're hidden.
                if ( overlay.offset().top < 43 ) {
                    overlay.addClass( 'fl-row-overlay-header-bottom' );
                }

                // Adjust the height of modules if needed.
                row.find( '.fl-module' ).each( function(){
                    var module = $( this );
                    if ( module.outerHeight( true ) < 20 ) {
                        module.addClass( 'fl-module-adjust-height' );
                    }
                } );
            }
		},
		
		/**
		 * Removes overlays when the mouse leaves a row.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowMouseleave
		 * @param {Object} e The event object.
		 */
		_rowMouseleave: function(e)
		{
			var toElement       = $(e.toElement) || $(e.relatedTarget),
				isOverlay       = toElement.hasClass('fl-row-overlay'),
				isOverlayChild  = toElement.closest('.fl-row-overlay').length > 0,
				isTipTip        = toElement.is('#tiptip_holder'),
				isTipTipChild   = toElement.closest('#tiptip_holder').length > 0;
			
			if(isOverlay || isOverlayChild || isTipTip || isTipTipChild) {
				return;
			}
			
			FLBuilder._removeRowOverlays();
		},
		
		/**
		 * Returns a helper element for row drag operations.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowDragHelper
		 * @return {Object} The helper element.
		 */
		_rowDragHelper: function()
		{
			return $('<div class="fl-builder-block-drag-helper">' + FLBuilderStrings.row + '</div>');
		},
		
		/**
		 * Initializes dragging for row. Rows themselves aren't sortables
		 * as nesting that many sortables breaks down quickly and draggable by
		 * itself is slow. Instead, we are programmatically triggering the drag
		 * of our helper div that isn't a nested sortable but connected to the 
		 * sortables in the main layout.
		 *
		 * @since 1.9
		 * @access private
		 * @method _rowDragInit
		 * @param {Object} e The event object.
		 */
		_rowDragInit: function( e )
		{
			var handle = $( e.target ),
				helper = $( '.fl-row-sortable-proxy-item' ),
				row    = handle.closest( '.fl-row' );
			
			row.addClass( 'fl-node-dragging' );
			
			FLBuilder._blockDragInit( e );
			
			e.target = helper[ 0 ];
			
			helper.trigger( e );
		},
		
		/**
		 * Callback that fires when dragging starts for a row.
		 *
		 * @since 1.9
		 * @access private
		 * @method _rowDragStart
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_rowDragStart: function( e, ui )
		{
			var rows = $( FLBuilder._contentClass + ' .fl-row' ),
				row  = $( '.fl-node-dragging' );
			
			if ( 1 === rows.length ) {
				$( FLBuilder._contentClass ).addClass( 'fl-builder-empty' );
			}
			
			row.hide();

			FLBuilder._blockDragStart( e, ui );
		},
		
		/**
		 * Callback for when a row drag operation completes.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_rowDragStop: function( e, ui )
		{
			var item     = ui.item,
				parent   = item.parent(),
				row      = null,
				group    = null,
				position = 0;
				
			FLBuilder._blockDragStop( e, ui );
			
			// A row was dropped back into the row list.
			if ( parent.hasClass( 'fl-builder-rows' ) ) {
				item.remove();
				return;
			}
			// A row was dropped back into the sortable proxy.
			else if ( parent.hasClass( 'fl-row-sortable-proxy' ) ) {
				$( '.fl-node-dragging' ).removeClass( 'fl-node-dragging' ).show();
				return;
			}
			// Add a new row.
			else if ( item.hasClass( 'fl-builder-block' ) ) {
			
				// Cancel the drop if the sortable is disabled?
				if ( parent.hasClass( 'fl-sortable-disabled' ) ) {
					item.remove();
					FLBuilder._showPanel();
					return;
				}
				// A new row was dropped into column.
				else if ( parent.hasClass( 'fl-col-content' ) ) {
					FLBuilder._addColGroup(
						item.closest( '.fl-col' ).attr( 'data-node' ),
						item.attr( 'data-cols' ), 
						parent.find( '> .fl-module, .fl-col-group, .fl-builder-block' ).index( item )
					);
				}
				// A new row was dropped next to a column.
				else if ( parent.hasClass( 'fl-col-drop-target' ) ) {
					FLBuilder._addCols(
						parent.closest( '.fl-col' ),
						parent.hasClass( 'fl-col-drop-target-last' ) ? 'after' : 'before',
						item.attr( 'data-cols' ),
						parent.closest( '.fl-col-group-nested' ).length > 0
					);
				}
				// A new row was dropped into a column group position.
				else if ( parent.hasClass( 'fl-col-group-drop-target' ) ) {
					
					group    = item.closest( '.fl-col-group' );
					position = item.closest( '.fl-row' ).find( '.fl-row-content > .fl-col-group' ).index( group );
					
					FLBuilder._addColGroup(
						item.closest( '.fl-row' ).attr( 'data-node' ),
						item.attr( 'data-cols' ), 
						parent.hasClass( 'fl-drop-target-last' ) ? position + 1 : position
					);
				}
				// A row was dropped into a row position.
				else {
					
					row = item.closest( '.fl-row' );
					position = ! row.length ? 0 : $( FLBuilder._contentClass + ' .fl-row' ).index( row );
					
					FLBuilder._addRow(
						item.attr('data-cols'), 
						parent.hasClass( 'fl-drop-target-last' ) ? position + 1 : position
					);
				}

				// Remove the helper.
				item.remove();
				
				// Show the builder panel.
				FLBuilder._showPanel();
				
				// Show the module list.
				$( '.fl-builder-modules' ).siblings( '.fl-builder-blocks-section-title' ).eq( 0 ).trigger( 'click' );
			}
			// Reorder a row.
			else {
				
				row = $( '.fl-node-dragging' ).removeClass( 'fl-node-dragging' ).show();
				
				// Make sure a single row wasn't dropped back into the main layout.
				if ( ! parent.parent().hasClass( 'fl-builder-content' ) ) {
				
					// Move the row in the UI.
					if ( parent.hasClass( 'fl-drop-target-last' ) ) {
						parent.parent().after( row );
					}
					else {
						parent.parent().before( row );
					}
					
					// Reorder the row.
					FLBuilder._reorderNode(
						row.attr('data-node'), 
						row.index()
					);
				}
				
				// Revert the proxy to its parent.
				$( '.fl-row-sortable-proxy' ).append( ui.item );
			}
		},
		
		/**
		 * Adds a new row to the layout.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addRow
		 * @param {String} cols The type of column layout to use.
		 * @param {Number} position The position of the new row.
		 */     
		_addRow: function(cols, position)
		{
			FLBuilder.showAjaxLoader();
		
			FLBuilder._newRowPosition = position;
			
			FLBuilder.ajax({
				action: 'render_new_row',
				cols: cols,
				position: position
			}, FLBuilder._addRowComplete);
		},
		
		/**
		 * Adds the HTML for a new row to the layout when the AJAX
		 * add operation is complete. Adds a module if one is queued
		 * to go in the new row.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addRowComplete
		 * @param {String} response The JSON response with the HTML for the new row.
		 */     
		_addRowComplete: function(response)
		{
			var data 	= JSON.parse(response),
				content = $(FLBuilder._contentClass),
				rowId   = $(data.html).data('node'),
				module  = FLBuilder._addModuleAfterNodeRender;
				
			// Add new row info to the data.
			data.nodeParent 	= content;
			data.nodePosition 	= FLBuilder._newRowPosition;
				
			// Render the layout.
			FLBuilder._renderLayout( data, function(){
				
				// Add a module to the newly created row.
				if(module !== null) {
					$('.fl-node-' + rowId + ' .fl-col-content').append(module);
					FLBuilder._reorderModule(module);
					FLBuilder._addModuleAfterNodeRender = null;
				}
			} );
		},
		
		/**
		 * Callback for when the delete row button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteRowClicked
		 * @param {Object} e The event object.
		 */
		_deleteRowClicked: function( e )
		{
			var row    = $(this).closest('.fl-row'),
				result = null;

			if(!row.find('.fl-module').length) {
				FLBuilder._deleteRow(row);
			} 
			else {
				result = confirm(FLBuilderStrings.deleteRowMessage);
				
				if(result) {
					FLBuilder._deleteRow(row);
				}
			}
			
			FLBuilder._removeAllOverlays();
			e.stopPropagation();
		},
		
		/**
		 * Deletes a row.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteRow
		 * @param {Object} row A jQuery reference of the row to delete.
		 */
		_deleteRow: function(row)
		{
			FLBuilder.ajax({
				action: 'delete_node',
				node_id: row.attr('data-node'),
				silent: true
			});
			
			row.empty();
			row.remove();
			FLBuilder._setupEmptyLayout();
			FLBuilder._removeRowOverlays();
		},
		
		/**
		 * Duplicates a row.
		 *
		 * @since 1.3.8
		 * @access private
		 * @method _rowCopyClicked
		 * @param {Object} e The event object.
		 */ 
		_rowCopyClicked: function(e)
		{
			var row 	= $( this ).closest( '.fl-row' ),
				nodeId 	= row.attr( 'data-node' );
				
			FLBuilder.showAjaxLoader();
			FLBuilder._removeAllOverlays();
			FLBuilder._newRowPosition = row.index( '.fl-row' ) + 1;
			
			FLBuilder.ajax( {
				action: 'copy_row',
				node_id: nodeId
			}, FLBuilder._rowCopyComplete );
			
			e.stopPropagation();
		},
		
		/**
		 * Callback for when a row has been duplicated.
		 *
		 * @since 1.7
		 * @access private
		 * @method _rowCopyComplete
		 * @param {String} response The JSON encoded response.
		 */ 
		_rowCopyComplete: function( response )
		{
			var data = JSON.parse( response );
			
			data.nodeParent 	= $( FLBuilder._contentClass );
			data.nodePosition 	= FLBuilder._newRowPosition;
			
			FLBuilder._renderLayout( data );
		},
		
		/**
		 * Shows the settings lightbox and loads the row settings
		 * when the row settings button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowSettingsClicked
		 */
		_rowSettingsClicked: function( e )
		{
			var button = $( this ),
				nodeId = button.closest( '.fl-row' ).attr( 'data-node' ),
				global = button.closest( '.fl-block-overlay-global' ).length > 0;
			
			if ( global && 'row' != FLBuilderConfig.userTemplateType ) {
				if ( FLBuilderConfig.userCanEditGlobalTemplates ) {
					window.open( $( '.fl-row[data-node="' + nodeId + '"]' ).attr( 'data-template-url' ) );
				}
			}
			else if ( button.hasClass( 'fl-block-settings' ) ) {
				
				FLBuilder._closePanel();
				FLBuilder._showLightbox();
				
				FLBuilder.ajax({
					action: 'render_row_settings',
					node_id: nodeId
				}, FLBuilder._rowSettingsLoaded);
			}
			
			e.stopPropagation();
		},
		
		/**
		 * Sets the lightbox content when the row settings have 
		 * loaded and creates a new preview.
		 *
		 * @since 1.0
		 * @access private
		 * @method _rowSettingsLoaded
		 * @param {String} response The JSON response with the HTML for the row settings form.
		 */
		_rowSettingsLoaded: function(response)
		{
			var data = JSON.parse(response);
			
			FLBuilder._setSettingsFormContent(data.settings);
			
			FLBuilder.preview = new FLBuilderPreview({ 
				type  : 'row',
				state : data.state 
			});
		},
		
		/* Columns
		----------------------------------------------------------*/
		
		/**
		 * Adds a dashed border to empty columns.
		 *
		 * @since 1.0
		 * @access private
		 * @method _highlightEmptyCols
		 */
		_highlightEmptyCols: function()
		{
			var notGlobal = 'row' == FLBuilderConfig.userTemplateType ? '' : ':not(.fl-node-global)',
				rows 	  = $(FLBuilder._contentClass + ' .fl-row' + notGlobal),
				cols 	  = $(FLBuilder._contentClass + ' .fl-col' + notGlobal);
			
			$( '.fl-row-highlight' ).removeClass('fl-row-highlight');
			cols.removeClass('fl-col-highlight').find('.fl-col-content').css( 'height', '' );
			
			cols.each(function(){
				
				var col = $(this);
				
				if(col.find('.fl-module, .fl-col').length === 0) {
					col.addClass('fl-col-highlight');
				}
			});
		},
		
		/**
		 * Sets up dashed borders to show where things can
		 * be dropped in rows and columns.
		 *
		 * @since 1.9
		 * @access private
		 * @method _highlightRowsAndColsForDrag
		 * @param {Object} target The event target for the drag.
		 */
		_highlightRowsAndColsForDrag: function( target )
		{
			var notGlobal = 'row' == FLBuilderConfig.userTemplateType ? '' : ':not(.fl-node-global)';
			
			// Highlight rows.
			$( FLBuilder._contentClass + ' .fl-row' ).addClass( 'fl-row-highlight' );
			
			// Highlight columns.
			if ( ! target.closest( '.fl-row-overlay' ).length ) {
				$( FLBuilder._contentClass + ' .fl-col' + notGlobal ).addClass( 'fl-col-highlight' );
			}
		},
		
		/**
		 * Adjust the height of columns with modules in them
		 * to account for the drop zone and keep the layout
		 * from jumping around. 
		 *
		 * @since 1.9
		 * @access private
		 * @method _adjustColHeightsForDrag
		 */
		_adjustColHeightsForDrag: function()
		{
			var notGlobal = 'row' == FLBuilderConfig.userTemplateType ? '' : '.fl-row:not(.fl-node-global) ',
				content   = $( FLBuilder._contentClass ),
				notNested = content.find( notGlobal + '.fl-col-group:not(.fl-col-group-nested) > .fl-col > .fl-col-content' ),
				nested    = content.find( notGlobal + '.fl-col-group-nested .fl-col-content' ),
				col       = null,
				i         = 0;
				
			$( '.fl-node-drag-init' ).hide();
				
			for ( ; i < nested.length; i++ ) {
				FLBuilder._adjustColHeightForDrag( nested.eq( i ) );
			}
				
			for ( i = 0; i < notNested.length; i++ ) {
				FLBuilder._adjustColHeightForDrag( notNested.eq( i ) );
			}
			
			$( '.fl-node-drag-init' ).show();
		},
		
		/**
		 * Adjust the height of a single column for dragging.
		 *
		 * @since 1.9
		 * @access private
		 * @method _adjustColHeightForDrag
		 */
		_adjustColHeightForDrag: function( col )
		{
			if ( col.find( '.fl-module:visible, .fl-col:visible' ).length ) {
				col.height( col.height() + 45 );
			}
		},
		
		/**
		 * Adds a border guide to a column when the column
		 * actions submenu is open for a module.
		 *
		 * @since 1.9
		 * @access private
		 * @method _showColHighlightGuide
		 */
		_showColHighlightGuide: function()
		{
			var li         = $( this ),
				link       = li.find( 'a' ),
				col        = li.closest( '.fl-col' ),
				parentCol  = col.parents( '.fl-col' ),
				guide      = $( '<div class="fl-col-highlight-guide"></div>' ),
				guideTop   = null,
				overlayTop = li.closest( '.fl-block-overlay' ).offset().top;
				
			if ( link.hasClass( 'fl-block-col-move-parent' ) || link.hasClass( 'fl-block-col-edit-parent' ) ) {
				col = parentCol;
			}
			if ( col.hasClass( 'fl-col-highlight' ) ) {
				return;
			}
			
			col.find( '> .fl-col-content' ).append( guide );
			col.addClass( 'fl-col-has-highlight-guide' );
			
			guideTop = guide.offset().top;
			
			if ( guideTop > overlayTop ) {
				guide.css( 'top', ( overlayTop - guideTop + 4 ) + 'px' );
			}
		},
		
		/**
		 * Removes all column highlight guides.
		 *
		 * @since 1.9
		 * @access private
		 * @method _showColHighlightGuide
		 */
		_removeColHighlightGuides: function()
		{
			$( '.fl-col-has-highlight-guide' ).removeClass( 'fl-col-has-highlight-guide' );
			$( '.fl-col-highlight-guide' ).remove();
		},
		
		/**
		 * Shows an overlay with actions when the mouse enters a column.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _colMouseenter
		 */
		_colMouseenter: function()
		{
			var col 	 	  	= $( this ),
				group           = col.closest( '.fl-col-group' ),
				global		  	= col.hasClass( 'fl-node-global' ),
				parentGlobal  	= col.parents( '.fl-node-global' ).length > 0,
				numCols		  	= col.closest( '.fl-col-group' ).find( '> .fl-col' ).length,
				index           = group.find( '> .fl-col' ).index( col ),
				first   		= 0 === index,
				last    		= numCols === index + 1,
				hasChildCols    = col.find( '.fl-col' ).length > 0,
				parentCol       = col.parents( '.fl-col' ),
				parentGroup     = parentCol.closest( '.fl-col-group' ),
				hasParentCol    = parentCol.length > 0,
				numParentCols	= hasParentCol ? parentGroup.find( '> .fl-col' ).length : 0,
				parentIndex     = parentGroup.find( '> .fl-col' ).index( parentCol ),
				parentFirst     = hasParentCol ? 0 === parentIndex : false,
				parentLast      = hasParentCol ? numParentCols === parentIndex + 1 : false,
				contentWidth    = col.find( '> .fl-col-content' ).width(),
				template 		= wp.template( 'fl-col-overlay' ),
				overlay			= null;
				
			if ( FLBuilderConfig.simpleUi ) {
				return;
			}
			else if ( global && parentGlobal && 'row' != FLBuilderConfig.userTemplateType ) {
				return;
			}
			else if ( col.find( '.fl-module' ).length > 0 ) {
				return;
			}
			else if ( col.find( '.fl-col' ).length > 0 ) {
				return;
			}
			else if ( ! col.hasClass( 'fl-block-overlay-active' ) ) {
				
				// Remove existing overlays.
				FLBuilder._removeColOverlays();
				FLBuilder._removeModuleOverlays();
				
				// Append the template.
				overlay = FLBuilder._appendOverlay( col, template( {
					global	      : global,
					numCols	      : numCols,
					first         : first,
					last   	      : last,
					hasChildCols  : hasChildCols,
					hasParentCol  : hasParentCol,
					parentFirst   : parentFirst,
					parentLast    : parentLast,
					numParentCols : numParentCols,
					contentWidth  : contentWidth
				} ) );
				
				// Build the overlay overflow menu if needed.
				FLBuilder._buildOverlayOverflowMenu( overlay );
				
				// Init column resizing.
				FLBuilder._initColDragResizing();
			}
			
			$( 'body' ).addClass( 'fl-block-overlay-muted' );
		},
		
		/**
		 * Removes overlays when the mouse leaves a column.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _colMouseleave
		 * @param {Object} e The event object.
		 */
		_colMouseleave: function(e)
		{
			var col             = $(this),
				toElement       = $(e.toElement) || $(e.relatedTarget),
				hasModules      = col.find('.fl-module').length > 0,
				isTipTip        = toElement.is('#tiptip_holder'),
				isTipTipChild   = toElement.closest('#tiptip_holder').length > 0;
			
			if( isTipTip || isTipTipChild ) {
				return;
			}
			if( hasModules ) {
				return;
			}
			
			FLBuilder._removeColOverlays();
			FLBuilder._removeColHighlightGuides();
		},
		
		/**
		 * Removes all column overlays from the page.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _removeColOverlays
		 */
		_removeColOverlays: function()
		{
			var cols = $( '.fl-col' );
			
			cols.removeClass('fl-block-overlay-active');
			cols.find('.fl-col-overlay').remove();
			$('body').removeClass('fl-block-overlay-muted');
		},
		
		/**
		 * Returns a helper element for column drag operations.
		 *
		 * @since 1.9
		 * @access private
		 * @method _colDragHelper
		 * @return {Object} The helper element.
		 */
		_colDragHelper: function()
		{   
			return $('<div class="fl-builder-block-drag-helper">' + FLBuilderStrings.column + '</div>');
		},
		
		/**
		 * Initializes dragging for columns. Columns themselves aren't sortables
		 * as nesting that many sortables breaks down quickly and draggable by
		 * itself is slow. Instead, we are programmatically triggering the drag
		 * of our helper div that isn't a nested sortable but connected to the 
		 * sortables in the main layout.
		 *
		 * @since 1.9
		 * @access private
		 * @method _colDragInit
		 * @param {Object} e The event object.
		 */
		_colDragInit: function( e )
		{
			var handle = $( e.target ),
				helper = $( '.fl-col-sortable-proxy-item' ),
				col    = handle.closest( '.fl-col' );
				
			if ( handle.hasClass( 'fl-block-col-move-parent' ) ) {
				col = col.parents( '.fl-col' );
			}
			
			col.addClass( 'fl-node-dragging' );
			
			FLBuilder._blockDragInit( e );
			FLBuilder._removeColHighlightGuides();
			
			e.target = helper[ 0 ];
			
			helper.trigger( e );
		},
		
		/**
		 * Callback that fires when dragging starts for a column.
		 *
		 * @since 1.9
		 * @access private
		 * @method _colDragStart
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_colDragStart: function( e, ui )
		{
			var col = $( '.fl-node-dragging' );
			
			col.hide();

			FLBuilder._resetColumnWidths( col.parent() );
			FLBuilder._blockDragStart( e, ui );
		},
		
		/**
		 * Callback that fires when dragging stops for a column.
		 *
		 * @since 1.9
		 * @access private
		 * @method _colDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_colDragStop: function( e, ui )
		{
			FLBuilder._blockDragStop( e, ui );
			
			var col        = $( '.fl-node-dragging' ).removeClass( 'fl-node-dragging' ).show(),
				colId      = col.attr( 'data-node' ),
				newParent  = ui.item.parent(),
				oldGroup   = col.parent(),
				oldGroupId = oldGroup.attr( 'data-node' )
				newGroup   = newParent.closest( '.fl-col-group' ),
				newGroupId = newGroup.attr( 'data-node' ),
				newRow     = newParent.closest('.fl-row'),
				position   = 0;
			
			// Cancel the drop if the sortable is disabled?
			if ( newParent.hasClass( 'fl-sortable-disabled' ) ) {
				FLBuilder._resetColumnWidths( oldGroup );
			}
			// A column was dropped back into the sortable proxy.
			else if ( newParent.hasClass( 'fl-col-sortable-proxy' ) ) {
				FLBuilder._resetColumnWidths( oldGroup );
			}
			// A column was dropped into a column.
			else if ( newParent.hasClass( 'fl-col-content' ) ) {
				
				// Remove the column.
				col.remove();
				
				// Remove empty old groups (needs to be done here for correct position).
				if ( 0 === oldGroup.find( '.fl-col' ).length ) {
					oldGroup.remove();
				}
				
				// Find the new group position.
				position = newParent.find( '> .fl-module, .fl-col-group, .fl-col-sortable-proxy-item' ).index( ui.item );
				
				// Add the new group.
				FLBuilder._addColGroup( newParent.closest( '.fl-col' ).attr('data-node'), colId, position );
			}
			// A column was dropped into a column position.
			else if ( newParent.hasClass( 'fl-col-drop-target' ) ) {
				
				// Move the column in the UI.
				if ( newParent.hasClass( 'fl-col-drop-target-last' ) ) {
					newParent.parent().after( col );
				}
				else {
					newParent.parent().before( col );
				}
				
				// Reset the UI column widths.
				FLBuilder._resetColumnWidths( newGroup );
				
				// Save the column move via AJAX.
				if ( oldGroupId == newGroupId ) {
					FLBuilder.ajax( {
						action: 'reorder_col',
						node_id: colId,
						position: col.index(),
						silent: true
					} );
				}
				else {
					FLBuilder.ajax( {
						action: 'move_col',
						node_id: colId,
						new_parent: newGroupId,
						position: col.index(),
						resize: [ oldGroupId, newGroupId ],
						silent: true
					} );
				}
				
				// Trigger a layout resize.
				FLBuilder._resizeLayout();
			}
			// A column was dropped into a column group position.
			else if ( newParent.hasClass( 'fl-col-group-drop-target' ) ) {
				
				// Remove the column.
				col.remove();
				
				// Remove empty old groups (needs to be done here for correct position).
				if ( 0 === oldGroup.find( '.fl-col' ).length ) {
					oldGroup.remove();
				}
				
				// Find the new group position.
				position = newRow.find( '.fl-row-content > .fl-col-group' ).index( newGroup );
				position = newParent.hasClass( 'fl-drop-target-last' ) ? position + 1 : position;
				
				// Add the new group.
				FLBuilder._addColGroup( newRow.attr('data-node'), colId, position );
			}
			// A column was dropped into a row position.
			else if ( newParent.hasClass( 'fl-row-drop-target' ) ) {
				
				// Remove the column.
				col.remove();
				
				// Find the new row position.
				position = newParent.closest( '.fl-builder-content' ).find( '.fl-row' ).index( newRow );
				position = newParent.hasClass( 'fl-drop-target-last' ) ? position + 1 : position;
				
				// Add the new row.
				FLBuilder._addRow( colId, position );
			}
				
			// Remove empty old groups.
			if ( 0 === oldGroup.find( '.fl-col' ).length ) {
				oldGroup.remove();
			}
			
			// Revert the proxy to its parent.
			$( '.fl-col-sortable-proxy' ).append( ui.item );
			
			// Finish the drag.
			FLBuilder._highlightEmptyCols();
			FLBuilder._initDropTargets();
			FLBuilder._initSortables();
		},
		
		/**
		 * Shows the settings lightbox and loads the column settings
		 * when the column settings button is clicked.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _colSettingsClicked
		 * @param {Object} e The event object.
		 */
		_colSettingsClicked: function(e)
		{
			var button = $( this ),
				col    = button.closest('.fl-col'),
				nodeId = null;
			
			if ( FLBuilder._colResizing ) {
				return;
			}
			
			if ( button.hasClass( 'fl-block-col-edit-parent' ) ) {
				nodeId = col.parents( '.fl-col' ).data( 'node' );
			}
			else {
				nodeId = col.attr('data-node');
			}
			
			FLBuilder._closePanel();
			FLBuilder._showLightbox();
			
			FLBuilder.ajax({
				action: 'render_column_settings',
				node_id: nodeId
			}, FLBuilder._colSettingsLoaded);
			
			e.stopPropagation();
		},
		
		/**
		 * Sets the lightbox content when the column settings have 
		 * loaded and creates a new preview.
		 *
		 * @since 1.1.9
		 * @access private
		 * @method _colSettingsLoaded
		 * @param {String} response The JSON response with the HTML for the column settings form.
		 */
		_colSettingsLoaded: function( response )
		{
			var data 	 = JSON.parse( response ),
				settings = null,
				nodeId   = null,
				col      = null,
				content  = null;
			
			FLBuilder._setSettingsFormContent( data.settings );
			
			settings = $( '.fl-builder-col-settings' );
			nodeId   = settings.data( 'node' );
			col      = $( '.fl-col[data-node="' + nodeId + '"]' );
			content  = col.find( '> .fl-col-content' );
				
			if ( col.siblings( '.fl-col' ).length === 0  ) {
				$( settings ).find( '#fl-builder-settings-section-general' ).css( 'display', 'none' );
			}
			else if( content.width() <= 40 ) {
				$( '#fl-field-size' ).hide();
			}
			
			FLBuilder.preview = new FLBuilderPreview( { 
				type  : 'col',
				state : data.state 
			} );
		},
		
		/**
		 * Callback for when the delete column button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteColClicked
		 * @param {Object} e The event object.
		 */
		_deleteColClicked: function( e )
		{
			var button         = $( this ),
				col            = button.closest( '.fl-col' ),
				parentGroup    = col.closest( '.fl-col-group' ),
				parentCol      = col.parents( '.fl-col' ),
				hasParentCol   = parentCol.length > 0,
				parentChildren = parentCol.find( '> .fl-col-content > .fl-module, > .fl-col-content > .fl-col-group' ),
				siblingCols    = col.siblings( '.fl-col' ),
				result         = true;
				
			if ( col.find( '.fl-module' ).length > 0 ) {
				result = confirm( FLBuilderStrings.deleteColumnMessage );	
			}
			
			// Handle deleting of nested columns.
			if ( hasParentCol && 1 === parentChildren.length ) {
				
				if ( 0 === siblingCols.length ) {
					col = parentCol;
				}
				else if ( 1 === siblingCols.length && ! siblingCols.find( '.fl-module' ).length ) {
					col = parentGroup;
				}
			}
			
			if ( result ) {
				FLBuilder._deleteCol( col );
				FLBuilder._removeAllOverlays();
				FLBuilder._highlightEmptyCols();
			}
			
			e.stopPropagation();
		},
		
		/**
		 * Deletes a column.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteCol
		 * @param {Object} col A jQuery reference of the column to delete (can also be a group).
		 */
		_deleteCol: function(col)
		{
			var row   = col.closest('.fl-row'),
				group = col.closest('.fl-col-group'),
				cols  = null,
				width = 0;
				
			col.remove();
			rowCols   = row.find('.fl-row-content > .fl-col-group > .fl-col');
			groupCols = group.find(' > .fl-col');
			
			if(0 === rowCols.length && 'row' != FLBuilderConfig.userTemplateType) {
				FLBuilder._deleteRow(row);
			}
			else {
				
				if(0 === groupCols.length) {
					group.remove();
				}
				else {
					
					if ( 6 === groupCols.length ) {
						width = 16.65;
					}
					else if ( 7 === groupCols.length ) {
						width = 14.28;
					}
					else {
						width = Math.round( 100 / groupCols.length * 100 ) / 100;
					}
					
					groupCols.css('width', width + '%');
				}
			
				FLBuilder.ajax({
					action          : 'delete_col',
					node_id         : col.attr('data-node'),
					new_width       : width,
					silent          : true
				});
				
				FLBuilder._initDropTargets();
				FLBuilder._initSortables();
			}
		},
		
		/**
		 * Inserts a column (or columns) before or after another column.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _addCols
		 * @param {Object} col A jQuery reference of the column to insert before or after.
		 * @param {String} insert Either before or after.
		 * @param {String} type The type of column(s) to insert.
		 * @param {Boolean} nested Whether these columns are nested or not.
		 */
		_addCols: function( col, insert, type, nested )
		{
			type   = typeof type == 'undefined' ? '1-col' : type;
			nested = typeof nested == 'undefined' ? false : nested;
			
			FLBuilder.showAjaxLoader();
			FLBuilder._removeAllOverlays();
			
			FLBuilder.ajax( {
				action          : 'render_new_columns',
				node_id         : col.attr('data-node'),
				insert 			: insert,
				type            : type,
				nested			: nested ? 1 : 0
			}, FLBuilder._addColsComplete );
		},
		
		/**
		 * Adds the HTML for columns to the layout when the AJAX add 
		 * operation is complete. Adds a module if one is queued to 
		 * go in a new column.
		 *
		 * @since 1.9
		 * @access private
		 * @method _addColsComplete
		 * @param {String} response The JSON response with the HTML for the new column(s).
		 */     
		_addColsComplete: function( response )
		{
			var data       = JSON.parse( response ),
				col        = null,
				moduleData = FLBuilder._addModuleAfterNodeRender,
				module     = null;
				
			// Render the layout.
			FLBuilder._renderLayout( data, function() {
					
				// Add a module to a newly created column.
				if ( moduleData !== null ) {
					
					$( '[data-node="' + moduleData.module.data( 'node' ) + '"]' ).remove()
					
					col = $( '[data-node="' + moduleData.colId + '"]' );
					
					if ( 'after' == moduleData.position ) {
						col.next().find( '.fl-col-content' ).append( moduleData.module );
					}
					else {
						col.prev().find( '.fl-col-content' ).append( moduleData.module );
					}
					
					FLBuilder._reorderModule( moduleData.module );
					FLBuilder._addModuleAfterNodeRender = null;
				}
			} );
		},
		
		/**
		 * Adds a new column group to the layout.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addColGroup
		 * @param {String} nodeId The node ID of the parent row.
		 * @param {String} cols The type of column layout to use.
		 * @param {Number} position The position of the new column group.
		 */
		_addColGroup: function(nodeId, cols, position)
		{
			var parent = $( '.fl-node-' + nodeId );
			
			// Show the loader.
			FLBuilder.showAjaxLoader();
			
			// Save the new column group info.
			FLBuilder._newColGroupPosition = position;
			
			if ( parent.hasClass( 'fl-col' ) ) {
				FLBuilder._newColGroupParent = parent.find( ' > .fl-col-content' );
			}
			else {
				FLBuilder._newColGroupParent = parent.find( '.fl-row-content' );
			}
			
			// Send the request.
			FLBuilder.ajax({
				action      : 'render_new_column_group',
				cols        : cols,
				node_id     : nodeId,
				position    : position
			}, FLBuilder._addColGroupComplete);
		},
		
		/**
		 * Adds the HTML for a new column group to the layout when 
		 * the AJAX add operation is complete. Adds a module if one 
		 * is queued to go in the new column group.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addColGroupComplete
		 * @param {String} response The JSON response with the HTML for the new column group.
		 */     
		_addColGroupComplete: function(response)
		{
			var data   = JSON.parse(response),
				colId  = $(data.html).find('.fl-col').data('node'),
				module = FLBuilder._addModuleAfterNodeRender;
				
			// Add new column group info to the data.
			data.nodeParent 	= FLBuilder._newColGroupParent;
			data.nodePosition 	= FLBuilder._newColGroupPosition;
				
			// Render the layout.
			FLBuilder._renderLayout( data, function(){
				
				// Added the nested columns class if needed.
				if ( data.nodeParent.hasClass( 'fl-col-content' ) ) {
					data.nodeParent.parents( '.fl-col' ).addClass( 'fl-col-has-cols' );
				}
				
				// Add a module to the newly created column group.
				if(module !== null) {
					$('.fl-node-' + colId + ' .fl-col-content').append(module);
					FLBuilder._reorderModule(module);
					FLBuilder._addModuleAfterNodeRender = null;
				}
			} );
		},
		
		/**
		 * Initializes draggables for column resizing.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _initColDragResizing
		 */
		_initColDragResizing: function()
		{
			$( '.fl-block-col-resize' ).draggable( {
				axis 	: 'x',
				start 	: FLBuilder._colDragResizeStart,
				drag	: FLBuilder._colDragResize,
				stop 	: FLBuilder._colDragResizeStop
			} );
		},
		
		/**
		 * Fires when dragging for a column resize starts.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _colDragResizeStart
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_colDragResizeStart: function( e, ui )
		{
			// Setup resize vars.
			var handle 		 = $( ui.helper ),
				direction 	 = '',
				resizeParent = handle.hasClass( 'fl-block-col-resize-parent' ),
				parentCol    = resizeParent ? handle.closest( '.fl-col' ).parents( '.fl-col' ) : null,
				group		 = resizeParent ? parentCol.parents( '.fl-col-group' ) : handle.closest( '.fl-col-group' ),
				cols 		 = group.find( '> .fl-col' ),
				col 		 = resizeParent ? parentCol : handle.closest( '.fl-col' ),
				sibling 	 = null,
				availWidth   = 100,
				i 			 = 0;
				
			// Find the direction and sibling.
			if ( handle.hasClass( 'fl-block-col-resize-e' ) ) {
				direction = 'e';
				sibling = col.next( '.fl-col' );
			}
			else {
				direction = 'w';
				sibling = col.prev( '.fl-col' );
			}
			
			// Find the available width.
			for ( ; i < cols.length; i++ ) {
				
				if ( cols.eq( i ).data( 'node' ) == col.data( 'node' ) ) {
					continue;
				}
				if ( cols.eq( i ).data( 'node' ) == sibling.data( 'node' ) ) {
					continue;
				}
				
				availWidth -= parseFloat( cols.eq( i )[ 0 ].style.width );
			}
			
			// Build the resize data object.
			FLBuilder._colResizeData = {
				handle			: handle,
				feedbackLeft	: handle.find( '.fl-block-col-resize-feedback-left' ),
				feedbackRight	: handle.find( '.fl-block-col-resize-feedback-right' ),
				direction		: direction,
				groupWidth		: group.outerWidth(),
				col 			: col,
				colWidth 		: parseFloat( col[ 0 ].style.width ) / 100,
				sibling 		: sibling,
				offset  		: ui.position.left,
				availWidth		: availWidth
			};
			
			// Set the resizing flag.
			FLBuilder._colResizing = true;
			
			// Add the body col resize class.
			$( 'body' ).addClass( 'fl-builder-col-resizing' );
			
			// Close the builder panel and destroy overlay events.
			FLBuilder._closePanel();
			FLBuilder._destroyOverlayEvents();
			
			// Trigger the col-resize-start hook.
			FLBuilder.triggerHook( 'col-resize-start' );
		},
		
		/**
		 * Fires when dragging for a column resize is in progress.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _colDragResize
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_colDragResize: function( e, ui )
		{
			// Setup resize vars.
			var data 			= FLBuilder._colResizeData,
				change 			= ( data.offset - ui.position.left ) / data.groupWidth,
				colWidth 		= 'e' == data.direction ? ( data.colWidth - change ) * 100 : ( data.colWidth + change ) * 100,
				colRound 		= Math.round( colWidth * 100 ) / 100,
				siblingWidth	= data.availWidth - colWidth,
				siblingRound	= Math.round( siblingWidth * 100 ) / 100,
				minRound		= 8,
				maxRound		= Math.round( ( data.availWidth - minRound ) * 100 ) / 100;
			
			// Set the min/max width if needed.
			if ( colRound < minRound ) {
				colRound 		= minRound;
				siblingRound 	= maxRound;
			}
			else if ( siblingRound < minRound ) {
				colRound 		= maxRound;
				siblingRound 	= minRound;
			}
			
			// Set the feedback values.
			if ( 'e' == data.direction ) {
				data.feedbackLeft.html( colRound.toFixed( 1 ) + '%'  ).show();
				data.feedbackRight.html( siblingRound.toFixed( 1 ) + '%'  ).show();
			}
			else {
				data.feedbackLeft.html( siblingRound.toFixed( 1 ) + '%'  ).show();
				data.feedbackRight.html( colRound.toFixed( 1 ) + '%'  ).show();
			}
			
			// Set the width attributes.
			data.col.css( 'width', colRound + '%' );
			data.sibling.css( 'width', siblingRound + '%' );
			
			// Trigger the col-resize-drag hook.
			FLBuilder.triggerHook( 'col-resize-drag' );
		},
		
		/**
		 * Fires when dragging for a column resize stops.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _colDragResizeStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_colDragResizeStop: function( e, ui )
		{
			var data    = FLBuilder._colResizeData,
				overlay = FLBuilder._colResizeData.handle.closest( '.fl-block-overlay' );
			
			// Hide the feedback divs.
			FLBuilder._colResizeData.feedbackLeft.hide();
			FLBuilder._colResizeData.feedbackRight.hide();
			
			// Save the resize data.
			FLBuilder.ajax({
				action			: 'resize_cols',
				col_id			: data.col.data( 'node' ),
				col_width		: parseFloat( data.col[ 0 ].style.width ),
				sibling_id		: data.sibling.data( 'node' ),
				sibling_width	: parseFloat( data.sibling[ 0 ].style.width ),
				silent			: true
			});
			
			// Build the overlay overflow menu if needed.
			FLBuilder._buildOverlayOverflowMenu( overlay );
			
			// Reset the resize data.
			FLBuilder._colResizeData = null;
			
			// Remove the body col resize class.
			$( 'body' ).removeClass( 'fl-builder-col-resizing' );
			
			// Rebind overlay events.
			FLBuilder._bindOverlayEvents();
			
			// Set the resizing flag to false with a timeout so other events get the right value.
			setTimeout( function() { FLBuilder._colResizing = false; }, 50 );
			
			// Trigger the col-resize-stop hook.
			FLBuilder.triggerHook( 'col-resize-stop' );
		},
		
		/**
		 * Resets the widths of all columns in a row when the 
		 * Reset Column Widths button is clicked.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _resetColumnWidthsClicked
		 * @param {Object} e The event object.
		 */
		_resetColumnWidthsClicked: function( e )
		{
			var group    = $( this ).parents( '.fl-col-group' ).last(),
				groupIds = [ group.data( 'node' ) ],
				children = group.find( '.fl-col-group' ),
				i        = 0;
				
			FLBuilder._resetColumnWidths( group );
				
			for ( ; i < children.length; i++ ) {
				FLBuilder._resetColumnWidths( children.eq( i ) );
				groupIds.push( children.eq( i ).data( 'node' ) );
			}
			
			FLBuilder.ajax({
				action		: 'reset_col_widths',
				group_id	: groupIds,
				silent		: true
			});
				
			FLBuilder.triggerHook( 'col-reset-widths' );
			FLBuilder._closeAllSubmenus();
			
			e.stopPropagation();
		},
		
		/**
		 * Resets the widths of all columns in a group.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _resetColumnWidths
		 * @param {Object} e The event object.
		 */
		_resetColumnWidths: function( group )
		{
			var cols  = group.find( ' > .fl-col:visible' ),
				width = 0;
			
			if ( 6 === cols.length ) {
				width = 16.65;
			}
			else if ( 7 === cols.length ) {
				width = 14.28;
			}
			else {
				width = Math.round( 100 / cols.length * 100 ) / 100;
			}
			
			cols.css( 'width', width + '%' );
		},
		
		/* Modules
		----------------------------------------------------------*/
		
		/**
		 * Shows an overlay with actions when the mouse enters a module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleMouseenter
		 */
		_moduleMouseenter: function()
		{
			var module        = $( this ),
				moduleName    = module.attr( 'data-name' ),
				global		  = module.hasClass( 'fl-node-global' ),
				parentGlobal  = module.parents( '.fl-node-global' ).length > 0,
				numCols		  = module.closest( '.fl-col-group' ).find( '> .fl-col' ).length,
				col           = module.closest( '.fl-col' ),
				colFirst      = 0 === col.index(),
				colLast       = numCols === col.index() + 1,
				parentCol     = col.parents( '.fl-col' ),
				hasParentCol  = parentCol.length > 0,
				numParentCols = hasParentCol ? parentCol.closest( '.fl-col-group' ).find( '> .fl-col' ).length : 0,
				parentFirst   = hasParentCol ? 0 === parentCol.index() : false,
				parentLast    = hasParentCol ? numParentCols === parentCol.index() + 1 : false,
				contentWidth  = col.find( '> .fl-col-content' ).width(),
				template	  = wp.template( 'fl-module-overlay' ),
				overlay       = null;
				
			// Remove existing overlays.
			FLBuilder._removeColOverlays();
			FLBuilder._removeModuleOverlays();
			
			if ( global && parentGlobal && 'row' != FLBuilderConfig.userTemplateType ) {
				return;
			}
			else if ( ! module.hasClass( 'fl-block-overlay-active' ) ) {
				
				// Append the template.
				overlay = FLBuilder._appendOverlay( module, template( { 
					global 		  : global, 
					moduleName	  : moduleName,
					numCols		  : numCols,
					colFirst      : colFirst,
					colLast       : colLast,
					hasParentCol  : hasParentCol,
					numParentCols : numParentCols,
					parentFirst   : parentFirst,
					parentLast    : parentLast,
					contentWidth  : contentWidth
				} ) );
				
				// Build the overlay overflow menu if necessary.
				FLBuilder._buildOverlayOverflowMenu( overlay );
				
				// Init column resizing.
				FLBuilder._initColDragResizing();
			}
			
			$( 'body' ).addClass( 'fl-block-overlay-muted' );
		},
		
		/**
		 * Removes overlays when the mouse leaves a module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleMouseleave
		 * @param {Object} e The event object.
		 */
		_moduleMouseleave: function(e)
		{
			var module          = $(this),
				toElement       = $(e.toElement) || $(e.relatedTarget),
				isTipTip        = toElement.is('#tiptip_holder'),
				isTipTipChild   = toElement.closest('#tiptip_holder').length > 0;
			
			if(isTipTip || isTipTipChild) {
				return;
			}
			
			FLBuilder._removeModuleOverlays();
			FLBuilder._removeColHighlightGuides();
		},
		
		/**
		 * Removes all module overlays from the page.
		 *
		 * @since 1.6.4
		 * @access private
		 * @method _removeModuleOverlays
		 */
		_removeModuleOverlays: function()
		{
			var modules = $('.fl-module');
			
			modules.removeClass('fl-block-overlay-active');
			modules.find('.fl-module-overlay').remove();
			$('body').removeClass('fl-block-overlay-muted');
		},
		
		/**
		 * Returns a helper element for module drag operations.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleDragHelper
		 * @param {Object} e The event object.
		 * @param {Object} item The element being dragged.
		 * @return {Object} The helper element.
		 */
		_moduleDragHelper: function(e, item)
		{   
			return $('<div class="fl-builder-block-drag-helper">' + item.attr('data-name') + '</div>');
		},
		
		/**
		 * Callback that fires when dragging starts for a module.
		 *
		 * @since 1.9
		 * @access private
		 * @method _moduleDragStart
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_moduleDragStart: function( e, ui )
		{
			$( ui.item ).data( 'original-position', ui.item.index() );
			
			FLBuilder._blockDragStart( e, ui );
		},
		
		/**
		 * Callback for when a module drag operation completes.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */
		_moduleDragStop: function(e, ui)
		{
			FLBuilder._blockDragStop( e, ui );
			
			var item     = ui.item,
				parent   = item.parent(),
				node     = null,
				position = 0,
				parentId = 0;
			
			// A module was dropped back into the module list.
			if ( parent.hasClass( 'fl-builder-modules' ) || parent.hasClass( 'fl-builder-widgets' ) ) {
				item.remove();
				return;
			}
			// A new module was dropped.
			else if ( item.hasClass( 'fl-builder-block' ) ) {
			
				// Cancel the drop if the sortable is disabled?
				if ( parent.hasClass( 'fl-sortable-disabled' ) ) {
					item.remove();
					FLBuilder._showPanel();
					return;
				}
				// A new module was dropped into a row position.
				else if ( parent.hasClass( 'fl-row-drop-target' ) ) {
					parent   = item.closest('.fl-builder-content');
					parentId = 0;
					node     = item.closest('.fl-row');
					position = parent.find( '.fl-row' ).index( node );
				}
				// A new module was dropped into a column group position.
				else if ( parent.hasClass( 'fl-col-group-drop-target' ) ) {
					parent   = item.closest( '.fl-row-content' );
					parentId = parent.closest( '.fl-row' ).attr( 'data-node' );
					node     = item.closest( '.fl-col-group' );
					position = parent.find( ' > .fl-col-group' ).index( node );
				}
				// A new module was dropped into a column position.
				else if ( parent.hasClass( 'fl-col-drop-target' ) ) {
					parent   = item.closest( '.fl-col-group' );
					parentId = parent.attr( 'data-node' );
					node     = item.closest( '.fl-col' );
					position = parent.find( ' > .fl-col' ).index( node );
				}
				// A new module was dropped into a column.
				else {
					position = parent.find( '> .fl-module, .fl-col-group, .fl-builder-block' ).index( item );
					parentId = item.closest( '.fl-col' ).attr( 'data-node' );
				}
				
				// Increment the position?
				if ( item.closest( '.fl-drop-target-last' ).length ) {
					position += 1;
				}
				
				// Add the new module.
				FLBuilder._addModule( parent, parentId, item.attr( 'data-type' ), position, item.attr( 'data-widget' ) );
				
				// Remove the drag helper.
				item.remove();
			}
			// Cancel the drop if the sortable is disabled?
			else if ( parent.hasClass( 'fl-sortable-disabled' ) ) {
				$( e.target ).append( ui.item );
				$( e.target ).children().eq( ui.item.data( 'original-position' ) ).before( ui.item );
				FLBuilder._highlightEmptyCols();
				return;
			}
			// A module was dropped into a row position.
			else if ( parent.hasClass( 'fl-row-drop-target' ) ) {
				node     = item.closest( '.fl-row' );
				position = item.closest( '.fl-builder-content' ).children( '.fl-row' ).index( node );
				position = item.closest( '.fl-drop-target-last' ).length ? position + 1 : position;
				FLBuilder._addModuleAfterNodeRender = item;
				FLBuilder._addRow( '1-col', position );
				item.remove();
			}
			// A module was dropped into a column group position.
			else if ( parent.hasClass( 'fl-col-group-drop-target' ) ) {
				node     = item.closest( '.fl-col-group' );
				position = item.closest( '.fl-row-content ').find( ' > .fl-col-group' ).index( node );
				position = item.closest( '.fl-drop-target-last' ).length ? position + 1 : position;
				FLBuilder._addModuleAfterNodeRender = item;
				FLBuilder._addColGroup( item.closest( '.fl-row' ).attr( 'data-node' ), '1-col', position );
				item.remove();
			}
			// A module was dropped into a column position.
			else if ( parent.hasClass( 'fl-col-drop-target' ) ) {
				node     = item.closest( '.fl-col' );
				position = item.closest( '.fl-col-drop-target-last' ).length ? 'after' : 'before';
				FLBuilder._addModuleAfterNodeRender = { module: item, colId: node.data( 'node' ), position: position };
				FLBuilder._addCols( node, position, '1-col', item.closest( '.fl-col-group-nested' ).length > 0 );
				item.remove();
			}
			// A module was dropped into another column.
			else {
				FLBuilder._reorderModule( item );
			}
			
			FLBuilder._resizeLayout();
		},
		
		/**
		 * Reorders a module within a column.
		 *
		 * @since 1.0
		 * @access private
		 * @method _reorderModule
		 * @param {Object} module The module element being dragged.
		 */
		_reorderModule: function(module)
		{
			var newParent = module.closest('.fl-col').attr('data-node'),
				oldParent = module.attr('data-parent'),
				nodeId    = module.attr('data-node'),
				position  = module.index();
				 
			if(newParent == oldParent) {
				FLBuilder._reorderNode( nodeId, position );
			}
			else {
				module.attr('data-parent', newParent);
				FLBuilder._moveNode( newParent, nodeId, position );
			}
		},
		
		/**
		 * Callback for when the delete module button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteModuleClicked
		 * @param {Object} e The event object.
		 */
		_deleteModuleClicked: function(e)
		{
			var module = $(this).closest('.fl-module'),
				result = confirm(FLBuilderStrings.deleteModuleMessage);
			
			if(result) {
				FLBuilder._deleteModule(module);
				FLBuilder._removeAllOverlays();
			}
			
			e.stopPropagation();
		},
		
		/**
		 * Deletes a module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteModule
		 * @param {Object} module A jQuery reference of the module to delete.
		 */
		_deleteModule: function(module)
		{
			var row = module.closest('.fl-row');

			FLBuilder.ajax({
				action: 'delete_node',
				node_id: module.attr('data-node'),
				silent: true
			});
			
			module.empty();
			module.remove();
			row.removeClass('fl-block-overlay-muted');
			FLBuilder._highlightEmptyCols();
			FLBuilder._removeAllOverlays();
		},
		
		/**
		 * Duplicates a module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleCopyClicked
		 * @param {Object} e The event object.
		 */ 
		_moduleCopyClicked: function(e)
		{
			var module = $(this).closest('.fl-module');
			
			FLBuilder.showAjaxLoader();
			FLBuilder._removeAllOverlays();
			FLBuilder._newModuleParent 	 = module.parent();
			FLBuilder._newModulePosition = module.index() + 1;
			
			FLBuilder.ajax({
				action: 'copy_module',
				node_id: module.attr('data-node')
			}, FLBuilder._moduleCopyComplete);
			
			e.stopPropagation();
		},
		
		/**
		 * Callback for when a module has been duplicated.
		 *
		 * @since 1.7
		 * @access private
		 * @method _moduleCopyComplete
		 * @param {String} response The JSON encoded response.
		 */ 
		_moduleCopyComplete: function( response )
		{
			var data = JSON.parse( response );
			
			data.nodeParent 	= FLBuilder._newModuleParent;
			data.nodePosition 	= FLBuilder._newModulePosition;
			
			FLBuilder._renderLayout( data );
		},
		
		/**
		 * Shows the settings lightbox and loads the module settings
		 * when the module settings button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleSettingsClicked
		 * @param {Object} e The event object.
		 */ 
		_moduleSettingsClicked: function(e)
		{
			var button   = $( this ),
				nodeId   = button.closest( '.fl-module' ).attr( 'data-node' ),
				parentId = button.closest( '.fl-col' ).attr( 'data-node' ),
				type     = button.closest( '.fl-module' ).attr( 'data-type' ),
				global 	 = button.closest( '.fl-block-overlay-global' ).length > 0;
			
			e.stopPropagation();
			
			if ( FLBuilder._colResizing ) {
				return;
			}
			if ( global && ! FLBuilderConfig.userCanEditGlobalTemplates ) {
				return;
			}
			
			FLBuilder._showModuleSettings(nodeId, parentId, type);
		},
		
		/**
		 * Shows the lightbox and loads the settings for a module.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showModuleSettings
		 * @param {String} nodeId The node ID for the module.
		 * @param {String} parentId The node ID for the module's parent.
		 * @param {String} type The type of module.
		 */
		_showModuleSettings: function(nodeId, parentId, type)
		{
			FLBuilder._closePanel();
			FLBuilder._showLightbox();
			
			FLBuilder.ajax({
				action: 'render_module_settings',
				node_id: nodeId,
				type: type,
				parent_id: parentId
			}, FLBuilder._moduleSettingsLoaded);
		},
		
		/**
		 * Sets the lightbox content when the module settings have 
		 * loaded and creates a new preview.
		 *
		 * @since 1.0
		 * @access private
		 * @method _moduleSettingsLoaded
		 * @param {Object} response The JSON encoded module settings data.
		 */ 
		_moduleSettingsLoaded: function(response)
		{
			var data 	  = JSON.parse(response),
				html      = $('<div>'+ data.settings +'</div>'),
				link      = html.find('link.fl-builder-settings-css'),
				script    = html.find('script.fl-builder-settings-js'),
				form      = html.find('.fl-builder-settings'),
				type      = form.attr('data-type'),
				layout	  = null,
				state 	  = null,
				helper    = null;
			
			// Append the settings css and js?
			if($.inArray(type, FLBuilder._loadedModuleAssets) > -1) {
				link.remove();
				script.remove();
			}
			else {
				$('head').append(link);
				$('head').append(script);
				FLBuilder._loadedModuleAssets.push(type);
			}
			
			// Set the content.
			FLBuilder._setSettingsFormContent(html);
			
			// Get layout data for a new module preview.
			if ( 'undefined' != typeof data.layout ) {
				layout 				= data.layout;				
				layout.nodeParent 	= FLBuilder._newModuleParent;
				layout.nodePosition = FLBuilder._newModulePosition;
			}
			
			// Get state data for the module preview.
			if ( 'undefined' != typeof data.state ) {
				state = data.state;
			}
			
			// Create a new preview.
			FLBuilder.preview = new FLBuilderPreview({ 
				type    : 'module',
				layout  : layout,
				state   : state
			});
			
			// Init the settings form helper.
			helper = FLBuilder._moduleHelpers[type];
			
			if(typeof helper !== 'undefined') {
				FLBuilder._initSettingsValidation(helper.rules);
				helper.init();
			}
		},
		
		/**
		 * Validates the module settings and saves them if 
		 * the form is valid.
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveModuleClicked
		 */ 
		_saveModuleClicked: function()
		{
			var form      = $(this).closest('.fl-builder-settings'),
				type      = form.attr('data-type'),
				id        = form.attr('data-node'),
				helper    = FLBuilder._moduleHelpers[type],
				valid     = true;
			
			if(typeof helper !== 'undefined') {
				
				form.find('label.error').remove();
				form.validate().hideErrors();
				valid = form.validate().form();
				
				if(valid) {
					valid = helper.submit();
				}
			}
			if(valid) {
				FLBuilder._saveSettings();
				FLBuilder._lightbox.close();
			}
			else {
				FLBuilder._toggleSettingsTabErrors();
			}
		},
		
		/**
		 * Adds a new module to a column and loads the settings.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addModule
		 * @param {Object} parent A jQuery reference to the new module's parent.
		 * @param {String} parentId The node id of the new module's parent.
		 * @param {String} type The type of module to add.
		 * @param {Number} position The position of the new module within its parent.
		 * @param {String} widget The type of widget if this module is a widget.
		 */ 
		_addModule: function(parent, parentId, type, position, widget)
		{
			// Show the loader.
			FLBuilder.showAjaxLoader();
			
			// Save the new module data.
			if ( parent.hasClass( 'fl-col-group' ) ) {
				FLBuilder._newModuleParent 	 = null;
				FLBuilder._newModulePosition = 0;
			}
			else {
				FLBuilder._newModuleParent 	 = parent;
				FLBuilder._newModulePosition = position;
			}
			
			// Send the request.
			FLBuilder.ajax({
				action          : 'render_new_module',
				parent_id       : parentId,
				type            : type,
				position        : position,
				node_preview    : 1,
				widget          : typeof widget === 'undefined' ? '' : widget
			}, FLBuilder._addModuleComplete);
		},
		
		/**
		 * Shows the settings lightbox and sets the content when
		 * the module settings have finished loading.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addModuleComplete
		 * @param {String} response The JSON encoded response.
		 */ 
		_addModuleComplete: function(response)
		{
			FLBuilder._showLightbox();
			FLBuilder._moduleSettingsLoaded(response);
			
			$('.fl-builder-module-settings').data('new-module', '1');
		},
		
		/**
		 * Registers a helper class for a module's settings.
		 *
		 * @since 1.0
		 * @method registerModuleHelper
		 * @param {String} type The type of module.
		 * @param {Object} obj The module helper.
		 */ 
		registerModuleHelper: function(type, obj)
		{
			var defaults = {
				rules: {},
				init: function(){},
				submit: function(){ return true; },
				preview: function(){}
			};
			
			FLBuilder._moduleHelpers[type] = $.extend({}, defaults, obj);
		},
		
		/**
		 * Deprecated. Use the public method registerModuleHelper instead.
		 *
		 * @since 1.0
		 * @access private
		 * @method _registerModuleHelper
		 * @param {String} type The type of module.
		 * @param {Object} obj The module helper.
		 */ 
		_registerModuleHelper: function(type, obj)
		{
			FLBuilder.registerModuleHelper(type, obj);
		},

		/* Node Templates
		----------------------------------------------------------*/

		/**
		 * Saves a node's settings and shows the node template settings
		 * when the Save As button is clicked.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _showNodeTemplateSettings
		 * @param {Object} e An event object.
		 */ 
		_showNodeTemplateSettings: function( e )
		{
			var form = $( '.fl-builder-settings-lightbox .fl-builder-settings' );
				
			FLBuilder._saveSettings();
			
			FLBuilder.ajax( {
				action  : 'render_node_template_settings',
				node_id : form.attr( 'data-node' )
			}, FLBuilder._nodeTemplateSettingsLoaded );
		},
		
		/**
		 * Sets the lightbox content when the node template settings have loaded.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _nodeTemplateSettingsLoaded
		 * @param {String} response The JSON with the HTML for the settings form.
		 */
		_nodeTemplateSettingsLoaded: function( response )
		{
			var data = JSON.parse( response );
			
			FLBuilder._showLightbox( false );
			FLBuilder._setSettingsFormContent( data.html );
			
			FLBuilder._initSettingsValidation({
				name: {
					required: true
				}
			});
		},
		
		/**
		 * Saves a node as a template when the save button is clicked.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _saveNodeTemplate
		 */ 
		_saveNodeTemplate: function()
		{
			var form  = $( '.fl-builder-settings-lightbox .fl-builder-settings' ),
				valid = form.validate().form();
				
			if ( valid ) {
					 
				FLBuilder.showAjaxLoader();
				
				FLBuilder.ajax({
					action	 : 'save_node_template',
					node_id  : form.attr( 'data-node' ),
					settings : FLBuilder._getSettings( form )
				}, FLBuilder._saveNodeTemplateComplete);
					
				FLBuilder._lightbox.close();
			}
		},
		
		/**
		 * Callback for when a node template has been saved.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _saveNodeTemplateComplete
		 */ 
		_saveNodeTemplateComplete: function( response )
		{
			var data 		= JSON.parse( response ),
				panel 		= $( '.fl-builder-saved-' + data.type + 's' ),
				blocks 		= panel.find( '.fl-builder-block' ),
				block   	= null,
				text    	= '',
				name    	= data.name.toLowerCase(),
				i			= 0,
				template 	= wp.template( 'fl-node-template-block' );
			
			// Show the success alert.
			if ( 'row' == data.type ) {
				FLBuilder.alert( FLBuilderStrings.rowTemplateSaved );
			}
			else if ( 'module' == data.type ) {
				FLBuilder.alert( FLBuilderStrings.moduleTemplateSaved );
			}
			
			// Update the layout for global templates.			
			if ( data.layout ) {
				FLBuilder._renderLayout( data.layout );
			}
			
			// Add the new template to the builder panel.
			if ( 0 === blocks.length ) {
				panel.append( template( data ) );
			}
			else {
				
				for ( ; i < blocks.length; i++ ) {
					
					block = blocks.eq( i );
					text  = block.text().toLowerCase().trim();
					
					if ( 0 === i && name < text ) {
						panel.prepend( template( data ) );
						break;
					}
					else if ( name < text ) {
						block.before( template( data ) );
						break;
					}
					else if ( blocks.length - 1 === i ) {
						panel.append( template( data ) );
						break;
					}
				}
			}
			
			// Remove the no templates placeholder.
			panel.find( '.fl-builder-block-no-node-templates' ).remove();
		},
		
		/**
		 * Callback for when a node template drag from the 
		 * builder panel has stopped.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _nodeTemplateDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */ 
		_nodeTemplateDragStop: function( e, ui )
		{
			FLBuilder._blockDragStop( e, ui );
			
			var item   		= ui.item,
				parent 		= item.parent(),
				parentId	= null,
				position 	= 0,
				node        = null,
				action 		= '',
				callback	= null;
			
			// A saved row was dropped.
			if ( item.hasClass( 'fl-builder-block-saved-row' ) || item.hasClass( 'fl-builder-block-row-template' ) ) {
				node     = item.closest( '.fl-row' );
				position = ! node.length ? 0 : $( FLBuilder._contentClass + ' .fl-row' ).index( node );
				position = parent.hasClass( 'fl-drop-target-last' ) ? position + 1 : position;
				parentId = null;
				action	 = 'render_new_row';
				callback = FLBuilder._addRowComplete;
				FLBuilder._newRowPosition = position;
			}
			// A saved module was dropped.
			else if ( item.hasClass( 'fl-builder-block-saved-module' ) || item.hasClass( 'fl-builder-block-module-template' ) ) {
				
				action	 = 'render_new_module';
				callback = FLBuilder._addModuleComplete;
				
				// Cancel the drop if the sortable is disabled?
				if ( parent.hasClass( 'fl-sortable-disabled' ) ) {
					item.remove();
					FLBuilder._showPanel();
					return;
				}
				// Dropped into a row position.
				else if ( parent.hasClass( 'fl-row-drop-target' ) ) {
					parent   = item.closest('.fl-builder-content');
					parentId = 0;
					position = parent.find( '.fl-row' ).index( item.closest('.fl-row') );
				}
				// Dropped into a column group position.
				else if ( parent.hasClass( 'fl-col-group-drop-target' ) ) {
					parent   = item.closest( '.fl-row-content' );
					parentId = parent.closest( '.fl-row' ).attr( 'data-node' );
					position = parent.find( ' > .fl-col-group' ).index( item.closest( '.fl-col-group' ) );
				}
				// Dropped into a column position.
				else if ( parent.hasClass( 'fl-col-drop-target' ) ) {
					parent   = item.closest('.fl-col-group');
					position = parent.children('.fl-col').index( item.closest('.fl-col') );
					parentId = parent.attr('data-node');
				}
				// Dropped into a column.
				else {
					position = parent.children( '.fl-module, .fl-builder-block' ).index( item );
					parentId = item.closest( '.fl-col' ).attr( 'data-node' );
				}
				
				// Increment the position?
				if ( item.closest( '.fl-drop-target-last' ).length ) {
					position += 1;
				}
				
				// Save the new module data.
				if ( parent.hasClass( 'fl-col-group' ) ) {
					FLBuilder._newModuleParent 	 = null;
					FLBuilder._newModulePosition = 0;
				}
				else {
					FLBuilder._newModuleParent 	 = parent;
					FLBuilder._newModulePosition = position;
				}
			}
			
			// Show the loader.
			FLBuilder.showAjaxLoader();
			
			// Apply and render the node template.
			FLBuilder.ajax({
				action	 	  : action,
				template_id   : item.attr( 'data-id' ),
				template_type : item.attr( 'data-type' ),
				parent_id     : parentId,
				position 	  : position
			}, callback );
			
			// Remove the helper.
			item.remove();
		},
		
		/**
		 * Launches the builder in a new tab to edit a user
		 * defined node template when the edit link is clicked.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _editUserTemplateClicked
		 * @param {Object} e The event object.
		 */
		_editNodeTemplateClicked: function( e )
		{
			e.preventDefault();
			e.stopPropagation();
			
			window.open( $( this ).attr( 'href' ) );
		},
		
		/**
		 * Fires when the delete node template icon is clicked in the builder's panel.
		 *
		 * @since 1.6.3
		 * @access private
		 * @method _deleteNodeTemplateClicked
		 * @param {Object} e The event object.
		 */
		_deleteNodeTemplateClicked: function( e )
		{
			var button 		= $( e.target ),
				section 	= button.closest( '.fl-builder-blocks-section' ),
				panel   	= section.find( '.fl-builder-blocks-section-content' ),
				blocks  	= panel.find( '.fl-builder-block' ),
				block  		= button.closest( '.fl-builder-block' ),
				global 		= block.hasClass( 'fl-builder-block-global' ),
				callback 	= global ? FLBuilder._updateLayout : undefined,
				message     = global ? FLBuilderStrings.deleteGlobalTemplate : FLBuilderStrings.deleteTemplate;
			
			if ( confirm( message ) ) {
				
				// Delete the UI block. 
				block.remove();
				
				// Add the no templates placeholder?
				if ( 1 === blocks.length ) {
					if ( block.hasClass( 'fl-builder-block-saved-row' ) ) {
						panel.append( '<span class="fl-builder-block-no-node-templates">' + FLBuilderStrings.noSavedRows + '</span>' );
					}
					else {
						panel.append( '<span class="fl-builder-block-no-node-templates">' + FLBuilderStrings.noSavedModules + '</span>' );
					}
				}
			
				// Delete the template.
				FLBuilder.ajax({
					action 	     : 'delete_node_template',
					template_id  : block.attr( 'data-id' ),
					silent		 : block.hasClass( 'fl-builder-block-global' ) ? false : true
				}, callback);
			}
		},

		/* Settings
		----------------------------------------------------------*/
		
		/**
		 * Initializes logic for settings forms.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initSettingsForms
		 */ 
		_initSettingsForms: function()
		{
			FLBuilder._initColorPickers();
			FLBuilder._initSelectFields();
			FLBuilder._initMultipleFields();
			FLBuilder._initAutoSuggestFields();
			FLBuilder._initLinkFields();
			FLBuilder._initFontFields();
			
			/**
		     * Hook for settings form init.
		     */
		    FLBuilder.triggerHook('settings-form-init');
		},
		
		/**
		 * Sets the content for the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _setSettingsFormContent
		 * @param {String} html The HTML content for the lightbox.
		 */ 
		_setSettingsFormContent: function(html)
		{
			FLBuilder._setLightboxContent(html);
			FLBuilder._initSettingsForms();
		},
		
		/**
		 * Shows the content for a settings form tab when it is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _settingsTabClicked
		 * @param {Object} e The event object.
		 */ 
		_settingsTabClicked: function(e)
		{
			var tab  = $(this),
				form = tab.closest('.fl-builder-settings'),
				id   = tab.attr('href').split('#').pop();
			
			form.find('.fl-builder-settings-tab').removeClass('fl-active');
			form.find('#' + id).addClass('fl-active');
			form.find('.fl-builder-settings-tabs .fl-active').removeClass('fl-active');
			$(this).addClass('fl-active');
			e.preventDefault();
		},
		
		/**
		 * Reverts an active preview and hides the lightbox when 
		 * the cancel button of a settings lightbox is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _settingsCancelClicked
		 * @param {Object} e The event object.
		 */ 
		_settingsCancelClicked: function(e)
		{
			var moduleSettings = $('.fl-builder-module-settings'),
				existingNodes  = null,
				previewModule  = null,
				previewCol     = null,
				existingCol    = null;
			
			// Delete a new module preview?
			if(moduleSettings.length > 0 && typeof moduleSettings.data('new-module') != 'undefined') {
			
				existingNodes = $(FLBuilder.preview.state.html);
				previewModule = $('.fl-node-' + moduleSettings.data('node'));
				previewCol    = previewModule.closest('.fl-col');
				existingCol   = existingNodes.find('.fl-node-' + previewCol.data('node'));
				
				if(existingCol.length > 0) {
					FLBuilder._deleteModule(previewModule);
				}
				else {
					FLBuilder._deleteCol(previewCol);
				}
			}
			// Do a standard preview revert. 
			else if( FLBuilder.preview ) {
				FLBuilder.preview.revert();
			}
			
			FLBuilder.preview = null;
			FLLightbox.closeParent(this);
		},
		
		/**
		 * Initializes validation logic for a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initSettingsValidation
		 * @param {Object} rules The validation rules object.
		 * @param {Object} messages Custom messages to show for invalid fields.
		 */ 
		_initSettingsValidation: function(rules, messages)
		{
			var form = $('.fl-builder-settings').last();
			
			form.validate({
				ignore: [],
				rules: rules,
				messages: messages,
				errorPlacement: FLBuilder._settingsErrorPlacement
			});
		},
		
		/**
		 * Places a validation error after the invalid field.
		 *
		 * @since 1.0
		 * @access private
		 * @method _settingsErrorPlacement
		 * @param {Object} error The error element.
		 * @param {Object} element The invalid field.
		 */ 
		_settingsErrorPlacement: function(error, element)
		{
			error.appendTo(element.parent());
		},
		
		/**
		 * Resets all tab error icons and then shows any for tabs
		 * that have fields with errors.
		 *
		 * @since 1.0
		 * @access private
		 * @method _toggleSettingsTabErrors
		 */ 
		_toggleSettingsTabErrors: function()
		{
			var form      = $('.fl-builder-settings:visible'),
				tabs      = form.find('.fl-builder-settings-tab'),
				tab       = null,
				tabErrors = null,
				i         = 0;
			
			for( ; i < tabs.length; i++) {
				
				tab = tabs.eq(i);
				tabErrors = tab.find('label.error');
				tabLink = form.find('.fl-builder-settings-tabs a[href*='+ tab.attr('id') +']');
				tabLink.find('.fl-error-icon').remove();
				tabLink.removeClass('error');
				
				if(tabErrors.length > 0) {
					tabLink.append('<span class="fl-error-icon"></span>');
					tabLink.addClass('error');
				}
			}
		},
		
		/**
		 * Returns an object with key/value pairs for all fields
		 * within a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _getSettings
		 * @param {Object} form The settings form element.
		 * @return {Object} The settings object.
		 */ 
		_getSettings: function(form)
		{
			FLBuilder._updateEditorFields();
			
			var data     	= form.serializeArray(),
				i        	= 0,
				k        	= 0,
				value	 	= '',
				name     	= '',
				key      	= '',
				keys      	= [],
				matches	 	= [],
				settings 	= {};
			
			// Loop through the form data.
			for ( i = 0; i < data.length; i++ ) {
				
				value = data[ i ].value.replace( /\r/gm, '' );
				
				// Don't save text editor textareas.
				if ( data[ i ].name.indexOf( 'flrich' ) > -1 ) {
					continue;
				}
				// Support foo[]... setting keys.
				else if ( data[ i ].name.indexOf( '[' ) > -1 ) {
					
					name 	= data[ i ].name.replace( /\[(.*)\]/, '' );
					key  	= data[ i ].name.replace( name, '' );
					keys	= [];
					matches = key.match( /\[[^\]]*\]/g );
					
					// Remove [] from the keys.
					for ( k = 0; k < matches.length; k++ ) {
						
						if ( '[]' == matches[ k ] ) {
							continue;
						}
						
						keys.push( matches[ k ].replace( /\[|\]/g, '' ) );
					}
					
					// foo[][key][key]
					if ( key.match( /\[\]\[[^\]]*\]\[[^\]]+\]/ ) ) {
						
						if ( 'undefined' == typeof settings[ name ] ) {
							settings[ name ] = {};
						}
						if ( 'undefined' == typeof settings[ name ][ keys[ 0 ] ] ) {
							settings[ name ][ keys[ 0 ] ] = {};
						}
						if ( 'undefined' == typeof settings[ name ][ keys[ 0 ] ][ keys[ 1 ] ] ) {
							settings[ name ][ keys[ 0 ] ][ keys[ 1 ] ] = {};
						}
						
						settings[ name ][ keys[ 0 ] ][ keys[ 1 ] ] = value;
						
					}
					// foo[][key][]
					else if ( key.match( /\[\]\[[^\]]*\]\[\]/ ) ) {
						
						if ( 'undefined' == typeof settings[ name ] ) {
							settings[ name ] = {};
						}
						if ( 'undefined' == typeof settings[ name ][ keys[ 0 ] ] ) {
							settings[ name ][ keys[ 0 ] ] = [];
						}
						
						settings[ name ][ keys[ 0 ] ].push( value );
					}
					// foo[][key]
					else if ( key.match( /\[\]\[[^\]]*\]/ ) ) {
						
						if ( 'undefined' == typeof settings[ name ] ) {
							settings[ name ] = {};
						}
						
						settings[ name ][ keys[ 0 ] ] = value;
						
					}
					// foo[]
					else if ( key.match( /\[\]/ ) ) {
						
						if ( 'undefined' == typeof settings[ name ] ) {
							settings[ name ] = [];
						}
						
						settings[ name ].push( value );
					}
				}
				// Standard name/value pair.
				else {
					settings[ data[ i ].name ] = value;
				}
			}
			
			// Update auto suggest values.
			for ( key in settings ) {
				
				if ( 'undefined' != typeof settings[ 'as_values_' + key ] ) {
					
					settings[ key ] = $.grep( 
						settings[ 'as_values_' + key ].split( ',' ), 
						function( n ) { 
							return n !== ''; 
						}
					).join( ',' );
					
					try {
						delete settings[ 'as_values_' + key ];
					}
					catch( e ) {}
				}
			}
			
			// Return the settings.
			return settings;
		},
		
		/**
		 * Saves the settings for the current settings form, shows
		 * the loader and hides the lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveSettings
		 */ 
		_saveSettings: function()
		{
			var form     = $('.fl-builder-settings-lightbox .fl-builder-settings'),
				nodeId   = form.attr('data-node'),
				settings = FLBuilder._getSettings(form);
		
			// Show the loader.
			FLBuilder.showAjaxLoader();
			
			// Make the AJAX call.
			FLBuilder.ajax({
				action          : 'save_settings',
				node_id         : nodeId,
				settings        : settings
			}, FLBuilder._saveSettingsComplete);
			
			// Close the lightbox.
			FLBuilder._lightbox.close();
		},
		
		/**
		 * Renders a new layout when the settings for the current 
		 * form have finished saving. 
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveSettingsComplete
		 * @param {String} response The layout data from the server.
		 */ 
		_saveSettingsComplete: function(response)
		{
			FLBuilder._renderLayout(response, function() {
				if(FLBuilder.preview) {
					FLBuilder.preview.clear();
					FLBuilder.preview = null;
				}
			});
		},
		
		/* Tooltips
		----------------------------------------------------------*/
		
		/**
		 * Shows a help tooltip in the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showHelpTooltip
		 */ 
		_showHelpTooltip: function()
		{
			$(this).siblings('.fl-help-tooltip-text').fadeIn();
		},
		
		/**
		 * Hides a help tooltip in the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _hideHelpTooltip
		 */ 
		_hideHelpTooltip: function()
		{
			$(this).siblings('.fl-help-tooltip-text').fadeOut();
		},
		
		/* Auto Suggest Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes all auto suggest fields within a settings form.
		 *
		 * @since 1.2.3
		 * @access private
		 * @method _initAutoSuggestFields
		 */ 
		_initAutoSuggestFields: function()
		{
			$('.fl-suggest-field').each(FLBuilder._initAutoSuggestField);
		},
		
		/**
		 * Initializes a single auto suggest field.
		 *
		 * @since 1.2.3
		 * @access private
		 * @method _initAutoSuggestField
		 */ 
		_initAutoSuggestField: function()
		{
			var field = $(this);
			
			field.autoSuggest(FLBuilder._ajaxUrl({ 
				'fl_action'         : 'fl_builder_autosuggest',
				'fl_as_action'      : field.data('action'),
				'fl_as_action_data' : field.data('action-data'),
				'_wpnonce'			: FLBuilderConfig.ajaxNonce
			}), $.extend({}, {
				asHtmlID                    : field.attr('name'),
				selectedItemProp            : 'name',
				searchObjProps              : 'name',
				minChars                    : 3,
				keyDelay                    : 1000,
				fadeOut                     : false,
				usePlaceholder              : true,
				emptyText                   : FLBuilderStrings.noResultsFound,
				showResultListWhenNoMatch   : true,
				preFill                     : field.data('value'),
				queryParam                  : 'fl_as_query',
				afterSelectionAdd           : FLBuilder._updateAutoSuggestField,
				afterSelectionRemove        : FLBuilder._updateAutoSuggestField,
				selectionLimit				: field.data('limit')
			}, field.data( 'args' )));
		},
		
		/**
		 * Updates the value of an auto suggest field.
		 *
		 * @since 1.2.3
		 * @access private
		 * @method _initAutoSuggestField
		 * @param {Object} element The auto suggest field.
		 * @param {Object} item The current selection.
		 * @param {Array} selections An array of selected values.
		 */ 
		_updateAutoSuggestField: function(element, item, selections)
		{
			$(this).siblings('.as-values').val(selections.join(',')).trigger('change');
		},
		
		/* Multiple Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes all multiple fields in a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initMultipleFields
		 */ 
		_initMultipleFields: function()
		{
			var multiples = $('.fl-builder-field-multiples'),
				multiple  = null,
				fields    = null,
				i         = 0,
				cursorAt  = FLBuilderConfig.isRtl ? { left: 10 } : { right: 10 };
				
			for( ; i < multiples.length; i++) {
			
				multiple = multiples.eq(i);
				fields = multiple.find('.fl-builder-field-multiple');
				
				if(fields.length === 1) {
					fields.eq(0).find('.fl-builder-field-actions').addClass('fl-builder-field-actions-single');
				}
				else {
					fields.find('.fl-builder-field-actions').removeClass('fl-builder-field-actions-single');
				}
			}
			
			$('.fl-builder-field-multiples').sortable({
				items: '.fl-builder-field-multiple',
				cursor: 'move',
				cursorAt: cursorAt,
				distance: 5,
				opacity: 0.5,
				helper: FLBuilder._fieldDragHelper,
				placeholder: 'fl-builder-field-dd-zone',
				stop: FLBuilder._fieldDragStop,
				tolerance: 'pointer'
			});
		},
		
		/**
		 * Adds a new multiple field to the list when the add
		 * button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _addFieldClicked
		 */ 
		_addFieldClicked: function()
		{
			var button      = $(this),
				fieldName   = button.attr('data-field'),
				fieldRow    = button.closest('tr').siblings('tr[data-field='+ fieldName +']').last(),
				clone       = fieldRow.clone(),
				index       = parseInt(fieldRow.find('label span.fl-builder-field-index').html(), 10) + 1;
				
			clone.find('th label span.fl-builder-field-index').html(index);
			clone.find('.fl-form-field-preview-text').html('');
			clone.find('input, textarea, select').val('');
			fieldRow.after(clone);
			FLBuilder._initMultipleFields();
		},
		
		/**
		 * Copies a multiple field and adds it to the list when 
		 * the copy button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _copyFieldClicked
		 */ 
		_copyFieldClicked: function()
		{
			var button      = $(this),
				row         = button.closest('tr'),
				clone       = row.clone(),
				index       = parseInt(row.find('label span.fl-builder-field-index').html(), 10) + 1;
				
			clone.find('th label span.fl-builder-field-index').html(index);
			row.after(clone);
			FLBuilder._renumberFields(row.parent());
			FLBuilder._initMultipleFields();
			FLBuilder.preview.delayPreview();
		},
		
		/**
		 * Deletes a multiple field from the list when the
		 * delete button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _deleteFieldClicked
		 */ 
		_deleteFieldClicked: function()
		{
			var row     = $(this).closest('tr'),
				parent  = row.parent(),
				result  = confirm(FLBuilderStrings.deleteFieldMessage);
			
			if(result) {
				row.remove();
				FLBuilder._renumberFields(parent);
				FLBuilder._initMultipleFields();
				FLBuilder.preview.delayPreview();
			}
		},
		
		/**
		 * Renumbers the labels for a list of multiple fields.
		 *
		 * @since 1.0
		 * @access private
		 * @method _renumberFields
		 * @param {Object} table A table element with multiple fields.
		 */ 
		_renumberFields: function(table)
		{
			var rows = table.find('.fl-builder-field-multiple'),
				i    = 0;
				
			for( ; i < rows.length; i++) {
				rows.eq(i).find('th label span.fl-builder-field-index').html(i + 1);
			}
		},
		
		/**
		 * Returns an element for multiple field drag operations.
		 *
		 * @since 1.0
		 * @access private
		 * @method _fieldDragHelper
		 * @return {Object} The helper element.
		 */ 
		_fieldDragHelper: function()
		{
			return $('<div class="fl-builder-field-dd-helper"></div>');
		},
		
		/**
		 * Renumbers and triggers a preview when a multiple field
		 * has finished dragging.
		 *
		 * @since 1.0
		 * @access private
		 * @method _fieldDragStop
		 * @param {Object} e The event object.
		 * @param {Object} ui An object with additional info for the drag.
		 */ 
		_fieldDragStop: function(e, ui)
		{
			FLBuilder._renumberFields(ui.item.parent());
			
			FLBuilder.preview.delayPreview();
		},
		
		/* Select Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes select fields for a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initSelectFields
		 */ 
		_initSelectFields: function()
		{
			$('.fl-builder-settings:visible').find('.fl-builder-settings-fields select').trigger('change');
		},
		
		/**
		 * Callback for when a settings form select has been changed.
		 * If toggle data is present, other fields will be toggled
		 * when this select changes.
		 *
		 * @since 1.0
		 * @access private
		 * @method _settingsSelectChanged
		 */ 
		_settingsSelectChanged: function()
		{
			var select  = $(this),
				toggle  = select.attr('data-toggle'),
				hide    = select.attr('data-hide'),
				trigger = select.attr('data-trigger'),
				val     = select.val(),
				i       = 0,
				k       = 0;
			
			// TOGGLE sections, fields or tabs.
			if(typeof toggle !== 'undefined') {
			
				toggle = JSON.parse(toggle);
				
				for(i in toggle) {
					FLBuilder._settingsSelectToggle(toggle[i].fields, 'hide', '#fl-field-');
					FLBuilder._settingsSelectToggle(toggle[i].sections, 'hide', '#fl-builder-settings-section-');
					FLBuilder._settingsSelectToggle(toggle[i].tabs, 'hide', 'a[href*=fl-builder-settings-tab-', ']');
				}
				
				if(typeof toggle[val] !== 'undefined') {
					FLBuilder._settingsSelectToggle(toggle[val].fields, 'show', '#fl-field-');
					FLBuilder._settingsSelectToggle(toggle[val].sections, 'show', '#fl-builder-settings-section-');
					FLBuilder._settingsSelectToggle(toggle[val].tabs, 'show', 'a[href*=fl-builder-settings-tab-', ']');
				}
			}
			
			// HIDE sections, fields or tabs.
			if(typeof hide !== 'undefined') {
			
				hide = JSON.parse(hide);
				
				if(typeof hide[val] !== 'undefined') {
					FLBuilder._settingsSelectToggle(hide[val].fields, 'hide', '#fl-field-');
					FLBuilder._settingsSelectToggle(hide[val].sections, 'hide', '#fl-builder-settings-section-');
					FLBuilder._settingsSelectToggle(hide[val].tabs, 'hide', 'a[href*=fl-builder-settings-tab-', ']');
				}
			}
			
			// TRIGGER select inputs.
			if(typeof trigger !== 'undefined') {
			
				trigger = JSON.parse(trigger);
				
				if(typeof trigger[val] !== 'undefined') {
					if(typeof trigger[val].fields !== 'undefined') {
						for(i = 0; i < trigger[val].fields.length; i++) {
							$('#fl-field-' + trigger[val].fields[i]).find('select').trigger('change');
						}
					}
				}
			}
		},
		
		/**
		 * @since 1.0
		 * @access private
		 * @method _settingsSelectToggle
		 * @param {Array} inputArray
		 * @param {Function} func
		 * @param {String} prefix
		 * @param {String} suffix
		 */ 
		_settingsSelectToggle: function(inputArray, func, prefix, suffix)
		{
			var i = 0;
			
			suffix = 'undefined' == typeof suffix ? '' : suffix;
			
			if(typeof inputArray !== 'undefined') {
				
				for( ; i < inputArray.length; i++) {
					
					$(prefix + inputArray[i] + suffix)[func]();
					
					// Resize code editor fields.
					$( prefix + inputArray[i] + suffix ).parent().find( '.fl-field[data-type="code"]' ).each( function() {
						$( this ).data( 'editor' ).resize();
					} );
				}
			}
		},
		
		/* Color Pickers
		----------------------------------------------------------*/
		
		/**
		 * Initializes color picker fields for a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initColorPickers
		 */ 
		_initColorPickers: function()
		{

			var colorPresets 	   = FLBuilderConfig.colorPresets ? FLBuilderConfig.colorPresets : [];
			FLBuilder.colorPicker  = new FLBuilderColorPicker({
				mode: 'hsv',
				elements: '.fl-color-picker .fl-color-picker-value',
		    	presets: colorPresets,
				labels: {
					colorPresets 		: FLBuilderStrings.colorPresets,
					colorPicker 		: FLBuilderStrings.colorPicker,
					placeholder			: FLBuilderStrings.placeholder,
					removePresetConfirm	: FLBuilderStrings.removePresetConfirm,
					noneColorSelected	: FLBuilderStrings.noneColorSelected,
					alreadySaved		: FLBuilderStrings.alreadySaved,
					noPresets			: FLBuilderStrings.noPresets,
					presetAdded			: FLBuilderStrings.presetAdded,
				},
				mode: 'hsv'
		    });

			$( FLBuilder.colorPicker ).on( 'presetRemoved presetAdded', function( event, data ) {
	    		FLBuilder.ajax({
					action: 'save_color_presets',
					presets: data.presets
				});

	    	});

		},
				
		/* Single Photo Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes the single photo selector.
		 *
		 * @since 1.8.6
		 * @access private
		 * @method _initSinglePhotoSelector
		 */ 
		_initSinglePhotoSelector: function()
		{
			if(FLBuilder._singlePhotoSelector === null) {
				FLBuilder._singlePhotoSelector = wp.media({
					title: FLBuilderStrings.selectPhoto,
					button: { text: FLBuilderStrings.selectPhoto },
					library : { type : 'image' },
					multiple: false
				});
			}
		},
		
		/**
		 * Shows the single photo selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _selectSinglePhoto
		 */ 
		_selectSinglePhoto: function()
		{
			FLBuilder._initSinglePhotoSelector();
			FLBuilder._singlePhotoSelector.once('open', $.proxy(FLBuilder._singlePhotoOpened, this));
			FLBuilder._singlePhotoSelector.once('select', $.proxy(FLBuilder._singlePhotoSelected, this));
			FLBuilder._singlePhotoSelector.open();
		},
		
		/**
		 * Callback for when the single photo selector is shown.
		 *
		 * @since 1.0
		 * @access private
		 * @method _singlePhotoOpened
		 */ 
		_singlePhotoOpened: function()
		{
			var selection   = FLBuilder._singlePhotoSelector.state().get('selection'),
				wrap        = $(this).closest('.fl-photo-field'),
				photoField  = wrap.find('input[type=hidden]'),
				photo       = photoField.val(),
				attachment  = null;
				
			if($(this).hasClass('fl-photo-replace')) {
				selection.reset();
				wrap.addClass('fl-photo-empty');
				photoField.val('');
			}
			else if(photo !== '') {           
				attachment = wp.media.attachment(photo);
				attachment.fetch();
				selection.add(attachment ? [attachment] : []);
			}
			else {
				selection.reset();
			}
		},
		
		/**
		 * Callback for when a single photo is selected.
		 *
		 * @since 1.0
		 * @access private
		 * @method _singlePhotoSelected
		 */ 
		_singlePhotoSelected: function()
		{
			var photo      = FLBuilder._singlePhotoSelector.state().get('selection').first().toJSON(),
				wrap       = $(this).closest('.fl-photo-field'),
				photoField = wrap.find('input[type=hidden]'),
				preview    = wrap.find('.fl-photo-preview img'),
				srcSelect  = wrap.find('select');
				
			photoField.val(photo.id);
			preview.attr('src', FLBuilder._getPhotoSrc(photo));
			wrap.removeClass('fl-photo-empty');
			wrap.find('label.error').remove();
			srcSelect.show();
			srcSelect.html(FLBuilder._getPhotoSizeOptions(photo));
			srcSelect.trigger('change');
		},
		
		/**
		 * Clears a photo that has been selected in a single photo field.
		 *
		 * @since 1.6.4.3
		 * @access private
		 * @method _singlePhotoRemoved
		 */ 
		_singlePhotoRemoved: function()
		{
			FLBuilder._initSinglePhotoSelector();
			
			var state       = FLBuilder._singlePhotoSelector.state(),
				selection   = 'undefined' != typeof state ? state.get('selection') : null,
				wrap        = $(this).closest('.fl-photo-field'),
				photoField  = wrap.find('input[type=hidden]'),
				srcSelect   = wrap.find('select');
			
			if ( selection ) {
				selection.reset();
			}
			
			wrap.addClass('fl-photo-empty');
			photoField.val('');
			srcSelect.html('<option value="" selected></option>');
			srcSelect.trigger('change');
		},
		
		/**
		 * Returns the src URL for a photo.
		 *
		 * @since 1.0
		 * @access private
		 * @method _getPhotoSrc
		 * @param {Object} photo A photo data object.
		 * @return {String} The src URL for a photo.
		 */ 
		_getPhotoSrc: function(photo)
		{
			if(typeof photo.sizes === 'undefined') {
				return photo.url;
			}
			else if(typeof photo.sizes.thumbnail !== 'undefined') {
				return photo.sizes.thumbnail.url;
			}
			else {
				return photo.sizes.full.url;
			}
		},
		
		/**
		 * Builds the options for a photo size select.
		 *
		 * @since 1.0
		 * @access private
		 * @method _getPhotoSizeOptions
		 * @param {Object} photo A photo data object.
		 * @return {String} The HTML for the photo size options.
		 */ 
		_getPhotoSizeOptions: function(photo)
		{
			var html     = '',
				size     = null,
				selected = null,
				title    = '',
				titles = {
					full      : FLBuilderStrings.fullSize,
					large     : FLBuilderStrings.large,
					medium    : FLBuilderStrings.medium,
					thumbnail : FLBuilderStrings.thumbnail
				};
				
			if(typeof photo.sizes === 'undefined') {
				html += '<option value="' + photo.url + '">' + FLBuilderStrings.fullSize + '</option>';
			}
			else {
				
				for(size in photo.sizes) {
					
					if ( 'undefined' != typeof titles[ size ] ) {
						title = titles[ size ] + ' - ';
					}
					else if ( 'undefined' != typeof FLBuilderConfig.customImageSizeTitles[ size ] ) {
						title = FLBuilderConfig.customImageSizeTitles[ size ] + ' - ';
					}
					else {
						title = '';
					}
					
					selected = size == 'full' ? ' selected="selected"' : '';
					html += '<option value="' + photo.sizes[size].url + '"' + selected + '>' + title + photo.sizes[size].width + ' x ' + photo.sizes[size].height + '</option>';
				}
			}
			
			return html;
		},
		
		/* Multiple Photo Fields
		----------------------------------------------------------*/
		
		/**
		 * Shows the multiple photo selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _selectMultiplePhotos
		 */ 
		_selectMultiplePhotos: function()
		{
			var wrap           = $(this).closest('.fl-multiple-photos-field'),
				photosField    = wrap.find('input[type=hidden]'),
				photosFieldVal = photosField.val(),
				parsedVal      = photosFieldVal === '' ? '' : JSON.parse(photosFieldVal),
				defaultPostId  = wp.media.gallery.defaults.id,
				content        = '[gallery ids="-1"]',
				shortcode      = null,
				attachments    = null, 
				selection      = null,
				i              = null,
				ids            = [];
			
			// Builder the gallery shortcode.
			if ( 'object' == typeof parsedVal ) {
				for ( i in parsedVal ) {
					ids.push( parsedVal[ i ] );
				}
				content = '[gallery ids="'+ ids.join() +'"]';
			}
			
			shortcode = wp.shortcode.next('gallery', content).shortcode;

			if(_.isUndefined(shortcode.get('id')) && !_.isUndefined(defaultPostId)) {
				shortcode.set('id', defaultPostId);
			}
			
			// Get the selection object.
			attachments = wp.media.gallery.attachments(shortcode);

			selection = new wp.media.model.Selection(attachments.models, {
				props: attachments.props.toJSON(),
				multiple: true
			});

			selection.gallery = attachments.gallery;

			// Fetch the query's attachments, and then break ties from the
			// query to allow for sorting.
			selection.more().done(function() {
				
				if ( ! selection.length ) {
					FLBuilder._multiplePhotoSelector.setState( 'gallery-library' );
				}
				
				// Break ties with the query.
				selection.props.set({ query: false });
				selection.unmirror();
				selection.props.unset('orderby');
			});

			// Destroy the previous gallery frame.
			if(FLBuilder._multiplePhotoSelector) {
				FLBuilder._multiplePhotoSelector.dispose();
			}
			
			// Store the current gallery frame.
			FLBuilder._multiplePhotoSelector = wp.media({
				frame:     'post',
				state:     $(this).hasClass('fl-multiple-photos-edit') ? 'gallery-edit' : 'gallery-library',
				title:     wp.media.view.l10n.editGalleryTitle,
				editing:   true,
				multiple:  true,
				selection: selection
			}).open();
			
			$(FLBuilder._multiplePhotoSelector.views.view.el).addClass('fl-multiple-photos-lightbox');
			FLBuilder._multiplePhotoSelector.once('update', $.proxy(FLBuilder._multiplePhotosSelected, this));
		},
		
		/**
		 * Callback for when multiple photos have been selected.
		 *
		 * @since 1.0
		 * @access private
		 * @method _multiplePhotosSelected
		 * @param {Object} data The photo data object.
		 */ 
		_multiplePhotosSelected: function(data)
		{
			var wrap        = $(this).closest('.fl-multiple-photos-field'),
				photosField = wrap.find('input[type=hidden]'),
				count       = wrap.find('.fl-multiple-photos-count'),
				photos      = [],
				i           = 0;
			
			for( ; i < data.models.length; i++) {
				photos.push(data.models[i].id);
			}
				
			if(photos.length == 1) {
				count.html('1 ' + FLBuilderStrings.photoSelected);
			}
			else {
				count.html(photos.length + ' ' + FLBuilderStrings.photosSelected);
			}
		 
			wrap.removeClass('fl-multiple-photos-empty');
			wrap.find('label.error').remove();
			photosField.val(JSON.stringify(photos)).trigger('change');
		},
		
		/* Single Video Fields
		----------------------------------------------------------*/
		
		/**
		 * Shows the single video selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _selectSingleVideo
		 */ 
		_selectSingleVideo: function()
		{
			if(FLBuilder._singleVideoSelector === null) {
			
				FLBuilder._singleVideoSelector = wp.media({
					title: FLBuilderStrings.selectVideo,
					button: { text: FLBuilderStrings.selectVideo },
					library : { type : 'video' },
					multiple: false
				}); 
			}
			
			FLBuilder._singleVideoSelector.once('select', $.proxy(FLBuilder._singleVideoSelected, this));
			FLBuilder._singleVideoSelector.open();
		},
		
		/**
		 * Callback for when a single video is selected.
		 *
		 * @since 1.0
		 * @access private
		 * @method _singleVideoSelected
		 */ 
		_singleVideoSelected: function()
		{
			var video      = FLBuilder._singleVideoSelector.state().get('selection').first().toJSON(),
				wrap       = $(this).closest('.fl-video-field'),
				image      = wrap.find('.fl-video-preview-img img'),
				filename   = wrap.find('.fl-video-preview-filename'),
				videoField = wrap.find('input[type=hidden]');
			
			image.attr('src', video.icon);
			filename.html(video.filename);
			wrap.removeClass('fl-video-empty');
			wrap.find('label.error').remove();
			videoField.val(video.id).trigger('change');
		},
		
		/* Multiple Audios Field
		----------------------------------------------------------*/
		
		/**
		 * Shows the multiple audio selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _selectMultipleAudios
		 */ 
		_selectMultipleAudios: function()
		{	
			var wrap           = $(this).closest('.fl-multiple-audios-field'),
				audiosField    = wrap.find('input[type=hidden]'),
				audiosFieldVal = audiosField.val(),
				content        = audiosFieldVal == '' ? '[playlist ids="-1"]' : '[playlist ids="'+ JSON.parse(audiosFieldVal).join() +'"]',
				shortcode      = wp.shortcode.next('playlist', content).shortcode,
				defaultPostId  = wp.media.playlist.defaults.id,
				attachments    = null, 
				selection      = null;

			if(_.isUndefined(shortcode.get('id')) && !_.isUndefined(defaultPostId)) {
				shortcode.set('id', defaultPostId);
			}
			
			attachments = wp.media.playlist.attachments(shortcode);

			selection = new wp.media.model.Selection(attachments.models, {
				props: attachments.props.toJSON(),
				multiple: true
			});

			selection.playlist = attachments.playlist;

			// Fetch the query's attachments, and then break ties from the
			// query to allow for sorting.
			selection.more().done(function() {
				// Break ties with the query.
				selection.props.set({ query: false });
				selection.unmirror();
				selection.props.unset('orderby');
			});

			// Destroy the previous frame.
			if(FLBuilder._multipleAudiosSelector) {
				FLBuilder._multipleAudiosSelector.dispose();
			}
			
			// Store the current frame.
			FLBuilder._multipleAudiosSelector = wp.media({
				frame:     'post',
				state:     $(this).hasClass('fl-multiple-audios-edit') ? 'playlist-edit' : 'playlist-library',
				title:     wp.media.view.l10n.editPlaylistTitle,
				editing:   true,
				multiple:  true,
				selection: selection
			}).open();

			// Hide the default playlist settings since we have them added in the audio settings
			FLBuilder._multipleAudiosSelector.content.get('view').sidebar.unset('playlist');
			FLBuilder._multipleAudiosSelector.on( 'content:render:browse', function( browser ) {
			    if ( !browser ) return;
			    // Hide Playlist Settings in sidebar
			    browser.sidebar.on('ready', function(){
			        browser.sidebar.unset('playlist');
			    });
			});
 

			FLBuilder._multipleAudiosSelector.once('update', $.proxy(FLBuilder._multipleAudiosSelected, this));
			
		},
		
		/**
		 * Callback for when a single/multiple audo is selected.
		 *
		 * @since 1.0
		 * @access private
		 * @method _multipleAudiosSelected
		 */ 
		_multipleAudiosSelected: function(data)
		{
			var wrap       		= $(this).closest('.fl-multiple-audios-field'),
				count      		= wrap.find('.fl-multiple-audios-count'),				
				audioField 		= wrap.find('input[type=hidden]'),
				audios     		= [],
				i          		= 0;

			for( ; i < data.models.length; i++) {
				audios.push(data.models[i].id);
			}
			
			if(audios.length == 1) {
				count.html('1 ' + FLBuilderStrings.audioSelected);
			}
			else {
				count.html(audios.length + ' ' + FLBuilderStrings.audiosSelected);
			}

			audioField.val(JSON.stringify(audios)).trigger('change');
			wrap.removeClass('fl-multiple-audios-empty');
			wrap.find('label.error').remove();
			
		},

		/* Icon Fields
		----------------------------------------------------------*/
		
		/**
		 * Shows the icon selector.
		 *
		 * @since 1.0
		 * @access private
		 * @method _selectIcon
		 */ 
		_selectIcon: function()
		{
			var self = this;
			
			FLIconSelector.open(function(icon){
				FLBuilder._iconSelected.apply(self, [icon]);
			});
		},
		
		/**
		 * Callback for when an icon is selected.
		 *
		 * @since 1.0
		 * @access private
		 * @method _iconSelected
		 * @param {String} icon The selected icon's CSS classname.
		 */ 
		_iconSelected: function(icon)
		{
			var wrap       = $(this).closest('.fl-icon-field'),
				iconField  = wrap.find('input[type=hidden]'),
				iconTag    = wrap.find('i'),
				oldIcon    = iconTag.attr('data-icon');
				
			iconField.val(icon).trigger('change');
			iconTag.removeClass(oldIcon);
			iconTag.addClass(icon);
			iconTag.attr('data-icon', icon);
			wrap.removeClass('fl-icon-empty');
			wrap.find('label.error').remove();
		},
		
		/**
		 * Callback for when a selected icon is removed.
		 *
		 * @since 1.0
		 * @access private
		 * @method _removeIcon
		 */ 
		_removeIcon: function()
		{
			var wrap       = $(this).closest('.fl-icon-field'),
				iconField  = wrap.find('input[type=hidden]'),
				iconTag    = wrap.find('i');
				
			iconField.val('').trigger('change');
			iconTag.removeClass();
			iconTag.attr('data-icon', '');
			wrap.addClass('fl-icon-empty');
		},
		
		/* Settings Form Fields
		----------------------------------------------------------*/

		/**
		 * Shows the settings for a nested form field when the
		 * edit link is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _formFieldClicked
		 */  
		_formFieldClicked: function()
		{
			var link                = $(this),
				linkLightboxId      = link.closest('.fl-lightbox-wrap').attr('data-instance-id'),
				linkLightbox        = FLLightbox._instances[linkLightboxId],
				linkLightboxLeft    = linkLightbox._node.find('.fl-lightbox').css('left'),
				linkLightboxTop     = linkLightbox._node.find('.fl-lightbox').css('top'),
				form                = link.closest('.fl-builder-settings'),
				type                = link.attr('data-type'),
				settings            = link.siblings('input').val(),
				helper              = FLBuilder._moduleHelpers[type],
				lightbox            = new FLLightbox({
										  className: 'fl-builder-lightbox fl-form-field-settings',
										  destroyOnClose: true
									  });

			link.closest('.fl-builder-lightbox').hide();
			link.attr('id', 'fl-' + lightbox._id);
			lightbox.open('<div class="fl-builder-lightbox-loading"></div>');
			lightbox.draggable({ handle: '.fl-lightbox-header' });
			$('body').undelegate('.fl-builder-settings-cancel', 'click', FLBuilder._settingsCancelClicked);
			
			lightbox._node.find('.fl-lightbox').css({
				'left': linkLightboxLeft,
				'top': Number(parseInt(linkLightboxTop) + 233) + 'px'
			});
			
			FLBuilder.ajax({
				action: 'render_settings_form',
				node_id: form.attr('data-node'),
				node_settings: FLBuilder._getSettings(form),
				type: type,
				settings: settings.replace(/&#39;/g, "'")
			}, 
			function(response) 
			{
				var data = JSON.parse(response);
				
				lightbox.setContent(data.html); 
				lightbox._node.find('form.fl-builder-settings').attr('data-type', type); 
				lightbox._node.find('.fl-builder-settings-cancel').on('click', FLBuilder._closeFormFieldLightbox);
				FLBuilder._initSettingsForms();
				
				if(typeof helper !== 'undefined') {
					FLBuilder._initSettingsValidation(helper.rules);
					helper.init();
				}
				
				lightbox._node.find('.fl-lightbox').css({
					'left': linkLightboxLeft,
					'top': linkLightboxTop
				});
			});
		},
		
		/**
		 * Closes the settings lightbox for a nested form field when the
		 * cancel or save button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _closeFormFieldLightbox
		 */ 
		_closeFormFieldLightbox: function()
		{
			var instanceId          = $(this).closest('.fl-lightbox-wrap').attr('data-instance-id'),
				lightbox            = FLLightbox._instances[instanceId],
				linkLightbox        = $('.fl-builder-settings-lightbox'),
				linkLightboxForm    = linkLightbox.find('form'),
				linkLightboxLeft    = lightbox._node.find('.fl-lightbox').css('left'),
				linkLightboxTop     = lightbox._node.find('.fl-lightbox').css('top'),
				boxHeight           = 0,
				win                 = $(window),
				winHeight           = win.height();
				
			if ( 'undefined' != typeof tinymce && 'undefined' != typeof tinymce.EditorManager.activeEditor ) {
				tinymce.EditorManager.activeEditor.remove();
			}
			
			lightbox._node.find('.fl-lightbox-content').html('<div class="fl-builder-lightbox-loading"></div>');
			boxHeight = lightbox._node.find('.fl-lightbox').height();
			
			if(winHeight - 80 > boxHeight) {
				lightbox._node.find('.fl-lightbox').css('top', ((winHeight - boxHeight)/2 - 40) + 'px');
			}
			else {
				lightbox._node.find('.fl-lightbox').css('top', '0px');
			}
			
			lightbox.on('close', function() 
			{
				linkLightbox.show();
				linkLightbox.find('label.error').remove();
				linkLightboxForm.validate().hideErrors();
				FLBuilder._toggleSettingsTabErrors();
				
				linkLightbox.find('.fl-lightbox').css({
					'left': linkLightboxLeft,
					'top': linkLightboxTop
				});
			});
			
			setTimeout(function()
			{
				lightbox.close();
				$('body').delegate('.fl-builder-settings-cancel', 'click', FLBuilder._settingsCancelClicked);
			}, 500);
		},
		
		/**
		 * Saves the settings for a nested form field when the
		 * save button is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _saveFormFieldClicked
		 * @return {Boolean} Whether the save was successful or not.
		 */  
		_saveFormFieldClicked: function()
		{
			var form          = $(this).closest('.fl-builder-settings'),
				lightboxId    = $(this).closest('.fl-lightbox-wrap').attr('data-instance-id'),
				type          = form.attr('data-type'),
				settings      = FLBuilder._getSettings(form),
				oldSettings   = {},
				helper        = FLBuilder._moduleHelpers[type],
				link          = $('.fl-builder-settings #fl-' + lightboxId),
				preview       = link.parent().attr('data-preview-text'),
				previewText   = settings[preview],
				selectPreview = $( 'select[name="' + preview + '"]' ),
				tmp           = document.createElement('div'),
				valid         = true;
				
			if ( selectPreview.length > 0 ) {
				previewText = selectPreview.find( 'option[value="' + settings[ preview ] + '"]' ).text();
			}  
			if(typeof helper !== 'undefined') {
				
				form.find('label.error').remove();
				form.validate().hideErrors();
				valid = form.validate().form();
				
				if(valid) {
					valid = helper.submit();
				}
			}
			if(valid) {
			
				if(typeof preview !== 'undefined' && typeof previewText !== 'undefined') {
				
					if(previewText.indexOf('fa fa-') > -1) {
						previewText = '<i class="' + previewText + '"></i>';
					}
					else if(previewText.length > 35) {
						tmp.innerHTML = previewText;
						previewText = (tmp.textContent || tmp.innerText || '').replace(/^(.{35}[^\s]*).*/, "$1")  + '...';
					}
				
					link.siblings('.fl-form-field-preview-text').html(previewText);
				}
				
				oldSettings = link.siblings('input').val().replace(/&#39;/g, "'");
				
				if ( '' != oldSettings ) {
					settings = $.extend( JSON.parse( oldSettings ), settings );
				}
				
				link.siblings('input').val(JSON.stringify(settings)).trigger('change');
				
				FLBuilder._closeFormFieldLightbox.apply(this);
				
				return true;
			}
			else {
				FLBuilder._toggleSettingsTabErrors();
				return false;
			}
		},
		
		/* Layout Fields
		----------------------------------------------------------*/

		/**
		 * Callback for when the item of a layout field is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _layoutFieldClicked
		 */ 
		_layoutFieldClicked: function()
		{
			var option = $(this);
			
			option.siblings().removeClass('fl-layout-field-option-selected');
			option.addClass('fl-layout-field-option-selected');
			option.siblings('input').val(option.attr('data-value'));
		},
		
		/* Link Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes all link fields in a settings form.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _initLinkFields
		 */ 
		_initLinkFields: function()
		{
			$('.fl-link-field').each(FLBuilder._initLinkField);
		},
		
		/**
		 * Initializes a single link field in a settings form.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _initLinkFields
		 */ 
		_initLinkField: function()
		{
			var wrap        = $(this),
				searchInput = wrap.find('.fl-link-field-search-input');
				
			searchInput.autoSuggest(FLBuilder._ajaxUrl({ 
				'fl_action'         : 'fl_builder_autosuggest',
				'fl_as_action'      : 'fl_as_links',
				'_wpnonce'			: FLBuilderConfig.ajaxNonce
			}), {
				asHtmlID                    : searchInput.attr('name'),
				selectedItemProp            : 'name',
				searchObjProps              : 'name',
				minChars                    : 3,
				keyDelay                    : 1000,
				fadeOut                     : false,
				usePlaceholder              : true,
				emptyText                   : FLBuilderStrings.noResultsFound,
				showResultListWhenNoMatch   : true,
				queryParam                  : 'fl_as_query',
				selectionLimit              : 1,
				afterSelectionAdd           : FLBuilder._updateLinkField
			});
		},
		
		/**
		 * Updates the value of a link field when a link has been 
		 * selected from the auto suggest menu.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _updateLinkField
		 * @param {Object} element The auto suggest field.
		 * @param {Object} item The current selection.
		 * @param {Array} selections An array of selected values.
		 */ 
		_updateLinkField: function(element, item, selections)
		{
			var wrap        = element.closest('.fl-link-field'),
				search      = wrap.find('.fl-link-field-search'),
				searchInput = wrap.find('.fl-link-field-search-input'),
				field       = wrap.find('.fl-link-field-input');
			
			field.val(item.value).trigger('keyup');
			searchInput.autoSuggest('remove', item.value);
			search.hide();
		},

		/**
		 * Shows the auto suggest input for a link field.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _linkFieldSelectClicked
		 */ 
		_linkFieldSelectClicked: function()
		{
			$(this).parent().find('.fl-link-field-search').show();
		},

		/**
		 * Hides the auto suggest input for a link field.
		 *
		 * @since 1.3.9
		 * @access private
		 * @method _linkFieldSelectCancelClicked
		 */ 
		_linkFieldSelectCancelClicked: function()
		{
			$(this).parent().hide();
		},

		/* Font Fields
		----------------------------------------------------------*/
		
		/**
		 * Initializes all font fields in a settings form.
		 *
		 * @since  1.6.3
		 * @access private
		 * @method _initFontFields
		 */ 
		_initFontFields: function(){
			$('.fl-font-field').each( FLBuilder._initFontField );
		},

		/**
		 * Initializes a single font field in a settings form.
		 *
		 * @since  1.6.3
		 * @access private
		 * @method _initFontFields
		 */ 
		_initFontField: function(){
			var wrap   = $(this),
				font   = wrap.find( '.fl-font-field-font' );
	
			font.on( 'change', function(){
				FLBuilder._getFontWeights( font );
			} );

		},

		/**
		 * Renders the correct weights list for a respective font.
		 *
		 * @since  1.6.3
		 * @acces  private
		 * @method _getFontWeights
		 * @param  {Object} currentFont The font field element.
		 */
		_getFontWeights: function( currentFont ){
			var selectWeight = currentFont.next( '.fl-font-field-weight' ),
				font         = currentFont.val(),
				weightMap    = {
					'default' : 'Default',
					'regular' : 'Regular',
					'100': 'Thin 100',
					'200': 'Extra-Light 200',
					'300': 'Light 300',
					'400': 'Normal 400',
					'500': 'Medium 500',
					'600': 'Semi-Bold 600',
					'700': 'Bold 700',
					'800': 'Extra-Bold 800',
					'900': 'Ultra-Bold 900'
				},
				weights      = {};

				selectWeight.html('');

				if ( 'undefined' != typeof FLBuilderFontFamilies.system[ font ] ) {
					weights = FLBuilderFontFamilies.system[ font ].weights;
				}
				else if ( 'undefined' != typeof FLBuilderFontFamilies.google[ font ] ) {
					weights = FLBuilderFontFamilies.google[ font ];
				} else {
					weights = FLBuilderFontFamilies.default[ font ];
				}

			$.each( weights, function( key, value ){
				selectWeight.append( '<option value="' + value + '">' + weightMap[ value ] + '</option>' );
			} );

		},
		
		/* Editor Fields
		----------------------------------------------------------*/
		
		/**
		 * Used to init pre WP 3.9 editors from field.php.
		 *
		 * @since 1.0
		 * @method initEditorField
		 */  
		initEditorField: function(id)
		{
			var newEditor = tinyMCEPreInit.mceInit.flhiddeneditor;
			
			newEditor.elements = id;
			tinyMCEPreInit.mceInit[ id ] = newEditor;
		},

		/**
		 * Updates all editor fields within a settings form.
		 *
		 * @since 1.0
		 * @access private
		 * @method _updateEditorFields
		 */  
		_updateEditorFields: function()
		{
			var wpEditors = $('.fl-builder-settings textarea.wp-editor-area');
			
			wpEditors.each(FLBuilder._updateEditorField);
		},

		/**
		 * Updates a single editor field within a settings form. 
		 * Creates a hidden textarea with the editor content so 
		 * this field can be saved.
		 *
		 * @since 1.0
		 * @access private
		 * @method _updateEditorField
		 */  
		_updateEditorField: function()
		{
			var textarea  = $( this ),
				field     = textarea.closest( '.fl-editor-field' ),
				form      = textarea.closest( '.fl-builder-settings' ),
				wrap      = textarea.closest( '.wp-editor-wrap' ),
				id        = textarea.attr( 'id' ),
				setting   = field.attr( 'id' ),
				editor    = typeof tinyMCE == 'undefined' ? false : tinyMCE.get( id ),
				hidden    = textarea.siblings( 'textarea[name="' + setting + '"]' ),
				wpautop   = field.data( 'wpautop' );
				
			// Add a hidden textarea if we don't have one.
			if ( 0 === hidden.length ) {
				hidden = $( '<textarea name="' + setting + '"></textarea>' ).hide();
				textarea.after( hidden );
			}
			
			// Save editor content.
			if ( wpautop ) {
				
				if ( editor && wrap.hasClass( 'tmce-active' ) ) {
					hidden.val( editor.getContent() );
				}
				else if ( 'undefined' != typeof switchEditors ) {
					hidden.val( switchEditors.wpautop( textarea.val() ) );
				}
				else {
					hidden.val( textarea.val() );
				}
			}
			else {
				
				if ( editor && wrap.hasClass( 'tmce-active' ) ) {
					editor.save();
				}
				
				hidden.val( textarea.val() );
			}
		},
		
		/* Loop Builder Fields
		----------------------------------------------------------*/

		/**
		 * Callback for when the post type of a loop builder changes.
		 *
		 * @since 1.2.3
		 * @access private
		 * @method _loopBuilderPostTypeChange
		 */ 
		_loopBuilderPostTypeChange: function()
		{
			var val = $(this).val();
			
			$('.fl-loop-builder-filter').hide();
			$('.fl-loop-builder-' + val + '-filter').show();
		},

		/* Text Fields - Add Value Selector
		----------------------------------------------------------*/

		/**
		 * Callback for when "add value" selectors for text fields changes.
		 *
		 * @since  1.6.5
		 * @access private
		 * @method _textFieldAddValueSelectChange
		 */
		_textFieldAddValueSelectChange: function()
		{

			var dropdown     = $( this ),
			    textField    = $( 'input[name="' + dropdown.data( 'target' ) + '"]' ),
			    currentValue = textField.val(),
			    addingValue  = dropdown.val(),
				newValue     = '';

			// Adding selected value to target text field only once

				if ( -1 == currentValue.indexOf( addingValue ) ) {
				
					newValue = ( currentValue.trim() + ' ' + addingValue.trim() ).trim();

					textField
						.val( newValue )
						.trigger( 'change' )
						.trigger( 'keyup' );

				}

			// Resetting the selector

				dropdown
					.val( '' );

		},
		
		/* AJAX
		----------------------------------------------------------*/

		/**
		 * Frontend AJAX for the builder interface.
		 *
		 * @since 1.0
		 * @method ajax
		 * @param {Object} data The data for the AJAX request.
		 * @param {Function} callback A function to call when the request completes.
		 */   
		ajax: function(data, callback)
		{
			var prop;
			
			// Show the loader and save the data for
			// later if a silent update is running.
			if(FLBuilder._silentUpdate) {
				FLBuilder.showAjaxLoader();
				FLBuilder._silentUpdateCallbackData = [data, callback];
				return;
			}
			
			// This request is silent, set the flag to true
			// so we know incase another ajax request is made
			// before this one finishes.
			else if(data.silent === true) {
				FLBuilder._silentUpdate = true;
			}
			
			// Undefined props don't get sent to the server, so make them null.
			for ( prop in data ) {
				if ( 'undefined' == typeof data[ prop ] ) {
					data[ prop ] = null;
				}
			}
			
			// Add the ajax nonce to the data.
			data._wpnonce = FLBuilderConfig.ajaxNonce;
			
			// Send the post id to the server. 
			data.post_id = $('#fl-post-id').val();
			
			// Tell the server that the builder is active.
			data.fl_builder = 1;
			
			// Append the builder namespace to the action.
			data.fl_action = data.action;
			
			// Prevent ModSecurity false positives if our fix is enabled. 
			if ( 'undefined' != typeof data.settings ) {
				data.settings = FLBuilder._ajaxModSecFix( data.settings );
			}
			if ( 'undefined' != typeof data.node_settings ) {
				data.node_settings = FLBuilder._ajaxModSecFix( data.node_settings );
			}
			
			// Store the data in a single variable to avoid conflicts.
			data = { fl_builder_data: data };
			
			// Do the ajax call.
			return $.post(FLBuilder._ajaxUrl(), data, function(response) {

				FLBuilder._ajaxComplete();
			
				if(typeof callback !== 'undefined') {
					callback.call(this, response);
				}
			});
		},

		/**
		 * Callback for when an AJAX request is complete. Runs a
		 * queued AJAX request if a silent update was in progress 
		 * when the last request was made.
		 *
		 * @since 1.0
		 * @access private
		 * @method _ajaxComplete
		 */   
		_ajaxComplete: function()
		{
			var data, callback;
			
			// Set the silent update flag to false
			// so other ajax requests can run.
			FLBuilder._silentUpdate = false;
			
			// Do an ajax request that was stopped 
			// by a silent ajax request.
			if(FLBuilder._silentUpdateCallbackData !== null) {
				FLBuilder.showAjaxLoader();
				data = FLBuilder._silentUpdateCallbackData[0];
				callback = FLBuilder._silentUpdateCallbackData[1];
				FLBuilder._silentUpdateCallbackData = null;
				FLBuilder.ajax(data, callback);
			}
			
			// We're done, hide the loader incase it's showing.
			else {
				FLBuilder.hideAjaxLoader();
			}
		},

		/**
		 * Returns a URL for an AJAX request.
		 *
		 * @since 1.0
		 * @access private
		 * @method _ajaxUrl
		 * @param {Object} params An object with key/value pairs for the AJAX query string.
		 * @return {String} The AJAX URL. 
		 */   
		_ajaxUrl: function(params)
		{
			var url     = window.location.href.split( '#' ).shift(),
				param   = null;
			
			if(typeof params !== 'undefined') {
			
				for(param in params) {
					url += url.indexOf('?') > -1 ? '&' : '?';
					url += param + '=' + params[param];
				}
			}
		
			return url;
		},

		/**
		 * Shows the AJAX loading overlay.
		 *
		 * @since 1.0
		 * @method showAjaxLoader
		 */   
		showAjaxLoader: function()
		{
			if( 0 === $( '.fl-builder-lightbox-loading' ).length ) {
				$( '.fl-builder-loading' ).show();
			}
		},

		/**
		 * Hides the AJAX loading overlay.
		 *
		 * @since 1.0
		 * @method hideAjaxLoader
		 */   
		hideAjaxLoader: function()
		{
			$( '.fl-builder-loading' ).hide();
		},

		/**
		 * Base64 encode settings to prevent ModSecurity false 
		 * positives if our fix is enabled.
		 *
		 * @since 1.8.4
		 * @access private
		 * @method _ajaxModSecFix
		 */   
		_ajaxModSecFix: function( settings )
		{
			var prop;
			
			if ( FLBuilderConfig.modSecFix && 'undefined' != typeof btoa ) {
				
				if ( 'string' == typeof settings ) {
					settings = btoa( settings );
				}
				else {
					
					for ( prop in settings ) {
					
						if ( 'string' == typeof settings[ prop ] ) {
							settings[ prop ] = btoa( settings[ prop ] );
						}
						else if( 'object' == typeof settings[ prop ] ) {
							settings[ prop ] = FLBuilder._ajaxModSecFix( settings[ prop ] );
						}
					}
				}
			}
			
			return settings;
		},
		
		/* Lightboxes
		----------------------------------------------------------*/
		
		/**
		 * Shows the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showLightbox
		 * @param {Boolean} draggable Whether the lightbox should be draggable or not.
		 */  
		_showLightbox: function(draggable)
		{
			draggable = typeof draggable === 'undefined' ? true : draggable;
			
			FLBuilder._lightbox.open('<div class="fl-builder-lightbox-loading"></div>');
			
			if(draggable) {
				FLBuilder._lightbox.draggable({
					handle: '.fl-lightbox-header'
				});
			}
			else {
				FLBuilder._lightbox.draggable(false);
			}
			
			FLBuilder._removeAllOverlays();
			FLBuilder._initLightboxScrollbars();
		},
		
		/**
		 * Set the content for the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _setLightboxContent
		 * @param {String} content The HTML content for the lightbox.
		 */  
		_setLightboxContent: function(content)
		{
			FLBuilder._lightbox.setContent(content);
		},
		
		/**
		 * Initializes the scrollbars for the settings lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _initLightboxScrollbars
		 */  
		_initLightboxScrollbars: function()
		{
			FLBuilder._initScrollbars();
			FLBuilder._lightboxScrollbarTimeout = setTimeout(FLBuilder._initLightboxScrollbars, 500);
		},
		
		/**
		 * Callback to clean things up when the settings lightbox
		 * is closed.
		 *
		 * @since 1.0
		 * @access private
		 * @method _lightboxClosed
		 */  
		_lightboxClosed: function()
		{
			FLBuilder.triggerHook( 'settings-lightbox-closed' );
			FLBuilder._lightbox.empty();
			clearTimeout( FLBuilder._lightboxScrollbarTimeout );
		},
		
		/**
		 * Shows the actions lightbox.
		 *
		 * @since 1.0
		 * @access private
		 * @method _showActionsLightbox
		 * @param {Object} settings An object with settings for the lightbox buttons.
		 */
		_showActionsLightbox: function(settings)
		{
			var template = wp.template( 'fl-actions-lightbox' );
			
			// Allow extensions to modify the settings object.
			FLBuilder.triggerHook( 'actions-lightbox-settings', settings );
			
			// Open the lightbox.
			FLBuilder._actionsLightbox.open( template( settings ) );
		},

		/**
		 * Resize lightbox to wether expand or contract
		 * 
		 * @access private
		 * @method _expandLightbox
		 */
		_resizeLightbox: function(){
			var link 			= $(this),
				resizeType 		= (link.hasClass('fa-expand')) ? 'expand' : 'contract';

			FLBuilder._lightbox.renderResize( resizeType );
			$(this).toggleClass("fa-expand").toggleClass("fa-compress");
		},
		
		/* Alert Lightboxes
		----------------------------------------------------------*/
		
		/**
		 * Shows the alert lightbox with a message.
		 *
		 * @since 1.0
		 * @method alert
		 * @param {String} message The message to show.
		 */
		alert: function(message)
		{
			var alert = new FLLightbox({
					className: 'fl-builder-lightbox fl-builder-alert-lightbox',
					destroyOnClose: true
				}),
				template = wp.template( 'fl-alert-lightbox' );
			
			alert.open( template( { message : message } ) );
		},
		
		/**
		 * Closes the alert lightbox when a child element is clicked.
		 *
		 * @since 1.0
		 * @access private
		 * @method _alertClose
		 */
		_alertClose: function()
		{
			FLLightbox.closeParent(this);
		},
		
		/* Simple JS hooks similar to WordPress PHP hooks.
		----------------------------------------------------------*/
		
		/**
		 * Trigger a hook.
		 *
		 * @since 1.8
		 * @method triggerHook
		 * @param {String} hook The hook to trigger.
		 * @param {Array} args An array of args to pass to the hook.
		 */
		triggerHook: function( hook, args )
		{
			$( 'body' ).trigger( 'fl-builder.' + hook, args );
		},
	
		/**
		 * Add a hook.
		 *
		 * @since 1.8
		 * @method addHook
		 * @param {String} hook The hook to add.
		 * @param {Function} callback A function to call when the hook is triggered.
		 */
		addHook: function( hook, callback )
		{
			$( 'body' ).on( 'fl-builder.' + hook, callback );
		},
	
		/**
		 * Remove a hook.
		 *
		 * @since 1.8
		 * @method removeHook
		 * @param {String} hook The hook to remove.
		 * @param {Function} callback The callback function to remove.
		 */
		removeHook: function( hook, callback )
		{
			$( 'body' ).off( 'fl-builder.' + hook, callback );
		},
		
		/* Console Logging
		----------------------------------------------------------*/
		
		/**
		 * Logs a message in the console if the console is available.
		 *
		 * @since 1.4.6
		 * @method log
		 * @param {String} message The message to log.
		 */
		log: function( message )
		{
			if ( 'undefined' == typeof window.console || 'undefined' == typeof window.console.log ) {
				return;
			}
			
			console.log( message );
		},
		
		/**
		 * Logs an error in the console if the console is available.
		 *
		 * @since 1.4.6
		 * @method logError
		 * @param {String} error The error to log.
		 */
		logError: function( error )
		{
			var message = null;
			
			if ( 'undefined' == typeof error ) {
				return;
			}
			else if ( 'undefined' != typeof error.stack ) {
				message = error.stack;
			}
			else if ( 'undefined' != typeof error.message ) {
				message = error.message;
			}
			
			if ( message ) {
				FLBuilder.log( '************************************************************************' );
				FLBuilder.log( FLBuilderStrings.errorMessage );
				FLBuilder.log( message );
				FLBuilder.log( '************************************************************************' );
			}
		},
		
		/**
		 * Logs a global error in the console if the console is available.
		 *
		 * @since 1.4.6
		 * @method logGlobalError
		 * @param {String} message
		 * @param {String} file
		 * @param {String} line
		 * @param {String} col
		 * @param {String} error
		 */
		logGlobalError: function( message, file, line, col, error )
		{
			FLBuilder.log( '************************************************************************' );
			FLBuilder.log( FLBuilderStrings.errorMessage );
			FLBuilder.log( FLBuilderStrings.globalErrorMessage.replace( '{message}', message ).replace( '{line}', line ).replace( '{file}', file ) );
			
			if ( 'undefined' != typeof error && 'undefined' != typeof error.stack ) {
				FLBuilder.log( error.stack );
				FLBuilder.log( '************************************************************************' );
			}
		}
	};

	/* Start the party!!! */
	$(function(){
		FLBuilder._init();
	});

})(jQuery);