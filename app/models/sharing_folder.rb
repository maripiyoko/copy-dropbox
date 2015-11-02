class SharingFolder < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user

  validates_presence_of :folder_id, :user_id
  validates_uniqueness_of :folder_id, scope: [ :user_id ]
end
