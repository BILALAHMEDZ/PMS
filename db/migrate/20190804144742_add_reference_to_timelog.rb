# frozen_string_literal: true

class AddReferenceToTimelog < ActiveRecord::Migration[5.2]
  def change
    add_reference :timelogs, :employee, class_name: 'User', index: true
  end
end
