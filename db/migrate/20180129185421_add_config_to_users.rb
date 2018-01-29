class AddConfigToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :configurations do |t|
      t.string :notification_setting, default: 'first_notification_to_recipient'
      t.integer :user_id
      t.timestamps
    end
    add_foreign_key :configurations, :users, column: :user_id
  end
end
