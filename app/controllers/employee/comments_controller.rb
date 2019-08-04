# frozen_string_literal: true

class Employee::CommentsController < CommentsBaseController
  before_action :validate_employee
  def validate_employee
    return if current_user.employee?

    redirect_to :root, alert: 'You are not allowed to access Employee'
  end

  def my_comment
    employee_comments_path
  end
end
