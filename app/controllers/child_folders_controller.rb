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

  def create
    @child_folder = Folder.new(folder_params)
    @child_folder.user = current_user
    if @child_folder.save
      redirect_to @folder, notice: "#{@child_folder.name} フォルダを作成しました。"
    else
      redirect_to @folder, alert: "新しいフォルダが作成出来ませんでした。"
    end
  end

  def update

  end


  private

    def set_parent_folder
      @folder = Folder.find(params[:folder_id])
    end

    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id)
    end
end
