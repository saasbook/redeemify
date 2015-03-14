class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
