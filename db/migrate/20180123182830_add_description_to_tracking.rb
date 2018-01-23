class AddDescriptionToTracking < ActiveRecord::Migration[5.1]
  def change
    add_column :trackings, :description, :string
  end
end
