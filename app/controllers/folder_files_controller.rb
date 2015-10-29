class FolderFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_child_file, only: [ :show, :edit, :update, :destroy ]

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
    if @child_file.update_attributes({name: params[:folder_file][:name]})
      redirect_to @folder, notice: "ファイル名を更新しました。"
    else
      redirect_to @folder, alert: "ファイル名の更新が出来ませんでした。"
    end
  end

  private

    def set_parent_folder
      @folder = Folder.find(params[:folder_id])
    end

    def set_child_file
      @child_file = FolderFile.find(params[:id])
    end

    def folder_file_params
      params.require(:folder_file).permit(:name, :folder_id, :uploaded_file)
    end
end
