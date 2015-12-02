require 'rails_helper'

describe User, type: :model do

  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:attachments) }
  it { should have_many(:comments) }
  it { should have_many(:authorizations) }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:attachment) { create(:attachment, attachable: question) }

  describe "#autor_of?" do

    it 'question autor_of?' do
      expect(user.autor_of?(question)).to be_truthy
    end

    it 'answer autor_of?' do
      expect(user.autor_of?(answer)).to be_truthy
    end

    it 'attachment autor_of?' do
      expect(user.autor_of?(attachment.attachable)).to be_truthy
    end
  end

  describe '#upvote_for' do
    it 'upvote 1' do
      expect{ user.vote_for(question, 1) }.to change(question.votes.upvotes, :count).by(1)
    end

    it 'doesnt change upvote count of object' do
      user.vote_for(question, 1)
      expect{ user.vote_for(question, 1) }.to_not change(question.votes.upvotes, :count)
    end

    it 'downvote 1' do
      expect{ user.vote_for(question, -1) }.to change(question.votes.downvotes, :count).by(1)
    end

    it 'doesnt change downvote count of object' do
      user.vote_for(question, 1)
      expect{ user.vote_for(question, -1) }.to_not change(question.votes.upvotes, :count)
    end
  end

  describe '#unvote_for' do
    it 'removes user vote from object' do
      user.vote_for(question, 1)
      expect{ user.unvote_for(question) }.to change(question.votes, :count).by(-1)
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
