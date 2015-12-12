class SubscriptionQuestionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    User.subscription_question
  end
end
