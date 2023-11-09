module Entities
  class Store < Base
    expose :id
    expose :name
    expose :user, as: :owner
  end
end
