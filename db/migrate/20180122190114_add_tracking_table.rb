class AddTrackingTable < ActiveRecord::Migration[5.1]
  def change
    create_table :trackings do |t|
      t.string :tracking_number
      t.integer :user_id
      t.boolean :is_active, defalut: true
      t.timestamps
    end
  end
end
