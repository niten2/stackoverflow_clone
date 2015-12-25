class Answer < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :question, touch: true
  belongs_to :user
  validates :content, :question_id, :user_id, presence: true
  after_commit :send_email_subscription_question
  default_scope -> { order(best: :desc).order(created_at: :asc) }


  def make_best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best: false)
      raise ActiveRecord::Rollback unless self.update(best: true)
    end
  end

  private

  def send_email_subscription_question
    EmailSubscriptionQuestionJob.perform_later(question)
  end

end
