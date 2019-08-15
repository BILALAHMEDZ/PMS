# frozen_string_literal: true

class RemoveColumnFromTimelog < ActiveRecord::Migration[5.2]
  def change
    remove_column :timelogs, :hours, :integer
  end
end
