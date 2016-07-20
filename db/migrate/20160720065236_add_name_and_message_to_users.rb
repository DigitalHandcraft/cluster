class AddNameAndMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :message, :string
  end
end
