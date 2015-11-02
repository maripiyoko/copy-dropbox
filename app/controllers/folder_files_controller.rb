class FolderFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_child_file, only: [ :show, :edit, :update, :destroy, :download, :move ]

  def new
    @modal_title = "新しいファイルをアップロードします"
    @child_file = FolderFile.new(folder: @folder, user: current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @modal_title = "ファイル名の更新"
    respond_to do |format|
      format.html { render :new }
      format.js { render :new }
    end
  end

  def move
    @modal_title = "ファイルの移動"
    @other_folders = current_user.folders
    respond_to do |format|
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

  def update
    if @child_file.update(folder_file_updating_params)
      redirect_to @folder, notice: "ファイルを更新しました。"
    else
      redirect_to @folder, alert: "ファイルを更新出来ませんでした。"
    end
  end

  def download
    send_file(@child_file.uploaded_file.current_path)
  end

  def destroy
    @child_file.destroy!
    redirect_to @folder, notice: "ファイルを削除しました。"
  end

  private

    def set_parent_folder
      ### 変数名を @parent_folder とした方が読みやすいと感じました
      @folder = Folder.find(params[:folder_id])
    end

    def set_child_file
      @child_file = FolderFile.find(params[:id])
    end

    def folder_file_params
      params.require(:folder_file).permit(:name, :folder_id, :uploaded_file)
    end

    def folder_file_updating_params
      params.require(:folder_file).permit(:name, :folder_id)
    end
end
