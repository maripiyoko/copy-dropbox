class FolderFilesController < ApplicationController
  before_action :set_folder
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
    @child_file = current_user.folder_files.new(folder_file_params)
    if @child_file.name.empty?
      @child_file.name = @child_file.uploaded_file.filename
    end

    if @child_file.save
      redirect_to @folder, notice: "#{@child_file.name} をアップロードしました。"
    else
      name_error_message = @child_file.errors.messages[:name]
      if name_error_message[0].include?("blank")
        message = "ファイルがありません。"
      elsif name_error_message[0].include?("taken")
        message = "ファイル名#{@child_file.name}は既に使われています。"
      end
      message += "ファイルがアップロード出来ませんでした。"
      redirect_to @folder, alert: message
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

    def set_folder
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
