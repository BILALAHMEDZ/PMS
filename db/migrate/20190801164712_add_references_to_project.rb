# frozen_string_literal: true

class AddReferencesToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :creater, class_name: 'User', index: true
  end
end
