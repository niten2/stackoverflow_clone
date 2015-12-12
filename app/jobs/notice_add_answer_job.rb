class NoticeAddAnswerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    User.send_notice_add_answer
  end
end
