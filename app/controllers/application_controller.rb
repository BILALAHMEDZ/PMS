# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_user

  include Pundit
  protect_from_forgery

  def after_sign_in_path_for(_resource)
    if current_user.admin?
      admin_users_url
    elsif current_user.manager?
      manager_clients_url
    elsif current_user.employee?
      employee_projects_url
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password status type])
  end

  private

  def unauthorized_user
    flash[:alert] = 'You are not authorized to perform this action.'
    if current_user.admin?
      return admin_clients_path
    elsif current_user.manager?
      return manager_clients_path
    elsif current_user.employee?
      return employee_projects_path
    else
      return root_url
    end
  end
end
