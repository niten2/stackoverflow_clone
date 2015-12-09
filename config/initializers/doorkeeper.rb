Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  admin_authenticator do
    current_user.try(:admin?) || redirect_to(new_user_session_path)
  end

end
