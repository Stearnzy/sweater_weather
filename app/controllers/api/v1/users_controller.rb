class Api::V1::UsersController < ApplicationController
  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    user = User.create(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { error: 'User create failed' }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :api_key)
  end
end
