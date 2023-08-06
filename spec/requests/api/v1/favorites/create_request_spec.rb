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

  describe "sad paths" do
    it "displays an error if api key is invalid" do
        user_params = {
          "api_key": "jgn983hy48thw9begh98h4539h4",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/.....",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
          }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/favorites", headers: headers, params: JSON.generate(user_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user).to be_a(Hash)
        expect(user).to have_key(:error)
        expect(user[:error]).to be_a(String)
        expect(user[:error]).to eq("Unauthorized user")
    end
  end
end