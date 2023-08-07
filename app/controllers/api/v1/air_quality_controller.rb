class Api::V1::AirQualityController < ApplicationController
  def index
    capital = CountryFacade.new(params[:country]).capital
    facade = AirQualityFacade.new(capital).air_quality
    render json: AirQualitySerializer.new(facade, capital).serialized_json
  end
end