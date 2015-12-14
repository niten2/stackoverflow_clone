require 'rails_helper'

describe EmailSubscriptionQuestionJob do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  it 'send mail owner' do
    expect(UserMailer).to receive(:subscription_question).with(user, question).and_call_original
    EmailSubscriptionQuestionJob.perform_now(question)
  end

  it 'send mail subscription' do
    users = create_list(:user, 3)
    users_question = create(:question)
    users_question.followers.clear
    users.each do |user|
      users_question.subscribe! user
    end
    users.each do |user|
      expect(UserMailer).to receive(:subscription_question).with(user, users_question).and_call_original
    end
    EmailSubscriptionQuestionJob.perform_now(users_question)
  end

end
