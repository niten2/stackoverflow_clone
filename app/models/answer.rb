class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :content, :question_id, :user_id, presence: true

  accepts_nested_attributes_for :attachments

  default_scope -> { order(best: :desc).order(created_at: :asc) }

  def make_best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best: false)
      raise ActiveRecord::Rollback unless self.update(best: true)
    end
  end

end
