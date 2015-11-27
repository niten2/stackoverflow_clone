class SessionsController < Devise::SessionsController

  after_filter :clear_sign_signout_flash, :only => [:create, :destroy]

  def create
    self.resource = warden.authenticate!(auth_options)
    flash[:notice] = "Вы успешно вошли." if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

protected

  def clear_sign_signout_flash
    if flash.keys.include?(:notice)
      flash.delete(:notice)
    end
  end
end
