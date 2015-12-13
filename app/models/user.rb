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

  # def send_daily_digest
  #   Question.today
  # end

  # def self.send_answer_owner_question(object)
  #   user = object.question.user
  #   question = object.question
  #   answer = object
  #   UserMailer.new_answer_owner_question(user, question, answer).deliver_later
  # end

  # def subscription_question
  # end


end
