require 'rails_helper'

RSpec.describe Comment, type: :model do

  before(:all) do
    @comment = build(:comment)
  end

  it 'is valid with a content, topic id and user_id' do
  	expect(@comment).to be_valid
  end

  it 'is invalid without a content' do
    @comment.content = nil
    @comment.valid?
  	expect(@comment.errors[:content]).to include("can't be blank")
  end

  it 'is invalid withou a topic_id' do
    @comment.topic_id = nil
    @comment.valid?
  	expect(@comment.errors[:topic_id]).to include("can't be blank")
  end

  it 'is invalid without a user_id' do
    @comment.user_id = nil
    @comment.valid?
    expect(@comment.errors[:user_id]).to include("can't be blank")
  end
end
