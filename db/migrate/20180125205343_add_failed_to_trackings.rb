class AddFailedToTrackings < ActiveRecord::Migration[5.1]
  def change
    add_column :trackings, :failed, :boolean, default: false
  end
end
