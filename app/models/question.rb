class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable

  validates :title, :content, :user_id, presence: true

  accepts_nested_attributes_for :attachments

end
