module Omniauthable
  extend ActiveSupport::Concern
  included do

    def self.find_for_oauth(auth)
      authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
      return authorization.user if authorization

      if auth.info.try(:email)
        email = auth.info[:email]
      else
        return false
      end

      user = User.where(email: email).first

      if user
        user.create_authorization(auth)
      else
        password = Devise.friendly_token[0, 20]
        user = User.new(email: email, password: password, password_confirmation: password)
        if user.valid?
          user.save!
          user.create_authorization(auth)
        else
          return false
        end
      end

      user
    end

    def create_authorization(auth)
      self.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
  end

end
