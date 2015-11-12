class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :user

  validates :content, :question_id, presence: true

end
