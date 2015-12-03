class RegistrationsController < Devise::RegistrationsController

  def finish_sign_up
  end

  private

  # def sign_up_params
  #   params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  # end

  # def account_update_params
  #   params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :current_password)
  # end
end
