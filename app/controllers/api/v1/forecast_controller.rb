class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.get_weather_report(query_params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  def query_params
    params.permit(:location)
  end
end
