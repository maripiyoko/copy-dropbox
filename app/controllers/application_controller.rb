class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_folder_authority

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :user_name
      devise_parameter_sanitizer.for(:account_update) << :user_name
    end


    def check_folder_authority
      if @folder.present?
        @folder.user == current_user || @folder.shared_users.include?(current_user)
      end
    end
end
