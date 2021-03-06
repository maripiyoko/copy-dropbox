class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :parent_folder_id

      t.timestamps null: false
    end
  end
end
