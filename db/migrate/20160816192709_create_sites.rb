class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :title
      t.string :activationkey
      t.text :prefs
      t.text :tracking_code
      t.timestamps
    end
  end
end
