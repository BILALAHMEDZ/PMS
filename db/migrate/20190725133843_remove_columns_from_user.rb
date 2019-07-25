# frozen_string_literal: true

class RemoveColumnsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :age, :integer
    remove_column :users, :phone, :string
    remove_column :users, :role, :boolean
  end
end
