<?php
/**
 * Custom hooks and function for woocommerce compatibility
 *
 * @package HashOne
 */

remove_action( 'woocommerce_before_main_content', 'woocommerce_output_content_wrapper', 10);
remove_action( 'woocommerce_before_main_content', 'woocommerce_breadcrumb', 20);
remove_action( 'woocommerce_after_main_content', 'woocommerce_output_content_wrapper_end', 10);
remove_action( 'woocommerce_archive_description', 'woocommerce_taxonomy_archive_description', 10);
remove_action( 'woocommerce_archive_description', 'woocommerce_product_archive_description', 10);
remove_action( 'woocommerce_sidebar', 'woocommerce_get_sidebar', 10);

add_action('woocommerce_before_main_content', 'hashone_theme_wrapper_start', 10);
add_action('woocommerce_after_main_content', 'hashone_theme_wrapper_end', 10);
add_action('sq_woocommerce_breadcrumb', 'woocommerce_breadcrumb', 10);
add_action('sq_woocommerce_archive_description', 'woocommerce_taxonomy_archive_description', 10);
add_action('sq_woocommerce_archive_description', 'woocommerce_product_archive_description', 10);


function hashone_theme_wrapper_start() {
	echo '<header class="hs-main-header">';
	echo '<div class="hs-container">';
	echo '<h1 class="hs-main-title">';
	woocommerce_page_title();
	echo '</h1>';
	do_action('sq_woocommerce_breadcrumb');
	do_action('sq_woocommerce_archive_description');
	echo '</div>';
	echo '</header>';

	echo '<div class="hs-container">';
	echo '<div id="primary">';
}

function hashone_theme_wrapper_end() {
  echo '</div>';
  get_sidebar( 'shop' );
  echo '</div>';
}

add_filter( 'woocommerce_show_page_title', '__return_false' );