require "rails_helper"

RSpec.describe EdamamService do
  describe "#get_recipes" do
    it "establishes a connection for recipes based on a query param", :vcr do
      country = "thailand"
      search = EdamamService.new.get_recipes(country)

      expect(search).to be_a(Hash)
      expect(search[:hits]).to be_an(Array)

      data = search[:hits].first

      expect(data).to have_key(:recipe)
      expect(data[:recipe]).to be_a(Hash)

      expect(data[:recipe]).to have_key(:url)
      expect(data[:recipe][:url]).to be_a(String)

      expect(data[:recipe]).to have_key(:image)
      expect(data[:recipe][:image]).to be_a(String)
      
      expect(data[:recipe]).to have_key(:label)
      expect(data[:recipe][:label]).to be_a(String)
    end
  end
end