class Api::V1::FavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    user_favorites = user.favorites
    render json: FavoriteSerializer.new(user_favorites)
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      new_favorite = Favorite.create(favorite_params)
      new_favorite.update!(user_id: user.id)
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