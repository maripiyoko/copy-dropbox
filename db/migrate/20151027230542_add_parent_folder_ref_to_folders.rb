class AddParentFolderRefToFolders < ActiveRecord::Migration
  def change
    add_foreign_key :folders, :folders, column: "parent_folder_id"
    add_index :folders, [ :name, :user_id, :parent_folder_id ], unique: true
  end
end
