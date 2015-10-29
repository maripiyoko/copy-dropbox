class FolderFile < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user

  mount_uploader :uploaded_file, FileUploader

  validates_presence_of :folder_id, :user_id
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
