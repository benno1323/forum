FactoryGirl.define do
  factory :topic do
  	association :category
  	association :user
    subject { Faker::Lorem.sentence }
		body { Faker::Lorem.sentences(3).join(' ') }
  end
end
