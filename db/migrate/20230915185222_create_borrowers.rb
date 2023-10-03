# frozen_string_literal: true

class CreateBorrowers < ActiveRecord::Migration[7.0]
  def change
    create_table(:borrowers) do |t|
      t.string(:name)
      t.string(:note)
      t.integer(:amount)
      t.integer(:district_id)
      t.integer(:ward_id)
      t.datetime(:deleted_at)
      t.timestamps
    end

    add_index(:borrowers, :deleted_at)
  end
end
