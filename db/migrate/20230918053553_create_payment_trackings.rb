# frozen_string_literal: true

class CreatePaymentTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table(:payment_trackings) do |t|
      t.integer(:amount)
      t.text(:note)
      t.references(:borrower, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
