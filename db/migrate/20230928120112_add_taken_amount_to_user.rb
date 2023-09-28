class AddTakenAmountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :borrowers, :taken_amount, :integer
  end
end
