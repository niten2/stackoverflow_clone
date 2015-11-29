require 'rails_helper'

describe CommentsController do

    let(:user) { create :user }
    let(:other_user) { create :user }

    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }

    let!(:question_comment) { create(:comment, commentable: question) }
    let!(:answer_comment) { create(:comment, commentable: answer, user: user) }

    before {request.env["HTTP_REFERER"] = "where_i_came_from"}

    describe "DELETE #destroy owner user" do
      before { sign_in(user) }
      it 'owner user delete comment question' do
        expect { delete :destroy, id: question_comment }.to change(user.questions.take.comments, :count).by(-1)
      end

      it 'owner user delete comment answer' do
        expect { delete :destroy, id: answer_comment }.to change(user.answers.take.comments, :count).by(-1)
      end

      it 'redirect to back' do
        delete :destroy, id: question_comment
        expect(response).to redirect_to "where_i_came_from"
      end
    end

    describe "DELETE #destroy other user" do
      before { sign_in(other_user) }

      it 'other user tried delete comment question' do
        expect { delete :destroy, id: question_comment }.not_to change(Comment, :count)
      end

      it 'other user tried delete comment question' do
        expect { delete :destroy, id: answer_comment }.not_to change(Comment, :count)
      end
    end
end
