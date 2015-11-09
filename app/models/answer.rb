class Answer < ActiveRecord::Base

  belongs_to :question

  validates :content, :question_id, presence: true

end
