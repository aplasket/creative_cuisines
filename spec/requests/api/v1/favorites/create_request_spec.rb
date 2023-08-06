require "rails_helper"

RSpec.describe "Favorite Create Action Endpoint" do
  describe "happy paths" do
    it "can add recipes to a favorited list for a particular user" do
      user = User.create!(name: "Stella", email: "puppy@ruffruff.com", password: "ilovetr3@t$", password_confirmation: "ilovetr3@t$" )

      user_params = {
        "api_key": user.api_key,
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/favorites", headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a(Hash)
      expect(user).to have_key(:success)
      expect(user[:success]).to be_a(String)
      expect(user[:success]).to eq("Favorite added successfully")
    end
  end
end