module Commentable

  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :destroy

    def klass_name
      self.class.to_s.downcase
    end
  end

end
