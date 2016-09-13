class CreateFieldoptions < ActiveRecord::Migration[5.0]
  def change
    create_table :fieldoptions do |t|
      t.string :name
      t.string :slug
      t.integer :itemfield_id
      t.integer :site_id
      t.timestamps
    end
    add_index :fieldoptions, :itemfield_id
    add_index :fieldoptions, :site_id
  end
end
