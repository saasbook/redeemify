class AddWebsiteToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :website, :string
  end
end
