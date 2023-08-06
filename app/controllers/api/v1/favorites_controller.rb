class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      Favorite.create(favorite_params)
      render json: { success: "Favorite added successfully" }, status: 201
    else
      render json: { error: "Unauthorized user" }, status: 400
    end
  end

  private
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title, :user_id)
  end
end