require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should belong_to(:question) }
  it { should belong_to(:user) }

  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many :attachments }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:question_id) }
  it { should validate_presence_of(:user_id) }

  it { should accept_nested_attributes_for :attachments }
  it { should accept_nested_attributes_for :comments }

  describe 'default_scope' do
    let(:question) { create(:question) }
    let(:best_answer) { create(:answer, question: question) }

    it 'shows best answer first' do
      best_answer.make_best
      expect(question.answers.first).to eq best_answer
    end
  end

  describe 'make_best response true' do

    let(:answer) { create(:answer) }

    it 'sets #best to true' do
      answer.make_best
      expect(answer.best).to be_truthy
    end

    let(:answers) { create_list(:answer, 5) }

    it 'sets #best to all other answers to false' do
      answers.first.make_best
      answers.shift
      answers.each do |answer|
        expect(answer.best).to be_falsey
      end
    end
  end

end

