module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable, dependent: :destroy

    def klass_name
      self.class.to_s.downcase
    end

  end
end
