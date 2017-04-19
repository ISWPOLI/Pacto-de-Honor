<div<?php FLBuilder::render_row_attributes( $row ); ?>>
	<div class="fl-row-content-wrap">
		<?php FLBuilder::render_row_bg( $row ); ?>
		<div class="<?php FLBuilder::render_row_content_class( $row ); ?>">
		<?php
		// $groups received as a magic variable from template loading.
		foreach ( $groups as $group ) {
			FLBuilder::render_column_group( $group );
		}
		
		?>
		</div>
	</div>
</div>