# == Schema Information
#
# Table name: channels
#
#  id           :bigint           not null, primary key
#  access_token :string
#  provider     :integer          default("facebook"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  social_id    :string           not null
#  user_id      :bigint
#
# Indexes
#
#  index_channels_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Channel < ApplicationRecord
  enum :provider, { facebook: 0, instagram: 1, zalo: 2, shopee: 3 }

  belongs_to :user_connect, class_name: 'User', foreign_key: 'user_id'
end
