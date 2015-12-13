class Question < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy



  validates :title, :content, :user_id, presence: true

  # scope, :today, -> {where: ("created_at" = "?", :today) }


end
