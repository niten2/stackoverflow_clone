module Commentable
  extend ActiveSupport::Concern
  included do
    has_many :comments, as: :commentable, dependent: :destroy
    accepts_nested_attributes_for :comments, reject_if: lambda { |a| a[:content].blank? }, allow_destroy: true

    def klass_name
      self.class.to_s.downcase
    end

  end
end
