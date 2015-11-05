class ChildFoldersController < ApplicationController
  before_action :set_parent_folder
  before_action :set_child_folder, only: [ :edit, :move, :update, :destroy ]

  def new
    @modal_title = "新しいフォルダを作成します"
    @child_folder = Folder.new(parent_folder: @folder, user: current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @modal_title = "フォルダ名を変更します"
    respond_to do |format|
      format.html { render :new }
      format.js { render :new }
    end
  end

  def move
    @modal_title = "フォルダを移動します"
    @other_folders = @child_folder.other_parent_folders(current_user)
    respond_to do |format|
      format.js
    end
  end

  def create
    @child_folder = current_user.folders.new(folder_params)
    if @child_folder.save
      redirect_to @folder, notice: "#{@child_folder.name} フォルダを作成しました。"
    else
      if @child_folder.errors.messages.has_key?(:name)
        message = "フォルダ名#{@child_folder.name}は既に使われています。"
      end
      message += "新しいフォルダが作成出来ませんでした。"
      redirect_to @folder, alert: message
    end
  end

  def update
    if @child_folder.update(folder_params)
      redirect_to @folder, notice: "#{@child_folder.name} を更新しました。"
    else
      redirect_to @folder, alert: "フォルダを更新出来ませんでした。"
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
      ### 変数名を @parent_folder とした方が、 @child_folder と対となって読みやすいと感じました
      @folder = Folder.find(params[:folder_id])
    end

    def set_child_folder
      @child_folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id)
    end
end
