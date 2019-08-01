# frozen_string_literal: true

class Payment < ApplicationRecord
  validates :payment, presence: true
  belongs_to :project
  belongs_to :creator, class_name: 'User'
end
