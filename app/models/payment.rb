# frozen_string_literal: true

class Payment < ApplicationRecord
  validates :payment, presence: true
  belongs_to :project
  belongs_to :creater, class_name: 'User'
end
