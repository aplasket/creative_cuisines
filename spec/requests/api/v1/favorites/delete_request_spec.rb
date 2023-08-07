require "rails_helper"

RSpec.describe "delete favorite request" do
  describe "happy paths" do
    it "can delete a favorite recipe associated with a user" do
      user = User.create!(name: "dog owner", email: "email@test.com", password: "luvdogs1", password_confirmation: "luvdogs1" )
      favorite1 = Favorite.create!(recipe_title: "Recipe: Really good soup",
                                  recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                                  country: "egypt",
                                  user_id: user.id )

      favorite2 = Favorite.create!(recipe_title: "Fried Rice",
                                  recipe_link: "https://www.tastingtable.com/.....",
                                  country: "thailand",
                                  user_id: user.id )
      params = {
        api_key: user.api_key,
        favorite_id: favorite1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      delete "/api/v1/favorites", headers: headers, params: JSON.generate(params)

      expect(response).to be_successful
      expect{Favorite.find(favorite1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end