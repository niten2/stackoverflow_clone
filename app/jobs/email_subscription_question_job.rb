class EmailSubscriptionQuestionJob < ActiveJob::Base

  def perform(question)
    question.followers.find_each do |follower|
      UserMailer.subscription_question(follower).deliver_later
    end
  end

end
