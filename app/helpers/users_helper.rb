# frozen_string_literal: true

module UsersHelper
  def earnings_per_month
    Payment.select({ created_at: (Time.now - 1.month)..Time.now }).group(:payment).sum(:payment)
  end

  def hours_spent_per_month
    Timelog.select({ created_at: (Time.now - 1.month)..Time.now }).group(:hours).sum(:hours)
  end
end
