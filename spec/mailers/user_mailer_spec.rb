require "rails_helper"

describe UserMailer do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:mail) { UserMailer.subscription_question(user, question) }

  it "renders the headers" do
    expect(mail.subject).to eq "На вопрос, который вы подписались ответили"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["from@example.com"]
  end

  it "renders the body question.title" do
    # expect(mail.body.encoded).to match(question.title)
  end

end
