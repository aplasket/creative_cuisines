class Api::V1::LearningResourcesController < ApplicationController
  def index
    facade = ResourceFacade.new(params)
    render json: ResourceSerializer.new(facade)
  end
end