class DailyDigestJob < ActiveJob::Base

  def perform
    User.find_each do |user|
      UserMailer.daily_digest(user).deliver_later
    end
  end

end
