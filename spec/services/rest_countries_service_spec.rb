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
end