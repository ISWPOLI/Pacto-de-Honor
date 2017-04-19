<div class="fl-builder-panel">
	<div class="fl-builder-panel-actions">
		<i class="fl-builder-panel-close fa fa-times"></i>
	</div>
	<div class="fl-builder-panel-content-wrap fl-nanoscroller">
		<div class="fl-builder-panel-content fl-nanoscroller-content">
			<div class="fl-builder-blocks">

				<?php do_action( 'fl_builder_ui_panel_before_rows' ); ?>

				<div id="fl-builder-blocks-rows" class="fl-builder-blocks-section">
					<span class="fl-builder-blocks-section-title">
						<?php _e('Row Layouts', 'fl-builder'); ?>
						<i class="fa fa-chevron-down"></i>
					</span>
					<div class="fl-builder-blocks-section-content fl-builder-rows">
						<span class="fl-builder-block fl-builder-block-row" data-cols="1-col"><span class="fl-builder-block-title"><?php _e('1 Column', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="2-cols"><span class="fl-builder-block-title"><?php _e('2 Columns', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="3-cols"><span class="fl-builder-block-title"><?php _e('3 Columns', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="4-cols"><span class="fl-builder-block-title"><?php _e('4 Columns', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="5-cols"><span class="fl-builder-block-title"><?php _e('5 Columns', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="6-cols"><span class="fl-builder-block-title"><?php _e('6 Columns', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="left-sidebar"><span class="fl-builder-block-title"><?php _e('Left Sidebar', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="right-sidebar"><span class="fl-builder-block-title"><?php _e('Right Sidebar', 'fl-builder'); ?></span></span>
						<span class="fl-builder-block fl-builder-block-row" data-cols="left-right-sidebar"><span class="fl-builder-block-title"><?php _e('Left &amp; Right Sidebar', 'fl-builder'); ?></span></span>
					</div>
				</div>

				<?php do_action( 'fl_builder_ui_panel_after_rows' ); ?>

				<div class="fl-builder-blocks-separator"></div>

				<?php do_action( 'fl_builder_ui_panel_before_modules' ); ?>

				<?php foreach($categories as $title => $modules) : ?>
				<div id="fl-builder-blocks-<?php echo FLBuilderModel::get_module_category_slug( $title ); ?>" class="fl-builder-blocks-section">
					<span class="fl-builder-blocks-section-title">
						<?php echo $title; ?>
						<i class="fa fa-chevron-down"></i>
					</span>
					<?php if($title == __('WordPress Widgets', 'fl-builder')) : ?>
					<div class="fl-builder-blocks-section-content fl-builder-widgets">
						<?php foreach($modules as $module) : ?>
						<span class="fl-builder-block fl-builder-block-module" data-type="widget" data-widget="<?php echo $module->class; ?>"><span class="fl-builder-block-title" title="<?php echo esc_attr( $module->name ); ?>"><?php echo $module->name; ?></span></span>
						<?php endforeach; ?>
					</div>
					<?php else : ?>
					<div class="fl-builder-blocks-section-content fl-builder-modules">
						<?php foreach($modules as $module) : ?>
						<span class="fl-builder-block fl-builder-block-module" data-type="<?php echo $module->slug; ?>"><span class="fl-builder-block-title" title="<?php echo esc_attr( $module->name ); ?>"><?php echo $module->name; ?></span></span>
						<?php endforeach; ?>
					</div>
					<?php endif; ?>
				</div>
				<?php endforeach; ?>

				<?php do_action( 'fl_builder_ui_panel_after_modules' ); ?>

				<?php if ( true === FL_BUILDER_LITE ) : ?>
				<div class="fl-builder-modules-cta">
					<a href="#" onclick="window.open('<?php echo FLBuilderModel::get_store_url( '', array( 'utm_medium' => 'bb-lite', 'utm_source' => 'builder-ui', 'utm_campaign' => 'modules-panel-cta' ) ); ?>');" target="_blank"><i class="fa fa-external-link-square"></i> <?php _e( 'Get more time-saving features, modules, and expert support.', 'fl-builder' ); ?></a>
				</div>
				<?php endif; ?>

			</div>
		</div>
	</div>
</div>
