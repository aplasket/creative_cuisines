require "rails_helper"

RSpec.describe "Recipes Index Request" do
  describe "fetches all recipes" do
    it "requests recipes from a specific country", :vcr do
      get "/api/v1/recipes?country=thailand"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_an(Array)
      expect(recipes[:data].count).to eq(20)

      recipes[:data].map do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe[:id]).to eq(nil)

        expect(recipe).to have_key(:type)
        expect(recipe[:type]).to eq("recipe")

        expect(recipe).to have_key(:attributes)
        expect(recipe[:attributes]).to be_a(Hash)
        expect(recipe[:attributes].keys.count).to eq(4)

        expect(recipe[:attributes]).to have_key(:title)
        expect(recipe[:attributes][:title]).to be_a(String)

        expect(recipe[:attributes]).to have_key(:url)
        expect(recipe[:attributes][:url]).to be_a(String)

        expect(recipe[:attributes]).to have_key(:country)
        expect(recipe[:attributes][:country]).to be_a(String)

        expect(recipe[:attributes]).to have_key(:image)
        expect(recipe[:attributes][:image]).to be_a(String)

        expect(recipe[:attributes]).to_not have_key(:source)
        expect(recipe[:attributes]).to_not have_key(:yield)
        expect(recipe[:attributes]).to_not have_key(:dietLabels)
        expect(recipe[:attributes]).to_not have_key(:healthLabels)
        expect(recipe[:attributes]).to_not have_key(:cautions)
        expect(recipe[:attributes]).to_not have_key(:ingredients)
        expect(recipe[:attributes]).to_not have_key(:cautions)
        expect(recipe[:attributes]).to_not have_key(:ingredientLines)
        expect(recipe[:attributes]).to_not have_key(:calories)
        expect(recipe[:attributes]).to_not have_key(:cuisineType)
        expect(recipe[:attributes]).to_not have_key(:mealType)
        expect(recipe[:attributes]).to_not have_key(:dishType)
        expect(recipe[:attributes]).to_not have_key(:totalNutrients)
        expect(recipe[:attributes]).to_not have_key(:digest)
        expect(recipe[:attributes]).to_not have_key(:_links)
      end
    end
  end
end