<?php
/*
 *
 * Template Name: Contact 
 *
 */
get_header();
$evolve_edit_post = evolve_get_option('evl_edit_post', '0');
$evolve_recaptcha_public = evolve_get_option('evl_recaptcha_public', '');
$evolve_recaptcha_private = evolve_get_option('evl_recaptcha_private', '');
$evolve_email_address = evolve_get_option('evl_email_address', '');
$evolve_sent_email_header = evolve_get_option('evl_sent_email_header', get_bloginfo('name'));

//If the form is submitted
if (isset($_POST['submit'])) {
    $emailSent = '';
    //Check to make sure that the name field is not empty
    if (trim($_POST['contact_name']) == '' || trim($_POST['contact_name']) == 'Name (required)') {
        $hasError = true;
    } else {
        $name = trim($_POST['contact_name']);
    }

    //Subject field is not required
    if (function_exists('stripslashes')) {
        $subject = stripslashes(trim($_POST['url']));
    } else {
        $subject = trim($_POST['url']);
    }

    //Check to make sure sure that a valid email address is submitted
    $pattern = '/^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$/iD';

    if (trim($_POST['email']) == '' || trim($_POST['email']) == 'Email (required)') {
        $hasError = true;
    } else if (preg_match($pattern, $_POST['email']) === 0) {
        $hasError = true;
    } else {
        $email = trim($_POST['email']);
    }

    //Check to make sure comments were entered
    if (trim($_POST['msg']) == '' || trim($_POST['msg']) == 'Message') {
        $hasError = true;
    } else {
        if (function_exists('stripslashes')) {
            $comments = stripslashes(trim($_POST['msg']));
        } else {
            $comments = trim($_POST['msg']);
        }
    }

    // reCaptch v2
    if ($evolve_recaptcha_public && $evolve_recaptcha_private) {

        $response = $_POST['g-recaptcha-response'];

        if (!empty($response)) {
            $reCaptcha = new evolve_GoogleRecaptcha();
            $verified = $reCaptcha->VerifyCaptcha($response);

            if (!$verified) {
                $hasError = true;
            }
        } else {
            $hasError = true;
        }
    }

    //If there is no error, send the email
    if (!isset($hasError)) {
        $name = wp_filter_kses($name);
        $email = wp_filter_kses($email);
        $subject = wp_filter_kses($subject);
        $comments = wp_filter_kses($comments);

        if (function_exists('stripslashes')) {
            $subject = stripslashes($subject);
            $comments = stripslashes($comments);
        }

        $emailTo = $evolve_email_address; //Put your own email address here
        $emailFrom = $evolve_sent_email_header;

        $body = __('Name:', 'evolve') . " $name \n\n";
        $body .= __('Email:', 'evolve') . " $email \n\n";
        $body .= __('Subject:', 'evolve') . " $subject \n\n";
        $body .= __('Comments:', 'evolve') . "\n $comments";

        $headers = 'Reply-To: ' . $name . ' <' . $email . '>' . "\r\n";

        if ($evolve_sent_email_header) {
            $headers .= 'From: ' . $emailFrom . ' <' . $email . '>' . "\r\n";
        } else {
            $headers .= 'From: ' . $emailTo . ' <' . $email . '>' . "\r\n";
        }

        $mail = wp_mail($emailTo, $subject, $body, $headers);
        $emailSent = true;
    }

    if ($emailSent == true) {
        $_POST['contact_name'] = '';
        $_POST['email'] = '';
        $_POST['url'] = '';
        $_POST['msg'] = '';
    }
}
?>
<!--BEGIN #primary .hfeed-->
<div id="primary" class="hfeed full-width contact-page">

    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>

            <!--BEGIN .hentry-->
            <div id="post-<?php the_ID(); ?>" class="<?php semantic_entries(); ?>"> 
                <?php
                if (get_post_meta($post->ID, 'evolve_page_title', true) == 'no'):
                else:
                    ?>
                    <h1 class="entry-title"><?php
                        if (get_the_title()) {
                            the_title();
                        }
                        ?></h1>               
                <?php
                endif;
                if ($evolve_edit_post == "1") {
                    if (current_user_can('edit_post', $post->ID)):
                        edit_post_link(__('EDIT', 'evolve'), '<span class="edit-page">', '</span>');
                    endif;
                }
                ?>

                <!--BEGIN .entry-content .article-->
                <div class="entry-content article">
                    <?php
                    the_content();

                    if (isset($hasError)) { //If errors are found  
                        ?>
                        <div class="alert alert-danger"><?php echo __("Please check if you've filled all the fields with valid information. Thank you.", 'evolve'); ?></div>
                        <br />
                        <?php
                    }

                    if (isset($emailSent) && $emailSent == true) { //If email is sent  
                        ?>
                        <div class="alert alert-success"><?php echo __('Thank you', 'evolve'); ?> <strong><?php echo $name; ?></strong> <?php echo __('for using my contact form! Your email was successfully sent!', 'evolve'); ?></div></div>
                    <br />
                <?php } ?>
            </div>
            <form action="" method="post">

                <div id="comment-input">

                    <div class="col-sm-4 col-md-4 padding-l">
                        <input type="text" name="contact_name" id="author" value="<?php
                        if (isset($_POST['contact_name']) && !empty($_POST['contact_name'])) {
                            echo esc_html($_POST['contact_name']);
                        }
                        ?>" placeholder="<?php _e('Name (required)', 'evolve'); ?>" size="22" tabindex="1" aria-required="true" class="input-name">
                    </div>

                    <div class="col-sm-4 col-md-4 padding-l">
                        <input type="text" name="email" id="email" value="<?php
                        if (isset($_POST['email']) && !empty($_POST['email'])) {
                            echo esc_html($_POST['email']);
                        }
                        ?>" placeholder="<?php _e('Email (required)', 'evolve'); ?>" size="22" tabindex="2" aria-required="true" class="input-email">
                    </div>

                    <div class="col-sm-4 col-md-4 padding-l">
                        <input type="text" name="url" id="url" value="<?php
                        if (isset($_POST['url']) && !empty($_POST['url'])) {
                            echo esc_html($_POST['url']);
                        }
                        ?>" placeholder="<?php _e('Subject', 'evolve'); ?>" size="22" tabindex="3" class="input-website">
                    </div>

                </div>

                <div class="clearfix"></div>

                <div id="comment-textarea" class="col-md-12">
                    <textarea name="msg" id="comment" cols="39" rows="4" tabindex="4" class="textarea-comment" placeholder="<?php _e('Message', 'evolve'); ?>"><?php
                        if (isset($_POST['msg']) && !empty($_POST['msg'])) {
                            echo esc_html($_POST['msg']);
                        }
                        ?></textarea>
                </div>
                <div class="clearfix"></div>

                <?php if ($evolve_recaptcha_public && $evolve_recaptcha_private): ?>

                    <div id="comment-recaptcha" class="col-md-12">
                        <div class="g-recaptcha" data-sitekey="<?php echo $evolve_recaptcha_public; ?>"></div>
                    </div>

                <?php endif; ?>

                <input name="submit" type="submit" id="submit" tabindex="5" value="<?php _e('Send Message', 'evolve'); ?>">            

            </form>

            <!--END .entry-content .article-->
            <div class="clearfix"></div> 

            <!-- Auto Discovery Trackbacks
            <?php trackback_rdf(); ?>
            -->
        </div><!--END .hentry-->

        <?php
        $evolve_share_this = evolve_get_option('evl_share_this', 'single');
        if (($evolve_share_this == "all")) {
            evolve_sharethis();
        }

        comments_template('', true);

    endwhile;
endif;
?> 

</div><!--END #primary .hfeed-->
<?php
get_footer();
