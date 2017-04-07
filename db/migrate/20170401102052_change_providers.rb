class ChangeProviders < ActiveRecord::Migration
  def change
    change_table :providers do |t|
      t.string :uid
      t.rename :uploadedCodes, :uploaded_codes
      t.rename :usedCodes, :used_codes
      t.rename :unclaimCodes, :unclaimed_codes
      t.rename :removedCodes, :removed_codes
    end
  end
end
