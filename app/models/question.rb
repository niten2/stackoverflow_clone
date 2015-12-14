class Question < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :followers, through: :subscriptions, source: :user

  validates :title, :content, :user_id, presence: true
  after_create :subscription_owner

  scope :created_yesterday, -> { where(created_at: (Date.today - 1.day)..Date.today) }

  def subscribe!(user)
    followers << user unless subscribe?(user)
  end

  def subscribe?(user)
    followers.include? user
  end

  def unsubscribe!(user)
    followers.delete(user) if subscribe?(user)
  end

  private

  def subscription_owner
    subscribe!(user)
  end

end
