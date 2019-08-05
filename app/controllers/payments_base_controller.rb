# frozen_string_literal: true

class PaymentsBaseController < ApplicationController
  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
  end

  def show
    find_payment
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.project_id = params[:project_id]
    @payment.creater_id = current_user.id
    if @payment.save
      redirect_to my_payment, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def edit
    find_payment
  end

  def update
    find_payment
    if @payment.update(payment_params)
      redirect_to my_payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_payment
    @payment.destroy
    redirect_to my_payment, notice: 'Payment was successfully destroyed.'
  end

  private

  def find_payment
    @payment = Payment.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @payment
  end

  def payment_params
    params.require(:payment).permit(:payment)
  end
end
