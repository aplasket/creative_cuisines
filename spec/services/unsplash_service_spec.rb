require "rails_helper"

RSpec.describe UnsplashService do
  describe "#find_images" do
    it "establishes a connection to unsplash and fetches images based on query", :vcr do
      country = "laos"
      images = UnsplashService.new(country).find_images

      expect(images).to have_key(:results)
      expect(images[:results]).to be_an(Array)
      expect(images[:results][0].keys.count).to eq(21)
      expect(images[:results][0]).to have_key(:description)
      expect(images[:results][0][:description]).to be_a(String)

      expect(images[:results][0]).to have_key(:urls)
      expect(images[:results][0][:urls]).to be_a(Hash)
      expect(images[:results][0][:urls]).to have_key(:raw)
      expect(images[:results][0][:urls][:raw]).to be_a(String)

      expect(images[:results][0]).to have_key(:id)
      expect(images[:results][0]).to have_key(:slug)
      expect(images[:results][0]).to have_key(:created_at)
      expect(images[:results][0]).to have_key(:updated_at)
      expect(images[:results][0]).to have_key(:promoted_at)
      expect(images[:results][0]).to have_key(:width)
      expect(images[:results][0]).to have_key(:height)
      expect(images[:results][0]).to have_key(:color)
      expect(images[:results][0]).to have_key(:blur_hash)
      expect(images[:results][0]).to have_key(:alt_description)
      expect(images[:results][0]).to have_key(:breadcrumbs)
      expect(images[:results][0]).to have_key(:links)
      expect(images[:results][0]).to have_key(:likes)
      expect(images[:results][0]).to have_key(:liked_by_user)
      expect(images[:results][0]).to have_key(:current_user_collections)
      expect(images[:results][0]).to have_key(:sponsorship)
      expect(images[:results][0]).to have_key(:topic_submissions)
      expect(images[:results][0]).to have_key(:user)
      expect(images[:results][0]).to have_key(:tags)
    end
  end
end