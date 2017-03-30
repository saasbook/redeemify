def set_omniauth(opts = {})
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
  	:provider => :google,
    :uid => "12345",
    :info => {
      :name => "name",
      :email => "test@domain.com"
    }
  })
end

def set_omniauth_vendor(info)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  	:provider => info[:provider],
    :uid => info[:uid],
    :info => {
      :name => info[:name],
      :email => info[:email]
    }
  })
end

def set_omniauth_provider(info)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:amazon] = OmniAuth::AuthHash.new({
    :provider => info[:provider],
    :uid => info[:uid],
    :info => {
      :name => info[:name],
      :email => info[:email]
    }
  })
end

def set_invalid_omniauth(opts = {})
  credentials = { :provider => :facebook,
                  :invalid  => :invalid_crendentials
                }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

end

def disable_test_omniauth()
	OmniAuth.config.test_mode = false
end
