class CreateFolderFiles < ActiveRecord::Migration
  def change
    create_table :folder_files do |t|
      t.string :name, null: false
      t.references :folder, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
