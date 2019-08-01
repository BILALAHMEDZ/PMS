# frozen_string_literal: true

class Admin::PaymentsController < PaymentsBaseController
  before_action :validate_admin
  def validate_admin
    return if current_user.admin?

    redirect_to :root, alert: 'You are not allowed to access Admin'
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
    admin_payments_path
  end
end
