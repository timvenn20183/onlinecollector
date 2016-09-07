class CreateImagefiles < ActiveRecord::Migration[5.0]
  def change
    create_table :imagefiles do |t|
      t.string :name
      t.integer :site_id
      t.integer :item_id
      t.string :image

      t.timestamps
    end
  end
end
