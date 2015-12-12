class Answer < ActiveRecord::Base

  include Attachable
  include Commentable
  include Votable

  belongs_to :question
  belongs_to :user

  validates :content, :question_id, :user_id, presence: true

  default_scope -> { order(best: :desc).order(created_at: :asc) }

  after_create :send_email_owner

  def make_best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best: false)
      raise ActiveRecord::Rollback unless self.update(best: true)
    end
  end


  private

  def send_email_owner
    # binding.pry
    user = self.question.user
    question = self.question
    answer = self
    UserMailer.new_answer_owner_question(user, question, answer).deliver_later
  end



end
