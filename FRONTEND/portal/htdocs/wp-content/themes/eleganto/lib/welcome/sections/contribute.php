<?php
/**
 * Contribute
 */
?>

<div id="contribute" class="eleganto-tab-pane">

	<h1><?php esc_html_e( 'How can I contribute?', 'eleganto' ); ?></h1>

	<hr/>

	<div class="eleganto-tab-pane-half eleganto-tab-pane-first-half">

		<p><strong><?php esc_html_e( 'Found a bug? Want to contribute with a fix?','eleganto'); ?></strong></p>

		<p><?php esc_html_e( 'Contact us!','eleganto' ); ?></p>

		<p>
			<a href="<?php echo esc_url( 'http://themes4wp.com/contact/' ); ?>" class="contribute-button button button-primary"><?php printf( esc_html__( '%s contact page', 'eleganto' ), 'Eleganto' ); ?></a>
		</p>

		<hr>

	</div>
	<div class="eleganto-tab-pane-half">

		<p><strong><?php printf( esc_html__( 'Are you a polyglot? Want to translate %s into your own language?', 'eleganto' ), 'eleganto' ); ?></strong></p>

		<p><?php esc_html_e( 'Get involved at WordPress.org.', 'eleganto' ); ?></p>

		<p>
			<a href="<?php echo esc_url( 'https://translate.wordpress.org/projects/wp-themes/eleganto/' ); ?>" class="translate-button button button-primary"><?php printf( esc_html__( 'Translate %s', 'eleganto' ), 'Eleganto' ); ?></a>
		</p>

	</div>

	<div>

		<h4><?php printf( esc_html__( 'Are you enjoying %s?', 'eleganto' ), 'eleganto' ); ?></h4>

		<p class="review-link"><?php printf( esc_html__( 'Rate our theme on %s. We\'d really appreciate it!', 'eleganto' ), '<a href="https://wordpress.org/support/view/theme-reviews/eleganto?filter=5">' . esc_html( 'WordPress.org', 'eleganto' ) . '</a>' ); ?></p>

		<p><span class="dashicons dashicons-star-filled"></span><span class="dashicons dashicons-star-filled"></span><span class="dashicons dashicons-star-filled"></span><span class="dashicons dashicons-star-filled"></span><span class="dashicons dashicons-star-filled"></span></p>

	</div>

</div>
