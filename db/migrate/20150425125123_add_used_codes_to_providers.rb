class AddUsedCodesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :usedCodes, :integer
  end
end
