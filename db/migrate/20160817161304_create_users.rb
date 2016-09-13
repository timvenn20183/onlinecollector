class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.integer :site_id
      t.integer :role, :default => 1
      t.string :appkey
      t.integer :login_failures => 0
      t.timestamps
    end
    add_index :users, :site_id
  end
end
