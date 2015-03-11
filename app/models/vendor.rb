class Vendor < ActiveRecord::Base
  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |vendor|
      vendor.provider = auth["provider"]
      vendor.uid = auth["uid"]
      vendor.name = auth["info"]["name"]
      vendor.code = "12345"
    end
  end
end
