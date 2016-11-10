class User < ActiveRecord::Base
	has_many :vendorCodes
  validates :auth_token, uniqueness: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
end
