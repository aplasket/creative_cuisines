class CountryFacade
  def initialize(country)
    @country = country
  end

  def get_country
    return nil if @country.empty?

    if @country == "random_country"
      random_country
    else
      @country
    end
  end


  def random_country
    json = RestCountriesService.new.get_random_country

    country = json.sample[:name][:common]

    # get_capital(country)

    # country
  end

  def capital(country)
    json = RestCountriesService.new.get_capital(country)
    capital = json[0][:capital][0]
  end
end