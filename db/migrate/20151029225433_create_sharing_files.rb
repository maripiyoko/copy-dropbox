class CreateSharingFiles < ActiveRecord::Migration
  def change
    create_table :sharing_files do |t|
      t.references :folder_file, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
