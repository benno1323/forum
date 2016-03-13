FactoryGirl.define do
  factory :topic do
  	association :category
    subject { Faker::Lorem.sentence }
		body { Faker::Lorem.sentences(3).join(' ') }
  end
end
