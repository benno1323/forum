require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with a name' do
  	category = create(:category)
  	category.valid?
  	expect(category).to be_valid
  end

  it 'is invalid without a name' do
  	category = build(:category, name: nil)
  	category.valid?
  	expect(category.errors[:name]).to include("can't be blank")
  end

  it 'has a number of topics' do
  	category = create(:category_with_topics)
  	expect(category.topics.count).to eq(5)
  end
end