class ChangeVendors < ActiveRecord::Migration
  def change
    change_table :vendors do |t|
      t.rename :helpLink, :help_link
      t.rename :cashValue, :cash_value
      t.rename :uploadedCodes, :uploaded_codes
      t.rename :usedCodes, :used_codes
      t.rename :unclaimCodes, :unclaimed_codes
      t.rename :removedCodes, :removed_codes
    end
  end
end
