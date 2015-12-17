require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }
    let(:question_attachment) { create(:attachment, attachable: question) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :manage, Question, user: user }
    it { should be_able_to :manage, Answer, user: user }
    it { should be_able_to :manage, Comment, user: user }

    it { should be_able_to :update, Question, user: user }
    it { should be_able_to :update, Answer, user: user }
    it { should be_able_to :update, Comment, user: user }

    it { should be_able_to :manage, question_attachment, user: user }
    it { should_not be_able_to :manage, create(:attachment) }

    it { should be_able_to :make_best, answer, user: user }
    it { should_not be_able_to :make_best, create(:answer) }

    it { should be_able_to :destroy, create(:answer, question: question) }
    it { should_not be_able_to :destroy, create(:answer) }

    it { should be_able_to :destroy, create(:comment, commentable: question) }
    it { should_not be_able_to :destroy, create(:comment) }

    it { should be_able_to :vote, create(:question, user: other), user: user }
    it { should_not be_able_to :vote, create(:question, user: user), user: user }

    it { should be_able_to :vote, create(:answer, user: other), user: user }
    it { should_not be_able_to :vote, create(:answer, user: user), user: user }

    it { should be_able_to :me, user }

    it { should be_able_to :subscribe, create(:question), user: user }
    it { should_not be_able_to :subscribe, create(:question, followers: [user]), user: user }

    it { should_not be_able_to :unsubscribe, create(:question), user: user }
    it { should be_able_to :unsubscribe, create(:question, followers: [user]), user: user }
  end
end
