class CreateItemfields < ActiveRecord::Migration[5.0]
  def change
    create_table :itemfields do |t|
      t.string :name
      t.string :slug
      t.integer :site_id
      t.boolean :required, :default => false
      t.timestamps
    end
    add_index :itemfields, :site_id
  end
end
