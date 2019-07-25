class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :status, :string
    add_column :users, :role, :boolean
  end
end
