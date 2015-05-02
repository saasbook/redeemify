class RemoveTotalCodesFromProviders < ActiveRecord::Migration
  def up
    remove_column :providers, :totalCodes
  end

  def down
    add_column :providers, :totalCodes, :integer
  end
end
