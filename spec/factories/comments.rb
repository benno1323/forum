FactoryGirl.define do
  factory :comment do
  	association :topic
  	association :user
    content "MyText"
  end

end
