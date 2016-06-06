FactoryGirl.define do
  factory :category do
    association :user
    name "MyString"

    factory :category_with_topics do
    	transient do
    		topics_count 5
    	end

    	after(:create) do |category, evaluator|
    		FactoryGirl.create_list(:topic, evaluator.topics_count, category: category)
    	end
    end
  end
end
