class EdamamService
  def get_recipes(country)
    response = conn.get("/api/recipes/v2?type=any&q=#{country}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params['app_id'] = ENV["EDAMAM_ID"]
      faraday.params['app_key'] = ENV['EDAMAM_KEY']
    end
  end
end