class User < ApplicationRecord
  include Authenticate
  devise :database_authenticatable, :recoverable, :validatable, :confirmable, :lockable, :trackable
end
