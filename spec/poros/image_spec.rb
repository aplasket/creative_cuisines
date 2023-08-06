require "rails_helper"

RSpec.describe Image do
  it "exists and has attributes", :vcr do
    params = {country: "laos"}
    resources = ResourceFacade.new(params)

    expect(resources.country).to eq(params[:country])

    expect(resources.images).to be_an(Array)
    expect(resources.images.first).to be_an(Image)
    expect(resources.images.first.alt_tag).to be_a(String)
    expect(resources.images.first.url).to be_a(String)

    expect(resources.video).to be_a(Video)
    expect(resources.video.title).to be_a(String)
    expect(resources.video.youtube_video_id).to be_a(String)
  end
end