# == Schema Information
#
# Table name: locations
#
#  id           :bigint           not null, primary key
#  address_type :integer
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  parent_id    :integer
#
class Location < ApplicationRecord
  enum address_type: { district: 1, ward: 2 }

  scope :districts, -> { where(address_type: :district) }
  scope :wards, lambda { |district_id|
                  where(address_type: :ward, parent_id: district_id)
                }
end
