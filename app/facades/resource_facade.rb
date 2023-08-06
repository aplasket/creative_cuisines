class ResourceFacade
  attr_reader :country,
              :video,
              :images

  def initialize(params)
    @country = params[:country]

    youtube_json = YoutubeService.new(@country).find_video

    if youtube_json[:items].empty?
      @video = {}
    else
      @video = Video.new(youtube_json[:items].first)
    end

    unsplash_json = UnsplashService.new(@country).find_images

    if unsplash_json[:results].empty?
      @images = []
    else
      @images = unsplash_json[:results].map do|image_details|
        Image.new(image_details)
      end
    end
  end
end