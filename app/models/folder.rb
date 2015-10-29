class Folder < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent_folder, class_name: 'Folder'

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: [ :user_id, :parent_folder_id ]

  ROOT_FOLDER_NAME = 'home'.freeze

  def self.find_or_create_users_root_folder(user)
    self.find_or_create_by!(name: ROOT_FOLDER_NAME, user: user)
  end

  def children
    Folder.where(parent_folder_id: self.id, user: self.user)
  end

  def other_parent_folders(user)
    all_folders = Folder.where(user: user).order(:parent_folder_id)
    self_folder = Folder.where(id: self.id)
    child_folders = self.children
    unless self.parent_folder.nil?
      self_parent_folder = Folder.where(id: self.parent_folder)
      all_folders - self_folder - child_folders - self_parent_folder
    else
      all_folders - self_folder - child_folders
    end
  end
end
