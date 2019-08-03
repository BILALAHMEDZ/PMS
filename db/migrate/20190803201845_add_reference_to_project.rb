# frozen_string_literal: true

class AddReferenceToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :manager, class_name: 'User', index: true
  end
end
