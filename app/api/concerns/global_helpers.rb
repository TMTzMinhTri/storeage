# frozen_string_literal: true

module GlobalHelpers
  extend Grape::API::Helpers
  include Pagy::Backend
  include JWTSessions::Authorization

  params :pagination do
    optional :page, type: Integer, desc: 'Page number!'
  end

  def declared_params
    @declared_params ||= ActionController::Parameters.new(declared(
                                                            params,
                                                            include_missing: false
                                                          )).permit!
  end

  def pagination_values(collection)
    pagy, data = pagy(collection, overflow: :last_page)
    {
      data:,
      pagination: pagy
    }
  end

  def login(tokens)
    cookies[JWTSessions.access_cookie] = {
      value: tokens[:access],
      expires: tokens[:access_expires_at],
      path: '/',
      httponly: false,
      secure: Rails.env.production?
    }

    cookies[JWTSessions.refresh_cookie] = {
      value: tokens[:refresh],
      expires: tokens[:refresh_expires_at],
      path: '/',
      httponly: Rails.env.production?,
      secure: Rails.env.production?
    }
  end

  def logout
    cookies.delete(JWTSessions.refresh_cookie, path: '/')
  end

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def request_headers
    request.headers
  end

  def request_cookies
    request.cookies
  end

  def request_method
    request.request_method
  end
end
