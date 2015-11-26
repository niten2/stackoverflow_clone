require 'rails_helper'

describe User, type: :model do

  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:attachments) }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:attachment) { create(:attachment, attachable: question) }

  it 'autor_of?(object)' do
    expect(user.autor_of?(attachment)).to be_truthy
  end

  describe '#upvote_for' do
    it 'upvote 1' do
      expect{ user.vote_for(question, 1) }.to change(question.votes.upvotes, :count).by(1)
    end

    it 'doesnt change upvote count of object' do
      user.vote_for(question, 1)
      expect{ user.vote_for(question, 1) }.to_not change(question.votes.upvotes, :count)
    end
  end

  describe '#upvote_for' do
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
end
