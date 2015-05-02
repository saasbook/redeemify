class AddUnclaimCodesToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :unclaimCodes, :integer
  end
end
