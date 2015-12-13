class Question < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :followers, through: :subscriptions, source: :user

  validates :title, :content, :user_id, presence: true

  # scope, :today, -> {where: ("created_at" = "?", :today) }

  def subscription!(user)
    followers << user unless subscription?(user)
  end

  def subscription?(user)
    followers.include? user
  end

  def unsubscription!(user)
    followers.delete(user) if subscription?(user)
  end

end
