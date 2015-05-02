class AddRemovedCodesToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :removedCodes, :integer
  end
end
