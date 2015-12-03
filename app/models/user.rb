class User < ActiveRecord::Base
  include UserVotable
  include Omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :authorizations
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy

  def autor_of?(object)
    object.user_id == self.id
  end

end
