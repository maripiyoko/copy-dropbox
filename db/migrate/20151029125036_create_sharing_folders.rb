class CreateSharingFolders < ActiveRecord::Migration
  def change
    create_table :sharing_folders do |t|
      t.references :folder, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
