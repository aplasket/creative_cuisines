require "rails_helper"

RSpec.describe "Favorites index request" do
  describe "happy paths" do
    it "get all of a users favorites" do
      user = User.create!(name: "dog owner", email: "email@test.com", password: "luvdogs1", password_confirmation: "luvdogs1" )

      get "/api/v1/favorites?api_key=#{user.api_key}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      fav_data = JSON.parse(response.body, symbolize_names: true)
      binding.pry
    end
  end

end