module V1
  class Root < API
    version 'v1', using: :path

    resources :ward do
      get ':district_id' do
        wards = Location.wards(params[:district_id])
        wards
      end
    end
  end
end
