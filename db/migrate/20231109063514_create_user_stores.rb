class CreateUserStores < ActiveRecord::Migration[7.1]
  def change
    create_table :user_stores, id: false do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :store, type: :uuid
      t.integer :role, default: 0, null: false
    end
  end
end
