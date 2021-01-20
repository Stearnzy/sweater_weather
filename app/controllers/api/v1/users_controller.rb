class Api::V1::UsersController < ApplicationController
  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    user = User.create(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: error_message(user), status: 400
    end
  end

  private

  def error_message(user)
    user.errors.messages.each do |category, error|
      return { 'error': "#{category.to_s.capitalize} #{error[0]}" }
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :api_key)
  end
end
