class CreateRedeemifyCodes < ActiveRecord::Migration
  def change
    rename_table :provider_codes, :redeemify_codes
    end
end
