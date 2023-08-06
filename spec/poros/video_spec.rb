require "rails_helper"

RSpec.describe Video do
  it "exists and has attributes", :vcr do
    params = {country: "laos"}
    resources = ResourceFacade.new(params)

    expect(resources.video).to be_a(Video)
    expect(resources.video.title).to be_a(String)
    expect(resources.video.youtube_video_id).to be_a(String)
  end
end