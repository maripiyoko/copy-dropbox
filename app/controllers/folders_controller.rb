class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, except: [ :shared_files ]

  def shared_files
    @shared_files = current_user.all_shared
  end

  private

    def set_folder
      @folder = Folder.find(params[:id])
    end

end
