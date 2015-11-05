class FolderFile < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user

  mount_uploader :uploaded_file, FileUploader

  has_many :sharing_files, class_name: 'SharingFile', foreign_key: :folder_file_id
  has_many :shared_users, through: :sharing_files, source: :user

  validates_presence_of :folder_id, :user_id, :name
  validates_uniqueness_of :name, scope: [ :folder_id, :user_id ]

  VALID_IMG_EXTS = %w(
    .jpg
    .jpeg
    .png
    .gif
  ).freeze

  def is_image?
    VALID_IMG_EXTS.include?(File.extname(self.uploaded_file.url).downcase)
  end
end
