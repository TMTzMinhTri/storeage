module Entities
  class Location < Base
    expose :id
    expose :name
    expose :address_type
    expose :parent_id
  end
end
