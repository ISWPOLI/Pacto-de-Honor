/*! matchMedia() polyfill addListener/removeListener extension. Author & copyright (c) 2012: Scott Jehl. Dual MIT/BSD license */
!function(a){"use strict";if(a.matchMedia&&a.matchMedia("all").addListener)return!1;var b=a.matchMedia,c=b("only all").matches,d=!1,e=0,f=[],g=function(c){a.clearTimeout(e),e=a.setTimeout(function(){for(var c=0,d=f.length;c<d;c++){var e=f[c].mql,g=f[c].listeners||[],h=b(e.media).matches;if(h!==e.matches){e.matches=h;for(var i=0,j=g.length;i<j;i++)g[i].call(a,e)}}},30)};a.matchMedia=function(e){var h=b(e),i=[],j=0;return h.addListener=function(b){c&&(d||(d=!0,a.addEventListener("resize",g,!0)),0===j&&(j=f.push({mql:h,listeners:i})),i.push(b))},h.removeListener=function(a){for(var b=0,c=i.length;b<c;b++)i[b]===a&&i.splice(b,1)},h}}(this);

/*! matchMedia() polyfill - Test a CSS media type/query in JS. Authors & copyright (c) 2012: Scott Jehl, Paul Irish, Nicholas Zakas. Dual MIT/BSD license */
/*! NOTE: If you're already including a window.matchMedia polyfill via Modernizr or otherwise, you don't need this part */
!function(a){"use strict";a.matchMedia=a.matchMedia||function(a,b){var c,d=a.documentElement,e=d.firstElementChild||d.firstChild,f=a.createElement("body"),g=a.createElement("div");return g.id="mq-test-1",g.style.cssText="position:absolute;top:-100em",f.style.background="none",f.appendChild(g),function(a){return g.innerHTML='&shy;<style media="'+a+'"> #mq-test-1 { width: 42px; }</style>',d.insertBefore(f,e),c=42===g.offsetWidth,d.removeChild(f),{matches:c,media:a}}}(a.document)}(this);

( function( $ ) {

	/**
	 * Helper for simulating media queries without resizing 
	 * the viewport.
	 *
	 * Based on Respond.js by Scott Jehl (https://github.com/scottjehl/Respond)
	 * 
	 * @since 1.9
	 * @class FLBuilderForcedMediaQueries
	 */
	FLBuilderForcedMediaQueries = {
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Array} _requestQueue
		 */
		_requestQueue: [],
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Object} _xmlHttp
		 */
		_xmlHttp: (function() {
			var xmlhttpmethod = false;
			try {
				xmlhttpmethod = new window.XMLHttpRequest();
			}
			catch( e ){
				xmlhttpmethod = new window.ActiveXObject( "Microsoft.XMLHTTP" );
			}
			return function(){
				return xmlhttpmethod;
			};
		})(),
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Object} _regex
		 */
		_regex: {
			media: /@media[^\{]+\{([^\{\}]*\{[^\}\{]*\})+/gi,
			keyframes: /@(?:\-(?:o|moz|webkit)\-)?keyframes[^\{]+\{(?:[^\{\}]*\{[^\}\{]*\})+[^\}]*\}/gi,
			comments: /\/\*[^*]*\*+([^/][^*]*\*+)*\//gi,
			urls: /(url\()['"]?([^\/\)'"][^:\)'"]+)['"]?(\))/g,
			findStyles: /@media *([^\{]+)\{([\S\s]+?)$/,
			only: /(only\s+)?([a-zA-Z]+)\s?/,
			minw: /\(\s*min\-width\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/,
			maxw: /\(\s*max\-width\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/,
			minmaxwh: /\(\s*m(in|ax)\-(height|width)\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/gi,
			other: /\([^\)]*\)/g
		},
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Array} _mediaStyles
		 */
		_mediaStyles: [],
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Array} _rules
		 */
		_rules: [],
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Array} _appendedEls
		 */
		_appendedEls: [],
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Object} _parsedSheets
		 */
		_parsedSheets: {},
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Number} _emInPx
		 */
		_emInPx: null,
		
		/**
		 * The current viewport width to simulate.
		 * 
		 * @since 1.9
		 * @access private
		 * @property {Number} _width
		 */
		_width: null,
		
		/**
		 * @since 1.9
		 * @access private
		 * @property {Function} _callback
		 */
		_callback: null,
		
		/**
		 * Translates all stylesheets and applies the media queries.
		 *
		 * @since 1.9
		 * @method update
		 * @param {Number) width The viewport width to simulate.
		 * @param {Function) callback
		 */
		update: function( width, callback )
		{
			var self    = FLBuilderForcedMediaQueries,
				doc     = window.document,
				docElem = doc.documentElement,
				head    = doc.getElementsByTagName( 'head' )[0] || docElem,
				base    = doc.getElementsByTagName( 'base' )[0],
				links   = head.getElementsByTagName( 'link' );
			
			self._mediaStyles = [];
			self._rules = [];
			
			if ( 'undefined' != typeof width ) {
				self._width = width;
			}
			if ( 'undefined' != typeof callback ) {
				self._callback = callback;
			}
			
			// Always reparse builder sheets for changes
			for ( var sheet in self._parsedSheets ) {
				if ( sheet.indexOf( '-layout-draft.css?' ) > -1 ) {
					self._parsedSheets[ sheet ].parsed = false;
				}
				else if ( sheet.indexOf( '-layout-preview.css?' ) > -1 ) {
					self._parsedSheets[ sheet ].parsed = false;
				}
			}

			for( var i = 0; i < links.length; i++ ){
				
				var sheet = links[ i ],
					href  = sheet.href,
					media = sheet.media,
					isCSS = sheet.rel && sheet.rel.toLowerCase() === 'stylesheet';

				if ( !! href && isCSS ) {
					
					// Don't translate builder UI sheets
					if ( href.indexOf( FLBuilderConfig.pluginUrl ) > -1 ) {
						continue;
					}
					// Translate cached sheets
					else if ( 'undefined' != typeof self._parsedSheets[ href ] && self._parsedSheets[ href ].parsed ) {
						self._translate( self._parsedSheets[ href ].styles, href, self._parsedSheets[ href ].media );
					}
					// Selectivizr exposes css through the rawCssText expando
					else if ( sheet.styleSheet && sheet.styleSheet.rawCssText ) {
						self._translate( sheet.styleSheet.rawCssText, href, media );
						self._parsedSheets[ href ] = true;
					} 
					else if( ( ! /^([a-zA-Z:]*\/\/)/.test( href ) && ! base ) ||
						     href.replace( RegExp.$1, '' ).split( '/' )[0] === window.location.host ) {
							     
						// IE7 doesn't handle urls that start with '//' for ajax request
						// manually add in the protocol
						if ( href.substring( 0,2 ) === '//' ) { 
							href = window.location.protocol + href; 
						}
						
						self._requestQueue.push( {
							href: href,
							media: media
						} );
					}
				}
			}
			
			self._makeRequests();
		},
		
		/**
		 * Applies translated media queries to the page.
		 *
		 * @since 1.9
		 * @method applyMedia
		 * @param {Number) width The viewport width to simulate.
		 */
		applyMedia: function( width )
		{
			var self        = FLBuilderForcedMediaQueries,
				name        = 'clientWidth',
				doc         = window.document,
				docElem     = doc.documentElement,
				docElemProp = docElem[ name ],
				head        = doc.getElementsByTagName( 'head' )[0] || docElem,
				links       = head.getElementsByTagName( 'link' ),
				lastLink    = links[ links.length - 1 ],
				now         = ( new Date() ).getTime(),
				styleBlocks	= {},
				mediaStyles = self._mediaStyles,
				appendedEls = self._appendedEls,
				emInPx      = self._emInPx;
				
			self._width = width;
				
			for ( var i in mediaStyles ) {
				if ( mediaStyles.hasOwnProperty( i ) ) {
					var thisStyle = mediaStyles[ i ],
						min       = thisStyle.minw,
						max       = thisStyle.maxw,
						minNull   = min === null,
						maxNull   = max === null,
						em        = 'em';

					if ( !! min ) {
						min = parseFloat( min ) * ( min.indexOf( em ) > -1 ? ( emInPx || self.getEmPixelValue() ) : 1 );
					}
					if ( !! max ) {
						max = parseFloat( max ) * ( max.indexOf( em ) > -1 ? ( emInPx || self.getEmPixelValue() ) : 1 );
					}

					// If there's no media query at all (the () part), or min or max is not null, and if either is present, they're true
					if ( ! thisStyle.hasQuery || ( ! minNull || ! maxNull ) && ( minNull || width >= min ) && ( maxNull || width <= max ) ) {
						if ( ! styleBlocks[ thisStyle.media ] ) {
							styleBlocks[ thisStyle.media ] = [];
						}
						styleBlocks[ thisStyle.media ].push( self._rules[ thisStyle.rules ] );
					}
				}
			}

			// Remove any existing respond style element(s)
			for ( var j in appendedEls ) {
				if ( appendedEls.hasOwnProperty( j ) ) {
					if( appendedEls[ j ] && appendedEls[ j ].parentNode === head ) {
						head.removeChild( appendedEls[ j ] );
					}
				}
			}
			
			self._appendedEls.length = 0;

			// Inject active styles, grouped by media type
			for ( var k in styleBlocks ) {
				if ( styleBlocks.hasOwnProperty( k ) ) {
					var ss  = doc.createElement( 'style' ),
						css = styleBlocks[ k ].join( "\n" );

					ss.type  = 'text/css';
					ss.media = k;

					// Originally, ss was appended to a documentFragment and sheets were appended in bulk.
					// This caused crashes in IE in a number of circumstances, such as when the HTML element 
					// had a bg image set, so appending beforehand seems best. Thanks to @dvelyk for the initial research on this one!
					head.insertBefore( ss, lastLink.nextSibling );

					if ( ss.styleSheet ) {
						ss.styleSheet.cssText = css;
					}
					else {
						ss.appendChild( doc.createTextNode( css ) );
					}

					// Push to _appendedEls to track for later removal
					self._appendedEls.push( ss );
				}
			}
		},
		
		/**
		 * @since 1.9
		 * @method isUnsupportedMediaQuery
		 */
		isUnsupportedMediaQuery: function( query ) 
		{
			var regex = FLBuilderForcedMediaQueries._regex;
			
			return query.replace( regex.minmaxwh, '' ).match( regex.other );
		},
		
		/**
		 * Returns the value of 1em in pixels.
		 *
		 * @since 1.9
		 * @method getEmPixelValue
		 */
		getEmPixelValue: function() 
		{
			var ret                  = null,
				doc                  = window.document,
				docElem              = doc.documentElement,
				body                 = doc.body,
				div                  = doc.createElement('div'),
				originalHTMLFontSize = docElem.style.fontSize,
				originalBodyFontSize = body && body.style.fontSize,
				fakeUsed             = false;

			div.style.cssText = 'position:absolute;font-size:1em;width:1em';

			if ( ! body ) {
				body = fakeUsed = doc.createElement( 'body' );
				body.style.background = 'none';
			}

			// 1em in a media query is the value of the default font size of the browser
			// reset docElem and body to ensure the correct value is returned
			docElem.style.fontSize = '100%';
			body.style.fontSize = '100%';

			body.appendChild( div );

			if ( fakeUsed ) {
				docElem.insertBefore( body, docElem.firstChild );
			}

			ret = div.offsetWidth;

			if ( fakeUsed ) {
				docElem.removeChild( body );
			}
			else {
				body.removeChild( div );
			}

			// Restore the original values
			docElem.style.fontSize = originalHTMLFontSize;
			
			if ( originalBodyFontSize ) {
				body.style.fontSize = originalBodyFontSize;
			}

			// Also update _emInPx before returning
			ret = FLBuilderForcedMediaQueries._emInPx = parseFloat( ret );

			return ret;
		},
		
		/**
		 * Find media blocks in css text, convert to style blocks.
		 *
		 * @since 1.9
		 * @private
		 * @method _translate
		 * @param {String) styles
		 * @param {String) href
		 * @param {String) media
		 */
		_translate: function( styles, href, media )
		{
			var self  = FLBuilderForcedMediaQueries,
				regex = self._regex,
				qs    = styles.replace( regex.comments, '' ).replace( regex.keyframes, '' ).match( regex.media ),
				ql    = qs && qs.length || 0;

			// Try to get CSS path
			href = href.substring( 0, href.lastIndexOf( '/' ) );

			var repUrls = function( css ) {
					return css.replace( regex.urls, "$1" + href + "$2$3" );
				},
				useMedia = !ql && media;

			// If path exists, tack on trailing slash
			if ( href.length ) { 
				href += '/'; 
			}

			// If no internal queries exist, but media attr does, use that
			// Note: this currently lacks support for situations where a media attr is specified on a link AND
			// Its associated stylesheet has internal CSS media queries.
			// In those cases, the media attribute will currently be ignored.
			if ( useMedia ) {
				ql = 1;
			}

			for ( var i = 0; i < ql; i++ ) {
				
				var fullq, thisq, eachq, eql;

				// Media attr
				if ( useMedia ) {
					fullq = media;
					self._rules.push( repUrls( styles ) );
				}
				//parse for styles
				else{
					fullq = qs[ i ].match( regex.findStyles ) && RegExp.$1;
					self._rules.push( RegExp.$2 && repUrls( RegExp.$2 ) );
				}

				eachq = fullq.split( ',' );
				eql   = eachq.length;

				for ( var j = 0; j < eql; j++ ) {
					
					thisq = eachq[ j ];

					if( self.isUnsupportedMediaQuery( thisq ) ) {
						continue;
					}

					self._mediaStyles.push( {
						media     : thisq.split( '(' )[ 0 ].match( regex.only ) && RegExp.$2 || 'all',
						rules     : self._rules.length - 1,
						hasQuery  : thisq.indexOf( '(' ) > -1,
						minw      : thisq.match( regex.minw ) && parseFloat( RegExp.$1 ) + ( RegExp.$2 || '' ),
						maxw      : thisq.match( regex.maxw ) && parseFloat( RegExp.$1 ) + ( RegExp.$2 || '' )
					} );
				}
			}
		},
		
		/**
		 * Loop through the request queue and get the 
		 * css text for each sheet.
		 *
		 * @since 1.9
		 * @private
		 * @method _makeRequests
		 */
		_makeRequests: function()
		{
			var self = FLBuilderForcedMediaQueries;
			
			if( self._requestQueue.length ) {
				
				var thisRequest = self._requestQueue.shift();

				self._ajax( thisRequest.href, function( styles )
				{
					self._translate( styles, thisRequest.href, thisRequest.media );
					
					self._parsedSheets[ thisRequest.href ] = { 
						parsed: true,
						styles: styles, 
						media: thisRequest.media 
					};

					// By wrapping recursive function call in setTimeout
					// We prevent "Stack overflow" error in IE7
					window.setTimeout( function(){ self._makeRequests(); },0 );
				} );
			}
			else if ( self._width ) {
				
				self.applyMedia( self._width );
				
				if ( self._callback ) {
					self._callback();
					self._callback = null;
				}
			}
		},
		
		/**
		 * @since 1.9
		 * @access private
		 * @method _ajax
		 */
		_ajax: function( url, callback ) {
			var req = FLBuilderForcedMediaQueries._xmlHttp();
			if (!req){
				return;
			}
			req.open( "GET", url, true );
			req.onreadystatechange = function () {
				if ( req.readyState !== 4 || req.status !== 200 && req.status !== 304 ){
					return;
				}
				callback( req.responseText );
			};
			if ( req.readyState === 4 ){
				return;
			}
			req.send( null );
		},
	};
	
} )( jQuery );