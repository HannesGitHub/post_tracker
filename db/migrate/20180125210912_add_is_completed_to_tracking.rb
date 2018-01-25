class AddIsCompletedToTracking < ActiveRecord::Migration[5.1]
  def change
    add_column :trackings, :is_completed, :boolean, default: false
  end
end
