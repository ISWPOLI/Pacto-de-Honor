jQuery(document).ready(function($) {
    "use strict";

    //FontAwesome Icon Control JS
    $('body').on('click', '.hashone-icon-list li', function(){
        var icon_class = $(this).find('i').attr('class');
        $(this).addClass('icon-active').siblings().removeClass('icon-active');
        $(this).parent('.hashone-icon-list').prev('.hashone-selected-icon').children('i').attr('class','').addClass(icon_class);
        $(this).parent('.hashone-icon-list').next('input').val(icon_class).trigger('change');
    });

    $('body').on('click', '.hashone-selected-icon', function(){
        $(this).next().slideToggle();
    });

    //Switch Control
    $('body').on('click', '.onoffswitch', function(){
        var $this = $(this);
        if($this.hasClass('switch-on')){
            $(this).removeClass('switch-on');
            $this.next('input').val('off').trigger('change')
        }else{
            $(this).addClass('switch-on');
            $this.next('input').val('on').trigger('change')
        }
    });

    // Gallery Control
    $('.upload_gallery_button').click(function(event){
        var current_gallery = $( this ).closest( 'label' );

        if ( event.currentTarget.id === 'clear-gallery' ) {
            //remove value from input
            current_gallery.find( '.gallery_values' ).val( '' ).trigger( 'change' );

            //remove preview images
            current_gallery.find( '.gallery-screenshot' ).html( '' );
            return;
        }

        // Make sure the media gallery API exists
        if ( typeof wp === 'undefined' || !wp.media || !wp.media.gallery ) {
            return;
        }
        event.preventDefault();

        // Activate the media editor
        var val = current_gallery.find( '.gallery_values' ).val();
        var final;

        if ( !val ) {
            final = '[gallery ids="0"]';
        } else {
            final = '[gallery ids="' + val + '"]';
        }
        var frame = wp.media.gallery.edit( final );

        frame.state( 'gallery-edit' ).on(
            'update', function( selection ) {

                //clear screenshot div so we can append new selected images
                current_gallery.find( '.gallery-screenshot' ).html( '' );

                var element, preview_html = '', preview_img;
                var ids = selection.models.map(
                    function( e ) {
                        element = e.toJSON();
                        preview_img = typeof element.sizes.thumbnail !== 'undefined' ? element.sizes.thumbnail.url : element.url;
                        preview_html = "<div class='screen-thumb'><img src='" + preview_img + "'/></div>";
                        current_gallery.find( '.gallery-screenshot' ).append( preview_html );
                        return e.id;
                    }
                );

                current_gallery.find( '.gallery_values' ).val( ids.join( ',' ) ).trigger( 'change' );
            }
        );
        return false;
    });

    //MultiCheck box Control JS
    $( '.customize-control-checkbox-multiple input[type="checkbox"]' ).on( 'change', function() {

            var checkbox_values = $( this ).parents( '.customize-control' ).find( 'input[type="checkbox"]:checked' ).map(
                function() {
                    return $( this ).val();
                }
            ).get().join( ',' );

            $( this ).parents( '.customize-control' ).find( 'input[type="hidden"]' ).val( checkbox_values ).trigger( 'change' );
        
        }
    );

    //Chosen JS
    $(".hs-chosen-select").chosen({
        width: "98%"
    });

    //Scroll to section
    $('body').on('click', '#sub-accordion-panel-hashone_home_panel .control-subsection .accordion-section-title', function(event) {
        var section_id = $(this).parent('.control-subsection').attr('id');
        scrollToSection( section_id );
    });
});

function scrollToSection( section_id ){
    var preview_section_id = "hs-home-slider-section";

    var $contents = jQuery('#customize-preview iframe').contents();

    switch ( section_id ) {
        case 'accordion-section-hashone_slider_sec':
        preview_section_id = "hs-home-slider-section";
        break;

        case 'accordion-section-hashone_about_sec':
        preview_section_id = "hs-about-us-section";
        break;

        case 'accordion-section-hashone_featured_sec':
        preview_section_id = "hs-featured-post-section";
        break;

        case 'accordion-section-hashone_portfolio_sec':
        preview_section_id = "hs-portfolio-section";
        break;

        case 'accordion-section-hashone_service_sec':
        preview_section_id = "hs-service-post-section";
        break;

        case 'accordion-section-hashone_team_sec':
        preview_section_id = "hs-team-section";
        break;

        case 'accordion-section-hashone_testimonial_sec':
        preview_section_id = "hs-testimonial-section";
        break;

        case 'accordion-section-hashone_counter_sec':
        preview_section_id = "hs-counter-section";
        break;

        case 'accordion-section-hashone_blog_sec':
        preview_section_id = "hs-blog-section";
        break;

        case 'accordion-section-hashone_logo_sec':
        preview_section_id = "hs-logo-section";
        break;

        case 'accordion-section-hashone_contact_sec':
        preview_section_id = "hs-contact-section";
        break;
    }

    if( $contents.find('#'+preview_section_id).length > 0 ){
        $contents.find("html, body").animate({
        scrollTop: $contents.find( "#" + preview_section_id ).offset().top - 82
        }, 1000);
    }
}