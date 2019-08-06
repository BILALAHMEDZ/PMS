# frozen_string_literal: true

class AddReferenceToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :project, index: true
  end
end
