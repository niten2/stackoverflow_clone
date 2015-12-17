module UserVotable
  extend ActiveSupport::Concern
  included do

    has_many :votes, dependent: :destroy

    def vote_for(votable, value)
      vote = self.votes.new(votable: votable, value: value)
      vote.save
    end

    def unvote_for(votable)
      self.votes.where(votable: votable).delete_all
    end

    def voted_for?(votable)
      self.votes.where(votable: votable).any?
    end

    def klass_name
      self.class.to_s.downcase
    end

  end
end
