class AddLatestStatusToTracking < ActiveRecord::Migration[5.1]
  def change
    add_column :trackings, :latest_status, :string
  end
end
