# frozen_string_literal: true

class CreateTimelogs < ActiveRecord::Migration[5.2]
  def change
    create_table :timelogs do |t|
      t.string :hours

      t.timestamps
    end
  end
end
