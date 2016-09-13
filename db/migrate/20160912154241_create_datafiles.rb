class CreateDatafiles < ActiveRecord::Migration[5.0]
  def change
    create_table :datafiles do |t|
      t.string :name
      t.integer :site_id
      t.integer :item_id
      t.string :data
      t.string :slug
      t.text :filetype
      t.timestamps
    end
  end
end
