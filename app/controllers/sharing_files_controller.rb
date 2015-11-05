class SharingFilesController < ApplicationController
  before_action :set_folder_file, :set_folder

  def new
    @sharing_folder_file = SharingFile.new(folder_file: @folder_file)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # ファイルを共有するモデルを作っている。
    # 共有先のuserをparamsから受け取ってセットする必要がある
    # 自分のuser_idはリファレンスのfolder_file_idから辿れるので、ここでセットしない
    @sharing_folder_file = SharingFile.new(sharing_folder_file_params)
    if @sharing_folder_file.save
      Notification.sharing_notice(current_user, @sharing_folder_file.user).deliver_now
      redirect_to @folder, notice: "#{@folder_file.name} を #{@sharing_folder_file.user.user_name} に共有しました。"
    else
      redirect_to @folder, alert: "#{@folder_file.name} を共有出来ませんでした。"
    end
  end

  private

    def set_folder_file
      # ファイルを共有する際に検索している箇所。自分のフォルダのみ対象とする
      @folder_file = current_user.folder_files.find(params[:folder_file_id])
    end

    def set_folder
      @folder = @folder_file.folder
    end

    def sharing_folder_file_params
      params.require(:sharing_file).permit(:folder_file_id, :user_id)
    end
end
