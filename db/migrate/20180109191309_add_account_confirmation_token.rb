class AddAccountConfirmationToken < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_activation_token, :string
    add_column :users, :account_activation_token_generation_date, :datetime
  end
end
