jQuery.noConflict()( function ( $ ) {
    "use strict";
    $( document ).ready( function () {

        // menu dropdown link clickable
        $( '.navbar .dropdown > a, .dropdown-menu > li > a' ).click( function () {
            location.href = this.href;
        } );

        // scroll to top button
        $( "#back-top" ).hide();
        $( function () {
            $( window ).scroll( function () {
                if ( $( this ).scrollTop() > 100 ) {
                    $( '#back-top' ).fadeIn();
                } else {
                    $( '#back-top' ).fadeOut();
                }
            } );

            // scroll body to 0px on click
            $( '#back-top a' ).click( function () {
                $( 'body,html' ).animate( {
                    scrollTop: 0
                }, 800 );
                return false;
            } );
        } );

        //smoothscroll
        var sections = $( 'section' )
            , nav = $( '#main-navigation-inner .nav' )
            , nav_height = nav.outerHeight();

        $( window ).on( 'scroll', function () {
            var cur_pos = $( this ).scrollTop();

            sections.each( function () {
                var top = $( this ).offset().top - nav_height,
                    bottom = top + $( this ).outerHeight();

                if ( cur_pos >= top && cur_pos <= bottom ) {
                    nav.find( 'a' ).removeClass( 'active' );
                    sections.removeClass( 'active' );

                    $( this ).addClass( 'active' );
                    nav.find( 'a[href="#' + $( this ).attr( 'id' ) + '"]' ).addClass( 'active' );
                }
            } );
        } );
        nav.find( 'a' ).on( 'click', function () {
            var $el = $( this )
                , id = $el.attr( 'href' );

            $( 'html, body' ).animate( {
                scrollTop: $( id ).offset().top - nav_height + 50
            }, 500 );

            return false;
        } );

        // FlexSlider
        $( window ).load( function () {
            $( '.homepage-slider' ).flexslider( {
                animation: "slide",
                slideshow: true,
                touch: true,
                keyboard: true,
                pauseOnHover: true,
                prevText: '',
                nextText: '',
            } );
        } );

        // FlexSlider Carousel
        var $window = $( window ),
            flexslider;

        // tiny helper function to add breakpoints
        function getGridSize() {
            return ( window.innerWidth < 520 ) ? 1 :
                ( window.innerWidth < 768 ) ? 2 :
                ( window.innerWidth < 992 ) ? 3 : 4;
        }
        $( window ).load( function () {
            $( '#carousel-home' ).flexslider( {
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                slideshow: true,
                itemWidth: 330,
                itemMargin: 30,
                prevText: '',
                nextText: '',
                minItems: getGridSize(),
                maxItems: getGridSize(),
                start: function ( slider ) {
                    flexslider = slider;
                    slider.removeClass( 'carousel-loading' );
                }
            } );
            $window.resize( function () {
                var gridSize = getGridSize();
                if ( flexslider ) {
                    flexslider.vars.minItems = gridSize;
                    flexslider.vars.maxItems = gridSize;
                }
            } );
        } );
        // set the timeout for the slider resize
        $( function () {
            var resizeEnd;
            $( window ).on( 'resize', function () {
                clearTimeout( resizeEnd );
                resizeEnd = setTimeout( function () {
                    flexsliderResize();
                }, 100 );
            } );
        } );
        function flexsliderResize() {
            if ( $( '#carousel-home' ).length > 0 ) {
                $( '#carousel-home' ).data( 'flexslider' ).resize();
            }
        }


        //  Border effects
        $( window ).on( 'resize', function (  ) {
            $( ".border-top" ).css( { "border-left-width": window.innerWidth } );
            $( ".border-bottom" ).css( { "border-right-width": window.innerWidth } );
        } ).trigger( 'resize' );


        //  Parallax effects
        if($('.img-holder').length > 0) {
          $('.img-holder').imageScroll({ coverRatio: 0.7 });
        };     

        // Portfolio isotope
        var $container = $( '#portfolio' );
        if ( $container.length ) {
            // init Isotope
            var $grid = $('#portfolio').imagesLoaded( function() {
              $grid.isotope();
            });
            // filter items when filter link is clicked
            $( '#filter a' ).click( function () {

                var selector = $( this ).attr( 'data-filter' );
                $container.isotope( { filter: selector } );
                return false;

            } );
        }

    } );
} );

// Smooth scroll effect
jQuery( document ).ready( function ( $ ) {
    if ( $( 'body' ).hasClass( 'smooth-scroll-on' ) ) {
        if ( window.addEventListener )
            window.addEventListener( 'DOMMouseScroll', wheel, false );
        window.onmousewheel = document.onmousewheel = wheel;

        function wheel( event ) {
            var delta = 0;
            if ( event.wheelDelta )
                delta = event.wheelDelta / 80;
            else if ( event.detail )
                delta = -event.detail / 3;

            handle( delta );
            if ( event.preventDefault )
                event.preventDefault();
            event.returnValue = false;
        }

        var goUp = true;
        var end = null;
        var interval = null;

        function handle( delta ) {
            var animationInterval = 7; //lower is faster
            var scrollSpeed = 7; //lower is faster

            if ( end == null ) {
                end = $( window ).scrollTop();
            }
            end -= 20 * delta;
            goUp = delta > 0;

            if ( interval == null ) {
                interval = setInterval( function () {
                    var scrollTop = $( window ).scrollTop();
                    var step = Math.round( ( end - scrollTop ) / scrollSpeed );
                    if ( scrollTop <= 0 ||
                        scrollTop >= $( window ).prop( "scrollHeight" ) - $( window ).height() ||
                        goUp && step > -1 ||
                        !goUp && step < 1 ) {
                        clearInterval( interval );
                        interval = null;
                        end = null;
                    }
                    $( window ).scrollTop( scrollTop + step );
                }, animationInterval );
            }
        }
    }
} );