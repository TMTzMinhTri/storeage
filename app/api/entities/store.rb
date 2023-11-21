module Entities
  class Store < Base
    expose :id
    expose :name
    expose :address
    expose :province_id
    expose :district_id
    expose :ward_id
  end
end
