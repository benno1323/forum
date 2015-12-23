FactoryGirl.define do
  factory :topic do
    subject { Faker::Lorem.sentence }
		body { Faker::Lorem.sentences(3).join(' ') }
  end
end
