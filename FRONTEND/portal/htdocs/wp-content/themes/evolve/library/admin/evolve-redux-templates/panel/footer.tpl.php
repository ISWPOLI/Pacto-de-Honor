<?php
/**
 * The template for the panel footer area.
 * Override this template by specifying the path where it is stored (templates_path) in your Redux config.
 *
 * @author        Redux Framework
 * @package       ReduxFramework/Templates
 * @version:      3.5.8.3
 */
?>
<div id="redux-sticky-padder" style="display: none;">&nbsp;</div>
<div id="redux-footer-sticky">
    <div id="redux-footer">
        <?php
        if (isset($this->parent->args['share_icons'])) {

            $skip_icons = false;
            if (!$this->parent->args['dev_mode'] && $this->parent->omit_share_icons) {
                $skip_icons = true;
            }
            ?>
            <div id="redux-share">
                <?php
                foreach ($this->parent->args['share_icons'] as $link) {
                    if ($skip_icons) {
                        continue;
                    }

                    // SHIM, use URL now
                    if (isset($link['link']) && !empty($link['link'])) {
                        $link['url'] = $link['link'];
                        unset($link['link']);
                    }
                    ?>
                    <a href="<?php echo esc_url($link['url']) ?>" title="<?php echo esc_attr($link['title']); ?>" target="_blank">
                        <?php if (isset($link['icon']) && !empty($link['icon'])) : ?>
                            <i class="<?php
                            if (strpos($link['icon'], 'el-icon') !== false && strpos($link['icon'], 'el ') === false) {
                                $link['icon'] = 'el ' . $link['icon'];
                            }
                            echo esc_attr($link['icon']);
                            ?>"></i>
                           <?php else : ?>
                            <img src="<?php echo esc_url($link['img']); ?>"/>
                        <?php endif; ?>

                    </a>
                <?php } ?>

            </div>
        <?php } ?>


        <!-- Show / Hide premium options button -->
        <?php
        global $evolve_opt_name, $evolve_prem_inpt_name;
        $evolvePremiumField = Redux::getField($evolve_opt_name, $evolve_prem_inpt_name);
        $evolvePremiumField['name'] = $evolve_opt_name . "[" . $evolve_prem_inpt_name . "]";
        ?>
        <div class="redux-SH-container">
            <li id="evl-SH-question-img2" class="redux-SH-question dashicons dashicons-editor-help">&nbsp</li>
            <span id="evl-SH-info2" class="redux-SH-info"><?php echo esc_html($evolvePremiumField['subtitle']); ?></span>
            <span class="redux-SH-title"><?php echo esc_html($evolvePremiumField['title']); ?></span>
            <br>&nbsp;
        </div>
        <div class="redux-group-tab redux-SH-container" style="display: block;">
            <fieldset id="evl_options-evl_hiden_premium2" class="redux-field-container redux-field redux-container-switch" data-id="evl_hiden_premium" data-type="switch">
                <div class="switch-options">
                    <label class="cb-enable" id="evl-premium-switch2-on">
                        <span>Show</span>
                    </label>
                    <label class="cb-disable" id="evl-premium-switch2-off">
                        <span>Hide</span>
                    </label>
                </div>
            </fieldset>
        </div>


        <div class="redux-action_bar">
            <span class="spinner"></span>
            <?php
            if (false === $this->parent->args['hide_save']) {
                submit_button(__('Save Changes', 'evolve'), 'primary', 'redux_save', false);
            }

            if (false === $this->parent->args['hide_reset']) {
                submit_button(__('Reset Section', 'evolve'), 'secondary', $this->parent->args['opt_name'] . '[defaults-section]', false, array('id' => 'redux-defaults-section'));
                submit_button(__('Reset All', 'evolve'), 'secondary', $this->parent->args['opt_name'] . '[defaults]', false, array('id' => 'redux-defaults'));
            }
            ?>
        </div>

        <div class="redux-ajax-loading" alt="<?php _e('Working...', 'evolve') ?>">&nbsp;</div>
        <div class="clear"></div>

    </div>
</div>
