require 'rails_helper'

RSpec.describe AttachmentController, type: :controller do

  describe 'DELETE #destroy' do

    let(:user) { create :user }
    let(:other_user) { create :user }

    let(:question) { create(:question, user: user) }
    let!(:question_attachment) { create(:attachment, attachable: question) }

    let(:answer) { create(:answer, user: user) }
    let!(:answer_attachment) { create(:attachment, attachable: answer) }

    before {request.env["HTTP_REFERER"] = "where_i_came_from"}

    it 'owner user delete attachment question' do
      sign_in(user)
      expect { delete :destroy, id: question_attachment }.to change(user.questions.take.attachments, :count).by(-1)
    end

    it 'owner user delete attachment answer' do
      sign_in(user)
      expect { delete :destroy, id: answer_attachment }.to change(user.answers.take.attachments, :count).by(-1)
    end

    it 'other user tried delete attachment question' do
      sign_in(other_user)
      expect { delete :destroy, id: question_attachment }.not_to change(Attachment, :count)
    end

    it 'other user tried delete attachment question' do
      sign_in(other_user)
      expect { delete :destroy, id: answer_attachment }.not_to change(Attachment, :count)
    end

    it 'redirect to back' do
      sign_in(user)
      delete :destroy, id: question_attachment
      expect(response).to redirect_to "where_i_came_from"
    end

  end

end

