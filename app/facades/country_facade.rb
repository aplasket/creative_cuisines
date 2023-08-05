class CountryFacade
  def initialize(params)
    @params = params[:country]
  end

  def get_country
    if @params.empty?
      nil
    elsif @params == "random_country"
      random_country
    else
      @params
    end
  end


  def random_country
    json = RestCountriesService.new.name_a_country

    json.sample[:name][:common]
  end
end