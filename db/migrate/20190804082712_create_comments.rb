# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :message
      t.integer :commentable_id
      t.string :commentable_type
      t.belongs_to :creater, class_name: 'User', index: true, null: false
      t.timestamps
    end
  end
end
