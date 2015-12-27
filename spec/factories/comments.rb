FactoryGirl.define do
  factory :comment do
  	association :topic
    content "MyText"
  end

end
