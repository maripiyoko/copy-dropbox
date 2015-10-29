class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder

  private

    def set_folder
      @folder = current_user.folders.find(params[:id])
    end

end
