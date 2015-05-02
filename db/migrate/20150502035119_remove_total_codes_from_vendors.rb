class RemoveTotalCodesFromVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :totalCodes
  end

  def down
    add_column :vendors, :totalCodes, :integer
  end
end
