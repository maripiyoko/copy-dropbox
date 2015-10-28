class Folder < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent_folder, class_name: 'Folder'

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: [ :user_id, :parent_folder_id ]

  ROOT_FOLDER_NAME = 'home'.freeze

  def self.find_or_create_users_root_folder(user)
    self.find_or_create_by!(name: ROOT_FOLDER_NAME, user: user)
  end

end
