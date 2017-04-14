<div class="fl-builder-loading"></div>
<div class="fl-sortable-proxy fl-row-sortable-proxy"><div class="fl-row-sortable-proxy-item"></div></div>
<div class="fl-sortable-proxy fl-col-sortable-proxy"><div class="fl-col-sortable-proxy-item"></div></div>
<div class="fl-builder-hidden-editor">
	<?php wp_editor(' ', 'flhiddeneditor', array('wpautop' => true)); ?>
</div>
<input type="hidden" id="fl-post-id" value="<?php echo $post_id; ?>" />
<input type="hidden" id="fl-admin-url" value="<?php echo admin_url(); ?>" />