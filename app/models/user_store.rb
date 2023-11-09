# == Schema Information
#
# Table name: user_stores
#
#  id         :bigint           not null, primary key
#  role       :integer          default("admin")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_stores_on_store_id  (store_id)
#  index_user_stores_on_user_id   (user_id)
#
class UserStore < ApplicationRecord
  enum role: { admin: 0, staff: 1 }

  belongs_to :user
  belongs_to :store
end
