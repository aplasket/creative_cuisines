require "rails_helper"

RSpec.describe "Learning Resources Index Request" do
  describe "happy path" do
    it "requests learning resources from a specific country", :vcr do
      params = {country: "laos"}
      get "/api/v1/learning_resources?country=#{params[:country]}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:data)
      expect(data[:data].keys.count).to eq(3)

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to eq(nil)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq("learning_resource")

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to have_key(:country)
      expect(data[:data][:attributes][:country]).to be_a(String)
      expect(data[:data][:attributes][:country]).to eq(params[:country])

      expect(data[:data][:attributes]).to have_key(:video)
      expect(data[:data][:attributes][:video]).to be_a(Hash)

      expect(data[:data][:attributes][:video].keys.count).to eq(2)
      expect(data[:data][:attributes][:video]).to have_key(:title)
      expect(data[:data][:attributes][:video][:title]).to be_a(String)
      expect(data[:data][:attributes][:video]).to have_key(:youtube_video_id)
      expect(data[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

      expect(data[:data][:attributes]).to have_key(:images)
      expect(data[:data][:attributes][:images]).to be_an(Array)
      expect(data[:data][:attributes][:images].first.keys.count).to eq(2)

      expect(data[:data][:attributes][:images].first).to have_key(:alt_tag)
      expect(data[:data][:attributes][:images].first[:alt_tag]).to be_a(String)

      expect(data[:data][:attributes][:images].first).to have_key(:url)
      expect(data[:data][:attributes][:images].first[:url]).to be_a(String)
    end
  end

  describe "sad path" do
    it "if no videos or images are found, those keys point to an empty object", :vcr do
      params = {country: "qz_"}
      get "/api/v1/learning_resources?country=#{params[:country]}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:data)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to eq(nil)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq("learning_resource")

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to have_key(:country)
      expect(data[:data][:attributes][:country]).to eq(params[:country])

      expect(data[:data][:attributes]).to have_key(:video)
      expect(data[:data][:attributes][:video]).to be_a(Hash)
      expect(data[:data][:attributes][:video]).to eq({})

      expect(data[:data][:attributes]).to have_key(:images)
      expect(data[:data][:attributes][:images]).to be_an(Array)
      expect(data[:data][:attributes][:images]).to eq([])
    end
  end
end