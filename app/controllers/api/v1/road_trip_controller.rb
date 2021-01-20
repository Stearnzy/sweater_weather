class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      render json: RoadTripSerializer.new(RoadTripFacade.new_road_trip(road_trip_params[:origin],
                                                                       road_trip_params[:destination]))
    else
      render json: { error: 'Invalid Api Key' }, status: 401
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
