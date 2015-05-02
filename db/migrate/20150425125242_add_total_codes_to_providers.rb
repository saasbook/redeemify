class AddTotalCodesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :totalCodes, :integer
  end
end
