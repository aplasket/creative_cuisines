require "rails_helper"

RSpec.describe NinjaService do
  describe "get air quality" do
    it "establishes a connection to ApiNinja and returns airquality for a city", :vcr do
      params = { country: "France" }
      capital = CountryFacade.new(params[:country]).capital

      aq_data = NinjaService.new.get_air_quality(capital)

      expect(aq_data).to be_a(Hash)

      expect(aq_data).to have_key(:CO)
      expect(aq_data[:CO]).to be_a(Hash)
      expect(aq_data[:CO]).to have_key(:concentration)
      expect(aq_data[:CO][:concentration]).to be_a(Float)
      expect(aq_data[:CO]).to have_key(:aqi)
      expect(aq_data[:CO][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:NO2)
      expect(aq_data[:NO2]).to be_a(Hash)
      expect(aq_data[:NO2]).to have_key(:concentration)
      expect(aq_data[:NO2][:concentration]).to be_a(Float)
      expect(aq_data[:NO2]).to have_key(:aqi)
      expect(aq_data[:NO2][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:O3)
      expect(aq_data[:O3]).to be_a(Hash)
      expect(aq_data[:O3]).to have_key(:concentration)
      expect(aq_data[:O3][:concentration]).to be_a(Float)
      expect(aq_data[:O3]).to have_key(:aqi)
      expect(aq_data[:O3][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:SO2)
      expect(aq_data[:SO2]).to be_a(Hash)
      expect(aq_data[:SO2]).to have_key(:concentration)
      expect(aq_data[:SO2][:concentration]).to be_a(Float)
      expect(aq_data[:SO2]).to have_key(:aqi)
      expect(aq_data[:SO2][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:"PM2.5")
      expect(aq_data[:"PM2.5"]).to be_a(Hash)
      expect(aq_data[:"PM2.5"]).to have_key(:concentration)
      expect(aq_data[:"PM2.5"][:concentration]).to be_a(Float)
      expect(aq_data[:"PM2.5"]).to have_key(:aqi)
      expect(aq_data[:"PM2.5"][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:PM10)
      expect(aq_data[:PM10]).to be_a(Hash)
      expect(aq_data[:PM10]).to have_key(:concentration)
      expect(aq_data[:PM10][:concentration]).to be_a(Float)
      expect(aq_data[:PM10]).to have_key(:aqi)
      expect(aq_data[:PM10][:aqi]).to be_an(Integer)

      expect(aq_data).to have_key(:overall_aqi)
      expect(aq_data[:overall_aqi]).to be_an(Integer)
    end
  end
end