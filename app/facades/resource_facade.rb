class ResourceFacade
  attr_reader :country,
              :video,
              :images

  def initialize(params)
    @country = params[:country]
    youtube_json = YoutubeService.new(@country).find_video
    @video = Video.new(youtube_json[:items].first)

    unsplash_json = UnsplashService.new(@country).find_images
    @images = unsplash_json[:results].map do|image_details|
      Image.new(image_details)
    end
  end
end