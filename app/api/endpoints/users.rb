# frozen_string_literal: true

module Endpoints
  class Users < API
    resources :users do
      desc 'Register new account'
      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
        requires :store_attributes, type: Hash do
          requires :name, type: String
        end
      end
      post :register do
        response = UserService::CreateUser.call(params: declared_params)
        present response.result, with: Entities::User
      end

      desc 'Login user'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post :login do
        {}
      end
    end
  end
end
