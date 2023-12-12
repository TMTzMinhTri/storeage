class CreateSocialPages < ActiveRecord::Migration[7.1]
  def change
    create_table :social_pages, id: :uuid do |t|
      t.references :store, type: :uuid, foreign_key: true
      t.integer :provider
      t.string :social_id
      t.string :access_token
      t.timestamps
    end
  end
end
