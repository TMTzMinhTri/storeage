# frozen_string_literal: true

module Endpoints
  class Users < API
    resources :users do
      desc 'Register new account'
      params do
        requires :user, type: Hash do
          requires :name, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
        end
        requires :store, type: Hash do
          requires :name, type: String
        end
      end
      post :register do
        response = UserService::RegisterUser.call(params: declared_params)
        present response.result, with: Entities::User
      end

      desc 'Login user'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post :login do
        user = User.authorize!(declared_params)
        session = JWTSessions::Session.new(
          payload: user.access_payload,
          refresh_payload: user.refresh_payload,
          namespace: user.email,
          refresh_by_access_allowed: true
        )

        tokens = session.login
        login(tokens)
        extra_infos = {
          access_token: tokens[:access],
          access_expires_at: tokens[:access_expires_at],
          csrf: tokens[:csrf]
        }
        present extra_infos
        present user, with: Entities::User
      end

      desc 'get current user'
      get :me do
        user = User.last
        present user, with: Entities::User
      end

      desc 'Refresh access token',
           headers: {
             "x_csrf_token": {
               description: 'csrf token',
               require: true
             }
           }
      get :refresh_token do
        authorize_refresh_request!
        user = User.find(payload['user_id'])
        session = JWTSessions::Session.new(
          payload: user.access_payload,
          refresh_payload: user.refresh_payload,
          namespace: user.email,
          refresh_by_access_allowed: true
        )
        tokens = session.refresh(found_token)
        tokens
      end

      desc 'Logout'
      delete :log_out do
        authorize_access_request!
        session = JWTSessions::Session.new(
          payload:,
          refresh_payload: {
            user_id: payload['user_id']
          },
          namespace: payload['email'],
          refresh_by_access_allowed: true
        )
        session.flush_by_access_payload
        logout
        status 200
      end

      desc 'handle callback oauth request'
      params do
        requires :code, type: String
      end
      get :facebook do
        present declared_params
      end

      route_param :store_id do
        desc 'invite user into store'
        params do
          requires :user, type: Hash do
            requires :name, type: String
            requires :email, type: String
          end
        end
        post :invitation do
          response = UserService::InviteUser.call(user_params: declared_params,
                                                  store_id: params[:store_id],
                                                  current_user:)

          present response.result
        end
      end
    end
  end
end
