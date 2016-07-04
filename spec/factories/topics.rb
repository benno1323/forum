FactoryGirl.define do
	factory :topic do
		association :category
		association :user
		subject { Faker::Lorem.sentence }
		body { Faker::Lorem.sentences(3).join(' ') }

		factory :topic_with_comments do
      transient do
      	comments_count 5
      end

      after(:create) do |topic, evaluator|
      	create_list(:comment, evaluator.comments_count, topic: topic)
      end
    end
  end
end
