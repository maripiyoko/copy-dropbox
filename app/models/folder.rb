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
    all_folders = Folder.where(user: user)
    # 自分の子孫フォルダを候補から外す（辿れなくなるため）
    target_id = self.id
    descendants_folders = Folder.where(id: target_id)
    all_folders.each do |f|
      descendants_folders << f if f.is_ancester?(target_id)
    end
    results = all_folders - descendants_folders
    results.sort { | a, b| a.id <=> b.id }
  end

  # self の parent_folder をnilまで辿る途中で、idが出てくるかチェック
  def is_ancester?(target_id)
    return false if self.parent_folder.nil?
    return true if self.parent_folder.id == target_id || self.id == target_id
    self.parent_folder.is_ancester?(target_id)
  end
end
