class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :folders
  has_many :folder_files

  has_many :sharing_folders, class_name: 'SharingFolder', foreign_key: :user_id
  has_many :shared_folders, through: :sharing_folders, source: :folder
  has_many :sharing_files, class_name: 'SharingFile', foreign_key: :user_id
  has_many :shared_files, through: :sharing_files, source: :folder_file

  validates_presence_of :user_name

  def other_users
    ### where で複数の ActiveRecord を取る場合は、scope に分けた方がよいですね。
    User.where.not(id: self.id)
  end

  def all_shared
    objects = []
    self.shared_folders.each do |f|
      objects << f
    end
    self.shared_files.each do |f|
      objects << f
    end
    objects
  end

end
