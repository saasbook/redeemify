class AddUnclaimCodesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :unclaimCodes, :integer
  end
end
