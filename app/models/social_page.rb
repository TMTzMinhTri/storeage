# == Schema Information
#
# Table name: social_pages
#
#  id           :uuid             not null, primary key
#  access_token :string
#  provider     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  social_id    :string
#  store_id     :uuid
#
# Indexes
#
#  index_social_pages_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class SocialPage < ApplicationRecord
  enum :provider, { facebook: 0 }
end
