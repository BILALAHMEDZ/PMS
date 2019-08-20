# frozen_string_literal: true

class PaymentsBaseController < ApplicationController
  before_action :set_comments, only: [:show]
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new edit update create]

  def index
    @payments = @project.payments.includes(:comments).order(:id)
  end

  def new
    @payment = Payment.new
  end

  def show
    @comment = Comment.new
  end

  def create
    @payment = @project.payments.new(payment_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @payment.assign_attributes(payment_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project = @payment.project
    @payment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_comments
    @payment = Payment.find_by(id: params[:id])
    @comments = @payment.comments.order(:id).reverse_order
  end

  def set_payment
    @payment = Payment.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Payment not found' if @payment.blank?
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
    return redirect_to root_path, alert: 'Project not found' if @project.blank?
  end

  def payment_params
    params.require(:payment).permit(:payment, :creater_id)
  end
end
