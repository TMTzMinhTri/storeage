# frozen_string_literal: true

module Entities
  class User < Base
    expose :id
    expose :email
    expose :name
    expose :store, using: Entities::Store
    with_options(format_with: :iso_timestamp) do
      expose :created_at
      expose :updated_at
    end
  end
end
