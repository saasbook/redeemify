class AddUploadedCodesToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :uploadedCodes, :integer
  end
end
