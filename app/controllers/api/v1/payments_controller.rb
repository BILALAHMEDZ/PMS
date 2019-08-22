# frozen_string_literal: true

class Api::V1::PaymentsController < ApiController
  before_action :set_payment, only: %i[show]
  before_action :set_project, only: %i[index]

  def index
    return render json: { message: 'You are not authorize to perform this action' } if (current_user.manager? && current_user.id != @project.manager_id && current_user.id != @project.creater_id) || current_user.employee?

    @payments = @project.payments
    json_string = PaymentSerializer.new(@payments).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded Payment', data: @payment }, status: :ok
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    return render json: { message: 'project not found' }, status: :not_found if @project.blank?
  end

  def set_payment
    @payment = Payment.find_by(id: params[:id])
    return render json: { message: 'payment not found' }, status: :not_found if @payment.blank?
  end
end
