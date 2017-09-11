class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true
  validates :content, :user_id, presence: true

end
