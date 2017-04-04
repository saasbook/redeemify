class ChangeVendorsCashValue < ActiveRecord::Migration
  def up
    change_table :vendors do |t|
      t.change :cash_value,
        'DECIMAL(5,2) USING CAST(cash_value AS DECIMAL(5,2))', default: 0
    end
  end
  
  def down
    change_table :vendors do |t|
      t.change :cash_value, :string
    end
  end
end
