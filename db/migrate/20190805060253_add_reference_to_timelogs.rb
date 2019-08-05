# frozen_string_literal: true

class AddReferenceToTimelogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :timelogs, :project, index: true
  end
end
