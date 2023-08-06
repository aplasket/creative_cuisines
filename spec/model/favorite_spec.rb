require "rails_helper"

RSpec.describe Favorite, type: :model do
  before(:each) do
    @user = User.create!(name: "bowwow", email: "sweet_dog@ruffruff.com", password: "treats123", password_confirmation: "treats123" )
    @favorite_1 = Favorite.create!(country: "thailand", recipe_link: "http://a_link.com", recipe_title: "really good recipe", user_id: @user.id )
    @favorite_2 = Favorite.create!(country: "france", recipe_link: "http://france_link.com", recipe_title: "another really good recipe", user_id: @user.id )
  end

  describe "validates presence of" do
    it { should validate_presence_of(:country) }
    it "has a country attribute" do
      expect(@favorite_1.country).to eq("thailand")
    end

    it { should validate_presence_of(:recipe_link) }

    it "has a recipe link attribute" do
      expect(@favorite_1.recipe_link).to eq("http://a_link.com")
    end

    it { should validate_presence_of(:recipe_title) }

    it "has a recipe title attribute" do
      expect(@favorite_1.recipe_title).to eq("really good recipe")
    end
  end

  describe "associations" do
    it { should belong_to(:user) }

    it "saves a favorite to a user" do
      expect(@favorite_1.user_id).to eq(@user.id)
    end
  end
end