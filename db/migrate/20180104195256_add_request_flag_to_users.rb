class AddRequestFlagToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_signup_request, :boolean, default: false
  end
end
