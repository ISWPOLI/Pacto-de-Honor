<form class="fl-builder-settings fl-template-selector">
	<div class="fl-lightbox-header">

		<h1><?php _e('Layout Templates', 'fl-builder'); ?></h1>

		<?php if ( count( $filter_data ) > 1 ) : ?>
		<div class="fl-template-category-filter fl-builder-settings-fields">
			<select class="fl-template-category-select" name="fl-template-category-select">
				<?php foreach ( $filter_data as $slug => $category ) : ?>
				<option value="fl-builder-settings-tab-<?php echo $slug; ?>"><?php echo $category; ?></option>
				<?php endforeach; ?>
			</select>
		</div>
		<?php endif; ?>

	</div>
	<div class="fl-builder-settings-fields fl-nanoscroller">
		<div class="fl-nanoscroller-content">

			<?php if ( true === FL_BUILDER_LITE ) : ?>
				<?php if ( FLBuilderModel::has_templates() ) : ?>
				<div class="fl-builder-settings-message fl-builder-templates-cta">
					<p><?php _e( 'Save and reuse your layouts or kick-start your creativity with even more professionally designed templates.', 'fl-builder' ); ?></p>
					<a class="fl-builder-upgrade-button fl-builder-button" href="<?php echo FLBuilderModel::get_store_url( '', array( 'utm_medium' => 'bb-lite', 'utm_source' => 'builder-ui', 'utm_campaign' => 'templates-cta' ) ); ?>" target="_blank"><?php _e( 'Learn More', 'fl-builder' ); ?> <i class="fa fa-external-link-square"></i></a>
				</div>
				<?php else : ?>
				<div class="fl-builder-settings-message fl-builder-templates-cta">
					<p><?php _e( 'Save and reuse your layouts or kick-start your creativity with dozens of professionally designed templates.', 'fl-builder' ); ?></p>
					<a class="fl-builder-upgrade-button fl-builder-button" href="<?php echo FLBuilderModel::get_store_url( '', array( 'utm_medium' => 'bb-lite', 'utm_source' => 'builder-ui', 'utm_campaign' => 'templates-cta' ) ); ?>" target="_blank"><?php _e( 'Learn More', 'fl-builder' ); ?> <i class="fa fa-external-link-square"></i></a>
				</div>
				<img class="fl-builder-templates-cta-img" src="<?php echo FL_BUILDER_URL; ?>img/templates-preview.jpg" />
				<?php endif; ?>
			<?php endif; ?>

			<?php $i = 0; foreach ( $templates['categorized'] as $slug => $category ) : ?>
			<div id="fl-builder-settings-tab-<?php echo $slug; ?>" class="fl-builder-settings-tab<?php if ( 0 === $i ) echo ' fl-active'; ?>">
				<div class="fl-builder-settings-section">
					<?php $k = 0; foreach ( $category['templates'] as $template ) : ?>
					<div class="fl-template-preview<?php if(($k + 1) % 3 === 0) echo ' fl-last'; ?>" data-id="<?php echo $template['id']; ?>">
						<div class="fl-template-image">
							<img src="<?php echo $template['image']; ?>" />
						</div>
						<span><?php echo $template['name']; ?></span>
					</div>
					<?php $k++; endforeach; ?>
				</div>
			</div>
			<?php $i++; endforeach; ?>

			<?php do_action( 'fl_builder_template_selector_content' ); ?>

		</div>
	</div>
	<div class="fl-lightbox-footer">
		<span class="fl-builder-settings-cancel fl-builder-button fl-builder-button-large" href="javascript:void(0);" onclick="return false;"><?php _e('Cancel', 'fl-builder'); ?></span>
	</div>
</form>
