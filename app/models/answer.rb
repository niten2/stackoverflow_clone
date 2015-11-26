class Answer < ActiveRecord::Base

  include Attachable
  include Votable

  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy

  validates :content, :question_id, :user_id, presence: true

  default_scope -> { order(best: :desc).order(created_at: :asc) }

  def make_best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best: false)
      raise ActiveRecord::Rollback unless self.update(best: true)
    end
  end

end
