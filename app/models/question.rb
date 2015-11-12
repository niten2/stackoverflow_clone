class Question < ActiveRecord::Base

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :content, presence: true

  # def have_current_user?
  #   self.user == current_user
  # end
end
