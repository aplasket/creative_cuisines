require "rails_helper"

RSpec.describe RestCountriesService do
  describe "#get_random_country" do
    it "establishes a connection to restcountries api based on query params", :vcr do
      search = RestCountriesService.new.get_random_country

      expect(search).to be_an(Array)

      search.map do |country|
        expect(country).to have_key(:name)
        expect(country[:name]).to be_a(Hash)

        expect(country[:name]).to have_key(:common)
        expect(country[:name][:common]).to be_a(String)
      end
    end
  end

  describe "#get_capital" do
    it "establishes a connection to restcountries api and fetches the capital", :vcr do
      # search = RestCountriesService.new.get_random_country
      # country = search.first[:name][:common]

      params = { country: "France" }

      country_data = RestCountriesService.new.get_capital(params[:country])

      expect(country_data).to be_an(Array)
      expect(country_data[0]).to have_key(:name)
      expect(country_data[0][:name][:common]).to eq(params[:country])

      expect(country_data[0]).to have_key(:capital)
      expect(country_data[0][:capital]).to be_an(Array)
      expect(country_data[0][:capital][0]).to eq("Paris")
    end
  end
end