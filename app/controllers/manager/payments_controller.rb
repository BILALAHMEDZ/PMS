# frozen_string_literal: true

class Manager::PaymentsController < PaymentsBaseController
  before_action :validate_manager

  def validate_manager
    return if current_user.manager?

    redirect_to :root, alert: 'You are not allowed to access Manager'
  end

  def my_payment
    manager_payments_path
  end
end
