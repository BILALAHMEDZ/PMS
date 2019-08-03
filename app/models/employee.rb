# frozen_string_literal: true

class Employee < User
  has_and_belongs_to_many :projects, join_table: 'employees_projects'
end
