every 1.days do
  runner "DailyDigestJob.perform_later"
end

every 60.minutes do
  rake "ts:index"
end
