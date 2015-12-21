require 'rails_helper'

describe DailyDigestJob do

  let!(:user) { create(:user) }
  let!(:questions) { create_list(:question, 2, user: user) }

  it 'sends daily digest' do
    expect(UserMailer).to receive(:daily_digest).and_call_original
    DailyDigestJob.perform_now
  end

end
