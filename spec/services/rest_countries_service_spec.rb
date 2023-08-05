require "rails_helper"

RSpec.describe RestCountriesService do
  describe "#get_random_country" do
    it "establishes a connection to restcountries api based on query params", :vcr do
      search = RestCountriesService.new.get_random_country
      binding.pry

      expect(search).to be_an(Array)

      search.map do |country|
        expect(country.keys.count).to eq(34)
        expect(country).to have_key(:name)
        expect(country).to have_key(:independent)
        expect(country).to have_key(:status)
        expect(country).to have_key(:unMember)
        expect(country).to have_key(:postalCode)

        expect(country[:name]).to be_a(Hash)
        expect(count[:name].keys.count).to eq(3)

        expect(country[:name]).to have_key(:common)
        expect(country[:name][:common]).to be_a(String)
      end
    end
  end
end