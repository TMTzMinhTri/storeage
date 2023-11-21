module Endpoints
  class Channels < API
    resources :channels do
      get do
        result = []

        present data: result
      end
    end
  end
end
