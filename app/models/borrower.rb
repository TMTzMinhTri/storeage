# == Schema Information
#
# Table name: borrowers
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  deleted_at   :datetime
#  name         :string
#  note         :string
#  taken_amount :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  district_id  :integer
#  ward_id      :integer
#
# Indexes
#
#  index_borrowers_on_deleted_at  (deleted_at)
#
class Borrower < ApplicationRecord
  include PgSearch::Model

  belongs_to :district, foreign_key: :district_id, class_name: 'Location', optional: true
  belongs_to :ward, foreign_key: :ward_id, class_name: 'Location', optional: true

  validates :name, presence: true, uniqueness: { scope: :deleted_at }
  validates :amount, presence: true

  scope :for_listing, lambda {
    includes(:district, :ward)
  }
  default_scope -> { where("deleted_at": nil).order('id DESC') }

  pg_search_scope :pg_search,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
