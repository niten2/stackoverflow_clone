require 'rails_helper'

describe 'Questions API' do

  describe 'GET /index' do
    it_behaves_like "API Authenticable"
    context 'authorized', :lurker do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path("questions")
      end
    end
  end

  describe 'GET /show' do
    it_behaves_like "API Authenticable"
    let(:access_token) { create(:access_token) }
    let(:question) { create(:question) }

    context 'authorized', :lurker do
      let!(:answer) { create(:answer, question: question) }
      let!(:comment_question) { create(:comment, commentable: question) }
      let!(:attachment_question) { create(:attachment, attachable: question) }

      before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end
    end
  end

  describe 'GET /create' do
    it_behaves_like "API Authenticable"
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      context 'with valid attributes', :lurker do
        it 'creates a new question' do
          expect { post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token }.to change(me.questions, :count).by(1)
        end

        it 'returns success code ' do
          post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token
          expect(response).to be_success
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new question' do
          expect { post "/api/v1/questions/", question: attributes_for(:invalid_question), format: :json, access_token: access_token.token }.to_not change(Question, :count)
        end

        it 'returns 422 code' do
          post "/api/v1/questions/", question: attributes_for(:invalid_question), format: :json, access_token: access_token.token
          expect(response.status).to eq 422
        end
      end
    end
  end

  def do_request(options = {})
    get '/api/v1/profiles/me', { format: :json }.merge(options)
  end
end

