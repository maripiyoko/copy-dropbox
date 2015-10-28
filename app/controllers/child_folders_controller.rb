class ChildFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder

  def new
    @child_folder = Folder.new(parent_folder: @folder, user: current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update

  end

  def create

  end

  private

    def set_parent_folder
      @folder = Folder.find(params[:folder_id])
    end
end
