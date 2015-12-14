require "rails_helper"

describe UserMailer do
  let(:user) { create(:user) }
  let(:questions) { create_list(:question, 3, created_at: Date.today - 1.day ) }
  let(:mail) { UserMailer.daily_digest(user) }

  it "renders the headers" do
    expect(mail.subject).to eq "Ежедневный список вопросов созданных за сегодня"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["from@example.com"]
  end

  it "renders the body" do
    questions.each do |question|
      expect(mail.body.encoded).to match(question.title)
    end
  end
end
