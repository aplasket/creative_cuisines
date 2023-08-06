class YoutubeService
  def initialize(country)
    @country = country
  end

  def find_video
    response = conn.get("/youtube/v3/search") do |request|
      request.params['part'] = "snippet"
      request.params['channelId'] = "UCluQ5yInbeAkkeCndNnUhpw"
      request.params['q'] = @country
      request.params['maxResults'] = 1
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://youtube.googleapis.com/") do |faraday|
      faraday.params['key'] = ENV['GOOGLE_TOKEN']
    end
  end
end