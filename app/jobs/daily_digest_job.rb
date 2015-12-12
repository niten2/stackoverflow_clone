class DailyDigestJob < ActiveJob::Base
  queue_as :default

  # include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily(1) }

  def perform(*args)
    User.send_daily_digest
  end
end
