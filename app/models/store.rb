# == Schema Information
#
# Table name: stores
#
#  id          :uuid             not null, primary key
#  address     :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :bigint
#  province_id :bigint
#  ward_id     :bigint
#
# Indexes
#
#  index_stores_on_district_id  (district_id)
#  index_stores_on_province_id  (province_id)
#  index_stores_on_ward_id      (ward_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => locations.id)
#  fk_rails_...  (province_id => locations.id)
#  fk_rails_...  (ward_id => locations.id)
#
class Store < ApplicationRecord
  has_many :user_stores
  has_many :users, through: :user_stores, dependent: :destroy
  belongs_to :province,
             lambda { |client|
               Location.province.where(id: client.province_id)
             },
             foreign_key: :province_id,
             class_name: 'Location',
             optional: true
  belongs_to :district,
             lambda { |client|
               Location.district.where(id: client.district_id)
             },
             foreign_key: :district_id,
             class_name: 'Location',
             optional: true
  belongs_to :ward,
             lambda { |client|
               Location.ward.where(
                 id: client.ward_id,
                 parent_id: client.district_id
               )
             },
             foreign_key: :ward_id,
             class_name: 'Location',
             optional: true

  validates :name, presence: true

  def owner
    user_stores.where(store_id: id, role: :admin).first
  end
end
