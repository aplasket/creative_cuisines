require "rails_helper"

RSpec.describe NinjaService do
  describe "get air quality" do
    it "establishes a connection to ApiNinja and returns airquality for a city", :vcr do
      params = { country: "France" }
      # country_data = RestCountriesService.new.get_capital(params[:country])
      capital = CountryFacade.new(params[:country]).capital
      binding.pry

      search = NinjaService.new.get_air_quality(capital)
    end
  end
end