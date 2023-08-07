class Api::V1::AirQualityController < ApplicationController
  def index
    capital = CountryFacade.new(params[:country]).capital
    return error unless capital

    facade = AirQualityFacade.new(capital).air_quality
    render json: AirQualitySerializer.new(facade, capital).serialized_json
  end

  private

  def error
    render json: ErrorSerializer.new("Country or Capital Not Found", "404").serialized_json, status: 404
  end
end