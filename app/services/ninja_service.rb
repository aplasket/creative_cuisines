class NinjaService
  def get_air_quality(capital)
    response = conn.get("/v1/airquality?") do |request|
      request.params['city'] = capital
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.api-ninjas.com") do |faraday|
      faraday.headers['X-Api-Key'] = ENV['API_NINJAS']
    end
  end
end