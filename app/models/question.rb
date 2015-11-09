class Question < ActiveRecord::Base

  validates :content, :title, presence: true

  has_many :answers

end
