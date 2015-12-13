require 'rails_helper'

describe EmailSubscriptionQuestionJob do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  it 'send mail owner' do
    expect(UserMailer).to receive(:subscription_question).with(user).and_call_original
    EmailSubscriptionQuestionJob.perform_now(question)
  end

  # it 'send mail subscription' do
    # question.followers << other_user
    # expect(UserMailer).to receive(:subscription_question).with(user).and_call_original
    # EmailSubscriptionQuestionJob.perform_now(question)
  # end

end
