class CountryFacade
  def initialize(params)
    @params = params
  end

  def get_country
    return nil if @params.empty?

    if @params == "random_country"
      random_country
    else
      @params
    end
  end


  def random_country
    json = RestCountriesService.new.get_random_country

    json.sample[:name][:common]
  end
end