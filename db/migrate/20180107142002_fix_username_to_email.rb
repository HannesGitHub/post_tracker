class FixUsernameToEmail < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :username
    add_column :users, :email, :string
  end
end
