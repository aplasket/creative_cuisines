require "rails_helper"

RSpec.describe "Sessions Create Request" do
  describe "happy path" do
    it "logs in a user" do
      user = User.create!(name: "Ringo", email: "starr@ruffruff.com", password: "treats123", password_confirmation: "treats123" )

      user_params = {
        "email": "starr@ruffruff.com",
        "password": "treats123"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)

      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to be_a(String)
      expect(user[:data][:type]).to eq("user")

      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to have_key(:name)
      expect(user[:data][:attributes][:name]).to be_a(String)

      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)

      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)

      expect(user[:data][:attributes]).to_not have_key(:password)
      expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end

  describe "sad paths" do
    describe "happy path" do
      it "cannot log in a user with invalid credentials" do
        user = User.create!(name: "Ringo", email: "starr@ruffruff.com", password: "treats123", password_confirmation: "treats123" )

        user_params = {
          "email": "starr@ruffruff.com",
          "password": "treat123"
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user).to be_a(Hash)
        expect(user).to have_key(:errors)
        expect(user[:errors]).to be_an(Array)
        expect(user[:errors][0]).to have_key(:status)
        expect(user[:errors][0][:status]).to eq("401")

        expect(user[:errors][0]).to have_key(:title)
        expect(user[:errors][0][:title]).to eq("Unauthorized user")

        expect(user).to_not have_key(:data)
      end
    end
  end
end