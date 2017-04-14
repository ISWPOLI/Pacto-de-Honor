<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the #content div and all content after
 *
 * @package Tesseract
 */
?>
    <?php 
	$bodyClass = ( version_compare($wp_version, '4.0.0', '>') && is_customize_preview() ) ? 'backend' : 'frontend';
	
	$opValue1 = get_theme_mod('tesseract_footer_colors_bck_color_opacity');
    $footer_bckOpacity = is_numeric($opValue1) ? TRUE : FALSE;
    if ( is_front_page() && ( $footer_bckOpacity && ( intval($opValue1) < 100 ) ) ) $bodyClass .= ' transparent-footer';


	$footpos = ( is_front_page() && ( $footer_bckOpacity && ( intval($opValue1) < 100 ) ) ) ? 'pos-absolute' : 'pos-relative'; 
	?>
	</div><!-- #content -->

	<footer id="colophon_TesseractTheme" class="site-footer <?php echo $footpos; ?>" role="contentinfo">

		<?php $additional = get_theme_mod('tesseract_footer_additional_content') ? true : false;

        $menuClass = 'only-menu';
        if ( $additional ) $menuClass = 'is-additional';

        $addcontent_hml = get_theme_mod('tesseract_footer_additional_content');
		$footerNav_class = ( is_string($addcontent_hml) && ( $addcontent_hml !== 'nothing' ) ) ? 'is-before' : 'none-before';

		$content = get_theme_mod('tesseract_footer_right');
		$content_default_button = get_theme_mod('tesseract_footer_right_content_if_button');

		$footerWidthClass = ( get_theme_mod('tesseract_footer_width') == 'fullwidth' ) ? ' footer-fullwidth' : ' footer-autowidth';

		if ( defined('TESSERACT_BRANDING_EXIST') ) {
			if ( $content ) :
				$rightContentClass = ' mother-content-' . $content;
			elseif ( !$content && $content_default_button ) :
				$rightContentClass = ' mother-content-notset mother-defbtn-isset';
			else:
				$rightContentClass = ' mother-content-notset mother-defbtn-isset';
			endif;
		} else {
			$rightContentClass = ' mother-branding';
		} ?>

    	<?php if ( class_exists( 'Tesseract_Remove_Branding' ) ){ ?>
		<div id="footer-banner" class="cf<?php echo ' menu-' . $menuClass; echo $rightContentClass . $footerWidthClass; ?> with_unbrandinglogo">
		<?php } else { ?>
    	<div id="footer-banner" class="cf<?php echo ' menu-' . $menuClass; echo $rightContentClass . $footerWidthClass; ?>">
		<?php } ?>
            <div id="horizontal-menu-wrap" class="<?php echo $menuClass . ' ' . $footerNav_class; ?>">

                <?php // SHOULD some additional content be added before the menu?
                if ( is_string($addcontent_hml) && ( $addcontent_hml !== 'nothing' ) ) : ?>

                    <div id="horizontal-menu-before" class="switch thm-left-left"><?php tesseract_horizontal_footer_menu_additional_content( $addcontent_hml ); ?></div>

                <?php endif; //EOF left menu - IS before content ?>

                <?php $menuSelected = get_theme_mod('tesseract_footer_menu_select');
 
				if ( $menuSelected !== 'none' ) : ?>

					<section id="footer-horizontal-menu" class="cf <?php echo $footerNav_class; ?>"><?php tesseract_output_menu( FALSE, FALSE, 'secondary', 1 ); ?></section>
              	<?php endif; ?>

            </div><!-- EOF horizontal-menu-wrap -->

            <?php tesseract_footer_branding(); ?>
			
			<?php $my_unbrandinglogo = get_theme_mod('tesseract_footer_content_if_unbranding'); ?>
            
			<?php if (class_exists( 'Tesseract_Remove_Branding' ) ){ 				
			if(!empty($my_unbrandinglogo)){ 	?>
			<div class="footer-extreme-right">
			<?php echo $my_unbrandinglogo; ?>
			</div>
			<?php }else{ ?>					
                  <style>.with_unbrandinglogo #footer-banner-right{width:40% !important;}
				  #footer-banner-right.banner-right #footer-button-container{ width:100% !important; text-align:right;}</style>  
			<?php }			
			} ?>
            
      	</div><!-- EOF footer-banner -->

	</footer><!-- #colophon -->
</div><!-- #page -->

<?php wp_footer(); ?>

</body>
</html>
