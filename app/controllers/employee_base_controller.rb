# frozen_string_literal: true

class EmployeeBaseController < ApplicationController
  before_action :validate_employee

  def validate_employee
    return if current_user.employee?

    redirect_to :root, alert: 'You are not allowed to access Employee'
  end
end
