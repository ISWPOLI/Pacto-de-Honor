/**
 * Hashone Custom JS
 *
 * @package HashOne
 *
 * Distributed under the MIT license - http://opensource.org/licenses/MIT
 */

jQuery(function($){

  if($('#hs-bx-slider .hs-slide').length > 0){
  	$('#hs-bx-slider').bxSlider({
  		'pager': false,
  		'auto' : true,
  		'mode' : 'fade',
  		'pause' : 6000,
      'onSliderLoad': function(){
        $('.slide-banner-overlay').remove();
      }
  	});
  }


	$('.hs-testimonial-slider').bxSlider({
		'controls' : false,
		'pager': true,
		'auto' : true,
		'pause' : 5000,
		'mode' : 'fade'
	});

	$(window).scroll(function () {

      if ($(this).scrollTop() > 100) {
          $('.page-template-home-template #hs-masthead, .home.blog #hs-masthead')
          .addClass('animated fadeInDown')
          .fadeIn();
          
      } else {
          $('#hs-masthead')
          .removeClass('animated fadeInDown');
      }

  });

  $(".hs_client_logo_slider").owlCarousel({
    autoPlay: 4000,
    items : 5,
    itemsDesktop : [1199,3],
    itemsDesktopSmall : [979,3],
    pagination : false
  });

  var first_class = $('.hs-portfolio-cat-name:first').data('filter');
  $('.hs-portfolio-cat-name:first').addClass('active');

	var $container = $('.hs-portfolio-posts').imagesLoaded( function() {
		$container.isotope({
		  itemSelector: '.hs-portfolio',
		  layoutMode: 'fitRows',
		  filter: first_class,
		  percentPosition: true,
		});
	});

	$('.hs-portfolio-cat-name-list').on( 'click', '.hs-portfolio-cat-name', function() {
	  var filterValue = $(this).attr('data-filter');
	  $container.isotope({ filter: filterValue });
	  $('.hs-portfolio-cat-name').removeClass('active');
	  $(this).addClass('active');
	});

	$('.hs-portfolio-image').nivoLightbox();
	
	$('body').imagesLoaded( { background: '.hs-section' }, function() {
		$.stellar({
			horizontalScrolling: false,
			verticalOffset: 40,

		});
	});

	$(window).resize(function() {
	    $.stellar('refresh');
	});

	wow = new WOW({
					offset:       100,          // default
					mobile:       false,       // default
					})
	wow.init();

	

  $('.odometer').waypoint(function() {
   setTimeout(function() {
      $('.odometer1').html($('.odometer1').data('count'));
    }, 500);
    setTimeout(function() {
      $('.odometer2').html($('.odometer2').data('count'));
    }, 1000);
    setTimeout(function() {
      $('.odometer3').html($('.odometer3').data('count'));
    }, 1500);
    setTimeout(function() {
      $('.odometer4').html($('.odometer4').data('count'));
    }, 2000);
  }, {
    offset: 800,
    triggerOnce: true
  });

  $('.hs-progress-bar-length').waypoint(function() {
    $(this.element).css({
      width: $(this.element).attr('data-width')+'%',
      visibility : 'visible'
    });
  }, {
    offset: '90%',
    triggerOnce: true
  });

  $(window).scroll(function(){
  	if($(window).scrollTop() > 300){
  		$('#hs-back-top').removeClass('bounceInRight bounceOutRight hs-hide').addClass('bounceInRight');
  	}else{
  		$('#hs-back-top').removeClass('bounceInRight bounceOutRight').addClass('bounceOutRight');
  	}
  });

  $('#hs-back-top').click(function(){
  	$('html,body').animate({scrollTop:0},800);
  });

  $('.hs-toggle-menu').click(function(){
  	$('.hs-main-navigation .hs-menu').slideToggle();
  });

  $('.hs-menu').onePageNav({
    currentClass: 'current',
    changeHash: false,
    scrollSpeed: 750,
    scrollThreshold: 0.1,
    scrollOffset: 82
  });

 // *only* if we have anchor on the url
  if(window.location.hash) {
      $('html, body').animate({
          scrollTop: $(window.location.hash).offset().top - 82
      }, 1000 );        
  }

});