# frozen_string_literal: true

class AddDetailToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :attachment, :string
  end
end
