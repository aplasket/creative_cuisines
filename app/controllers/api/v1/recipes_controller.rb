class Api::V1::RecipesController < ApplicationController
  def index
    @facade = RecipeFacade.new(params[:country]).recipes
    render json: RecipeSerializer.new(@facade)
  end
end