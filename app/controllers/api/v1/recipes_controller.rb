class Api::V1::RecipesController < ApplicationController
  def index
    country = CountryFacade.new(params).get_country
    facade = RecipeFacade.new(country).recipes
    if facade.nil?
      render json: { "data": [] }
    else
      render json: RecipeSerializer.new(facade)
    end
  end
end