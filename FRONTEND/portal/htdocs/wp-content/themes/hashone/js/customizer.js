/**
 * Theme Customizer enhancements for a better user experience.
 *
 * Contains handlers to make Theme Customizer preview reload changes asynchronously.
 */

( function( $ ) {
	// Site title and description.
	wp.customize( 'blogname', function( value ) {
		value.bind( function( to ) {
			$( '.hs-site-title a' ).text( to );
		} );
	} );
	wp.customize( 'blogdescription', function( value ) {
		value.bind( function( to ) {
			$( '.hs-site-description' ).text( to );
		} );
	} );
	// Header text color.
	wp.customize( 'header_textcolor', function( value ) {
		value.bind( function( to ) {
			if ( 'blank' === to ) {
				$( '.hs-site-title, .hs-site-description' ).css( {
					'clip': 'rect(1px, 1px, 1px, 1px)',
					'position': 'absolute'
				} );
			} else {
				$( '.hs-site-title, .hs-site-description' ).css( {
					'clip': 'auto',
					'color': to,
					'position': 'relative'
				} );
			}
		} );
	} );

	wp.customize( 'hashone_header_bg', function( value ) {
		value.bind( function( to ) {
			$( '#hs-masthead' ).removeClass( 'hs-white hs-black' ).addClass( to );
		} );
	} );

	wp.customize( 'hashone_disable_about_sec', function( value ) {
		value.bind( function( to ) {
			if( to == 'on' ){
				$('#hs-about-us-section').css('display','none');
			}else{
				$('#hs-about-us-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_about_progressbar_title1', function( value ) {
		value.bind( function( to ) {
			$( '.hs-progress-count1 h6' ).text( to );
		} );
	} );

	wp.customize( 'hashone_about_progressbar_title2', function( value ) {
		value.bind( function( to ) {
			$( '.hs-progress-count2 h6' ).text( to );
		} );
	} );

	wp.customize( 'hashone_about_progressbar_title3', function( value ) {
		value.bind( function( to ) {
			$( '.hs-progress-count3 h6' ).text( to );
		} );
	} );

	wp.customize( 'hashone_about_progressbar_title4', function( value ) {
		value.bind( function( to ) {
			$( '.hs-progress-count4 h6' ).text( to );
		} );
	} );

	wp.customize( 'hashone_about_progressbar_title5', function( value ) {
		value.bind( function( to ) {
			$( '.hs-progress-count5 h6' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_featured_sec', function( value ) {
		value.bind( function( to ) {
			if( to == 'on' ){
				$('#hs-featured-post-section').css('display','none');
			}else{
				$('#hs-featured-post-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_featured_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-featured-post-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_featured_desc', function( value ) {
		value.bind( function( to ) {
			$( '#hs-featured-post-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_featured_page_icon1', function( value ) {
		value.bind( function( to ) {
			$('.hs-featured-post1 i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_featured_page_icon2', function( value ) {
		value.bind( function( to ) {
			$('.hs-featured-post2 i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_featured_page_icon3', function( value ) {
		value.bind( function( to ) {
			$('.hs-featured-post3 i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_featured_page_icon4', function( value ) {
		value.bind( function( to ) {
			$('.hs-featured-post4 i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_disable_portfolio_sec', function( value ) {
		value.bind( function( to ) {
			if( to == 'on' ){
				$('#hs-portfolio-section').css('display','none');
			}else{
				$('#hs-portfolio-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_portfolio_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-portfolio-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_portfolio_desc', function( value ) {
		value.bind( function( to ) {
			$( '#hs-portfolio-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_service_sec', function( value ) {
		value.bind( function( to) {
			if( to == 'on' ){
				$('#hs-service-post-section').css('display','none');
			}else{
				$('#hs-service-post-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_service_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-service-post-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_service_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-service-post-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_service_page_icon1', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post1 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_service_page_icon2', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post2 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_service_page_icon3', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post3 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_service_page_icon4', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post4 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_service_page_icon5', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post5 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_service_page_icon6', function( value ) {
		value.bind( function( to ) {
			$('.hs-service-post6 .hs-service-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_disable_team_sec', function( value ) {
		value.bind( function( to ) {
			if( to == 'on' ){
				$('#hs-team-section').css('display','none');
			}else{
				$('#hs-team-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_team_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-team-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_team_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-team-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_counter_sec', function( value ) {
		value.bind( function( to) {
			if( to == 'on' ){
				$('#hs-counter-section').css('display','none');
			}else{
				$('#hs-counter-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_counter_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-counter-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-counter-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_title1', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter1 .hs-counter-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_title2', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter2 .hs-counter-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_title3', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter3 .hs-counter-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_title4', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter4 .hs-counter-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_count1', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter1 .hs-counter-count' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_count2', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter2 .hs-counter-count' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_count3', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter3 .hs-counter-count' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_count4', function( value ) {
		value.bind( function( to ) {
			$( '.hs-counter4 .hs-counter-count' ).text( to );
		} );
	} );

	wp.customize( 'hashone_counter_icon1', function( value ) {
		value.bind( function( to ) {
			$('.hs-counter1 .hs-counter-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_counter_icon2', function( value ) {
		value.bind( function( to ) {
			$('.hs-counter2 .hs-counter-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_counter_icon3', function( value ) {
		value.bind( function( to ) {
			$('.hs-counter3 .hs-counter-icon i').removeClass().addClass(to);
		} );
	} );
	
	wp.customize( 'hashone_counter_icon4', function( value ) {
		value.bind( function( to ) {
			$('.hs-counter4 .hs-counter-icon i').removeClass().addClass(to);
		} );
	} );

	wp.customize( 'hashone_disable_logo_sec', function( value ) {
		value.bind( function( to) {
			if( to == 'on' ){
				$('#hs-logo-section').css('display','none');
			}else{
				$('#hs-logo-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_logo_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-logo-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_logo_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-logo-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_testimonial_sec', function( value ) {
		value.bind( function( to )  {
			if( to == 'on' ){
				$('#hs-testimonial-section').css('display','none');
			}else{
				$('#hs-testimonial-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_testimonial_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-testimonial-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_testimonial_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-testimonial-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_blog_sec', function( value ) {
		value.bind( function( to ) {
			if( to == 'on' ){
				$('#hs-blog-section').css('display','none');
			}else{
				$('#hs-blog-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_blog_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-blog-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_blog_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-blog-section .hs-section-tagline' ).text( to );
		} );
	} );

	wp.customize( 'hashone_disable_contact_sec', function( value ) {
		value.bind( function( to) {
			if( to == 'on' ){
				$('#hs-contact-section').css('display','none');
			}else{
				$('#hs-contact-section').css('display','block');
			}
		} );
	} );

	wp.customize( 'hashone_contact_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-contact-section .hs-section-title' ).text( to );
		} );
	} );

	wp.customize( 'hashone_contact_sub_title', function( value ) {
		value.bind( function( to ) {
			$( '#hs-contact-section .hs-section-tagline' ).text( to );
		} );
	} );

} )( jQuery );
