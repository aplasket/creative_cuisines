require "rails_helper"

RSpec.describe "Favorites index request" do
  describe "happy paths" do
    it "get all of a users favorites" do
      user = User.create!(name: "dog owner", email: "email@test.com", password: "luvdogs1", password_confirmation: "luvdogs1" )
      favorite1 = Favorite.create(recipe_title: "Recipe: Egyptian Tomato Soup",
                                  recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                                  country: "egypt",
                                  user_id: user.id )

      favorite2 = Favorite.create(recipe_title: "Crab Fried Rice (Khaao Pad Bpu)",
                                  recipe_link: "https://www.tastingtable.com/.....",
                                  country: "thailand",
                                  user_id: user.id )

      get "/api/v1/favorites?api_key=#{user.api_key}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      fav_data = JSON.parse(response.body, symbolize_names: true)

      expect(fav_data).to have_key(:data)
      expect(fav_data[:data]).to be_an(Array)

      expect(fav_data[:data][0]).to have_key(:id)
      expect(fav_data[:data][0][:id]).to eq(nil)

      expect(fav_data[:data][0]).to have_key(:type)
      expect(fav_data[:data][0][:type]).to be_a(String)
      expect(fav_data[:data][0][:type]).to eq("favorite")

      expect(fav_data[:data][0]).to have_key(:attributes)
      expect(fav_data[:data][0][:attributes]).to be_a(Hash)
      expect(fav_data[:data][0][:attributes]).to have_key(:country)
      expect(fav_data[:data][0][:attributes][:country]).to be_a(String)

      expect(fav_data[:data][0][:attributes]).to have_key(:recipe_link)
      expect(fav_data[:data][0][:attributes][:recipe_link]).to be_a(String)

      expect(fav_data[:data][0][:attributes]).to have_key(:recipe_title)
      expect(fav_data[:data][0][:attributes][:recipe_title]).to be_a(String)

      expect(fav_data[:data][0][:attributes]).to have_key(:created_at)
      expect(fav_data[:data][0][:attributes][:created_at]).to be_a(String)
    end
  end

  describe "sad paths" do
    it "returns error for invalid api key" do
      user = User.create!(name: "dog owner", email: "email@test.com", password: "luvdogs1", password_confirmation: "luvdogs1" )
      favorite1 = Favorite.create(recipe_title: "Recipe: Egyptian Tomato Soup",
                                  recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                                  country: "egypt",
                                  user_id: user.id )

      favorite2 = Favorite.create(recipe_title: "Crab Fried Rice (Khaao Pad Bpu)",
                                  recipe_link: "https://www.tastingtable.com/.....",
                                  country: "thailand",
                                  user_id: user.id )

      get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h42930182"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      fav_data = JSON.parse(response.body, symbolize_names: true)

      expect(fav_data).to have_key(:error)
      expect(fav_data[:error]).to be_a(String)
      expect(fav_data[:error]).to eq("invalid credentials")
    end
  end
end