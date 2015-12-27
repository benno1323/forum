class Comment < ActiveRecord::Base
  belongs_to :topic

  validates :content, :topic_id, presence: true
end
