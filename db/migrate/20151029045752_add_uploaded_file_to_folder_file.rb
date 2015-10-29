class AddUploadedFileToFolderFile < ActiveRecord::Migration
  def change
    add_column :folder_files, :uploaded_file, :text
  end
end
