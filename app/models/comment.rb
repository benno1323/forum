class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :content, :topic_id, :user_id, presence: true

  scope :descending, -> { order(created_at: :desc) }
end
