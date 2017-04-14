<?php if($row->settings->bg_video_source == 'wordpress') { ?>
<div class="fl-bg-video" 
data-width="<?php if ( isset( $vid_data['mp4'] ) ) echo @$vid_data['mp4']->width; else echo @$vid_data['webm']->width; ?>" 
data-height="<?php if ( isset( $vid_data['mp4'] ) ) echo @$vid_data['mp4']->height; else echo @$vid_data['webm']->height; ?>" 
data-fallback="<?php if ( isset( $vid_data['mp4'] ) ) echo $vid_data['mp4']->fallback; else echo $vid_data['webm']->fallback; ?>" 
<?php if ( isset( $vid_data['mp4'] ) ) : ?>
data-mp4="<?php echo $vid_data['mp4']->url; ?>" 
data-mp4-type="video/<?php echo $vid_data['mp4']->extension; ?>" 
<?php endif; ?>
<?php if ( isset( $vid_data['webm'] ) ) : ?>
data-webm="<?php echo $vid_data['webm']->url; ?>" 
data-webm-type="video/<?php echo $vid_data['webm']->extension; ?>" 
<?php endif; ?>></div>
<?php } ?>

<?php if($row->settings->bg_video_source == 'video_url') { ?>
<div class="fl-bg-video" 
data-fallback="<?php if ( isset( $row->settings->bg_video_fallback_src ) ) echo $row->settings->bg_video_fallback_src; ?>" 
<?php if ( isset( $row->settings->bg_video_url_mp4 ) ) : ?>
data-mp4="<?php echo $row->settings->bg_video_url_mp4; ?>" 
data-mp4-type="video/mp4" 
<?php endif; ?>
<?php if ( isset( $row->settings->bg_video_url_webm ) ) : ?>
data-webm="<?php echo $row->settings->bg_video_url_webm; ?>" 
data-webm-type="video/webm" 
<?php endif; ?>></div>
<?php } ?>

<?php if($row->settings->bg_video_source == 'video_service') {
$video_data = FLBuilderUtils::get_video_data($row->settings->bg_video_service_url); ?>
<div class="fl-bg-video" 
data-fallback="<?php if ( isset( $row->settings->bg_video_fallback_src ) ) echo $row->settings->bg_video_fallback_src; ?>" 
<?php if ( isset( $row->settings->bg_video_service_url ) ) : ?>
data-<?php echo $video_data['type']; ?>="<?php echo $row->settings->bg_video_service_url; ?>" 
data-video-id="<?php echo $video_data['video_id']; ?>"
data-enable-audio="<?php echo $row->settings->bg_video_audio; ?>"
<?php endif; ?>>
<div class="fl-bg-video-player"></div>
</div>
<?php } ?>
