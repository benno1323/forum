FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    role 2
  end
end