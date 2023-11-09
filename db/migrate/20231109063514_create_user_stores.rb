class CreateUserStores < ActiveRecord::Migration[7.1]
  def change
    create_table :user_stores do |t|
      t.belongs_to :user
      t.belongs_to :store
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
