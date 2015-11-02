class SharingFile < ActiveRecord::Base
  belongs_to :folder_file
  belongs_to :user

  validates_presence_of :folder_file_id, :user_id
  validates_uniqueness_of :folder_file_id, scope: [ :user_id ]
end
