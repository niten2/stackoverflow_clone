class DailyDigestJob < ActiveJob::Base
  queue_as :default

  def perform(object)
    questions = Question.all

    User.find_each do |user|
      UserMailer.daily_digest(user, questions).deliver
    end
  end

end
