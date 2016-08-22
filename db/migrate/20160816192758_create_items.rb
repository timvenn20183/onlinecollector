class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :slug
      t.string :alphabet_letter, :limit => 1
      t.integer :site_id
      t.date :acquired_date
      t.date :removed_date

      t.timestamps
    end
  end
end
