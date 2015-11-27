require 'rails_helper'

describe AnswersController do

  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let!(:answer) { create :answer, question: question, user: user }

  let(:other_user) { create :user }
  let(:other_question) { create :question }
  let!(:other_answer_in_other_question) { create :answer, question: other_question, user: other_user }
  let!(:other_answer_in_question) { create :answer, question: question, user: other_user }

  before { sign_in(user) }

  describe "PATCH make_best" do
    it "have_http_status(:ok)" do
      patch :make_best, id: answer, question_id: question.id, format: :js
      expect(response).to have_http_status(:ok)
    end

    it "owner question check best answer" do
      patch :make_best, id: answer, format: :js
      expect(assigns(:answer).best).to be_truthy
    end

    it "user tried other question check best answer" do
      sign_in(other_user)
      patch :make_best, id: answer, format: :js
      expect(assigns(:answer).best).to be_falsey
    end
  end

  describe 'POST create' do
    context 'create valid answer' do
      it 'save answer with valid parametrs' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'create invalid answer' do
      it 'should not save answer with invalid parametrs' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to change(question.answers, :count).by(0)
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested answer to @answer' do
        patch :update, question_id: question.id, id: answer, answer: { content: "new content" }, format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'changes question attributes' do
        patch :update, question_id: question.id, id: answer, answer: { content: "new content" }, format: :js
        answer.reload
        expect(answer.content).to eq 'new content'
      end
    end

    context 'invalid attributes' do
      before { patch :update, question_id: question.id, id: answer, answer: { content: nil }, format: :js }
      it 'does not change answer attributes' do
        answer.reload
        expect(answer.content).to eq answer.content
      end
    end
  end

  describe 'DELETE #destroy' do

    it 'status: :ok' do
      delete :destroy, question_id: answer.question_id, id: answer.id, format: :js
      expect(response).to have_http_status(:ok)
    end

    it "owner question deletes your answer in question" do
      expect { delete :destroy, id: answer.id, format: :js }.to change(Answer, :count).by(-1)
    end

    it "owner question deletes other_answer in question" do
      expect { delete :destroy, id: other_answer_in_question, format: :js }.to change(Answer, :count).by(-1)
    end

    it "other_user owner answer deletes your answer in question" do
      sign_in(other_user)
      expect { delete :destroy, id: other_answer_in_other_question, format: :js }.to change(Answer, :count).by(-1)
    end

    it "other_user tried deletes other answer in other question" do
      sign_in(other_user)
      expect { delete :destroy, id: answer, format: :js }.to_not change(Answer, :count)
    end
  end
end
