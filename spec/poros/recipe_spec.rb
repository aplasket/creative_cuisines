require "rails_helper"

RSpec.describe Recipe do
  it "exists and has attributes", :vcr do
    params = {country: "thailand"}
    list_recipes = RecipeFacade.new(params[:country]).recipes
    recipe = list_recipes.first

    expect(recipe).to be_a(Recipe)
    expect(recipe.url).to be_a(String)
    expect(recipe.country).to be_a(String)
    expect(recipe.country).to eq(params[:country])
    expect(recipe.image).to be_a(String)
    expect(recipe.title).to be_a(String)
  end
end