# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  include Authenticate

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable,
         :recoverable,
         :validatable,
         :confirmable,
         :lockable,
         :trackable

  has_many :user_stores
  has_many :stores, through: :user_stores
  has_many :channels, inverse_of: 'user_connect'

  before_validation :ensure_password, on: :create, if: -> { password.blank? }

  accepts_nested_attributes_for :stores

  def access_payload
    refresh_payload.merge({
                            email:
                          })
  end

  def refresh_payload
    { user_id: id }
  end

  def ensure_password
    self.password = Devise.friendly_token(6)
  end
  class << self
  end
end
