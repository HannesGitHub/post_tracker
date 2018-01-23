class AddFkUserAndTrackings < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :trackings, :users, column: :user_id
  end
end
