# frozen_string_literal: true

class RemoveReferencesFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :manager_id, :bigint
  end
end
