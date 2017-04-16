<?php
/**
 * The template for the header sticky bar.
 * Override this template by specifying the path where it is stored (templates_path) in your Redux config.
 *
 * @author        Redux Framework
 * @package       ReduxFramework/Templates
 * @version:      3.5.7.8
 */
?>
<div id="redux-sticky">
    <div id="info_bar">
        <a href="javascript:void(0);" class="expand_options<?php echo esc_attr(( $this->parent->args['open_expanded'] ) ? ' expanded' : ''); ?>"<?php echo $this->parent->args['hide_expand'] ? ' style="display: none;"' : '' ?>>
            <?php esc_attr_e('Expand', 'evolve'); ?>
        </a>

        <!-- Show / Hide premium options switch -->
        <?php
        global $evolve_opt_name, $evolve_prem_inpt_name;
        $evolvePremiumField = Redux::getField($evolve_opt_name, $evolve_prem_inpt_name);
        $evolvePremiumField['name'] = $evolve_opt_name . "[" . $evolve_prem_inpt_name . "]";
        ?>
        <div class="redux-SH-container">
            <li id="evl-SH-question-img1" class="redux-SH-question dashicons dashicons-editor-help">&nbsp</li>
            <span id="evl-SH-info1" class="redux-SH-info"><?php echo esc_html($evolvePremiumField['subtitle']); ?></span>
            <span class="redux-SH-title"><?php echo esc_html($evolvePremiumField['title']); ?></span>
            <br>&nbsp;
        </div>
        <div id="premium_section_group"  class="redux-group-tab redux-SH-container">
            <?php
            $this->parent->_field_input($evolvePremiumField, $this->parent->options[$evolve_prem_inpt_name]);
            ?>
        </div>

        <div class="redux-action_bar">
            <span class="spinner"></span>
            <?php
            if (false === $this->parent->args['hide_save']) {
                submit_button(esc_attr__('Save Changes', 'evolve'), 'primary', 'redux_save', false);
            }

            if (false === $this->parent->args['hide_reset']) {
                submit_button(esc_attr__('Reset Section', 'evolve'), 'secondary', $this->parent->args['opt_name'] . '[defaults-section]', false, array('id' => 'redux-defaults-section'));
                submit_button(esc_attr__('Reset All', 'evolve'), 'secondary', $this->parent->args['opt_name'] . '[defaults]', false, array('id' => 'redux-defaults'));
            }
            ?>
        </div>
        <div class="redux-ajax-loading" alt="<?php esc_attr_e('Working...', 'evolve') ?>">&nbsp;</div>
        <div class="clear"></div>
    </div>

    <!-- Notification bar -->
    <div id="redux_notification_bar">
        <?php $this->notification_bar(); ?>
    </div>


</div>
