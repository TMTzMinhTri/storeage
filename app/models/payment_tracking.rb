# frozen_string_literal: true

# == Schema Information
#
# Table name: payment_trackings
#
#  id          :bigint           not null, primary key
#  amount      :integer
#  note        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  borrower_id :bigint           not null
#
# Indexes
#
#  index_payment_trackings_on_borrower_id  (borrower_id)
#
# Foreign Keys
#
#  fk_rails_...  (borrower_id => borrowers.id)
#
class PaymentTracking < ApplicationRecord
  belongs_to :borrower

  validates :amount, presence: true
  validate :validate_within_a_day, on: :create

  scope :today, -> { where(created_at: (Date.current.beginning_of_day..Date.current.end_of_day)) }
  scope :filter_by_date, lambda { |date|
    where(created_at: date.beginning_of_day..date.end_of_day)
  }

  private

  def validate_within_a_day
    return unless PaymentTracking.today.exists?(borrower_id:)

    errors.add(:borrower_id, :taken)
  end
end
