<?php
/**
 * The template for displaying product content within loops
 *
 * This template can be overridden by copying it to yourtheme/woocommerce/content-product.php.
 *
 * HOWEVER, on occasion WooCommerce will need to update template files and you
 * (the theme developer) will need to copy the new files to your theme to
 * maintain compatibility. We try to do this as little as possible, but it does
 * happen. When this occurs the version of the template file will be bumped and
 * the readme will list any important changes.
 *
 * @see     https://docs.woothemes.com/document/template-structure/
 * @author  WooThemes
 * @package WooCommerce/Templates
 * @version 2.6.1
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

global $product;

// Ensure visibility
if ( empty( $product ) || ! $product->is_visible() ) {
	return;
}
?>
<li <?php post_class(); ?>>
	<?php
	/**
	 * woocommerce_before_shop_loop_item hook.
	 *
	 * @hooked woocommerce_template_loop_product_link_open - 10
	 */
	do_action( 'woocommerce_before_shop_loop_item' );

	/**
	 * woocommerce_before_shop_loop_item_title hook.
	 *
	 * @hooked woocommerce_show_product_loop_sale_flash - 10
	 * @hooked woocommerce_template_loop_product_thumbnail - 10
	 */
	do_action( 'woocommerce_before_shop_loop_item_title' );

	/**
	 * woocommerce_shop_loop_item_title hook.
	 *
	 * @hooked woocommerce_template_loop_product_title - 10
	 */
	//do_action( 'woocommerce_shop_loop_item_title' );
	?>
	<div class="shop_descrip">
	<?php $wootitle_size = get_theme_mod('tesseract_woocommerce_title_size'); 
							switch ( $wootitle_size ) {
								case 'small':
									$wootitle_classsize = 'wootitle-small';

									break;
								case 'large':
									$wootitle_classsize = 'wootitle-large';

									break;
								default:
									$wootitle_classsize = 'wootitle-medium';
							}
	?>
	<?php $wootitle_underline = get_theme_mod('tesseract_woocommerce_title_underline'); 
							switch ( $wootitle_underline ) {
								case 'underline':
									$wootitle_classunderline = 'wootitle-underline';

									break;
								default:
									$wootitle_classunderline = 'wootitle-notunderline';
							}
	?>
	
	
	<div id="prodlist_title" class="<?php echo $wootitle_classsize; ?> <?php echo $wootitle_classunderline; ?>">
	<a href ="<?php echo get_permalink(); ?>"><h3><?php echo get_the_title(); ?></h3></a>
	</div>
	<?php
	/**
	 * woocommerce_after_shop_loop_item_title hook.
	 *
	 * @hooked woocommerce_template_loop_rating - 5
	 * @hooked woocommerce_template_loop_price - 10
	 */
	 ?>
	 <?php $wooprice = get_theme_mod('tesseract_woocommerce_price_size'); ?>
	 <?php $woopriceweight = get_theme_mod('tesseract_woocommerce_price_weight');
	    switch ( $woopriceweight ) {
			case 'bold':
				$wooprice_classbold = 'wooprice-bold';

			break;
			default:
				$wooprice_classbold = 'wooprice-nonbold';
		}
	 ?>
	<?php	$prodregprice = $product->regular_price;	$prodsalesprice = $product->sale_price;	?>
	 <div style="font-size: <?php echo $wooprice; ?>px;" class="wooshop-price <?php echo $wooprice_classbold; ?>">
		<?php if( ($prodregprice != '') && ($prodsalesprice != '') ) { ?>		<span class="regular-price">$<?php echo $prodregprice; ?>.00</span>		<?php } elseif( ($prodregprice != '') && ($prodsalesprice == '') ) { ?>		<span class="regular-pricenew">$<?php echo $prodregprice; ?>.00</span>		<?php } ?>		<?php if($prodsalesprice != '') { ?>		<span class="sales-price">$<?php echo $prodsalesprice; ?>.00</span>			<?php } ?>
	 <?php //do_action( 'woocommerce_after_shop_loop_item_title' ); ?>
	 </div>
    <?php
	/**
	 * woocommerce_after_shop_loop_item hook.
	 *
	 * @hooked woocommerce_template_loop_product_link_close - 5
	 * @hooked woocommerce_template_loop_add_to_cart - 10
	 */
	?>
	<?php $wooshopratings = get_theme_mod('tesseract_woocommerce_shop_ratings'); ?>
	<?php if( $wooshopratings == 'showratings' ) { ?>
	<div class="product-rating">
	<?php //add_action( 'woocommerce_after_shop_loop_item_title', 'woocommerce_template_loop_rating', 5 ); ?>
	<?php
	if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
    }
	global $product;
	if ( get_option( 'woocommerce_enable_review_rating' ) === 'no' ) {
		return;
	}
	$rating_count = $product->get_rating_count();
	$review_count = $product->get_review_count();
	$average      = $product->get_average_rating(); ?>
	<?php //if ( $rating_count > 0 ) : ?>

		<div class="woocommerce-product-rating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
			<div class="star-rating" title="<?php printf( __( 'Rated %s out of 5', 'woocommerce' ), $average ); ?>">
				<span style="width:<?php echo ( ( $average / 5 ) * 100 ); ?>%">
					<strong itemprop="ratingValue" class="rating"><?php echo esc_html( $average ); ?></strong> <?php printf( __( 'out of %s5%s', 'woocommerce' ), '<span itemprop="bestRating">', '</span>' ); ?>
					<?php printf( _n( 'based on %s customer rating', 'based on %s customer ratings', $rating_count, 'woocommerce' ), '<span itemprop="ratingCount" class="rating">' . $rating_count . '</span>' ); ?>
				</span>
			</div>
		</div>

	<?php //endif; ?>
	</div>
	<?php } else {
	}
	?>
	
	<div class="wooprod-button">
	<?php $wooaddbutton = get_theme_mod('tesseract_woocommerce_product_morebutton'); ?>
			<?php if($wooaddbutton == 'showcartbutton' ) { ?>
				<?php //do_action( 'woocommerce_after_shop_loop_item' ); ?>
				<?php $woobutton_bgcolor = get_theme_mod('tesseract_woocommerce_buttonbgcolor'); ?>
				<?php $woobutton_brderradius = get_theme_mod('tesseract_woocommerce_button_radius'); ?>
				<?php $woobutton_size = get_theme_mod('tesseract_woocommerce_button_size'); ?>
				<?php $woobutclass = ''; ?>
				<?php if($woobutton_size == 'small' ) { 
					$woobutclass = 'woobutton-small';
				} elseif ($woobutton_size == 'large' ) { 
					$woobutclass = 'woobutton-large'; 
				} else {
					$woobutclass = 'woobutton-medium';
				} ?>
				<?php
				global $product;
				echo apply_filters( 'woocommerce_loop_add_to_cart_link',
					sprintf( '<a style="background-color: '.$woobutton_bgcolor.'; border-radius: '.$woobutton_brderradius.'px;" href="%s" rel="nofollow" data-product_id="%s" data-product_sku="%s" class="button '.$woobutclass.' %s product_type_%s">%s</a>',
						esc_url( $product->add_to_cart_url() ),
						esc_attr( $product->id ),
						esc_attr( $product->get_sku() ),
						$product->is_purchasable() ? 'add_to_cart_button' : '',
						esc_attr( $product->product_type ),
						esc_html( $product->add_to_cart_text() )
					),
				$product );
				?>
			<?php } elseif ($wooaddbutton == 'showmorebutton' ) { ?>
				<a class="shop_moredetails" href ="<?php echo get_permalink(); ?>">Show More Details</a>
		    <?php } elseif ($wooaddbutton == 'hidecartbutton' ) {	
			} ?>
	</div>		
			
	</div>
	<div class="oneColClear"></div>	
</li>
