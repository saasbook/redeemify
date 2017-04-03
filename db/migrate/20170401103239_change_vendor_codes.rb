class ChangeVendorCodes < ActiveRecord::Migration
  def change
    change_table :vendor_codes do |t|
      t.remove :vendor
    end
  end
end
