class RestCountriesService
  def get_random_country
    get_url("/v3.1/all")
  end

  def get_capital(country)
    formatted_country = country.split.join("%20")
    get_url("/v3.1/name/#{formatted_country}?fullText=true")
    # get_url("/v3.1/name/#{country}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://restcountries.com")
  end
end