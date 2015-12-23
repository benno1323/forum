require 'rails_helper'

RSpec.describe Topic, type: :model do
	it 'is valid with a subject and body' do
		topic = create(:topic)
		expect(topic).to be_valid
	end

  it 'is not valid without a subject' do
  	topic = build(:topic, subject: nil)
  	topic.valid?
  	expect(topic.errors[:subject]).to include("can't be blank")
  end

  it 'is not valid without a body' do
  	topic = build(:topic, body: nil)
  	topic.valid?
  	expect(topic.errors[:body]).to include("can't be blank")
  end
end
