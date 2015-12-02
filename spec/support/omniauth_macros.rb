module OmniauthMacros

  def mock_auth_hash(provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({ provider: provider.to_s, uid: '123456'
    }.merge(provider == :facebook ? { info: { email: 'test@email.com' }} : {}))
  end

  # def mock_auth_hash
  #   OmniAuth.config.mock_auth[:twitter] = {
  #     'provider' => 'twitter',
  #     'uid' => '123545',
  #     'user_info' => {
  #       'name' => 'mockuser',
  #       'image' => 'mock_user_thumbnail_url'
  #     },
  #     'credentials' => {
  #       'token' => 'mock_token',
  #       'secret' => 'mock_secret'
  #     }
  #   }
  # end

  # def mock_auth_hash
  #   OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
  #       provider: 'facebook',
  #       uid: '123456',
  #       info: {
  #           email: 'mockuser@mail.ru',
  #       },
  #   )

  #   OmniAuth.config.add_mock(:twitter, {:uid => '12345'})
  # end


end
