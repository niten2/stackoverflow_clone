require 'rails_helper'

describe 'Answer API' do

  describe 'GET /index' do
    it_behaves_like "API Authenticable"
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    context 'authorized', :lurker do
      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'included in answer object' do
        expect(response.body).to have_json_size(1).at_path("answers")
      end
    end
  end

  describe 'GET /show' do
    it_behaves_like "API Authenticable"
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    context 'authorized', :lurker do
      let!(:comment_answer) { create(:comment, commentable: answer) }
      let!(:attachment_answer) { create(:attachment, attachable: answer) }

      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

    end
  end

  describe 'GET /create' do
    it_behaves_like "API Authenticable"
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    context 'authorized' do
      context 'with valid attributes', :lurker do
        it 'creates a new question' do
          expect { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json, access_token: access_token.token }.to change(me.answers, :count).by(1)
        end
        it 'returns success code ' do
          post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json, access_token: access_token.token
          expect(response).to be_success
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new question' do
          expect { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:invalid_answer), format: :json, access_token: access_token.token }.to_not change(Answer, :count)
        end
        it 'returns 422 code' do
          post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:invalid_answer), format: :json, access_token: access_token.token
          expect(response.status).to eq 422
        end
      end
    end
  end
  def do_request(options = {})
    get '/api/v1/profiles/me', { format: :json }.merge(options)
  end
end
