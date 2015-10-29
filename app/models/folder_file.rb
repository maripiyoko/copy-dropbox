class FolderFile < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user

  mount_uploader :uploaded_file, FileUploader

  validates_presence_of :folder_id, :user_id
  validates_uniqueness_of :name, scope: [ :folder_id, :user_id ]
end
