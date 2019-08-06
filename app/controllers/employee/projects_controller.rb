# frozen_string_literal: true

class Employee::ProjectsController < ProjectsBaseController
  def index
    @projects = current_user.projects
  end

  def show
    super
  end
end
