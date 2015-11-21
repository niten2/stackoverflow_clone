class Question < ActiveRecord::Base

  has_many :answers, dependent: :destroy
  # has_many :attachments, as: :attachmentable
  has_many :attachments
  belongs_to :user

  validates :title, :content, :user_id, presence: true

  accepts_nested_attributes_for :attachments

end
