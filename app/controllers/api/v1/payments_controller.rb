# frozen_string_literal: true

class Api::V1::PaymentsController < ApiController
  before_action :authorize_request, except: :create

  def index
    @project = Project.find_by(id: params[:project_id])
    @payments = @project.payments
    json_string = PaymentSerializer.new(@payments).serialized_json
    render json: json_string
  end

  def show
    set_payment
    render json: { status: 'SUCCESS', message: 'Loaded Payment', data: @payment }, status: :ok
  end

  private

  def set_payment
    @payment = Payment.find_by(id: params[:id])
    return redirect_to root_path, alert: 'payment not found' if @payment.blank?
  end
end
