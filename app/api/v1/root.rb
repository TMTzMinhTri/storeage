module V1
  class Root < API
    version 'v1', using: :path

    resources :demo do
      get do
        status 200
        User.all
      end
    end
  end
end
