class Api::V1::FavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    return error unless user

    user_favorites = user.favorites
    render json: FavoriteSerializer.new(user_favorites)
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    return error unless user

    new_favorite = Favorite.create(favorite_params)
    new_favorite.update!(user_id: user.id)
    render json: { success: "Favorite added successfully" }, status: 201
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    favorite = Favorite.find_by(id: params[:favorite_id])

    favorite.destroy
  end

  private
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title, :user_id)
  end

  def error
    render json: ErrorSerializer.new("Unauthorized user", "401").serialized_json, status: 401
  end
end