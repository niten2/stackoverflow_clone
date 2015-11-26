module Votable
  extend ActiveSupport::Concern
  included do
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

    # def klass_name_question
    #   # x = self.class.to_s.downcase
    #   "question" + self.class.to_s.downcase
    #   # return "question" + x
    # end

  end
end
