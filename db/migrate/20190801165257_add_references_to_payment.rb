# frozen_string_literal: true

class AddReferencesToPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :creater, class_name: 'User', index: true
  end
end
