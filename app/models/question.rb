class Question < ActiveRecord::Base

  has_many :answers, dependent: :destroy

  validates :content, :title, presence: true

end
