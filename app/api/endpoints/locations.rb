module Endpoints
  class Locations < API
    resources :locations do
      get :province do
        provinces = Location.province
        present provinces, with: Entities::Location
      end

      resources :district do
        route_param :province_id do
          get do
            districts = Location.for_districts(params[:province_id])
            present districts, with: Entities::Location
          end
        end
      end

      resources :ward do
        route_param :district_id do
          get do
            wards = Location.for_wards(params[:district_id])
            present wards, with: Entities::Location
          end
        end
      end
    end
  end
end
