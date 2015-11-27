class User < ActiveRecord::Base

  include UserVotable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :attachments, dependent: :destroy

  def autor_of?(object)
    object.attachable.user_id == self.id
  end

end
