class Api::V1::MunchiesController < ApplicationController
  def index
    starting = params[:start]
    ending = params[:end_location]
    food = params[:food]

    munchie_response = MunchiesFacade.restaurant_response(starting, ending, food)
    render json: munchie_response
  end
end
