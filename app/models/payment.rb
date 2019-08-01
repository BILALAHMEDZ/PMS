# frozen_string_literal: true

class Payment < ApplicationRecord
  validates :payment, presence: true
end
