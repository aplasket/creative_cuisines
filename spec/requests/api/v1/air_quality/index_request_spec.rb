require "rails_helper"

RSpec.describe "AirQuality Index Request" do
  describe "happy paths" do
    it "fetches airquality via country query", :vcr do
      params = {country: "Nigeria"}

      get "/api/v1/air_quality?country=#{params[:country]}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      aq_data = JSON.parse(response.body, symbolize_names: true)

      expect(aq_data).to have_key(:data)
      expect(aq_data[:data]).to be_a(Hash)
      expect(aq_data[:data]).to have_key(:id)
      expect(aq_data[:data][:id]).to eq(nil)

      expect(aq_data[:data]).to have_key(:type)
      expect(aq_data[:data][:type]).to be_a(String)
      expect(aq_data[:data][:type]).to eq("air_quality")

      expect(aq_data[:data]).to have_key(:city)
      expect(aq_data[:data][:city]).to be_a(String)
      expect(aq_data[:data][:city]).to eq("Abuja")

      expect(aq_data[:data]).to have_key(:attributes)
      expect(aq_data[:data][:attributes]).to be_a(Hash)
      expect(aq_data[:data][:attributes]).to have_key(:aqi)
      expect(aq_data[:data][:attributes][:aqi]).to be_an(Integer)

      expect(aq_data[:data][:attributes]).to have_key(:pm25_concentration)
      expect(aq_data[:data][:attributes][:pm25_concentration]).to be_a(Float)

      expect(aq_data[:data][:attributes]).to have_key(:co_concentration)
      expect(aq_data[:data][:attributes][:co_concentration]).to be_a(Float)

      expect(aq_data[:data][:attributes]).to_not have_key(:NO2)
      expect(aq_data[:data][:attributes]).to_not have_key(:O3)
      expect(aq_data[:data][:attributes]).to_not have_key(:SO2)
      expect(aq_data[:data][:attributes]).to_not have_key(:PM10)
      expect(aq_data[:data][:attributes]).to_not have_key(:CO)
      expect(aq_data[:data][:attributes]).to_not have_key(:"PM2.5")
      expect(aq_data[:data][:attributes]).to_not have_key(:overall_aqi)
    end

    it "fetchs airquality for a random country", :vcr do
      params = {country: "random_country"}
      country = CountryFacade.new(params[:country]).get_country

      get "/api/v1/air_quality?country=#{country}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      aq_data = JSON.parse(response.body, symbolize_names: true)

      expect(aq_data).to have_key(:data)
      expect(aq_data[:data]).to be_a(Hash)
      expect(aq_data[:data]).to have_key(:id)
      expect(aq_data[:data][:id]).to eq(nil)

      expect(aq_data[:data]).to have_key(:type)
      expect(aq_data[:data][:type]).to be_a(String)
      expect(aq_data[:data][:type]).to eq("air_quality")

      expect(aq_data[:data]).to have_key(:city)
      expect(aq_data[:data][:city]).to be_a(String)

      expect(aq_data[:data]).to have_key(:attributes)
      expect(aq_data[:data][:attributes]).to be_a(Hash)
      expect(aq_data[:data][:attributes]).to have_key(:aqi)
      expect(aq_data[:data][:attributes][:aqi]).to be_an(Integer)

      expect(aq_data[:data][:attributes]).to have_key(:pm25_concentration)
      expect(aq_data[:data][:attributes][:pm25_concentration]).to be_a(Float)

      expect(aq_data[:data][:attributes]).to have_key(:co_concentration)
      expect(aq_data[:data][:attributes][:co_concentration]).to be_a(Float)
    end
  end

  describe "sad paths" do
    it "returns error message if country is invalid", :vcr do
      params = {country: "Fnce"}

      get "/api/v1/air_quality?country=#{params[:country]}"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true )
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors][0]).to have_key(:status)
      expect(data[:errors][0][:status]).to eq("404")

      expect(data[:errors][0]).to have_key(:title)
      expect(data[:errors][0][:title]).to eq("Country or Capital Not Found")
  end
  end
end