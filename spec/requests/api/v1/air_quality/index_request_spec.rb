require "rails_helper"

RSpec.describe "AirQuality Index Request" do
  describe "happy paths" do
    it "fetches airquality via country query" do
      params = {country: "Nigeria"}

      get "/api/v1/air_quality?country=#{params[:country]}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      binding.pry
      
    end
  end
end