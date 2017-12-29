class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :username
      t.string :password
      t.string :auth_token
      t.boolean :is_active, defalut: true
      t.timestamps
    end
  end
end