require 'rails_helper'

RSpec.describe Topic, type: :model do
  before(:all) do
    @topic = build(:topic)
  end

	it 'is valid with a subject and body' do
		expect(@topic).to be_valid
	end

  it 'is not valid without a subject' do
  	@topic.subject = nil
  	@topic.valid?
  	expect(@topic.errors[:subject]).to include("can't be blank")
  end

  it 'is not valid without a body' do
  	@topic.body = nil
  	@topic.valid?
  	expect(@topic.errors[:body]).to include("can't be blank")
  end
end