class SharingFoldersController < ApplicationController
  before_action :set_folder

  def new
    @sharing_folder = SharingFolder.new(folder: @folder)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @sharing_folder = SharingFolder.new(sharing_folder_params)
    if @sharing_folder.save
      Notification.sharing_notice(current_user, @sharing_folder.user).deliver_now
      redirect_to @folder, notice: "#{@folder.name} を #{@sharing_folder.user.user_name} に共有しました。"
    else
      redirect_to @folder, alert: "#{@folder.name} を共有出来ませんでした。"
    end
  end

  private

    def set_folder
      @folder = current_user.folders.find(params[:folder_id])
    end

    def sharing_folder_params
      params.require(:sharing_folder).permit(:folder_id, :user_id)
    end
end
