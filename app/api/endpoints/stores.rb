module Endpoints
  class Stores < API
    resources :stores do
      desc 'get current stores'
      get do
        stores = Store.all
        present stores, with: Entities::Store
      end

      route_param :store_id do
        desc 'update current store'
        params do
          requires :store, type: Hash do
            requires :address, type: String
            requires :province_id, type: Integer
            requires :district_id, type: Integer
            requires :ward_id, type: Integer
          end
        end
        put do
          store = Store.update!(params[:store_id],
                                declared_params[:store])
          present store, with: Entities::Store
        end
      end
    end
  end
end
