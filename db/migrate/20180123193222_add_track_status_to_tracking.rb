class AddTrackStatusToTracking < ActiveRecord::Migration[5.1]
  def change
    add_column :trackings, :tracking_status, :string
  end
end
