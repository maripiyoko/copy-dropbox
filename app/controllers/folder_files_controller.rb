class FolderFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder

  def new
    @modal_title = "新しいファイルをアップロードします"
    @child_file = FolderFile.new(folder: @folder, user: current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @child_file = FolderFile.new(folder_file_params)
    @child_file.user = current_user
    if @child_file.name.empty?
      @child_file.name = @child_file.uploaded_file.filename
    end
    if @child_file.save
      redirect_to @folder, notice: "#{@child_file.name} をアップロードしました。"
    else
      redirect_to @folder, alert: "ファイルがアップロード出来ませんでした。"
    end
  end

  private

    def set_parent_folder
      @folder = Folder.find(params[:folder_id])
    end

    def folder_file_params
      params.require(:folder_file).permit(:name, :folder_id, :uploaded_file)
    end
end
