class AddNameToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :name, :string
  end
end
