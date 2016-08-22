class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :title
      t.boolean :activated, default: false
      t.string :activationkey
      t.timestamps
    end
  end
end
