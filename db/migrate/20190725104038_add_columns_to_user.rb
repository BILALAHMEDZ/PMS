# frozen_string_literal: true

class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :phone, :string
  end
end
