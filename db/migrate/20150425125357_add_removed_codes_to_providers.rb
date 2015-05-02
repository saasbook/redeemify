class AddRemovedCodesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :removedCodes, :integer
  end
end
