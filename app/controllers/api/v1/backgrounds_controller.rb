class Api::V1::BackgroundsController < ApplicationController
  def index
    if !query_params[:location].empty?
      render json: ImageSerializer.new(ImageFacade.get_image_data(query_params[:location]))
    else
      render json: { error: 'Entry blank, please enter in a valid location' }, status: 401
    end
  end

  def query_params
    params.permit(:location)
  end
end
