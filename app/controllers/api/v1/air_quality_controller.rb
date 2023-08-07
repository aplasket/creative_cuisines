class Api::V1::AirQualityController < ApplicationController
  def index
    capital = CountryFacade.new(params[:country]).capital
    # facade = AirQualityFacade.new(capital).air_quality
    binding.pry
    # render json: AirQualitySerializer.new(facade)
  end
end