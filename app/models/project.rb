# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :client
  has_many :payments
  has_one :manager
  belongs_to :creator, class_name: 'User'
  validates :title, :hours_spent, :amount, presence: true
end
