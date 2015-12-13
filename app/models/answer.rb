class Answer < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :question
  belongs_to :user

  validates :content, :question_id, :user_id, presence: true

  after_create :send_email_owner_question, :send_email_subscription_question

  default_scope -> { order(best: :desc).order(created_at: :asc) }


  def make_best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best: false)
      raise ActiveRecord::Rollback unless self.update(best: true)
    end
  end


  private

  def send_email_owner_question
    # EmailOwnerQuestionJob.perform_now(self)
  end

  def send_email_subscription_question
    # SubscriptionQuestionJob.perform_now(self)
  end

end
