class CreateImagefiles < ActiveRecord::Migration[5.0]
  def change
    create_table :imagefiles do |t|
      t.string :name
      t.integer :site_id
      t.integer :item_id
      t.string :image
      t.string :slug
      t.timestamps
    end
    add_index :imagefiles, :site_id
    add_index :imagefiles, :item_id
  end
end
