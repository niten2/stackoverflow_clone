class Question < ActiveRecord::Base

  include Attachable
  include Votable

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, :content, :user_id, presence: true

end
