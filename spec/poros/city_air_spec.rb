require "rails_helper"

RSpec.describe CityAir do
  it "exists and has attributes", :vcr do
    params = {country: "cuba"}
    capital = CountryFacade.new(params[:country]).capital
    object_data = AirQualityFacade.new(capital).air_quality

    expect(object_data).to be_a(CityAir)
    expect(object_data.aqi).to be_an(Integer)
    expect(object_data.co_concentration).to be_a(Float)
    expect(object_data.pm25_concentration).to be_a(Float)
  end
end