# == Schema Information
#
# Table name: user_stores
#
#  role     :integer          default("admin"), not null
#  store_id :uuid
#  user_id  :uuid
#
# Indexes
#
#  index_user_stores_on_store_id  (store_id)
#  index_user_stores_on_user_id   (user_id)
#
class UserStore < ApplicationRecord
  enum :role, { admin: 0, staff: 1 }

  belongs_to :user
  belongs_to :store
  validates :user, uniqueness: { scope: :store }
end
