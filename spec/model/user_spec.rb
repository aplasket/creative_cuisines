require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  before(:each) do
    @user = User.create!(name: "super-doggo", email: "good_dog@ruffruff.com", password: "treats123", password_confirmation: "treats123" )
  end

  describe "#has secure password" do
    it { should have_secure_password }

    it "doesn't save passwords to the db" do
      expect(@user.password_digest).to_not eq(nil)
      expect(@user.password_digest).to_not eq("treats123")
    end
  end

  describe "#has secure token" do
    it { should have_secure_token :api_key }

    it "creates an api_key for each user" do
      expect(@user.api_key.length).to eq(32)
      expect(@user.api_key).to be_a(String)
    end
  end
end