class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to(Folder.find_or_create_users_root_folder(current_user))
  end
end
