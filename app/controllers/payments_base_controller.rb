# frozen_string_literal: true

class PaymentsBaseController < ApplicationController
  before_action :set_comments, only: [:show]

  def index
    @project = Project.find_by_id(params[:project_id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
    @payments = @project.payments.order(:id).page(params[:page])
  end

  def new
    @project = Project.find(params[:project_id])
    @payment = Payment.new
  end

  def show
    set_payment
    @comment = Comment.new
  end

  def create
    @project = Project.find(params[:project_id])
    @payment = @project.payments.new(payment_params)
    @payment.creater_id = current_user.id

    respond_to do |format|
      format.js
    end
  end

  def edit
    set_payment
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def update
    set_payment
    @payment.assign_attributes(payment_params)
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    set_payment
    @project = @payment.project
    @payment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_comments
    @payment = Payment.find_by_id(params[:id])
    @comments = @payment.comments
  end

  def set_payment
    @payment = Payment.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @payment
  end

  def payment_params
    params.require(:payment).permit(:payment)
  end
end
