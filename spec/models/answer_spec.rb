require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let!(:answers) { create_list(:answer, 5, question: question, best: true) }

  it { should belong_to(:question) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:question_id) }
  it { should validate_presence_of(:user_id) }

  describe 'default_scope' do
    let!(:best_answer) { create(:answer, question: question) }

    it 'shows best answer first' do
      best_answer.make_best
      question.answers.reload
      expect(question.answers.first).to eq best_answer
    end
  end

  describe 'make_best response true' do
    it 'sets #best to true' do
      answer.make_best
      answer.reload
      expect(answer).to be_truthy
    end

    it 'sets #best to all other answers to false' do
      answer.make_best
      answers.each do |answer|
        answer.reload
        expect(answer.best).to be_falsey
      end
    end
  end

end

