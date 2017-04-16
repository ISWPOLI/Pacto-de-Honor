<div class="fl-code-field">
	<?php $editor_id = 'flcode' . time() . '_' . $name; ?>
	<textarea id="<?php echo $editor_id; ?>" name="<?php echo $name; ?>" data-editor="<?php echo $field['editor']; ?>" <?php if(isset($field['class'])) echo ' class="'. $field['class'] .'"'; if(isset($field['rows'])) echo ' rows="'. $field['rows'] .'"'; ?>><?php echo htmlspecialchars($value); ?></textarea>
	<script>
	
	jQuery(function(){
		
		var textarea = jQuery('#<?php echo $editor_id; ?>'), 
			mode     = textarea.data('editor'), 
			editDiv  = jQuery('<div>', {
				position:   'absolute',
				height:     parseInt(textarea.attr('rows'), 10) * 20
			}), 
			editor = null;

		editDiv.insertBefore(textarea);
		textarea.css('display', 'none');
		ace.require('ace/ext/language_tools');
		editor = ace.edit(editDiv[0]);
		editor.$blockScrolling = Infinity;
		editor.getSession().setValue(textarea.val());
		editor.getSession().setMode('ace/mode/' + mode);
		
		<?php if ( isset( $field['wrap'] ) && $field['wrap'] === true ) : ?>
			editor.getSession().setUseWrapMode(true);
		<?php endif; ?>
		
		editor.setOptions({
	        enableBasicAutocompletion: true,
	        enableLiveAutocompletion: true,
	        enableSnippets: false
	    });
		
		editor.getSession().on('change', function(e) {
			textarea.val(editor.getSession().getValue()).trigger('change');
		});
		
		textarea.closest( '.fl-field' ).data( 'editor', editor );
	});
	
	</script>
</div>