class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :address_type, default: 0
      t.references :parent, foreign_key: { to_table: :locations }
    end

    change_table :stores do |t|
      t.references :province, foreign_key: { to_table: :locations }
      t.references :district, foreign_key: { to_table: :locations }
      t.belongs_to(:ward, foreign_key: { to_table: :locations })
    end
  end
end
