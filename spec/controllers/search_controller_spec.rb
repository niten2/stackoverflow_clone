require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  include Devise::TestHelpers

  describe "GET #search" do
    [nil, 'question', 'answer', 'comment', 'user'].each do |index_type|
      it "returns matched questions" do
        index = index_type ? Kernel.const_get(index_type.capitalize) : ThinkingSphinx
        expect(index).to receive(:search).with(anything)
        get :search, search_query: {query: 'test', index_type: index_type}
      end
    end
  end

  describe "GET #find" do
    it "status :ok" do
      get :find
      expect(response).to have_http_status(200)
    end

  end

end
