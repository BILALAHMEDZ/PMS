# frozen_string_literal: true

class Employee::TimelogsController < TimelogsBaseController
  before_action :validate_employee
  def validate_employee
    return if current_user.employee?

    redirect_to :root, alert: 'You are not allowed to access Employee'
  end

  def my_timelog
    employee_project_timelogs_path
  end
end
