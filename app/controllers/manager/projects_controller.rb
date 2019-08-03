# frozen_string_literal: true

class Manager::ProjectsController < ProjectsBaseController
  before_action :validate_manager

  def validate_manager
    return if current_user.manager?

    redirect_to :root, alert: 'You are not allowed to access Manager'
  end

  def my_project
    manager_projects_path
  end
end
