# frozen_string_literal: true

module UsersHelper
  def earnings_per_month
    Project.where({ created_at: (Time.now - 1.month)..Time.now }).group(:title).sum(:amount)
  end

  def hours_spent_per_month
    Project.where({ created_at: (Time.now - 1.month)..Time.now }).group(:title).sum(:hours_spent)
  end
end
