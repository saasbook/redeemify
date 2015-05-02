class AddTotalCodesToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :totalCodes, :integer
  end
end
