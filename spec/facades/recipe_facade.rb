require "rails_helper"

RSpec.describe RecipeFacade do
  describe "#recipes" do
    it "finds recipes and makes recipe objects", :vcr do
      params = {country: "thailand"}
      recipes = RecipeFacade.new(params[:country]).recipes

      expect(recipes).to be_an(Array)

      recipes.map do |recipe|
        expect(recipe).to be_a(Recipe)
        expect(recipe.url).to be_a(String)
        expect(recipe.country).to be_a(String)
        expect(recipe.country).to eq(params[:country])
        expect(recipe.image).to be_a(String)
        expect(recipe.title).to be_a(String)
      end
    end
  end
end