# frozen_string_literal: true

class Admin::ProjectsController < ProjectsBaseController
  before_action :validate_admin
  def validate_admin
    return if current_user.admin?

    redirect_to :root, alert: 'You are not allowed to access Admin'
  end

  def my_project
    admin_projects_path
  end
end
