# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :client
  has_many :payments
  belongs_to :manager
  belongs_to :creater, class_name: 'User'
  has_and_belongs_to_many :employees, join_table: 'employees_projects'
  validates :title, :hours_spent, :amount, presence: true
end
