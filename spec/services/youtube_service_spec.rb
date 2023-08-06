require "rails_helper"

RSpec.describe YoutubeService do
  describe "#find_video" do
    it "establishes a connection to youtube and fetches a video based on query", :vcr do
      country = "laos"
      video = YoutubeService.new(country).find_video

      expect(video.keys.count).to eq(6)
      expect(video).to have_key(:items)
      expect(video[:items]).to be_an(Array)
      expect(video[:items][0].keys.count).to eq(4)
      expect(video[:items][0].keys).to eq([:kind, :etag, :id, :snippet])

      expect(video[:items][0]).to have_key(:id)
      expect(video[:items][0][:id].keys).to eq([:kind, :videoId])
      expect(video[:items][0][:id]).to have_key(:videoId)
      expect(video[:items][0][:id][:videoId]).to be_a(String)

      expect(video[:items][0]).to have_key(:snippet)
      expect(video[:items][0][:snippet]).to be_a(Hash)
      expect(video[:items][0][:snippet].keys.count).to eq(8)
      expect(video[:items][0][:snippet].keys).to eq([:publishedAt, :channelId, :title, :description, :thumbnails, :channelTitle, :liveBroadcastContent, :publishTime])

      expect(video[:items][0][:snippet]).to have_key(:title)
      expect(video[:items][0][:snippet][:title]).to be_a(String)
    end
  end
end