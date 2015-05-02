class AddUsedCodesToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :usedCodes, :integer
  end
end
