class Api::V1::RecipesController < ApplicationController
  def index

    # render json: RecipeSerializer.all(recipes)
    binding.pry
    country = params[:q]
    conn = Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params['app_id'] = ENV["EDAMAM_ID"]
      faraday.params['app_key'] = ENV['EDAMAM_KEY']
      faraday.params['type'] = "any"
      faraday.params['q'] = country
    end

    response = conn.get("/api/recipes/v2")
    json = JSON.parse(response.body, symbolize_names: true)

    @recipes = json[:hits].map do |recipe_data|
      Recipe.new(recipe_data)
    end
  end
end