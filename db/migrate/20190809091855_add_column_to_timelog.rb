# frozen_string_literal: true

class AddColumnToTimelog < ActiveRecord::Migration[5.2]
  def change
    add_column :timelogs, :hours, :decimal
  end
end
