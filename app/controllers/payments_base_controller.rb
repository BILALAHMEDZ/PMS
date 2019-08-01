# frozen_string_literal: true

class PaymentsBaseController < ApplicationController
  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to my_payment, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def edit
    find_Payment
  end

  def update
    find_Payment
    if @payment.update(payment_params)
      redirect_to my_payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_Payment
    @payment.destroy
    redirect_to my_payment, notice: 'Payment was successfully destroyed.'
  end

  private

  def find_Payment
    @payment = Payment.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @payment
  end

  def payment_params
    params.require(:payment).permit(:payment)
  end
end
