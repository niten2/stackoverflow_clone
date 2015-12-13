class SubscriptionQuestionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)


    UserMailer.subscription_question(user, question, answer).deliver


  end
end
