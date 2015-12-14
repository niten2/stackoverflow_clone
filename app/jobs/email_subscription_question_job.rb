class EmailSubscriptionQuestionJob < ActiveJob::Base

  def perform(question)
    question.followers.find_each do |user|
      UserMailer.subscription_question(user, question).deliver_later
      # UserMailer.subscription_question(user).deliver_later
    end
  end

end
