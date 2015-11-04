class SharingFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder_file

  def new
    @sharing_folder_file = SharingFile.new(folder_file: @folder_file)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
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
      @folder_file = current_user.folder_files.find(params[:folder_file_id])
      ### set_folder_file メソッドの中で @folder にも set していますので、少し読んでいて引っかかりました。
      ### set_folder というプライベートメソッドを、別途用意し、
      ### `before_action :set_folder_file, :set_folder`
      ### とした方が読みやすいような気がします。
      @folder = @folder_file.folder
    end

    def sharing_folder_file_params
      params.require(:sharing_file).permit(:folder_file_id, :user_id)
    end
end
