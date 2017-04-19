<?php if ( count( $module_templates['categorized'] ) > 0 ) : ?>
	<?php foreach ( $module_templates['categorized'] as $cat ) : ?>
	<div class="fl-builder-blocks-section">
		<span class="fl-builder-blocks-section-title">
			<?php echo $cat['name']; ?>
			<i class="fa fa-chevron-down"></i>
		</span>
		<div class="fl-builder-blocks-section-content fl-builder-module-templates">
			<?php foreach ( $cat['templates'] as $template ) : ?>
			<span class="fl-builder-block fl-builder-block-template fl-builder-block-module-template" data-id="<?php echo $template['id']; ?>" data-type="<?php echo $template['type']; ?>">
				<?php if ( ! stristr( $template['image'], 'blank.jpg' ) ) : ?>
				<img class="fl-builder-block-template-image" src="<?php echo $template['image']; ?>" />
				<?php endif; ?>
				<span class="fl-builder-block-title"><?php echo $template['name']; ?></span>
			</span>
			<?php endforeach; ?>
		</div>
	</div>
	<?php endforeach; ?>
<?php endif; ?>