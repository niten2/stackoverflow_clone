class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  def autor_of?(object)
    object.attachable.user_id == self.id
  end

end
