class CreateFieldoptionsItems < ActiveRecord::Migration
  def change
    create_table :fieldoptions_items, :id => false do |t|
      t.references :fieldoption
      t.references :item
    end

    add_index :fieldoptions_items, [:fieldoption_id, :item_id],
      name: "fieldoptions_items_index",
      unique: true
  end
end
