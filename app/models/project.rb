# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :hours_spent, :amount, presence: true
end
