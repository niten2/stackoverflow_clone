class EmailSubscriptionQuestionJob < ActiveJob::Base

  def perform(question)
    question.followers.find_each do |user|
      UserMailer.subscription_question(user, question).deliver_later
    end
  end

end
