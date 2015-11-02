class AddIndexToSharings < ActiveRecord::Migration
  def change
    add_index :sharing_folders, [ :folder_id, :user_id ], unique: true
    add_index :sharing_files, [ :folder_file_id, :user_id ], unique: true
  end
end
