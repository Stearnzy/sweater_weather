FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
