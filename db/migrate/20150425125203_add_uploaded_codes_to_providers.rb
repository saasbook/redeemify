class AddUploadedCodesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :uploadedCodes, :integer
  end
end
