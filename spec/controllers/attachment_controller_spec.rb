require 'rails_helper'

RSpec.describe AttachmentController, type: :controller do

  describe 'DELETE #destroy' do

    let(:user) { create :user }
    let(:question) { create(:question) }
    let!(:attachment) { create(:attachment, attachable: question) }
    before {request.env["HTTP_REFERER"] = "where_i_came_from"}
    before { sign_in(user) }

    it 'deletes attachment' do
      expect { delete :destroy, id: attachment }.to change(Attachment, :count).by(-1)
    end

    it 'redirect to back' do
      delete :destroy, id: attachment
      expect(response).to redirect_to "where_i_came_from"
    end

  end

end

