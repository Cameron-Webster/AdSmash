class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

   def after_sign_in_path_for(resource)
   projects_path
  end


protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :company, :name, :last_name, :avatar, :avatar_cache, :job_title, :invite_project])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :current_password,:password, :company, :name, :last_name, :avatar, :avatar_cache, :job_title])

  end
end
