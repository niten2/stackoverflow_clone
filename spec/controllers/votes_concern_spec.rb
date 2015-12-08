require 'rails_helper'

describe QuestionsController do
  let(:other_user) { create :user }
  let(:user) { create :user }
  let(:answer) { create :answer, user: user }
  let(:question) { create :question, user: user }

  describe 'PATCH #upvote' do
    describe "other user" do
      before { sign_in(other_user) }
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

    describe "user tried"  do
      before { sign_in(user) }
      it 'renders question/vote.json.jbuilder' do
        patch :upvote, id: question, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save upvote' do
        expect { patch :upvote, id: question, format: :json }.to_not change(question.votes.upvotes, :count)
      end

      it 'delete upvote' do
        expect { patch :upvote, id: question, format: :json }.to_not change(question.votes.upvotes, :count)
        expect { patch :unvote, id: question, format: :json }.to_not change(question.votes.upvotes, :count)
      end
    end
  end

  describe 'PATCH #downvote' do
    describe 'other_user' do
      before { sign_in(other_user) }
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

      it 'renders question/vote.json.jbuilder' do
        patch :unvote, id: question, format: :json
        expect(response).to render_template :vote
      end
    end

    describe 'user tried' do
      before { sign_in(user) }
      it 'renders question/vote.json.jbuilder' do
        patch :downvote, id: question, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save downvote' do
        expect { patch :downvote, id: question, format: :json }.to_not change(question.votes.downvotes, :count)
      end

      it 'delete downvote' do
        expect { patch :downvote, id: question, format: :json }.to_not change(question.votes.downvotes, :count)
        expect { patch :unvote, id: question, format: :json }.to_not change(question.votes.downvotes, :count)
      end

      it 'renders question/vote.json.jbuilder' do
        patch :unvote, id: question, format: :json
        expect(response).to_not render_template :vote
      end
    end
  end
end

describe AnswersController do
    let(:other_user) { create :user }
    let(:user) { create :user }
    let(:answer) { create :answer, user: user }
    let(:question) { create :question, user: user }

  describe 'PATCH #upvote' do
    describe 'other_user' do
      before { sign_in(other_user) }
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

    describe 'user tried' do
      before { sign_in(user) }
      it 'renders answer/vote.json.jbuilder' do
        patch :upvote, id: answer, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save upvote' do
        expect { patch :upvote, id: answer, format: :json }.to_not change(answer.votes.upvotes, :count)
      end

      it 'delete upvote' do
        expect { patch :upvote, id: answer, format: :json }.to_not change(answer.votes.upvotes, :count)
        expect { patch :unvote, id: answer, format: :json }.to_not change(answer.votes.upvotes, :count)
      end
    end
  end

  describe 'PATCH #downvote' do
    describe 'other_user' do
      before { sign_in(other_user) }
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

      it 'renders answer/vote' do
        patch :unvote, id: answer, format: :json
        expect(response).to render_template :vote
      end
    end

    describe 'user tried' do
      before { sign_in(user) }
      it 'renders answer/vote.json.jbuilder' do
        patch :downvote, id: answer, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save downvote' do
        expect { patch :downvote, id: answer, format: :json }.to_not change(answer.votes.downvotes, :count)
      end

      it 'delete  downvote' do
        expect { patch :downvote, id: answer, format: :json }.to_not change(answer.votes.downvotes, :count)
        expect { patch :unvote, id: answer, format: :json }.to_not change(answer.votes.downvotes, :count)
      end

      it 'renders answer/vote' do
        patch :unvote, id: answer, format: :json
        expect(response).to_not render_template :vote
      end
    end
  end
end
