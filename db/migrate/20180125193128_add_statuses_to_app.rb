class AddStatusesToApp < ActiveRecord::Migration[5.1]
  def change
    create_table :tracking_statuses do |t|
      t.string :date
      t.string :description
      t.string :details
      t.timestamps
      t.integer :tracking_id
    end
    add_foreign_key :tracking_statuses, :trackings, column: :tracking_id
  end
end
