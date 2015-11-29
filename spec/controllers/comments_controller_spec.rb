require 'rails_helper'

describe CommentsController do

    let(:user) { create :user }
    let(:other_user) { create :user }

    let(:question) { create(:question, user: user) }
    let!(:question_comment) { create(:comment, commentable: question) }

    let(:create_params_question) {{ comment: attributes_for(:comment), commentable: 'questions', question_id: question }}
    let(:create_params_answer) {{ comment: attributes_for(:comment), commentable: 'answers', answer_id: answer }}

    let(:create_params_question_invalid) {{ comment: attributes_for(:comment, :with_wrong_attributes), commentable: 'questions', question_id: question }}
    let(:create_params_answer_invalid) {{ comment: attributes_for(:comment, :with_wrong_attributes), commentable: 'answers', answer_id: answer }}


    let(:answer) { create(:answer, question: question, user: user) }
    let!(:answer_comment) { create(:comment, commentable: answer, user: user) }

    before {request.env["HTTP_REFERER"] = "where_i_came_from"}

    describe "POST #create" do
      before { sign_in(user) }

      describe "valid data" do
        it 'create comment question' do
          expect{ post :create, create_params_question}.to change(question.comments, :count).by(1)
        end
        it 'create comment asnwers' do
          expect{ post :create, create_params_answer}.to change(answer.comments, :count).by(1)
        end
      end

      describe "invalid data" do
        it 'tried create comment question' do
          expect{ post :create, create_params_question_invalid}.to_not change(question.comments, :count)
        end
        it 'tried create comment asnwers' do
          expect{ post :create, create_params_answer_invalid}.to_not change(answer.comments, :count)
        end
      end


    end



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
