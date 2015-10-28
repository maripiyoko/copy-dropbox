class Folder < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent_folder, class_name: 'Folder'

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: [ :user_id, :parent_folder_id ]
end
