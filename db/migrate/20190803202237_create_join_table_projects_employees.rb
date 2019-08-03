# frozen_string_literal: true

class CreateJoinTableProjectsEmployees < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :employees do |t|
      # t.index [:project_id, :employee_id]
      # t.index [:employee_id, :project_id]
    end
  end
end
