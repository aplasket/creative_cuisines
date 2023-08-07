require "rails_helper"

RSpec.describe AirQualityFacade do
  describe "#air quality" do
    it "fetches air quality info from ninja service and makes objects", :vcr do
      params = {country: "Nigeria"}
      capital = CountryFacade.new(params[:country]).capital

      aq_object = AirQualityFacade.new(capital).air_quality

      expect(aq_object).to be_an(CityAir)
      expect(aq_object.aqi).to be_an(Integer)
      expect(aq_object.aqi).to eq(25)
      expect(aq_object.co_concentration).to be_a(Float)
      expect(aq_object.co_concentration).to eq(433.92)
      expect(aq_object.pm25_concentration).to be_a(Float)
      expect(aq_object.pm25_concentration).to eq(4.21)
    end
  end
end