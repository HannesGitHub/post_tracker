class SetIsActiveUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_active
    add_column :users, :is_active, :boolean, default: true
  end
end
