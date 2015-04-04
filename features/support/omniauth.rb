def set_omniauth(opts = {})

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
  	"provider" => :facebook,
    'uid' => "1234",
    "info" => {
      "name" => "foo"
      }
  }
end

def set_omniauth_vendor(info)

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
  	"provider" => info[:provider],
    'uid' => info[:uid],
    "info" => {
      "name" => info[:name],
      "email" => info[:email]
      }
  }

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
