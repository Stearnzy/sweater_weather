class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: { error: 'Invalid email or password' }, status: 400
    end
  end

  def login_params
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
