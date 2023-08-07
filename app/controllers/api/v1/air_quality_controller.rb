class Api::V1::AirQualityController < ApplicationController
  def index
    capital = CountryFacade.new(params[:country]).capital
    if capital.nil?
      render json: { error: "invalid country or country does not have a capital" }, status: 400
    else
      facade = AirQualityFacade.new(capital).air_quality
      render json: AirQualitySerializer.new(facade, capital).serialized_json
    end
  end
end