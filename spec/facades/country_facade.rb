require "rails_helper"

RSpec.describe CountryFacade do
  describe "#get_country" do
    it "finds country inputted by and returns that countries name", :vcr do
      params = {country: "peru"}
      country = CountryFacade.new(params[:country]).get_country

      expect(country).to eq(params[:country])
    end

    it "returns nil if no country is inputted", :vcr do
      params = {country: ""}
      country = CountryFacade.new(params[:country]).get_country

      expect(country).to eq(nil)
    end
  end

  describe "#random_country" do
    it "finds random countries and a country name", :vcr do
      params = {country: "random_country"}
      search = CountryFacade.new(params[:country]).get_country
      country = search

      expect(country).to eq(search)
    end
  end

  describe "#get capital" do
    it "given a country, it can return the name of the capital", :vcr do
      params = {country: "France"}
      search = CountryFacade.new(params[:country]).capital(params[:country])

      expect(search).to be_a(String)
      expect(search).to eq("Paris")
    end
  end
end