require 'rails_helper'

describe User, type: :model do

  it { should have_many(:questions) }
  it { should have_many(:answers) }

  describe 'autor_of?' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:attachment) { create(:attachment, attachable: question) }

    it 'autor_of?(object)' do
      expect(user.autor_of?(attachment)).to be_truthy
    end
  end


end
