# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :client
  has_many :payments
  has_one :manager
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :employees, join_table: 'employees_projects'
  validates :title, :hours_spent, :amount, presence: true
end
