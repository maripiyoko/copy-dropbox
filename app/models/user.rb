class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :folders

  has_many :sharing_folders, class_name: 'SharingFolder', foreign_key: :user_id
  has_many :shared_folders, through: :sharing_folders, source: :folder

  validates_presence_of :user_name

  def other_users
    User.where.not(id: self.id)
  end

end
