class AddDefaultActiveForTracking < ActiveRecord::Migration[5.1]
  def change
    remove_column :trackings, :is_active
    add_column :trackings, :is_active, :boolean, default: true
  end
end
