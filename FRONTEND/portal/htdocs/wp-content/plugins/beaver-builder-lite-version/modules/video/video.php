<?php

/**
 * @class FLVideoModule
 */
class FLVideoModule extends FLBuilderModule {

	/**
	 * @property $data
	 */
	public $data = null;

	/**
	 * @method __construct
	 */
	public function __construct()
	{
		parent::__construct(array(
			'name'          	=> __('Video', 'fl-builder'),
			'description'   	=> __('Render a WordPress or embedable video.', 'fl-builder'),
			'category'      	=> __('Basic Modules', 'fl-builder'),
			'partial_refresh'	=> true
		));

		$this->add_js('jquery-fitvids');
	}

	/**
	 * @method get_data
	 */
	public function get_data()
	{
		if(!$this->data) {

			$this->data = FLBuilderPhoto::get_attachment_data($this->settings->video);

			if(!$this->data && isset($this->settings->data)) {
				$this->data = $this->settings->data;
			}
			if($this->data) {
				$parts                  = explode('.', $this->data->filename);
				$this->data->extension  = array_pop($parts);
				$this->data->poster     = isset($this->settings->poster_src) ? $this->settings->poster_src : '';
				$this->data->loop       = isset($this->settings->loop) && $this->settings->loop ? ' loop="yes"' : '';
				$this->data->autoplay   = isset($this->settings->autoplay) && $this->settings->autoplay ? ' autoplay="yes"' : '';

				// WebM format
				$webm_data = FLBuilderPhoto::get_attachment_data($this->settings->video_webm);
				$this->data->video_webm = isset($this->settings->video_webm) && $webm_data ? ' webm="'. $webm_data->url .'"' : '';
				
			}
		}

		return $this->data;
	}

	/**
	 * @method update
	 * @param $settings {object}
	 */
	public function update($settings)
	{
		// Cache the attachment data.
		if($settings->video_type == 'media_library') {

			$video = FLBuilderPhoto::get_attachment_data($settings->video);

			if($video) {
				$settings->data = $video;
			}
		}

		return $settings;
	}
}

/**
 * Register the module and its form settings.
 */
FLBuilder::register_module('FLVideoModule', array(
	'general'       => array(
		'title'         => __('General', 'fl-builder'),
		'sections'      => array(
			'general'       => array(
				'title'         => '',
				'fields'        => array(
					'video_type'       => array(
						'type'          => 'select',
						'label'         => __('Video Type', 'fl-builder'),
						'default'       => 'wordpress',
						'options'       => array(
							'media_library'     => __('Media Library', 'fl-builder'),
							'embed'             => __('Embed', 'fl-builder')
						),
						'toggle'        => array(
							'media_library'      => array(
								'fields'      => array('video', 'video_webm', 'poster', 'autoplay', 'loop')
							),
							'embed'     => array(
								'fields'      => array('embed_code')
							)
						)
					),
					'video'          => array(
						'type'          => 'video',
						'label'         => __( 'Video (MP4)', 'fl-builder' ),
						'help'          => __('A video in the MP4 format. Most modern browsers support this format.', 'fl-builder'),
					),
					'video_webm' => array(
						'type'          => 'video',
						'label'         => __('Video (WebM)', 'fl-builder'),
						'help'          => __('A video in the WebM format to use as fallback. This format is required to support browsers such as FireFox and Opera.', 'fl-builder'),
						'preview'         => array(
							'type'            => 'none'
						)
					),
					'poster'         => array(
						'type'          => 'photo',
						'label'         => _x( 'Poster', 'Video preview/fallback image.', 'fl-builder' )
					),
					'autoplay'       => array(
						'type'          => 'select',
						'label'         => __('Auto Play', 'fl-builder'),
						'default'       => '0',
						'options'       => array(
							'0'             => __('No', 'fl-builder'),
							'1'             => __('Yes', 'fl-builder')
						),
						'preview'       => array(
							'type'          => 'none'
						)
					),
					'loop'           => array(
						'type'          => 'select',
						'label'         => __('Loop', 'fl-builder'),
						'default'       => '0',
						'options'       => array(
							'0'             => __('No', 'fl-builder'),
							'1'             => __('Yes', 'fl-builder')
						),
						'preview'       => array(
							'type'          => 'none'
						)
					),
					'embed_code'     => array(
						'type'          => 'code',
						'wrap'          => true,
						'editor'        => 'html',
						'label'         => '',
						'rows'          => '9'
					)
				)
			)
		)
	)
));