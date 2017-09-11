class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :oauth

  def facebook
  end

  def twitter
    # NOTE redirect_to controller: :questions, action: :index
  end

  def finish_sign_up
  end

  private

  def oauth
    @user = User.find_for_oauth(auth)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{action_name}".capitalize) if is_navigational_format?
    else
      flash[:notice] = 'Для завершения регистрации введите E-mail'
      render 'omniauth_callbacks/prompt_email', locals: { auth: auth }
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end

end
