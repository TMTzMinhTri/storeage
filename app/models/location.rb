# == Schema Information
#
# Table name: locations
#
#  id           :bigint           not null, primary key
#  address_type :integer          default("province")
#  name         :string
#  parent_id    :bigint
#
# Indexes
#
#  index_locations_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => locations.id)
#
class Location < ApplicationRecord
  enum :address_type, {
    province: 0, district: 1, ward: 2
  }

  has_many :districts, -> { where(address_type: :district) },
           class_name: 'Location',
           foreign_key: :parent_id
  has_many :wards, -> { where(address_type: :ward) },
           class_name: 'Location',
           foreign_key: :parent_id

  scope :for_districts, ->(province_id) { district.where(parent_id: province_id) }
  scope :for_wards, ->(district_id) { ward.where(parent_id: district_id) }
end
