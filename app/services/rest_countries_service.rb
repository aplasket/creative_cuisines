class RestCountriesService
  def name_a_country
    response = conn.get("/v3.1/all")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://restcountries.com")
  end
end