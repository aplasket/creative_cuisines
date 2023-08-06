require "rails_helper"

RSpec.describe Image do
  it "exists and has attributes", :vcr do
    params = {country: "laos"}
    resources = ResourceFacade.new(params)

    expect(resources.images).to be_an(Array)
    expect(resources.images.first).to be_an(Image)
    expect(resources.images.first.alt_tag).to be_a(String)
    expect(resources.images.first.url).to be_a(String)
  end
end