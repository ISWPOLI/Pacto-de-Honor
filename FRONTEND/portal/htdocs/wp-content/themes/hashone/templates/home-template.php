<?php
/**
 * Template Name: Home Page
 *
 * @package HashOne
 */

get_header(); 

$hashone_home_sections = hashone_home_section();

foreach ($hashone_home_sections as $hashone_home_section) {
	get_template_part( 'template-parts/section', $hashone_home_section );
}

get_footer();