class EmailOwnerQuestionJob < ActiveJob::Base
  queue_as :default

  def perform(object)
    answer = object
    question = answer.question
    user = answer.question.user
    UserMailer.owner_question(user, question, answer).deliver_later
  end
end
