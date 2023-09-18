class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :address_type
      t.integer :parent_id

      t.timestamps
    end
  end
end
