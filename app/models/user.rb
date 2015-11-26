class User < ActiveRecord::Base

  include Votable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :attachments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def autor_of?(object)
    object.attachable.user_id == self.id
  end

end
