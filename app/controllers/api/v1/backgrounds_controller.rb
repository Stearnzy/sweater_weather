class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: ImageSerializer.new(ImageFacade.get_image_data(query_params[:location]))
  end

  def query_params
    params.permit(:location)
  end
end
