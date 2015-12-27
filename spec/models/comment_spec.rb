require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with a content and topic id' do
  	comment = create(:comment)
  	comment.valid?
  	expect(comment).to be_valid
  end

  it 'is invalid without a content' do
  	comment = build(:comment, content: nil)
  	comment.valid?
  	expect(comment.errors[:content]).to include("can't be blank")
  end

  it 'is invalid withou a topic id' do
  	comment = build(:comment, topic_id: nil)
  	comment.valid?
  	expect(comment.errors[:topic_id]).to include("can't be blank")
  end
end
