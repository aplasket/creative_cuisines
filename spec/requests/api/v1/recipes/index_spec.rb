require "rails_helper"

RSpec.describe "Recipes Index Request" do
  describe "fetches all recipes" do
    it "requests recipes from a specific country", :vcr do
      get "/api/v1/recipes?country=thailand"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      recipes = JSON.parse(response.body, symbolize_names: true)
      binding.pry

    end
  end
end