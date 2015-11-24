class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:votable_type, :votable_id] }

  scope :upvotes, -> { where(value: 1) }
  scope :downvotes, -> { where(value: -1) }
  scope :rating, -> { sum(:value)}
end
