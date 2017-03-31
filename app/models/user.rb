class User < ActiveRecord::Base
  validates :provider, :uid, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false, conditions: 
                      -> { where.not(email: 'anonymous@anonymous.com') } }
	has_many :vendorCodes
	
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"] || "developer@email.com"
    end
  end
    
  def anonymize!
    unless self.nil?
      self.name = "anonymous"
      self.email = "anonymous@anonymous.com"
      self.provider = "anonymous"
      self.uid = "anonymous"
      self.save!
    end  
  end  
end
