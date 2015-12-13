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

  def subscription!(user)
    followers << user unless subscription?(user)
  end

  def subscription?(user)
    followers.include? user
  end

  def unsubscription!(user)
    followers.delete(user) if subscription?(user)
  end

  private

  def subscription_owner
    subscription!(user)
  end

end
