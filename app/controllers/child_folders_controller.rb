class ChildFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_child_folder, only: [ :edit, :update, :destroy ]

  def new
    @child_folder = Folder.new(parent_folder: @folder, user: current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html { render :new }
      format.js { render :new }
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
    if @child_folder.update(folder_params)
      redirect_to @folder, notice: "#{@child_folder.name} にリネームしました。"
    else
      redirect_to @folder, alert: "フォルダ名のリネームが出来ませんでした。"
    end
  end

  def destroy
    redirect_to root_path, alert: 'ルートフォルダは削除できません。' if @child_folder.parent_folder_id.nil?
    if @child_folder.children.empty?
      @child_folder.destroy!
      redirect_to @folder, notice: 'フォルダを削除しました。'
    else
      redirect_to @folder, alert: '空でないフォルダは削除できません。'
    end
  end

  private

    def set_parent_folder
      @folder = Folder.find(params[:folder_id])
    end

    def set_child_folder
      @child_folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id)
    end
end
