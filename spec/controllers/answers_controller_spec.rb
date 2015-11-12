require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:answer) { create :answer }
  let(:question) { create :question }

  describe 'GET #new' do
    before { get :new, question_id: answer.question_id }
    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it "redirect to new view" do
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do

    context 'create valid answer' do
      it 'save answer with valid parametrs' do
        expect{ post :create, question_id: question.id, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirect_to question' do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(response).to redirect_to question
      end
    end

    context 'create invalid answer' do
      it 'should not save answer with invalid parametrs' do
        expect{ post :create, question_id: question.id, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 'render new template invalid_answer' do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested answer to @answer' do
        patch :update, question_id: question.id, id: answer, answer: { content: "new content" }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes question attributes' do
        patch :update, question_id: question.id, id: answer, answer: { content: "new content" }
        answer.reload
        expect(answer.content).to eq 'new content'
      end

      it 'redirects to the updated answer' do
        patch :update, question_id: question.id, id: answer, answer: { content: "new content" }
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, question_id: question.id, id: answer, answer: { content: nil } }
      it 'does not change answer attributes' do
        answer.reload
        expect(answer.content).to eq answer.content
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #destroy' do
    it "deletes answer" do
      create(:answer)
      expect { delete :destroy, question_id: answer.question_id, id: answer.id }.to change(Answer, :count).by(0)
    end

    it 'redirect to question view' do
      delete :destroy, question_id: answer.question_id, id: answer.id
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
