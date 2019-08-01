# frozen_string_literal: true

class Manager::PaymentsController < PaymentsBaseController
  before_action :validate_manager

  def validate_manager
    return if current_user.manager?

    redirect_to :root, alert: 'You are not allowed to access Manager'
  end

  def index
    super
  end

  def new
    super
  end

  def show
    super
  end

  def create
    super
  end

  def update
    super
  end

  def edit
    super
  end

  def destroy
    super
  end

  def my_payment
    manager_payments_path
  end
end
