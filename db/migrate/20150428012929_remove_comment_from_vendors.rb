class RemoveCommentFromVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :comment
  end

  def down
    add_column :vendors, :comment, :string
  end
end
