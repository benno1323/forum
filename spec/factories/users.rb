FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    role 0

    factory :admin do
    	role 2
    end
  end
end
