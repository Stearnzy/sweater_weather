class User < ApplicationRecord
  has_secure_token :api_key
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :api_key, presence: true, uniqueness: true
end
