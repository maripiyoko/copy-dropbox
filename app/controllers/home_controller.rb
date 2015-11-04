class HomeController < ApplicationController

  def index
    redirect_to(Folder.find_or_create_users_root_folder(current_user))
  end
end
