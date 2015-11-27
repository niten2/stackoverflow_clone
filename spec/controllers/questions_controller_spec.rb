require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:question) { create(:question, user: user) }
  before { sign_in(user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: question }

    it 'owner question assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end

    it "other_user tried edit question" do
      sign_out(user)
      sign_in(other_user)
      get :edit, id: question
      expect(response).to have_http_status(403)
      expect(response.body).to have_content "У вас нет прав доступах"
    end

  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)

      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, id: question, question: { title: 'new title', content: 'new content'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.content).to eq 'new content'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: question, question: { title: 'new title', content: nil} }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq question.title
        expect(question.content).to eq question.content
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end

      it "other_user tried update question" do
        sign_out(user)
        sign_in(other_user)
        get :edit, id: question
        expect(response).to have_http_status(403)
        expect(response.body).to have_content "У вас нет прав доступах"
      end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'owner deletes question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'other_user tried deletes question' do
      sign_in(other_user)
      expect { delete :destroy, id: question }.to_not change(Question, :count)
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end

    it "other_user tried destroy question" do
      sign_out(user)
      sign_in(other_user)
      get :edit, id: question
      expect(response).to have_http_status(403)
      expect(response.body).to have_content "У вас нет прав доступах"
    end
  end
end
