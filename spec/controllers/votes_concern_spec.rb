require 'rails_helper'

describe QuestionsController do
  let(:user) { create :user }
  let(:answer) { create :answer, user: user }
  let(:question) { create :question, user: user }
  before { sign_in(user) }

  describe 'PATCH #upvote' do
    it 'renders question/vote.json.jbuilder' do
      patch :upvote, id: question, format: :json
      expect(response).to render_template :vote
    end

    it 'save upvote' do
      expect { patch :upvote, id: question, format: :json }.to change(question.votes.upvotes, :count).by 1
    end

    it 'delete upvote' do
      expect { patch :upvote, id: question, format: :json }.to change(question.votes.upvotes, :count).by 1
      expect { patch :unvote, id: question, format: :json }.to change(question.votes.upvotes, :count).by -1
    end
  end

  describe 'PATCH #downvote' do
    it 'renders question/vote.json.jbuilder' do
      patch :downvote, id: question, format: :json
      expect(response).to render_template :vote
    end

    it 'save downvote' do
      expect { patch :downvote, id: question, format: :json }.to change(question.votes.downvotes, :count).by 1
    end

    it 'delete downvote' do
      expect { patch :downvote, id: question, format: :json }.to change(question.votes.downvotes, :count).by 1
      expect { patch :unvote, id: question, format: :json }.to change(question.votes.downvotes, :count).by -1
    end
  end

  describe 'PATCH #unvote' do
    it 'renders question/vote.json.jbuilder' do
      patch :unvote, id: question, format: :json
      expect(response).to render_template :vote
    end
  end
end

describe AnswersController do
    let(:user) { create :user }
    let(:answer) { create :answer, user: user }
    let(:question) { create :question, user: user }
    before { sign_in(user) }

  describe 'PATCH #upvote' do
    it 'renders answer/vote.json.jbuilder' do
      patch :upvote, id: answer, format: :json
      expect(response).to render_template :vote
    end

    it 'save upvote' do
      expect { patch :upvote, id: answer, format: :json }.to change(answer.votes.upvotes, :count).by 1
    end

    it 'delete upvote' do
      expect { patch :upvote, id: answer, format: :json }.to change(answer.votes.upvotes, :count).by 1
      expect { patch :unvote, id: answer, format: :json }.to change(answer.votes.upvotes, :count).by -1
    end
  end

  describe 'PATCH #downvote' do
    it 'renders answer/vote.json.jbuilder' do
      patch :downvote, id: answer, format: :json
      expect(response).to render_template :vote
    end

    it 'save downvote' do
      expect { patch :downvote, id: answer, format: :json }.to change(answer.votes.downvotes, :count).by 1
    end

    it 'delete  downvote' do
      expect { patch :downvote, id: answer, format: :json }.to change(answer.votes.downvotes, :count).by 1
      expect { patch :unvote, id: answer, format: :json }.to change(answer.votes.downvotes, :count).by -1
    end
  end

  describe 'PATCH #unvote' do
    it 'renders answer/vote' do
      patch :unvote, id: answer, format: :json
      expect(response).to render_template :vote
    end
  end
end
